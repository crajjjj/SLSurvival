Scriptname _SLS_IntCf Hidden

Int Function GetArousalThreshold(Quest McmQuest) Global
	CreatureFrameworkConfig Config = McmQuest as CreatureFrameworkConfig
	If Config
		Return Config.GenArousalThreshold
	EndIf
	Return -2 ; CF config unavailable - sentinel the caller ignores
EndFunction

Function SetArousalThreshold(Quest McmQuest, Int Threshold) Global
	CreatureFrameworkConfig Config = McmQuest as CreatureFrameworkConfig
	If Config
		Config.GenArousalThreshold = Threshold
	EndIf
EndFunction
