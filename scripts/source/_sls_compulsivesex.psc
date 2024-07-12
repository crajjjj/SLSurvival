Scriptname _SLS_CompulsiveSex extends Quest  

Event OnInit()
	If Self.IsRunning()
		If Game.GetModByName("SLSO.esp") != 255
			RegisterForEvents()
			StorageUtil.SetIntValue(None, "_SLS_CompulsiveSexTutorial", 1)
		Else
			StorageUtil.SetIntValue(Menu, "CompulsiveSex", 0)
			Self.Stop()
		EndIf
	EndIf
EndEvent

Function RegisterForEvents()
	UnRegisterForAllModEvents()
	RegisterForModEvent("HookAnimationStart", "OnAnimationStart")
	;RegisterForModEvent("HookStageStart", "OnStageStart")
EndFunction

Event OnKeyDown(Int KeyCode)
	If !Utility.IsInMenuMode() && Game.GetCameraState() == 3
		If KeyCode == 264 ; Wheel up
			ManualAdjust = PapyrusUtil.ClampFloat((ManualAdjust + 0.2), -0.6, 0.6)
			;Debug.Notification("Lost, I start fucking harder " + ManualAdjust) ; Notification Too slow/spammy
		Else
			ManualAdjust = PapyrusUtil.ClampFloat((ManualAdjust - 0.2), -0.6, 0.6)
			;Debug.Notification("I start fucking slower " + ManualAdjust)
		EndIf
	EndIf
EndEvent

Event OnAnimationStart(int tid, bool HasPlayer)
	BeginAutoFucking(tid, HasPlayer, false)
EndEvent

Function BeginAutoFucking(int tid, bool HasPlayer, Bool ManualStart)
	If HasPlayer || ManualStart
		CurrentTid = Sexlab.FindPlayerController()
		SlsoEnjoyKey = JsonUtil.GetIntValue("/SLSO/Config.json", "hotkey_bonusenjoyment")
		;SlsoUtilityKey = JsonUtil.GetIntValue("/SLSO/Config.json", "hotkey_utility")
		If SlsoEnjoyKey > 0; && SlsoUtilityKey > 0
			Bool DoIt = false
			;Debug.Messagebox("Level: " + Util.GetSkoomaJunkieLevel(PlayerRef, IsWithdrawing = true))
			If !ManualStart
				If PlayerRef.GetFactionRank(Game.GetFormFromFile(0x03FC36, "SexLabAroused.esm") as Faction) >= 100
					NotifyStr = "Addled by lust I begin fucking"
					DoIt = true
				ElseIf Util.IsDrugged(PlayerRef, CheckSkooma = true, CheckSW = true, CheckLactacid = true)
					NotifyStr = "High on skooma I can't help but fuck"
					DoIt = true
				ElseIf Util.GetSkoomaJunkieLevel(PlayerRef, IsWithdrawing = true) >= 5
					NotifyStr = "Unable to think clearly I begin fucking"
					DoIt = true
				EndIf
			Else
				DoIt = true
			EndIf
			If DoIt
				IsFucking = true
				Tutorial(ManualStart)
				;PlayerHasCum = true
				;If PlayerRef.GetFactionRank(Game.GetFormFromFile(0x03FC36, "SexLabAroused.esm") as Faction) >= 50 || !Sexlab.HookAnimation(CurrentTid).HasTag("Oral")
				;	PlayerHasCum = false
				;	Debug.Messagebox("Hold key")
				;	Input.HoldKey(SlsoUtilityKey)
				;EndIf
				ManualAdjust = 0.0
				RegisterForModEvent("HookAnimationEnd", "OnAnimationEnd")
				RegisterForModEvent("HookStageStart", "OnStageStart")
				;RegisterForModEvent("SexLabOrgasmSeparate", "OnSexLabOrgasmSeparate")
				RegisterForMenu("Console")
				RegisterForMenu("InventoryMenu")
				StageCount = Sexlab.HookAnimation(CurrentTid).StageCount as Float
				RegisterForKey(264)
				RegisterForKey(265)
				If !ManualStart
					IsCompulsiveFuck = true
					Utility.Wait(3.0)
					Debug.Notification(NotifyStr)
				Else
					IsCompulsiveFuck = false
					SetUpdateTime(CurrentTid)
				EndIf
				RegisterForSingleUpdate(0.1)
			EndIf
		EndIf
	EndIf
EndFunction

Function ManualStopFucking()
	If !IsCompulsiveFuck
		SexStopped()
	Else
		Debug.Notification("I can't help myself")
	EndIf
EndFunction

Event OnStageStart(int tid, bool HasPlayer)
	If HasPlayer
		SetUpdateTime(tid)
	EndIf
EndEvent

Function SetUpdateTime(Int tid)
	Stage = SexLab.GetController(tid).Stage as Float
	If Stage == StageCount ; Last stage, slow down
		UpdateTime = (0.1 + (((StageCount + 1) - 2) * 0.25)) * TimeBetweenFucks
		
	Else
		UpdateTime = (0.1 + (((StageCount + 1) - Stage) * 0.25)) * TimeBetweenFucks
	EndIf
EndFunction

Event OnUpdate()
	If PlayerRef.GetActorValuePercentage("Stamina") >= 0.10 && !Utility.IsInMenuMode()
		If PlayerRef.IsInFaction(SexlabAnimatingFaction)
			;Debug.Trace("_SLS_: OnUpdate(): " + SlsoEnjoyKey)
			;Debug.Notification("Fucking: " + SlsoEnjoyKey)
			;Debug.Messagebox("IsKeyPressed: " + Input.IsKeyPressed(SlsoUtilityKey))
			Input.TapKey(SlsoEnjoyKey)
			
		Else ;  Player somehow is not having sex anymore. Terminate updates. 
			SexStopped()
			Return
		EndIf
	EndIf
	RegisterForSingleUpdate(UpdateTime - (UpdateTime * ManualAdjust) + Utility.RandomFloat(0.0, 0.2))
EndEvent
;/
Event OnSexLabOrgasmSeparate(Form ActorRef, Int tid)
	If ActorRef == PlayerRef
		;Debug.Messagebox("Release Key")
		Input.ReleaseKey(SlsoUtilityKey)
		PlayerHasCum = true
	EndIf
EndEvent
/;
Event OnAnimationEnd(int tid, bool HasPlayer)
	If HasPlayer
		SexStopped()
	EndIf
EndEvent

Function SexStopped()
	UnRegisterForUpdate()
	;Input.ReleaseKey(SlsoUtilityKey)
	UnRegisterForModEvent("HookAnimationEnd")
	UnRegisterForModEvent("HookStageStart")
	;UnRegisterForModEvent("SexLabOrgasmSeparate")
	UnRegisterForAllKeys()
	UnRegisterForAllMenus()
	IsFucking = false
	Stage = 1.0
EndFunction
;/
Event OnMenuOpen(String MenuName)
	If !PlayerHasCum
		Input.ReleaseKey(SlsoUtilityKey)
	EndIf
EndEvent

Event OnMenuClose(String MenuName)
	If !PlayerHasCum
		Input.HoldKey(SlsoUtilityKey)
	EndIf
EndEvent
/;
Function Tutorial(Bool ManualStart)
	If !ManualStart && StorageUtil.GetIntValue(None, "_SLS_CompulsiveSexTutorial", Missing = 0) == 1
		StorageUtil.UnSetIntValue(None, "_SLS_CompulsiveSexTutorial")
		Debug.Messagebox("Sexlab Survival\n\nYour character is in a compromised state and has begun fucking without your input. \n\nWhile in FreeCam mode you adjust how fast or slow she fucks by using mouse wheel up/down. But you can not stop her from fucking\n\nYour character may fuck compulsively if she's high on skooma/drugs OR highly aroused OR has achieved junkie status in Skooma Whore.\n\nDisable 'Compulsive Sex' in the 'Sex' menu if you wish to disable this")
	EndIf
EndFunction

;Bool PlayerHasCum
Bool Property IsCompulsiveFuck = false Auto Hidden
Bool Property IsFucking = false Auto Hidden

Int SlsoEnjoyKey
Int SlsoUtilityKey
Int CurrentTid

Float Stage = 1.0
Float StageCount
Float UpdateTime
Float ManualAdjust = 0.0

Float Property TimeBetweenFucks = 1.0 Auto Hidden

String NotifyStr

Actor Property PlayerRef Auto

Faction Property SexlabAnimatingFaction Auto

SLS_Utility Property Util Auto
SLS_Init Property Init Auto
SLS_Mcm Property Menu Auto

SexlabFramework Property Sexlab Auto
