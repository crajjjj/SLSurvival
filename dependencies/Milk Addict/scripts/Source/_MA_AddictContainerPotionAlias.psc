Scriptname _MA_AddictContainerPotionAlias extends ReferenceAlias  

Event OnInit()
	If Self.GetReference() != None
		;Debug.Notification("Container has potions")
		AddictQuest.ContainerHasPotions = true
	EndIf
EndEvent

_MA_AddictContainerQuestScript Property AddictQuest Auto