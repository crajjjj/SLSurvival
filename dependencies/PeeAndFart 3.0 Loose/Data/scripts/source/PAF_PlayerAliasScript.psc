Scriptname PAF_PlayerAliasScript extends ReferenceAlias

PAF_MainQuestScript property PAF_MainQuest auto

Event OnObjectUnequipped(Form akBaseObject, ObjectReference akReference)
	if (akBaseObject == PAF_MainQuest.PAF_DiaperArmor || akBaseObject == PAF_MainQuest.PAF_DiaperDirtyArmor)
		PAF_MainQuest.ScaleButt(PAF_MainQuest.PlayerREF, 1.0)	
	endif
endEvent
