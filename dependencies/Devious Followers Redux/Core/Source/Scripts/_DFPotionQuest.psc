Scriptname _DFPotionQuest extends Quest  Conditional

_DFTools Property Tool auto
QF__DflowDealController_0A01C86D Property DC auto
QF__Gift_09000D62 Property Q Auto
Quest Property Dtick Auto


GlobalVariable Property GameDaysPassed Auto
GlobalVariable Property _DFlowPotionDeal Auto
GlobalVariable Property _DFlowPotionDealEvil Auto

Actor Property PlayerRef  Auto  
Actor Property TempActor Auto

Int Property nState Auto Conditional

Float Property Delay Auto Conditional
Float Property DelayMin = 3.0 Auto 
Float Property DelayMax = 11.0 Auto 
Float Property DelayPenalty Auto 

Bool Property Enabled Auto Conditional      ; Standard voluntary potion
Bool Property EnabledEvil Auto Conditional  ; Forced potion

Referencealias Property _DMaster Auto
Referencealias Property _DAddicted Auto
Referencealias property Follower auto

Message Property WeakenMsg Auto
Message property GagMsg Auto
Message property ForcedDrink Auto

Idle property BleedOutStart auto
Idle property BleedOutStop auto

Armor Property RopesI auto
Armor Property RopesR auto

MiscObject property Gold001 auto
Scene Property TheScene auto
Potion Property _DFPotion  Auto  
Perk Property Weakened2 Auto

Bool GagMsgB = True

Bool Waiting 


Function RunScene()

    Tool.PauseAll()

    Float  StartTime = 0.0
    Bool keepGoing = True
    Follower.ForceRefTo(_DMaster.GetActorReference())
    game.setplayeraidriven(true)
    TheScene.Start()
    while TheScene.IsPlaying() && keepGoing
        utility.wait(1)
        if(utility.GetCurrentRealTime() - StartTime == 200)	;200 seconds enough to complete scene but still running so it simply stuck
            keepGoing = false
            TheScene.Stop()
        endif
    endwhile

    ForcedDrink.show()

    Tool.PC.Disable()
    game.setplayeraidriven(False)
    Setstage(10)

    Tool.ResumeAll()

EndFunction


Function GivePotion()
    PlayerRef.additem(_DFPotion)
    _DAddicted.ForceRefTo(_DMaster.GetActorReference())
EndFunction


Function SetWaitDelay()
    Int lo = (((DelayMin - DelayPenalty) * 24.0) + 0.5) As Int
    Int hi = (((DelayMax - DelayPenalty) * 24.0) + 0.5) As Int
    If lo < 6
        lo = 6
    EndIf
    If hi < 30
        hi = 30
    EndIf
    
    Float delayHours = Utility.RandomInt(lo, hi) As Float
    Float delayDays = delayHours / 24.0
    
    Delay = Utility.GetCurrentGameTime() + delayDays
EndFunction


Function FirstDelay()
    
    SetWaitDelay()
    
    DC.ResetAllDeals()
    Q.PotionPayDebt()
    
    Waiting = True
    
    While Waiting
        Utility.Wait(37.0)
        If Delay < Utility.GetCurrentGameTime()
            Waiting = False
        endif
    EndWhile

    While  IsAnimating(PlayerRef)
        Utility.Wait(3.0)
    EndWhile
    
    Weaken()
    Setstage(20)
EndFunction


; Called on every potion drink after the first...
Function Delay()

    SetWaitDelay()
    
    Waiting = True

    While Waiting
        Utility.Wait(37.0)
        If Delay < Utility.GetCurrentGameTime()
            Waiting = False
        endif
    EndWhile

    While  IsAnimating(PlayerRef)
        Utility.Wait(3.0)
    EndWhile

    Weaken()
    Setstage(100)
    
EndFunction

Bool MsgOnce = False


Function Weaken()

    PlayerRef.PlayIdle(BleedOutStart)
    Tool.UnequipGear()
    Utility.wait(2)
    PlayerRef.AddPerk(Weakened2)
    PlayerRef.PlayIdle(BleedOutStop)

    If MsgOnce == False
        WeakenMsg.Show()
        MsgOnce = True
    EndIf

EndFunction


Bool Function IsAnimating(Actor who)
    
    Return (Dtick As _Dtick).Suspend \
            || !who.Is3DLoaded() || who.IsDisabled()|| who.IsOnMount() || who.IsSwimming() || who.IsInCombat() \
            || who.GetSitState() || who.GetSleepState() || who.IsBleedingOut() || who.IsUnconscious() \
            || who.IsFlying() || who.IsInKillMove() || who.IsDead() || who.GetCurrentScene()
    
EndFunction


Function Unweaken()

    ; The states are ONLY used at startup, then it sets state 0, and the dialog selection is any random match.

    ; State = 0 || State = 2 + gold > 1000 && not in gold control
    ; You can pay me a thousand gold to drink my pussy juices and beg for it like a good little pet. => State = 2
    
    ; State = 0 || State = 3 + gold > 2000 && not in gold control
    ; You can pay me two thousand gold to drink my pussy juices and beg like an obedient little pet for the privilege. => State = 3
    
    ; State = 0 || State = 4 + gold > 5000 && not in gold control
    ; You can pay me five thousand gold to drink my pussy juices and beg for it like  good little pet. => State = 4
    
    ; State = 0 || State = 5
    ; I'm feeling generous. Just be a good little pet and beg nicely.
    
    ; State = 0 || State = 6 + not in heavy bondage
    ; If you beg nicely enough for it, I'll tie you up and you can lick my pussy.

    PlayerRef.RemovePerk(Weakened2)

    Int removeGold = -1

    ; Stat 2 = 1k, 3=2k, 4=5k 5=nothing 6=Tied 7=Fail
    If nState == 2
        If PlayerRef.GetItemCount(gold001) >= 1000
            removeGold = 1000
        else
            nstate = 7
        endif
    elseif nState == 3
        If PlayerRef.GetItemCount(gold001) >= 2000
            removeGold = 2000
        else
            nstate = 7
        endif
    elseif nState == 4
        If PlayerRef.GetItemCount(gold001) >= 5000
            removeGold = 5000
        else
            nstate = 7
        endif
    elseif nState == 5
            removeGold = 0
    elseif nState == 6
            tool.libs.EquipDevice(tool.libs.PlayerRef, RopesI , RopesR, tool.libs.zad_DeviousHeavyBondage, skipevents = false, skipmutex = true)
            removeGold = 0
    endif

    If nstate == 7
        ; Use all the gold the player has to pay and punish.
        ; In general, this never happens. The PC has to lose money between starting the dialog and beginning the sex.
        
        Debug.Notification("$DFPOTIONTIMERED") ; Forced to drink more often message.
        removeGold = PlayerRef.GetGoldAmount()
        
        DelayPenalty += 0.5
    endif

    If removeGold > 0
        PlayerRef.RemoveItem(gold001, removeGold)
    EndIf

    If removeGold >= 0
        Bool ok = Tool.SexOral(_DAddicted.GetActorReference())
        If !ok
            ok = Tool.Sex(_DAddicted.GetActorReference())
        EndIf
        
        If ok
            Tool.WaitForSex()
        EndIf

        If  GagMsgB && !PlayerRef.WornHasKeyword(tool.libs.zad_PermitOral) && PlayerRef.WornHasKeyword(tool.libs.zad_DeviousGag)
            GagMsgB = False ; This stays false forever now, we only show this message once.
            GagMsg.Show()
            ; Being gagged, you wonder how you'll can comsume <Alias.ShortName=_DFAddictedTo>'s fluids, but as they touch and run down your skin you feel your mouth watering with the taste of them rather than your saliva.
            ; Soon, your mouth is full to the point that the fluid is pouring from the sides of your gag and you must swallow or choke.
            ; Gulping it down, you realize that even gagged you're forced to taste their secretions, and you shudder, cursing whoever made that potion.
        EndIf

    EndIf


    nState = 0

    TempActor = _DAddicted.GetActorReference()
    Reset()
    Setstage(50)
    _DAddicted.ForceRefTo(TempActor) ; Put the actor back after reset.
    
EndFunction


Function ResetQuest()
    Reset()
    PlayerRef.RemovePerk(Weakened2)

    If DelayMin < 0.25 && DelayMax < 0.25
        DelayMin = 3.0
        DelayMax = 11.0
    EndIf
EndFunction
