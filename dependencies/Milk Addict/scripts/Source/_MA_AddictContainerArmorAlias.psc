Scriptname _MA_AddictContainerArmorAlias extends ReferenceAlias  

Event OnInit()
	If Self.GetReference() != None
		;Debug.Notification("Container has armor")
		AddictQuest.ContainerHasArmor = true
	EndIf
EndEvent

_MA_AddictContainerQuestScript Property AddictQuest Auto