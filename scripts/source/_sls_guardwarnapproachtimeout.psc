Scriptname _SLS_GuardWarnApproachTimeout extends Quest  

Float Timeout = 10.0

Actor Guard

Bool IsTalkingToGuard = false

Event OnInit()
	If Self.IsRunning()
		Guard = (Self.GetNthAlias(0) as ReferenceAlias).GetReference() as Actor
		If Guard
			RegisterForMenu("Dialogue Menu")
			RegisterForSingleUpdate(Timeout)
		EndIf
	EndIf
EndEvent

Event OnUpdate()
	If Self.IsRunning()
		(Game.GetFormFromFile(0x000D64, "SL Survival.esp") as SLS_Utility).StopAllGuardWarnApproachQuests(Guard, DoCooldown = true)
	EndIf
EndEvent

Event OnMenuOpen(String MenuName)
	; If guard is talking to the player then don't stop quest - Causes dialgoue to stop mid progress
	If Guard.IsInDialogueWithPlayer()
		IsTalkingToGuard = true
		UnRegisterForUpdate()
	EndIf
EndEvent

Event OnMenuClose(String MenuName)
	If IsTalkingToGuard ; If the player was talking to the guard and the menu closes prematurely (death, sex scene start), stop all approaches. This might result in StopAllGuardWarnApproachQuests() running more than once (it's also run at the end of dialogue)
		(Game.GetFormFromFile(0x000D64, "SL Survival.esp") as SLS_Utility).StopAllGuardWarnApproachQuests(Guard, DoCooldown = true)
	EndIf
EndEvent
