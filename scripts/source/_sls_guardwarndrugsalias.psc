Scriptname _SLS_GuardWarnDrugsAlias extends ReferenceAlias  

Event OnInit()
	RegisterForModEvent("PlayerTrack_Start", "On_ForceDrugsBegin")
    RegisterForModEvent("PlayerTrack_End", "OnForceDrugsEnd")
EndEvent

Event OnUpdate()
	IsInForceDrugsPeriod = false
EndEvent

Event PlayerLoadsGame()
	If Init.SkoomaWhoreInstalled && Init.MilkAddictInstalled
		GoToState("SkoomaLactacid")
	ElseIf Init.SkoomaWhoreInstalled
		GoToState("Skooma")
	ElseIf Init.MilkAddictInstalled
		GoToState("Lactacid")
	Else
		GoToState("")
	EndIf
EndEvent

Event On_ForceDrugsBegin(Form FormRef, int tid)
    IsInForceDrugsPeriod = true
EndEvent

Event OnForceDrugsEnd(Form FormRef, int tid)
	RegisterForSingleUpdate(1.0)
EndEvent

Event OnObjectEquipped(Form akBaseObject, ObjectReference akReference)
EndEvent

State Skooma
	Event OnObjectEquipped(Form akBaseObject, ObjectReference akReference)
		If akBaseObject as Potion
			If !IsInForceDrugsPeriod && IsSkoomaDrug(akBaseObject)
				DidDrugs()
			EndIf
		EndIf
	EndEvent
EndState

State Lactacid
	Event OnObjectEquipped(Form akBaseObject, ObjectReference akReference)
		If akBaseObject as Potion
			If !IsInForceDrugsPeriod && IsLactacid(akBaseObject)
				DidDrugs()
			EndIf
		EndIf
	EndEvent
EndState

State SkoomaLactacid
	Event OnObjectEquipped(Form akBaseObject, ObjectReference akReference)
		If !IsInForceDrugsPeriod && akBaseObject as Potion
			If IsSkoomaDrug(akBaseObject) || IsLactacid(akBaseObject)
				DidDrugs()
			EndIf
		EndIf
	EndEvent
EndState

Bool Function IsSkoomaDrug(Form akBaseObject)
	If _SLS_DrugsListWoLactacid.HasForm(akBaseObject)
		Return true
	EndIf
	Return false
EndFunction

Bool Function IsLactacid(Form akBaseObject)
	If akBaseObject == Init.MME_Lactacid
		Return true
	EndIf
	Return false
EndFunction

Function DidDrugs()
	If _SLS_GuardWarnTypeAndCooldown.GetValueInt() == 0 ; Check is another warning in progress or in cooldown
		_SLS_PlayerIsAIDriven.SetValueInt((PlayerRef.GetCurrentPackage() != None) as Int)
		_SLS_GuardWarnDoApproach.SetValueInt(0)
		_SLS_GuardWarnDrugDetectionQuest.Stop()
		_SLS_GuardWarnDrugDetectionQuest.Start()
		Actor Guard = GuardAlias.GetReference() as Actor
		If Guard ; Detected
			_SLS_GuardWarnTypeAndCooldown.SetValueInt(2)
			If Guard.IsInFaction(_SLS_GuardBehaviourWarningFact)
				_SLS_GuardWarnDrugDetectionQuest.Stop()
				Util.SendBeginGuardWarnPunishEvent(_SLS_GuardWarnDrugDetectionQuest, Guard)
			EndIf
			_SLS_GuardWarnDoApproach.SetValueInt(1)
			Guard.EvaluatePackage()
		EndIf
	EndIf
EndFunction

Bool IsInForceDrugsPeriod = false

Quest Property _SLS_GuardWarnDrugDetectionQuest Auto

Actor Property PlayerRef Auto

GlobalVariable Property _SLS_GuardWarnDoApproach Auto
GlobalVariable Property _SLS_GuardWarnTypeAndCooldown Auto
GlobalVariable Property _SLS_PlayerIsAIDriven Auto

Faction Property _SLS_GuardBehaviourWarningFact Auto

Formlist Property _SLS_DrugsListWoLactacid Auto

ReferenceAlias Property GuardAlias Auto

SLS_Init Property Init Auto
SLS_Utility Property Util Auto
