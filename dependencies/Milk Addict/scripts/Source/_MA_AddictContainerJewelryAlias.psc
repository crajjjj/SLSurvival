Scriptname _MA_AddictContainerJewelryAlias extends ReferenceAlias  

Event OnInit()
	If Self.GetReference() != None
		;Debug.Notification("Container has jewelry")
		AddictQuest.ContainerHasJewelry = true
	EndIf
EndEvent

_MA_AddictContainerQuestScript Property AddictQuest Auto