Scriptname _SLS_GuardWarnPickDetect extends Quest  

Event OnInit()
	If Self.IsRunning()
		RegisterForMenu("Lockpicking Menu")
	EndIf
EndEvent

Event OnMenuOpen(String MenuName)
	LockpickMenuOpen = true
	BeginCheckingLockpickingDetect()
EndEvent

Event OnMenuClose(String MenuName)
	LockpickMenuOpen = false
EndEvent

Function BeginCheckingLockpickingDetect()
	While LockpickMenuOpen && !IsDetectedLockpicking()
		Utility.WaitMenuMode(1.0)
	EndWhile
EndFunction

Bool Function IsDetectedLockpicking()
	;Debug.Messagebox("Checking")
	If _SLS_GuardWarnTypeAndCooldown.GetValueInt() == 0
		_SLS_PlayerIsAIDriven.SetValueInt((PlayerRef.GetCurrentPackage() != None) as Int)
		_SLS_GuardWarnDoApproach.SetValueInt(0) ; Disable approach until it can be determined whether to do initial warning or punishment. Avoids guards greeting you with nothing to say if started close to a guard (timing issue)
		_SLS_GuardWarnPickDetectionQuest.Stop()
		_SLS_GuardWarnPickDetectionQuest.Start()
		Actor Guard = (_SLS_GuardWarnPickDetectionQuest.GetNthAlias(0) as ReferenceAlias).GetReference() as Actor
		If Guard ; Detected
			_SLS_GuardWarnTypeAndCooldown.SetValueInt(3)
			If Guard.IsInFaction(_SLS_GuardBehaviourWarningFact)
				_SLS_GuardWarnPickDetectionQuest.Stop()
				Util.SendBeginGuardWarnPunishEvent(_SLS_GuardWarnPickDetectionQuest, Guard)
			EndIf
			_SLS_GuardWarnDoApproach.SetValueInt(1)
			Guard.EvaluatePackage()
			Return true
		Else ; Not detected
			Return false
		EndIf
	
	Else
		Return false
	EndIf
EndFunction

Bool LockpickMenuOpen = false

Quest Property _SLS_GuardWarnPickDetectionQuest Auto

Actor Property PlayerRef Auto

GlobalVariable Property _SLS_GuardWarnDoApproach Auto
GlobalVariable Property _SLS_GuardWarnTypeAndCooldown Auto
GlobalVariable Property _SLS_PlayerIsAIDriven Auto

Faction Property _SLS_GuardBehaviourWarningFact Auto

SLS_Utility Property Util Auto
