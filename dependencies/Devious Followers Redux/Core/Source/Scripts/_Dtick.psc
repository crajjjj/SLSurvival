Scriptname _Dtick extends Quest  conditional

; FOLDSTART - Properties
Quest Property _DFlowSleep Auto
_Dftools Property Tool Auto
SexLabFramework Property SexLab Auto
Zadlibs Property libs Auto
Quest Property _DFlow Auto
QF__Gift_09000D62 Property Q  Auto  
DialogueFollowerScript Property VanillaDialogFollower Auto
_DFlowFollowerController Property FollowerController Auto
_DFlowFollowerController Property DFlowFollowerController Auto ; Duplicate of above, because I messed up and released an ESP with it unset.
_DFGoldConQScript Property GoldControl Auto ; Not set in earlier versions - mod event code will not add gold control properly in old games.
Quest Property DealController Auto
_DFlowModDealController Property ModDealController Auto
Quest Property _DFLicenses Auto

Actor Property PlayerRef Auto
Actor Property Follower Auto
ReferenceAlias Property FollowerAlias Auto
FormList Property _DFPauseModsList Auto

Faction Property Enslaved Auto ; Not set and hopefully, not used. Probably intended to be soft-dep'd onto ZAP.
Faction Property DismissedFollowerFaction Auto
Faction Property DMasterFaction Auto
Faction Property DIgnoreFaction Auto

Armor Property mittsI Auto
Armor Property mittsR Auto
Armor Property glovesI Auto
Armor Property glovesR Auto
Armor Property dealAmulet Auto
Armor Property dealCirclet Auto
Armor Property dealRing Auto

MiscObject Property Gold001 Auto

Keyword Property NewProperty  Auto
Keyword Property _DFCrawlRequired Auto
Keyword Property _DFSlaveGloves Auto
Keyword Property _DFSlaveMitts Auto

GlobalVariable Property Lives Auto
GlobalVariable Property _DFlowLivesMax Auto
GlobalVariable Property _DFFollowerHasMaxLives Auto
GlobalVariable Property _DFLivesFollowerRape Auto
GlobalVariable Property _DWill Auto
GlobalVariable Property _DFMinimumContract Auto
GlobalVariable Property _DFMinimumContractRemaining Auto
GlobalVariable Property _DFFollowerCount Auto
GlobalVariable Property _DFStanding Auto
GlobalVariable Property pPlayerFollowerCount Auto
GlobalVariable Property _DFSeverityMitigation Auto
GlobalVariable Property _DFSeverityMitigationBase Auto
GlobalVariable Property _DFSlutCount Auto
GlobalVariable Property _DFModMmePresent Auto
GlobalVariable Property _DFModSkoomaWhorePresent Auto
GlobalVariable Property _DFModSLSPresent Auto
GlobalVariable Property Pause Auto
GlobalVariable Property _DF_State2 Auto
GlobalVariable Property _DF_State3 Auto
GlobalVariable Property _DF_State4 Auto


ObjectReference Property GetCrosshairTarget 
    ObjectReference Function Get()
        _dtickPlayerAlias playerAlias = GetNthAlias(0) As _dtickPlayerAlias
        Return playerAlias.CrosshairTarget
    EndFunction
EndProperty

Bool Property IsPaused
    Bool Function Get()
        Return 0.0 == Pause.GetValue()
    EndFunction
EndProperty

Bool Property NotPaused
    Bool Function Get()
        Return 0.0 != Pause.GetValue()
    EndFunction
EndProperty


Bool Property RunOnce Auto
Bool Property WasEnslaved Auto

Int Property Suspend = 0 Auto conditional
Int Property PEnslaved = 0 Auto conditional
Int Property modID Auto
Int Property mtIdleBase Auto
Int Property mtBase Auto
Int Property mtxBase Auto
Int Property sneakBase Auto
Int Property sneakmtBase Auto
Int Property h2heqp Auto
Int Property h2hidle Auto
Int Property h2hatkpow Auto
Int Property h2hatk Auto
Int Property h2hstag Auto
Int Property jump Auto
Int Property sprint Auto
Int Property shout1 Auto
Int Property mtturn Auto

Float Property SlutTimer Auto
Float Property SlutTimerPeriod
    Float Function Get()
        Return 60.0 * 10.0 ; Ten real minutes
    EndFunction
EndProperty


; FOLDEND - Properties

Int lastVictimCount = -1
Int lastVictimCountFollower = -1

Float previousUpdateSeconds


String Function GetScriptVersionName()
    Return "2.14.4"
EndFunction

Int Function GetScriptVersion()
    Return 21440
EndFunction

Bool runDefferredInitTasks = False


; Can be called from MCM to fix broken blocked state.
Function UnblockEvents()
    GotoState("")
EndFunction


; Called on game load
Event Init()

    GotoState("InEvent")

    Debug.TraceConditional("DF - _Dtick - Init", True)
    _DUtil.DebugSpam_SetInfo()
    
    (GetNthAlias(0) As _dtickPlayerAlias).AddEventRegistrations()
    
    (DealController As _DFDealUberController).StartDeals()

    RegisterForModEvent("DF-Pause", "PauseByEvent")
    RegisterForModEvent("DFEnslave", "EnslaveFromSimpleSlavery")  ; Called when enslaved into DF from Simple Slavery
    RegisterForModEvent("AnimationEnd","Rapecheck")
    RegisterForModEvent("dhlp-Suspend", "Suspend")
    RegisterForModEvent("dhlp-Resume", "Resume")
    
    ; Handle auto-pause for slavery - though this also prevents DFC from setting zbfFactionSlave.
    ; DFC also issues these when putting the player into (or ending) internal slavery, but not Lola.
    RegisterForModEvent("PlayerRefEnslaved", "PEnslave") ; This is sent by SS in response to a PEnslaveCheck event based on membership of the zbfFactionSlave
    RegisterForModEvent("PlayerRefFreed", "PUnEnslave") ; This is sent by SS in response to a PEnslaveCheck event.
    
    RegisterForModEvent("SSLV Entry", "SSClean") ; Called by mods to send player to Simple Slavery auction.
    RegisterForModEvent("DF-ResistanceLoss", "HandleResistanceLoss")
    RegisterForModEvent("DF-ResistanceLossWithSeverity", "HandleResistanceLossWithSeverity")
    RegisterForModEvent("DF-ResistanceGain", "HandleResistanceGain")
    RegisterForModEvent("DF-DebtAdjust", "HandleDebtAdjust")
    RegisterForModEvent("DF-MinimumContractChange", "HandleMinimumContractChange")
    RegisterForModEvent("DF-AddFollower", "HandleAddFollower")
    RegisterForModEvent("DF-RemoveFollower", "HandleRemoveFollower")
    RegisterForModEvent("DF-Spank", "HandleSpanks")
    RegisterForModEvent("MME_MilkingDone", "HandleMilkDone")
    
    modID = FNIS_aa.GetAAModID("dfs", "DeviousFollowers", True)
    mtIdleBase = FNIS_aa.GetGroupBaseValue(modID,FNIS_aa._mtidle(),"DeviousFollowers",True) 
    mtBase = FNIS_aa.GetGroupBaseValue(modID,FNIS_aa._mt(),"DeviousFollowers",True) 
    mtxBase = FNIS_aa.GetGroupBaseValue(modID,FNIS_aa._mtx(),"DeviousFollowers",True)
    sneakBase=FNIS_aa.GetGroupBaseValue(ModID,FNIS_aa._sneakidle(),"DeviousFollowers",True)
    sneakmtBase=FNIS_aa.GetGroupBaseValue(ModID,FNIS_aa._sneakmt(),"DeviousFollowers",True)
    h2heqp=FNIS_aa.GetGroupBaseValue(ModID,FNIS_aa._h2heqp(),"DeviousFollowers",True)
    h2hidle=FNIS_aa.GetGroupBaseValue(ModID,FNIS_aa._h2hidle(),"DeviousFollowers",True)
    h2hatkpow=FNIS_aa.GetGroupBaseValue(ModID,FNIS_aa._h2hatkpow(),"DeviousFollowers",True)
    h2hatk=FNIS_aa.GetGroupBaseValue(ModID,FNIS_aa._h2hatk(),"DeviousFollowers",True)
    h2hstag=FNIS_aa.GetGroupBaseValue(ModID,FNIS_aa._h2hstag(),"DeviousFollowers",True)
    jump=FNIS_aa.GetGroupBaseValue(ModID,FNIS_aa._jump(),"DeviousFollowers",True)
    sprint=FNIS_aa.GetGroupBaseValue(ModID,FNIS_aa._sprint(),"DeviousFollowers",True)
    shout1=FNIS_aa.GetGroupBaseValue(ModID,FNIS_aa._shout(),"DeviousFollowers",True)
    mtturn=FNIS_aa.GetGroupBaseValue(ModID,FNIS_aa._mtturn(),"DeviousFollowers",True)
    lastVictimCount = SexLab.GetSkill(PlayerRef, "Victim")
    Follower = FollowerAlias.GetActorReference()
    lastVictimCountFollower = SexLab.GetSkill(Follower, "Victim")
    
    _DFModMmePresent.SetValue(IsMmePresent())
    _DFModSkoomaWhorePresent.SetValue(IsSkoomaWhorePresent())
    _DFModSlsPresent.SetValue(IsSlsPresent())
    
    (_DflowSleep as _DflowSleepQuestScript).UnRegisterForSleep()
    (_DflowSleep as _DflowSleepQuestScript).RegisterForSleep()
    
    previousUpdateSeconds = Utility.GetCurrentRealTime()
    
    StorageUtil.SetIntValue(_DFlow As Form, "_DF_Version", GetScriptVersion())
    
    ; Reset the slut counter again after SlutTimerPeriod seconds (ten real minutes)
    slutTimer = previousUpdateSeconds + SlutTimerPeriod
    
    _DFSlutCount.SetValue(0.0)

    
    _DUtil.Info("_Dtick:Init - almost done")
    
    runDefferredInitTasks = True
    GotoState("")
    
    RegisterForSingleUpdate(4.0)

EndEvent

Event PauseByEvent(Bool pausedState, Form sender)
    GotoState("InEvent")
    PauseWorker(pausedState, sender)
    GotoState("")
EndEvent

; Simple Slavery event handler - removes follower
; This is called by external mods to send the PC to Simple Slavery, and SS listens for it.
; This is also raised by Simple Slavery internally when telling the player they black out and wake up in the auction due to collar shenanigans.
; DF raises it itself when sending player to SS.
Event SSClean(String eventName, String strArg, Float numArg, Form sender)
    GotoState("InEvent")
    If NotPaused
        If Q.getstage() >= 10
            Q.ExternalRemoveFollower()
        EndIf
    EndIf
    GotoState("")
EndEvent

; This is raised by SimpleSlavery in response to a PEnslaveCheck event based on membership of zbfFactionSlave
; Also raised by EnslavedDueToDebt if sending to DF internal slavery.
Event PEnslave(String eventName, String strArg, Float numArg, Form sender)

    GotoState("InEvent")
    Debug.TraceConditional("DF - SS/SD+/SLTR says player is enslaved via some foreign mod", True)
    If NotPaused
        Debug.TraceConditional("DF - isn't paused, so check if we should pause...", True)
    
        If Q.Tool.MCM._DFZAZAutoPause && PEnslaved == 0 && Q.GetStage() < 90
            Debug.TraceConditional("DF - auto-pause because we aren't already paused", True)
            FirePauseEvent(True)
        EndIf
    EndIf
    PEnslaved = 1
    GotoState("")

EndEvent

; This is raised by SimpleSlavery in response to a PEnslaveCheck event based on membership of zbfFactionSlave
; Handle end of enslavement by external mod - though we have no assurance it will be raised in a timely manner...
; Perhaps DFC should be raising PEnslaveCheck itself from time to time?
; It can cause an automatic unpause.
; Also raised by BuyoutOfSlavery if ending DF internal slavery.
Event PUnEnslave(String eventName, String strArg, Float numArg, Form sender)
    GotoState("InEvent")
    Debug.TraceConditional("DF - SS/SD+/SLTR says player is NOT enslaved via some foreign mod", True)
    If Q.Tool.MCM._DFZAZAutoPause && PEnslaved == 1 && Q.GetStage() < 90
        Debug.TraceConditional("DF - unpause because we were auto-paused", True)
        FirePauseEvent(False)
    EndIf
    PEnslaved = 0
    GotoState("")
EndEvent


Event EnslaveFromSimpleSlavery(String eventName, String strArg, Float numArg, Form sender)
    GotoState("InEvent")
    If NotPaused
        FirePauseEvent(False)
        WaitForUnpause()
    EndIf
    Q.Enslave()
    GotoState("")
EndEvent


Event Suspend(String eventName, String strArg, Float numArg, Form sender)
    GotoState("InEvent")
    Suspend = 1
    GotoState("")
EndEvent


Event Resume(String eventName, String strArg, Float numArg, Form sender)
    GotoState("InEvent")
	Suspend = 0
    GotoState("")
EndEvent


Event HandleResistanceLossWithSeverity(String eventNameUnused, String severity, Float resistanceLoss, Form sender)

    GotoState("InEvent")
    Float severityNumber = (severity As Int) As Float
    Float currentWill = _DWill.GetValue()
    
    If currentWill < (_DFSeverityMitigationBase.GetValue() - severityNumber)
    
        resistanceLoss = Math.Ceiling(resistanceLoss * _DFSeverityMitigation.GetValue())
        
    EndIf
    
    ; Express loss as a positive number
    If resistanceLoss > 0.0
        Tool.ReduceResistFloat(resistanceLoss)
    EndIf
    GotoState("")

EndEvent

Event HandleResistanceLoss(String eventNameUnused, String strUnused, Float resistanceLoss, Form sender)

    GotoState("InEvent")
    ; Express loss as a positive number
    If resistanceLoss > 0.0
        Tool.ReduceResistFloat(resistanceLoss)
    EndIf
    GotoState("")

EndEvent

Event HandleResistanceGain(String eventNameUnused, String strUnused, Float resistanceGain, Form sender)

    GotoState("InEvent")
    ; Gain cannot be negative, use HandleResistanceLoss for that
    If resistanceGain > 0.0
        Tool.IncreaseResistFloat(resistanceGain)
    EndIf
    GotoState("")

EndEvent


; This modifies DEBT, not credit, so positive values increase debt, and negative values decrease it (or add credit)
Event HandleDebtAdjust(String eventNameUnused, String strUnused, Float debtDelta, Form sender)

    GotoState("InEvent")
    Q.AdjustDebt(debtDelta As Int)
    GotoState("")

EndEvent

Event HandleMinimumContractChange(String eventNameUnused, String strUnused, Float durationInDays, Form sender)

    GotoState("InEvent")
    SetMinimumContract(durationInDays)
    GotoState("")
    
EndEvent

Event HandleAddFollower(Form sender, Form followerToAddForm, Int debtToAdd, Bool forceGoldControlMode, Float minimumContractDays)

    GotoState("InEvent")
    If NotPaused
        Actor followerToAdd = followerToAddForm As Actor
        
        If followerToAdd
            DFlowFollowerController.AddFollowerDflow(followerToAdd)
            Q.AdjustDebt(debtToAdd)
            
            If minimumContractDays >= 0.0 ; Pass -ve contract to avoid changing it
                SetMinimumContract(minimumContractDays)
            EndIf
            
            If forceGoldControlMode && GoldControl.Active && !GoldControl.Enabled
                GoldControl.StartIt()
            EndIf
        EndIf
    EndIf
    GotoState("")
    
EndEvent

Event HandleRemoveFollower(Form followerToRemoveForm)

    GotoState("InEvent")
    If NotPaused
        Actor followerToRemove = followerToRemoveForm As Actor
        
        If followerToRemove
            followerToRemove.RemoveFromFaction(DMasterFaction)

            If !followerToRemove.IsInFaction(DismissedFollowerFaction)
                VanillaDialogFollower.DismissFollower(0, 0)
            EndIf
        EndIf
    EndIf
    GotoState("")
    
EndEvent

Event HandleMilkDone(Form who, Int bottles, Int boobgasmcount, Int cumcount)
    GotoState("InEvent")
    If NotPaused
        If who == PlayerRef
            ModDealController.MilkingDone(bottles)
        EndIf
    EndIf
    GotoState("")
EndEvent


Event HandleSpanks(String eventNameUnused, String actorFormId, Float severity, Form sender)

    GotoState("InEvent")
    ; Severity = -1, let DF work out severity based on willpower.
    ; Severity 0 .. 2 ; explicitly specify a severity.
    ; Don't specify a severity over 2, it just gets clamped to 2.
    
    ; ActorFormId is the integer formID in a string.
    Int formId = actorFormId As Int
    If formId
    
        Actor spanker = Game.GetForm(formId) As Actor
        If spanker
        
            If severity > 2.0
                severity = 2.0
            ElseIf severity < 0
                severity = -1.0
            EndIf
            
            Int iSeverity = severity As Int
            
            Tool.Spank(spanker, iSeverity)
            
        EndIf
    EndIf
    GotoState("")
    
EndEvent


Bool Function WaitForUnpause()
    
    Float timeOut = Utility.GetCurrentGameTime() + 0.1
    While 0.0 == Pause.GetValue() && Utility.GetCurrentGameTime() < timeOut
        Utility.Wait(1.0)
    EndWhile

    If 0.0 != Pause.GetValue()
        ; Unpaused...
        ; Check follower alias is OK...
        Utility.Wait(1.0)
        Actor who = Q.Alias__DMaster.GetActorRef()
        If who
            Return True
        EndIf
    
    EndIf
    
    Return False
    
EndFunction

; Wait for pause, return True is actually paused.
Bool Function WaitForPause()

    Float timeOut = Utility.GetCurrentGameTime() + 0.1
    While Pause.GetValue() && Utility.GetCurrentGameTime() < timeOut
        Utility.Wait(1.0)
    EndWhile
    
    Return 0.0 == Pause.GetValue()

EndFunction


Function PauseWorker(Bool pausedState, Form sender)
    If pausedState
        ; Only pause when the list is empty
        If 0 == _DFPauseModsList.GetSize()
            Q.Tool.MCM.PauseMod()
        EndIf
        _DFPauseModsList.AddForm(sender)
    Else
        ; Only unpause when the list is empty
        _DFPauseModsList.RemoveAddedForm(sender)
        If 0 == _DFPauseModsList.GetSize()
            Q.Tool.MCM.ResumeMod()
        EndIf
    EndIf
EndFunction


Function FirePauseEvent(Bool pauseOn)
    Int eventHandle = ModEvent.Create("DF-Pause")
    If eventHandle
        ModEvent.PushBool(eventHandle, pauseOn) ; true if pausing, false if resuming.
        ModEvent.PushForm(eventHandle, Q) ; The form that is the event source - be consistent.
        ModEvent.Send(eventHandle)
    EndIf
EndFunction


Function SetMinimumContract(Float durationInDays)

    Float currentMinimum = _DFMinimumContract.GetValue()
    Float currentRemaining = _DFMinimumContractRemaining.GetValue()
    
    If durationInDays > currentMinimum
        currentRemaining += (durationInDays - currentMinimum)
        _DFMinimumContractRemaining.SetValue(currentRemaining)
    EndIf
    
    _DFMinimumContract.SetValue(durationInDays)

EndFunction


; This relies on the SexLab victim stat - it's not triggered directly by SexLab.
Event Rapecheck(String eventName, String argString, Float argNum, form sender)
    
    Bool creatureSex = False
    Bool heavyBondage = False

    Int dmg = 1  ; Base sex damage

    Follower = FollowerAlias.GetActorReference()

    If checkForVictimChange()

        ; This is the steal mechanic in MCM, can steal less as willpower reduced.
        Steal()
        
        dmg += 5  ; Base rape damage
        
        If PlayerRef.WornHasKeyword(libs.zad_DeviousHeavyBondage)
            dmg += 3
            heavyBondage = True
        EndIf
        If PlayerRef.WornHasKeyword(libs.zad_DeviousBlindfold) || PlayerRef.WornHasKeyword(libs.zad_DeviousHood)
            dmg += 2
        EndIf
        If PlayerRef.WornHasKeyword(libs.zad_DeviousCollar)
            dmg += 2
        EndIf
        If PlayerRef.WornHasKeyword(libs.zad_DeviousGag)
            dmg += 1
        EndIf
        If PlayerRef.WornHasKeyword(libs.zad_DeviousPetSuit)
            dmg += 1
        EndIf
        If PlayerRef.WornHasKeyword(libs.zad_DeviousGloves) || PlayerRef.WornHasKeyword(libs.zad_DeviousBondageMittens)
            dmg += 1
        EndIf
        If PlayerRef.WornHasKeyword(libs.zad_DeviousBoots)
            dmg += 1
        EndIf
        If PlayerRef.WornHasKeyword(_DFCrawlRequired)
            dmg += 1
        EndIf
        If PlayerRef.WornHasKeyword(libs.zad_DeviousCorset) || PlayerRef.WornHasKeyword(libs.zad_DeviousHarness)
            dmg += 1
        EndIf
        If PlayerRef.WornHasKeyword(libs.zad_DeviousArmCuffs)
            dmg += 1
        EndIf
        If PlayerRef.WornHasKeyword(libs.zad_DeviousLegCuffs)
            dmg += 1
        EndIf
        If PlayerRef.WornHasKeyword(libs.zad_DeviousSuit)
            dmg += 1
        EndIf
        
        Actor[] actorList = SexLab.HookActors(argString)
        If SexLab.CreatureCount(actorList) > 0
            dmg += 4
            creatureSex = True
        EndIf
        
        If actorList.Length != 1 && actorList.Find(Follower) == -1
            tool.DenialDmg(dmg, creatureSex, heavyBondage)
        EndIf
        
        ;Debug.Notification("Rape resistance damage " + dmg)
        Tool.ReduceResist(dmg)
    Else
        Actor[] actorList = SexLab.HookActors(argString)
        If actorList.Length != 1 && actorList.Find(Game.GetPlayer()) != -1
            tool.DenialDmg((dmg+2) / 3, False, False) ; Don't deal massive denial damage now that resist damage can be more than 3x higher
        EndIf
    EndIf

    If (checkForFollowerVictimChange() && _DFLivesFollowerRape.GetValue() != 0.0)
        Int reduced = (Lives.GetValue()) as Int - 1
        Lives.SetValue(reduced)
    EndIf

EndEvent


Function Steal()

    If Tool.MCM._DFTheifsBool
        ; Steal as a random percentage
        Float steal = (Utility.RandomInt(Tool.MCM._DFMinStolenPer,Tool.MCM._DFMaxStolenPer) As Float) / 100.0
        
        If Tool.MCM._DFWillBool
        
            Float willScale = _DWill.GetValue() / 10.0
            willScale = willScale * 0.9 + 0.10 ; always steal at least 10% of gold

            steal *= willScale

        EndIf
        
        Int stealAmount = (steal * Game.GetPlayer().GetItemCount(Gold001)) As Int
        If stealAmount > 0
            Game.GetPlayer().RemoveItem(Gold001, stealAmount, True)
        EndIf
    EndIf
    
EndFunction


Bool Function checkForVictimChange()

	Int newCount = SexLab.GetSkill(PlayerRef, "Victim")
	If newCount != lastVictimCount
		lastVictimCount = newCount
		Return True
	Else
		Return False
	EndIf
    
EndFunction


Bool Function checkForFollowerVictimChange()

	Int newCount = SexLab.GetSkill(Follower, "Victim")
	If newCount != lastVictimCountFollower
		lastVictimCountFollower = newCount
		Return True
	Else
		Return False
	EndIf
    
EndFunction


Function CheckForNewFollowers()

    ; Try each of the follower extensions in turn...
    Int currentKnownFollowerCount = _DFFollowerCount.GetValue() As Int
    
    Int followerCount = -1
    
    If 255 != Game.GetModByName("AmazingFollowerTweaks.esp")
        followerCount = _df_AFT_extensions.CountDeviousFollowers(DIgnoreFaction)
    EndIf
    
    If followerCount < 0 && 255 != Game.GetModByName("EFFCore.esm")
    followerCount = _df_EFF_extensions.CountDeviousFollowers(DIgnoreFaction)
    EndIf

    If followerCount < 0 && 255 != Game.GetModByName("nwsFollowerFramework.esp")
        followerCount = _df_NFF_extensions.CountDeviousFollowers(DIgnoreFaction)
    EndIf
    
    If followerCount <= 0 ; it's possible for follower to exist but not be counted by NFF
        followerCount = (pPlayerFollowerCount.GetValue() As Int)
    EndIf
    
    Debug.Trace("DF - CheckForNewFollowers - followerCount " + followerCount)
    
    If followerCount != currentKnownFollowerCount
    
        _DFFollowerCount.SetValue(followerCount As Float)
        
        If followerCount > 0
            ; We've detected a follower acquisition that we could act on immediately - if we wanted.
            Debug.TraceConditional("DF - try and add a new follower", True)
            (Q As QF__Gift_09000D62).QuickStartNewAgreement() ; Does nothing if we have a follower already.
        EndIf
    EndIf

EndFunction


Float Function IsMmePresent()
    If 255 != Game.GetModByName("MilkModNEW.esp")
        Return 1.0
    EndIf
    Return 0.0
EndFunction

Float Function IsSkoomaWhorePresent()
    If 255 != Game.GetModByName("SexLabSkoomaWhore.esp")
        Return 1.0
    EndIf
    Return 0.0
EndFunction

Float Function IsSlsPresent()
    If 255 != Game.GetModByName("SL Survival.esp")
        Return 1.0
    EndIf
    Return 0.0
EndFunction

Function RegisterSlsExceptions()
    FormList slsExceptions = _DF_SLS.GetExceptionList()
    If slsExceptions
        slsExceptions.AddForm(dealAmulet)
        slsExceptions.AddForm(dealCirclet)
        slsExceptions.AddForm(dealRing)
    EndIf
EndFunction


Event OnUpdate()

    ; Default update delay - used if not in slavery.
    ; Reduced this so the 'state' values will be more effective.
    Float updateDelay = 13.0

    ;_Dutil.Info("_Dtick:OnUpdate - start")
    
    If runDefferredInitTasks ; Instead of running these on load, we run them a bit later.
        runDefferredInitTasks = False
        
        If RunOnce
            Tool.LDC.Init()
        Endif
        
        If IsSlsPresent() != 0.0
            RegisterSlsExceptions() ; Stop SLS taking deal items
            (_DFLicenses As _DFLicensing).TryResumeLicensing()
        Else
            (_DFLicenses As _DFLicensing).TryStop()
        EndIf
        
    EndIf
    
    Float state2 = _DF_State2.GetValue()
    state2 += 1.0
    If state2 > 1.0
        state2 = 0.0
    EndIf
    _DF_State2.SetValue(state2)

    Float state3 = _DF_State3.GetValue()
    state3 += 1.0
    If state3 > 2.0
        state3 = 0.0
    EndIf
    _DF_State3.SetValue(state3)
    
    Float state4 = _DF_State4.GetValue()
    state4 += 1.0
    If state4 > 3.0
        state4 = 0.0
    EndIf
    _DF_State4.SetValue(state4)

    ; Don't run all the updates while paused.
    If IsPaused
        Tool.UpdateSpankingStatus()
        RegisterForSingleUpdate(updateDelay)
        Return
    EndIf

    Int stage = _DFlow.GetStage()

    Actor akPlayer = Game.GetPlayer()

    ; Handle the magic slave gloves - they only work if you're enslaved.
    If stage >= 100 && stage < 200

        WasEnslaved = True
        
        ; Finding this takes approx AGES - can replace with keyword check...
        ;Armor wornHands = akPlayer.GetWornForm(0x00000008) as Armor
        ;If !inCombat && wornHands == glovesR
        ;    libs.ForceEquipDevice(akPlayer, mittsI, mittsR, libs.zad_DeviousGloves)
        ;    updateDelay = 6.0
        ;ElseIf inCombat && wornHands == mittsR
        ;    libs.ForceEquipDevice(akPlayer, glovesI, glovesR, libs.zad_DeviousGloves)
        ;    updateDelay = 6.0
        ;ElseIf wornHands == mittsR || wornHands == glovesR
        ;     updateDelay = 3.0
        ;Else
        ;    updateDelay = 10.0
        ;EndIf

        Bool inCombat = akPlayer.IsInCombat()
        Bool inGloves = akPlayer.WornHasKeyword(_DFSlaveGloves)
        Bool inMitts = akPlayer.WornHasKeyword(_DFSlaveMitts)
        If !inCombat && inGloves
            libs.ForceEquipDevice(akPlayer, mittsI, mittsR, libs.zad_DeviousGloves)
            updateDelay = 6.0
        ElseIf inCombat && inMitts
            libs.ForceEquipDevice(akPlayer, glovesI, glovesR, libs.zad_DeviousGloves)
            updateDelay = 6.0
        ElseIf inGloves || inMitts
            updateDelay = 3.0
        Else
            updateDelay = 10.0
        EndIf
        
        If !inCombat && akPlayer.WornHasKeyword(_DFCrawlRequired) && akPlayer.IsWeaponDrawn()
            Float dmg = ((4.0 * updateDelay / 3.0 + 0.5) As Int) As Float
            akPlayer.DamageActorValue("Health", dmg) ; Ouch!!!
        EndIf
        
        String stance = StorageUtil.GetStringValue(akPlayer, "_SD_sDefaultStance", "")
        If stance == "Standing"
            _DFStanding.SetValue(1.0)
        Else
            _DFStanding.SetValue(0.0)
        EndIf

        ModDealController.CheckKeyDealTrigger()
        
    ElseIf WasEnslaved
        WasEnslaved = False
        SendModEvent("PlayerRefIsFree")
    Endif

    If stage >= 10
        StorageUtil.SetFormValue(PlayerRef, "_DFLow_Follower", FollowerAlias.GetReference())
    Else
        CheckForNewFollowers() ; Check more often while follower not established.
    EndIf

    Float now = Utility.GetCurrentRealTime()
    If now > previousUpdateSeconds + 23.0

        previousUpdateSeconds = now
        
        ;_Dutil.Info("_Dtick:OnUpdate - stage " + stage)
        If stage >= 10
        
            CheckForNewFollowers() ; The less frequent check 
        
            Int currentLives = Lives.GetValue() As Int
            Int maxLives = _DFlowLivesMax.GetValue() As Int
            Float hasMaxLives = (currentLives == maxLives) As Float
            _DFFollowerHasMaxLives.SetValue(hasMaxLives)
            ;Debug.Notification("_Dtick:OnUpdate - currentLives " + currentLives + ", maxLives " + maxLives + " " + hasMaxLives)
            
            Follower = FollowerAlias.GetActorReference()
            If Follower && Follower.WornHasKeyword(libs.zad_DeviousHeavyBondage)
                Tool.DeferPunishments()
                Q.SetZeroLives()
            EndIf
                    
        EndIf
        
        ; Update spanking information, once in a while...
        Tool.UpdateSpankingStatus()

        If slutTimer < previousUpdateSeconds
            ; Reset the slut counter again after ten real minutes passed
            slutTimer = previousUpdateSeconds + SlutTimerPeriod
            _DFSlutCount.SetValue(0.0)
        EndIf
        
    EndIf

    If 9 == stage && Q.Delay < Utility.GetCurrentGameTime()
        Debug.Notification("Follower is back on the clock.")
        Q.SetStage(10)
    EndIf

    ;_Dutil.Info("_Dtick:OnUpdate - end")

    RegisterForSingleUpdate(updateDelay)
    
EndEvent




State InEvent

Event Init()
    ; Trust this won't fire re-entrantly and use this to repair games where the state got broken.
    GotoState("")
    Debug.TraceConditional("DFC - reparing broken Init() state!!!", True)
    Init()
EndEvent

Event PauseByEvent(Bool pausedState, Form sender)
    Debug.TraceConditional("DFC - PauseByEvent re-entry from " + sender, True)
EndEvent

Event SSClean(String eventName, String strArg, Float numArg, Form sender)
    Debug.TraceConditional("DFC - SSClean re-entry from " + sender, True)
EndEvent

Event PEnslave(String eventName, String strArg, Float numArg, Form sender)
    Debug.TraceConditional("DFC - PEnslave re-entry from " + sender, True)
EndEvent

Event PUnEnslave(String eventName, String strArg, Float numArg, Form sender)
    Debug.TraceConditional("DFC - PUnEnslave re-entry from " + sender, True)
EndEvent

Event EnslaveFromSimpleSlavery(String eventName, String strArg, Float numArg, Form sender)
    Debug.TraceConditional("DFC - Enslave re-entry from " + sender, True)
EndEvent

Event Suspend(String eventName, String strArg, Float numArg, Form sender)
    Debug.TraceConditional("DFC - Suspend re-entry from " + sender, True)
EndEvent

Event Resume(String eventName, String strArg, Float numArg, Form sender)
    Debug.TraceConditional("DFC - Resume re-entry from " + sender, True)
EndEvent

Event HandleResistanceLossWithSeverity(String eventNameUnused, String severity, Float resistanceLoss, Form sender)
    Debug.TraceConditional("DFC - HandleResistanceLossWithSeverity re-entry from " + sender, True)
EndEvent

Event HandleResistanceLoss(String eventNameUnused, String strUnused, Float resistanceLoss, Form sender)
    Debug.TraceConditional("DFC - HandleResistanceLoss re-entry from " + sender, True)
EndEvent

Event HandleResistanceGain(String eventNameUnused, String strUnused, Float resistanceGain, Form sender)
    Debug.TraceConditional("DFC - HandleResistanceGain re-entry from " + sender, True)
EndEvent

Event HandleDebtAdjust(String eventNameUnused, String strUnused, Float debtDelta, Form sender)
    Debug.TraceConditional("DFC - HandleDebtAdjust re-entry from " + sender, True)
EndEvent

Event HandleMinimumContractChange(String eventNameUnused, String strUnused, Float durationInDays, Form sender)
    Debug.TraceConditional("DFC - HandleMinimumContractChange re-entry from " + sender, True)
EndEvent

Event HandleAddFollower(Form sender, Form followerToAddForm, Int debtToAdd, Bool forceGoldControlMode, Float minimumContractDays)
    Debug.TraceConditional("DFC - HandleAddFollower re-entry from " + sender, True)
EndEvent

Event HandleRemoveFollower(Form followerToRemoveForm)
    Debug.TraceConditional("DFC - HandleRemoveFollower re-entry", True)
EndEvent

Event HandleMilkDone(Form who, Int bottles, Int boobgasmcount, Int cumcount)
    Debug.TraceConditional("DFC - HandleMilkDone re-entry", True)
EndEvent

Event HandleSpanks(String eventNameUnused, String actorFormId, Float severity, Form sender)
    Debug.TraceConditional("DFC - HandleSpanks re-entry from " + sender, True)
EndEvent


EndState
