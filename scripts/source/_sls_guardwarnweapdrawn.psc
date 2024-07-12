Scriptname _SLS_GuardWarnWeapDrawn extends Quest  

Event OnInit()
	If Self.IsRunning()
		RegisterForSingleUpdate(0.1)
	EndIf
EndEvent

Event OnUpdate()
	;Debug.Messagebox("update")
	If IsInit
		IsInit = false
		DoInit()
	ElseIf !CheckIsDetected()
		RegForUpdate()
	EndIf
EndEvent

Function DoInit()
	_SLS_GuardWarnDoApproach.SetValueInt(0) ; Disable approach until it can be determined whether to do initial warning or punishment. Avoids guards greeting you with nothing to say if started close to a guard (timing issue)
	_SLS_GuardWarnWeapDrawnDetectionQuest.Stop()
	If !CheckIsDetected()
		RegForUpdate()
	EndIf
EndFunction

Function RegForUpdate()
	If PlayerRef.IsInCombat()
		RegisterForSingleUpdate(30.0)
	Else
		RegisterForSingleUpdate(3.0)
	EndIf
EndFunction

Bool Function CheckIsDetected()
	If _SLS_GuardWarnTypeAndCooldown.GetValueInt() == 0
		_SLS_PlayerIsAIDriven.SetValueInt((PlayerRef.GetCurrentPackage() != None) as Int)
		_SLS_GuardWarnWeapDrawnDetectionQuest.Stop()
		_SLS_GuardWarnWeapDrawnDetectionQuest.Start()
		Actor Guard = (_SLS_GuardWarnWeapDrawnDetectionQuest.GetNthAlias(0) as ReferenceAlias).GetReference() as Actor
		If Guard ; Detected
			;Debug.Messagebox("Detected")
			_SLS_GuardWarnTypeAndCooldown.SetValueInt(6)
			If Guard.IsInFaction(_SLS_GuardBehaviourWarningFact)
				_SLS_GuardWarnWeapDrawnDetectionQuest.Stop()
				Util.SendBeginGuardWarnPunishEvent(_SLS_GuardWarnWeapDrawnDetectionQuest, Guard)
			EndIf
			_SLS_GuardWarnDoApproach.SetValueInt(1)
			Guard.EvaluatePackage()
			Return true
		Else ; Not detected
			;Debug.Messagebox("NOT Detected")
			Return false
		EndIf
	
	Else
		Return false
	EndIf
EndFunction

Bool IsInit = true

Actor Property PlayerRef Auto

Quest Property _SLS_GuardWarnWeapDrawnDetectionQuest Auto

Faction Property _SLS_GuardBehaviourWarningFact Auto

GlobalVariable Property _SLS_GuardWarnDoApproach Auto
GlobalVariable Property _SLS_GuardWarnTypeAndCooldown Auto
GlobalVariable Property _SLS_PlayerIsAIDriven Auto

SLS_Utility Property Util Auto
