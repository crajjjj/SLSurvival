Scriptname _DDeal extends Quest Conditional

QF__DflowDealController_0A01C86D Property DC Auto
_DFtools Property Tool Auto
_LDC Property LDC Auto

Referencealias Property FlAlias Auto
Referencealias Property _DMaster Auto

Armor Property ArmCuffs Auto
Armor Property LegCuffs Auto
Armor Property Collar Auto
Armor Property Chasity Auto
Armor Property Gag Auto
Armor Property Corset Auto
Armor Property Boots Auto
Armor Property Hands Auto
Armor Property Nips Auto
Armor Property Vag Auto
Armor Property Item1 Auto
Armor Property Item1R Auto
Armor Property Item2 Auto
Armor Property Item2R Auto
Armor Property Item3 Auto
Armor Property Item3R Auto

Scene Property TheScene Auto
Scene Property TheScene2 Auto
Scene Property TheScene3 Auto
Scene Property TheScene4 Auto
Scene Property TheScene5 Auto

MiscObject Property Gold001 Auto
Actor Property PlayerRef  Auto
Message Property _DFlowRollDealO2 Auto

GlobalVariable Property GameDaysPassed Auto
GlobalVariable Property _DFBoredom Auto

Bool Property Triggered = False Auto

; Conditional properties
Float Property Delay Auto Conditional
Int Property Stat Auto Conditional
Int Property Said1 = 0 Auto Conditional
Int Property SelectedStage = -1 Auto Hidden Conditional

Int Property MaxStages Auto Hidden
Bool[] Property FinalStagesEnabled Auto Hidden
String[] Property FinalStages Auto Hidden
Int[] Property FinalStageIndexes Auto Hidden

Float Property TimerCache Auto Hidden
Int Property StageCache Auto Hidden

; Callbacks
Function BuyOutCallback()
    {clean up your deal - unequip devices, remove items, etc.}
EndFunction

Function CleanUp()
    Debug.Trace("DF - Cleaning up - " + GetName())
EndFunction

; Utilities
Function Stage0()
    Debug.TraceConditional("DF - _DDeal:Stage0", True)
EndFunction

Function AddCuffs()
    LDC.AddDeviceByKeyword(LDC.Libs.zad_deviousarmcuffs)
    Utility.Wait(5.0)
    LDC.AddDeviceByKeyword(LDC.Libs.zad_deviouslegcuffs)
EndFunction

Function AddCollar()
    LDC.AddDeviceByKeyword(LDC.Libs.zad_deviouscollar)
EndFunction

Function AddNips()
    LDC.AddDeviceByKeyword(LDC.Libs.zad_deviouspiercingsnipple)
EndFunction

Function AddVag()
    LDC.AddDeviceByKeyword(LDC.Libs.zad_deviouspiercingsvaginal)
EndFunction

Function AddBelt()
    LDC.AddDeviceByKeyword(LDC.Libs.zad_deviousBelt)
EndFunction

Function AddGag()
    LDC.AddDeviceByKeyword(LDC.Libs.zad_deviousgag)
EndFunction

Function AddCorset()
    LDC.AddDeviceByKeyword(LDC.Libs.zad_deviouscorset)
EndFunction

Function AddBootsAndHands()
    LDC.AddDeviceByKeyword(LDC.Libs.zad_deviousgloves)
    Utility.Wait(5.0)
    LDC.AddDeviceByKeyword(LDC.Libs.zad_deviousboots)
EndFunction

Function AddItem1()
    PlayerRef.AddItem(item1)
EndFunction

Function EquipItem1()
     Tool.libs.ForceequipDevice(Tool.libs.PlayerRef, item1 , item1R, Tool.libs.zad_DeviousBelt, skipevents = false, skipmutex = true)
EndFunction

Function RemoveItem1()
     Tool.libs.RemoveDevice(Tool.libs.PlayerRef, item1 , item1R, Tool.libs.zad_DeviousBelt, skipevents = false, skipmutex = true)
EndFunction

Function AddItem2()
    PlayerRef.additem(item2)
EndFunction

Function AddItem3()
    PlayerRef.additem(item3)
EndFunction

Function DelayReset()
    Delay = GameDaysPassed.GetValue() + 0.03
Endfunction

Function DelayForever()
    Delay = GameDaysPassed.GetValue() + 100.0
Endfunction

Function DelayDay()
    Delay = GameDaysPassed.GetValue() + 1.0
Endfunction

Function DelayHr()
    ; If Delay expires within next 43 minutes, set delay to be in another 100 minutes
    Float now = GameDaysPassed.GetValue()
    If Delay <= now + 0.03
        Delay = now + 0.07
    Endif
    ; An hour is 0.04166666666 days
    ; 0.03 days is about 43 minutes
    ; 0.07 days is about 100 minutes
Endfunction

Function DelayHrs(Float hrs)
    Float days = hrs / 24.0
    Float now = GameDaysPassed.GetValue()
    If Delay <= now + days
        Delay = now + days
    Endif
Endfunction


; Denial game dice rolling.
Function Roll(Int maxRoll)

    Tool.DenDmgStop = True
    Tool.WaitForSex()
    Tool.Masturbation(Tool.MCM.Follower.GetActorRef())
    
    Tool.ReduceResistFloat((maxRoll/2) As Float)


    Utility.Wait(5.0)
    int rolled = Utility.RandomInt(1, maxRoll)

    Debug.Trace("DF - Ownership - Rolled = " + rolled)

    Tool.WaitForSex()
    If Tool.MCM._DFShowRollMsg
        _DFlowRollDealO2.Show(maxRoll, rolled)
    EndIf
    If rolled == 6 
        Debug.Trace("DF - Ownership - Roll Succeded")
        RollSuccess()
    Else
        Debug.Trace("DF - Ownership - Roll Failed")
        RollFail()
    EndIf

    Tool.DenDmgStop = False
    
EndFunction


Function DenialDogSex()

    Removeitem1()
    Utility.Wait(2.0)

    Actor follower  = _DMaster.GetActorRef()
    FlAlias.ForceRefTo(follower)
    Actor Dog = Tool.Dog
    Dog.Enable()
    Dog.MoveTo(Game.Getplayer())
    Utility.Wait(1)
    
    Tool.ReduceResistFloat(22.0)
    Tool.AddFatigueValue(1.0)
    
    Tool.Sex(Dog) ; This shouldn't reduce resist.
    Utility.Wait(10)
    TheScene.Start()
    Tool.WaitForSex()
    Debug.Notification("$DFDENDOG1")
    Utility.Wait(2)
    Tool.Sex(Dog)
    Utility.Wait(10)
    TheScene.Start()
    Tool.WaitForSex()
    Debug.Notification("$DFDENDOG2")
    Dog.Disable()
    Stat = 0
    Tool.AdjustBoredom(-2.0)
    Equipitem1()
    
EndFunction


Function RollSuccess()

    Int rnd = Utility.RandomInt(1, 3)
    Actor follower  = _DMaster.GetActorRef()
    TheScene2.Start() ; Intro scene Win1
    Tool.SceneErrorCatch(TheScene2, 10)

    Removeitem1()
    Utility.Wait(2.0)

    If rnd == 1
        Tool.Sex(follower)
        
        Utility.Wait(5.0)
        Tool.WaitForSex()
        Tool.Sex(follower)
        Utility.Wait(5)
        Tool.WaitForSex()
        Debug.Notification("$DFDENSUCCESS1")
        TheScene3.Start() ; end scene 
        Tool.SceneErrorCatch(TheScene3, 10)

        Tool.ReduceResistFloat(4.0)

        Stat = 0
        Tool.AdjustBoredom(-0.8)
        
    ElseIf rnd == 2
        
        Tool.Sex(follower)
        Utility.Wait(5.0)
        Tool.WaitForSex()
        Debug.Notification("$DFDENSUCCESS2")
        TheScene4.Start() ; end scene 2
        Tool.SceneErrorCatch(TheScene4, 10)
        Stat -= 16
        If Stat < 8
            Stat = 8
        EndIf

        Tool.ReduceResistFloat(8.0)

        Tool.AdjustBoredom(-1.0)
        
    ElseIf rnd == 3
        
        Tool.Sex(follower)
        Utility.Wait(5.0)
        Tool.WaitForSex()
        Debug.Notification("$DFDENSUCCESS3")
        TheScene5.Start() ; end scene 3 - cut short
        Tool.SceneErrorCatch(TheScene5, 10)
        Stat -= 8
        If Stat < 8
            Stat = 8
        EndIf
        
        Tool.ReduceResistFloat(14.0)
        
        Tool.AdjustBoredom(-1.1)
    EndIf

    Equipitem1()
    
EndFunction


Function RollFail()

    Int rnd = Utility.RandomInt(1,3)
    Actor follower  = _DMaster.GetActorRef()
    If rnd == 1
        Debug.Notification("$DFDENFAIL1")
        Stat += 4
        Tool.AdjustBoredom(-0.1)
        DC.AddRndDay()
        
    ElseIf rnd == 2
        Debug.Notification("$DFDENFAIL2")
        Tool.Masturbation(follower)
        Utility.Wait(5)
        Tool.WaitForSex()
        Stat += 4
        Tool.AdjustBoredom(-0.1)
        RollFail()
        
    ElseIf rnd == 3
        Debug.Notification("$DFDENFAIL3")
        Tool.SexAnal(follower)
        Utility.Wait(5)
        Tool.WaitForSex()
        Debug.Notification("$DFDENFAIL4")
        Stat += 10
        Tool.AdjustBoredom(-0.3)
        DC.AddRndDay()
    EndIf
    
EndFunction

; Internal
Function Buyout(GlobalVariable price)
    
    DC = Quest.GetQuest("_DflowDealController") As QF__DflowDealController_0A01C86D

    Debug.TraceConditional("DF - _DDeal - Buyout", True)
    Int removeGold = price.GetValue() As Int
    PlayerRef.RemoveItem(Gold001, removeGold)
    Debug.TraceConditional("DF - _DDeal - remove " + removeGold + " debt", True)
    
    Int s = GetStage()
    If s > 3
        s = 3
    EndIf
    
    if s >= 3
      DC.DealMaxAdd(-1)
    Endif

    DC.DealAdd(-s)
    
    DealManager.RemoveDeal(self)
    
    DC.PickRandomDeal()

    BuyOutCallback()
EndFunction
