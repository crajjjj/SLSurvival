Scriptname _MA_AddictContainerWeaponAlias extends ReferenceAlias  

Event OnInit()
	If Self.GetReference() != None
		;Debug.Notification("Container has weapons")
		AddictQuest.ContainerHasWeapons = true
	EndIf
EndEvent

_MA_AddictContainerQuestScript Property AddictQuest Auto