Scriptname SOS_Maintenance_Alias extends ReferenceAlias  

Event OnPlayerLoadGame()
	(GetOwningQuest() as SOS_Maintenance).Init()
EndEvent
