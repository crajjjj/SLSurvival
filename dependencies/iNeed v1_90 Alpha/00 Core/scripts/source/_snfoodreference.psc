Scriptname _SNFoodReference extends ReferenceAlias 

_SNQuestScript Property _SNQuest Auto 

Event OnInit()
	ObjectReference Food = GetRef()
	If Food
		If _SNQuest.SKSEVersion > 0.0
			If !Food.GetEnableParent()
				Food.DisableNoWait()
			EndIf
		Else
			Food.DisableNoWait()
		EndIf
	EndIf
EndEvent