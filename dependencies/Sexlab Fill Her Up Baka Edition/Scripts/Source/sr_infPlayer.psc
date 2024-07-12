Scriptname sr_infPlayer extends ReferenceAlias

sr_inflateQuest Property inflater Auto
Quest Property srinflateQuest Auto
Quest Property srinflateConfig Auto
int property currentversion = 1 auto
Event OnPlayerLoadGame()
	inflater.maintenance()
EndEvent

Event OnCellLoad()
	inflater.RestoreActors()
EndEvent

Function ResetQuests()
	srinflateQuest.stop()
	srinflateConfig.stop()

	srinflateQuest.start()
	srinflateConfig.start()
EndFunction

int function VersionCheck()
	return 1
EndFunction

int function DecimalCheck()
	return 1
EndFunction