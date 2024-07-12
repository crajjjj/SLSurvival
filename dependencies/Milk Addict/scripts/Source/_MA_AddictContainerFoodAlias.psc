Scriptname _MA_AddictContainerFoodAlias extends ReferenceAlias  

Event OnInit()
	If Self.GetReference() != None
		;Debug.Notification("Container has food")
		AddictQuest.ContainerHasFood = true
	EndIf
EndEvent

_MA_AddictContainerQuestScript Property AddictQuest Auto