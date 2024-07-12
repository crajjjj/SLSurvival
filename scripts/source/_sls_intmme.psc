Scriptname _SLS_IntMme Hidden 

Function MilkPlayer(Quest MmeMilkQuest) Global
	Int NotificationKey = (MmeMilkQuest as MilkQUEST).NotificationKey
	(MmeMilkQuest as MilkQUEST).OnKeyUp(NotificationKey, HoldTime = 3.0)
EndFunction

Function RefreshBreastSize(Quest MmeMilkQuest, Actor akActor) Global
	(MmeMilkQuest as MilkQUEST).CurrentSize(akActor)
EndFunction
