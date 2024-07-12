Scriptname SLS_DclBondageAdventure extends ReferenceAlias  

Event OnObjectEquipped(Form akBaseObject, ObjectReference akReference)
	If akBaseObject.HasKeyword(Devious.zad_DeviousHeavyBondage)
		Int OldStage = _SLS_DclTrack.GetCurrentStageID()
		Int Count = 0
		While Count < 20 &&  Init.Dcl_bondageadventurequest.GetCurrentStageID() == OldStage
			Utility.Wait(5.0)
			Count += 1
		EndWhile
		If Count < 20
			If OldStage == 1000 && Init.Dcl_bondageadventurequest.GetCurrentStageID() == 0 ; bondage quest is restarting. Wait more
				Count = 0
				While Count < 20 &&  Init.Dcl_bondageadventurequest.GetCurrentStageID() == 0
					Utility.Wait(5.0)
					Count += 1
				EndWhile
				If Count < 20
					If Init.Dcl_bondageadventurequest.GetCurrentStageID() == 10
						; Reset SLS
						_SLS_DclTrack.Reset()
						SLS_QuestGiver.ForceRefTo((Init.Dcl_bondageadventurequest.getAliasByName("alias_questgiver") as ReferenceAlias).GetReference())
						_SLS_DclTrack.SetCurrentStageID(Init.Dcl_bondageadventurequest.GetCurrentStageID())
						_SLS_DclTrack.SetObjectiveDisplayed(10, true)
					EndIf
				Else
					Debug.Trace("SLS_: Bondage adventure timeout 2")
				EndIf
			Else ; Normal start
				SLS_QuestGiver.ForceRefTo((Init.Dcl_bondageadventurequest.getAliasByName("alias_questgiver") as ReferenceAlias).GetReference())
				_SLS_DclTrack.SetCurrentStageID(Init.Dcl_bondageadventurequest.GetCurrentStageID())
				_SLS_DclTrack.SetObjectiveDisplayed(10, true)
			EndIf
		Else
			Debug.Trace("SLS_: Bondage adventure timeout 1")
		EndIf
	EndIf
EndEvent

Event OnObjectUnequipped(Form akBaseObject, ObjectReference akReference)
	If akBaseObject.HasKeyword(Devious.zad_DeviousHeavyBondage) && _SLS_DclTrack.GetCurrentStageID() == 10
		Int Count = 0
		While _SLS_DclTrack.GetCurrentStageID() == Init.Dcl_bondageadventurequest.GetCurrentStageID() && Count < 10
			Utility.Wait(5)
			Count += 1
		EndWhile
		_SLS_DclTrack.SetCurrentStageID(Init.Dcl_bondageadventurequest.GetCurrentStageID())
		_SLS_DclTrack.SetObjectiveDisplayed(10,false)
	EndIf
EndEvent

SLS_Init Property Init Auto
_SLS_InterfaceDevious Property Devious Auto

ReferenceAlias Property SLS_QuestGiver Auto
ReferenceAlias Property Dcl_QuestGiver Auto Hidden

Quest Property _SLS_DclTrack Auto

Actor Property PlayerRef Auto
