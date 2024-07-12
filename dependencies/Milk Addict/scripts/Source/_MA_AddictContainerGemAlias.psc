Scriptname _MA_AddictContainerGemAlias extends ReferenceAlias  

Event OnInit()
	If Self.GetReference() != None
		;Debug.Notification("Container has gems")
		AddictQuest.ContainerHasGems = true
	EndIf
EndEvent

_MA_AddictContainerQuestScript Property AddictQuest Auto