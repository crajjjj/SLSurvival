Scriptname sr_infPlayer extends ReferenceAlias

sr_inflateQuest Property inflater Auto
Quest Property srinflateQuest Auto
Quest Property srinflateConfig Auto
int property currentversion = 1 auto
Event OnPlayerLoadGame()
	inflater.RestoreActors()
EndEvent

Event OnCellLoad()
	inflater.RestoreActors()
EndEvent

Function ResetQuests()
	; obsolete
EndFunction

int function VersionCheck()
	return 1
EndFunction

int function DecimalCheck()
	return 1
EndFunction

;/ Event onupdate() /;
	;/ inflater.bDeflateAnimation = true /;
;/ EndEvent /;