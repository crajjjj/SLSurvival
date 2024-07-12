Scriptname _SLS_IntCf Hidden

Int Function GetArousalThreshold(Quest McmQuest) Global
	Return (McmQuest as CFConfigMenu).GenArousalThreshold
EndFunction

Function SetArousalThreshold(Quest McmQuest, Int Threshold) Global
	(McmQuest as CFConfigMenu).GenArousalThreshold = Threshold
EndFunction

