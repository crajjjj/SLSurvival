Scriptname _SLS_KennelUtil extends Quest

; Troll Quest stages: 0 - Intro not done, 10 - Intro done, 20 - Accepts offer. 30 - Enters cage, 40 - Had sex, 50 - Made the troll cum

Event OnInit()
	If Self.IsRunning()
		_SLS_KennelTrollRef.AddToFaction(SexLabAnimatingFaction)
	EndIf
EndEvent

Event OnUpdate()
	; Something removing troll from SexLabAnimatingFaction some seconds after sex ends (SL?)
	; This is a bit shit but works
	If _SLS_KennelTrollRef.IsInFaction(SexLabAnimatingFaction)
		TrollInAnimatingFactionCount += 1
	Else
		_SLS_KennelTrollRef.AddToFaction(SexLabAnimatingFaction)
		TrollInAnimatingFactionCount = 0
	EndIf
	If TrollInAnimatingFactionCount <= 4
		RegisterForSingleUpdate(1.5)
	EndIf
EndEvent

Event OnOrgasmStart(int tid, bool HasPlayer);(string eventName, string argString, float argNum, form sender)
	OrgasmEvent(ActorRef = None, tid = tid, HasPlayer = HasPlayer)
EndEvent

Event OnSexLabOrgasmSeparate(Form ActorRef, Int tid)
	;Bool HasPlayer = Sexlab.FindPlayerController() == tid
	OrgasmEvent(ActorRef = ActorRef as Actor, tid = tid, HasPlayer = Sexlab.FindPlayerController() == tid)
EndEvent

Function OrgasmEvent(Actor ActorRef = None, Int tid, Bool HasPlayer)
	If HasPlayer
		Self.SetStage(50) ; Made the troll cum
		_SLS_KennelTrollRef.AddToFaction(SexLabAnimatingFaction)
		UnRegisterForModEvent("HookOrgasmStart")
		UnRegisterForModEvent("SexLabOrgasmSeparate")
	EndIf
EndFunction

Event OnAnimationStart(int tid, bool HasPlayer)
	If HasPlayer
		Self.SetStage(40) ; Sex started. Possibly didn't make the troll cum
		UnRegisterForModEvent("HookAnimationStart")
	EndIf
EndEvent

Function TrollSexDialogueBegin()
	Init.CanDoMilkOrSkooma = ForceDrug.GetCanDoMilkOrSkooma() as Int
EndFunction

Function DoKennelTrollKeepersDesire()
	SendModEvent("dhlp-Suspend")
	_SLS_OnLocChangeDlhpResumeQuest.Start() ; Fail safe if player decides to just leave after accepting deal
	Self.SetStage(20) ; Accepts deal
	(Self.GetNthAlias(2) as ReferenceAlias).ForceRefTo(_SLS_KennelKeeperRef)
	ObjectReference Gate = Game.GetFormFromFile(0x0D2A87, "SL Survival.esp") as ObjectReference
	_SLS_KennelGateUnlock.Play(Gate)
	Gate.Lock(false, false)
	Gate.SetOpen()
	
	If Init.TrollSexKeepersDesire == 0 ; Devices
		Devious.EquipRandomDds(PlayerRef, Quantity = Menu.TollUtil.TollCostDevices)
	ElseIf Init.TrollSexKeepersDesire == 1 ; Sex
		Int RanInt = Utility.RandomInt(0, 2)
		If RanInt == 0
			Main.StartSexOralMale(akSpeaker = _SLS_KennelKeeperRef, SexCat = 0, DecWillIncFame = true, Victim = none, TeleportType = 0)
		ElseIf RanInt == 1
			Main.StartSexVaginal(akSpeaker = _SLS_KennelKeeperRef, SexCat = 0, DecWillIncFame = true, Victim = none, TeleportType = 0)
		Else
			Main.StartSexAnal(akSpeaker = _SLS_KennelKeeperRef, SexCat = 0, DecWillIncFame = true, Victim = none, TeleportType = 0)
		EndIf
	ElseIf Init.TrollSexKeepersDesire == 2 ; Drugs
		;ForceDrug.DoRapeDrugs(PlayerRef, Quantity = Menu.TollCostDrugs, Silent = false)
		ForceDrug.DoRapeDrugs(PlayerRef, Quantity = 1, Silent = false)
	ElseIf Init.TrollSexKeepersDesire == 3 ; Gold
		PlayerRef.RemoveItem(Game.GetFormFromFile(0xF, "Skyrim.esm"), 50)
	Else ; Tats
		;Int i = Menu.TollCostTattoos
		Int i = 1
		While i > 0
			i -= 1
			RapeTats.AddRapeTat(PlayerRef)
		EndWhile
	EndIf
	Init.TrollSexKeepersDesire = -1
EndFunction

Function KennelTrollEnterTrigger()
	If Self.GetCurrentStageID() == 20
		LockTrollCage()
		PlayerRef.Moveto(Game.GetFormFromFile(0x0D40A1, "SL Survival.esp") as ObjectReference)
		Self.SetStage(30) ; Enters cage
		
		If Game.GetModByName("SLSO.esp") != 255
			RegisterForModEvent("SexLabOrgasmSeparate", "OnSexLabOrgasmSeparate")
		Else
			RegisterForModEvent("HookOrgasmStart", "OnOrgasmStart")
		EndIf
		RegisterForModEvent("HookAnimationStart", "OnAnimationStart")
		
		CheckTrollPosition()
		_SLS_KennelTrollRef.RemoveFromFaction(SexLabAnimatingFaction)
	EndIf
EndFunction

Function KennelTrollOutsideGateTrig()
	If Self.GetCurrentStageID() == 50
		ResetTrollSexQuest()
	EndIf
EndFunction

Function UnlockTrollCage()
	ObjectReference Gate = Game.GetFormFromFile(0x0D2A87, "SL Survival.esp") as ObjectReference
	Gate.SetLockLevel(0)
	Gate.SetOpen()
	(Self.GetNthAlias(2) as ReferenceAlias).Clear()
EndFunction

Function LockTrollCage()
	ObjectReference Gate = Game.GetFormFromFile(0x0D2A87, "SL Survival.esp") as ObjectReference
	Gate.SetOpen(False)
	Gate.Lock(true, false)
	Gate.SetLockLevel(255)
EndFunction

Function CheckTrollPosition()
	If _SLS_KennelTrollRef.GetDistance(_SLS_KwTrollMarker01) > 128.0
		_SLS_KennelTrollRef.MoveTo(_SLS_KwTrollMarker01)
	EndIf
EndFunction

Function PlayerLeavesKennel()
	; Player leave the kennel after accepting deal. Fired from _SLS_OnLocChangeDlhpResumeQuest
	If Self.GetCurrentStageID() >= 20
		ResetTrollSexQuest()
	EndIf
EndFunction

Function ResetTrollSexQuest()
	(Self.GetNthAlias(2) as ReferenceAlias).Clear()
	Self.Reset()
	Self.SetStage(10)
	LockTrollCage()
	CheckTrollPosition()
	OnUpdate()
EndFunction

Int TrollInAnimatingFactionCount

Sound Property _SLS_KennelGateUnlock Auto

Actor Property PlayerRef Auto
Actor Property _SLS_KennelTrollRef Auto
Actor Property _SLS_KennelKeeperRef Auto

ObjectReference Property _SLS_KwTrollMarker01 Auto

Faction Property SexLabAnimatingFaction Auto

Quest Property _SLS_OnLocChangeDlhpResumeQuest Auto

SLS_Main Property Main Auto
SLS_Mcm Property Menu Auto
SLS_Init Property Init Auto
_SLS_ForcedDrugging Property ForceDrug Auto
_SLS_InterfaceDevious Property Devious Auto
_SLS_InterfaceRapeTats Property RapeTats Auto

SexlabFramework Property Sexlab Auto
