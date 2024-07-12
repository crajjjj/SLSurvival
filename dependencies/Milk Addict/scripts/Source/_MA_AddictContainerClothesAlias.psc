Scriptname _MA_AddictContainerClothesAlias extends ReferenceAlias  

Event OnInit()
	If Self.GetReference() != None
		;Debug.Notification("Container has clothes")
		AddictQuest.ContainerHasClothes = true
	EndIf
EndEvent

_MA_AddictContainerQuestScript Property AddictQuest Auto