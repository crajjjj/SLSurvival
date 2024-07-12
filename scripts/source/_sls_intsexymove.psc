Scriptname _SLS_IntSexyMove  Hidden 

Function ChangeAnimationSet(Quest SmQuest, Int MenuSelect, Actor akTarget) Global
	FNISSMQuestScript FNISSMquest = SmQuest as FNISSMQuestScript
	Bool Sm360 = FNISSMquest.SM360
	bool bOk
	If MenuSelect == 0
		bOk = FNIS_aa.SetAnimGroup(akTarget, "_mt", 0, 0, "FNIS Sexy Move", true)
		bOk = bOk && FNIS_aa.SetAnimGroup(akTarget, "_mtx", 0, 0, "FNIS Sexy Move", true)
	Else
		If ( SM360 && ( FNISSMquest.FNISs3ModID >= 0 ))
			bOk = FNIS_aa.SetAnimGroup(akTarget, "_mt", FNISSMQuest.FNISs3MtBase, MenuSelect - 1, "FNIS Sexy Move(360)", true)
			bOk = bOk && FNIS_aa.SetAnimGroup(akTarget, "_mtx", FNISSMQuest.FNISs3MtxBase, MenuSelect - 1, "FNIS Sexy Move(360)", true)
		Else
			bOk = FNIS_aa.SetAnimGroup(akTarget, "_mt", FNISSMQuest.FNISsmMtBase, MenuSelect - 1, "FNIS Sexy Move", true)
			bOk = bOk && FNIS_aa.SetAnimGroup(akTarget, "_mtx", FNISSMQuest.FNISsmMtxBase, MenuSelect - 1, "FNIS Sexy Move", true)
		EndIf
	EndIf
EndFunction
