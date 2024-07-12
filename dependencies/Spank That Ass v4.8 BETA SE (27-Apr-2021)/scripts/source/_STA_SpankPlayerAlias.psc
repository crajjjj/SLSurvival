Scriptname _STA_SpankPlayerAlias extends ReferenceAlias  

_STA_SpankUtil Property SpankUtil Auto
_STA_SexDialogUtil Property SexDialog Auto

Actor Property PlayerRef Auto

Event OnPlayerLoadGame()
	SpankUtil.PlayerLoadsGame()
	SexDialog.PlayerLoadsGame()
EndEvent

Function BeginGameTimeUpdates()
	RegisterForSingleUpdateGameTime(1.0)
	Return
EndFunction

Event OnUpdateGameTime()
	SpankUtil.DoGameTimeUpdate()
	RegisterForSingleUpdateGameTime(1.0)
EndEvent
