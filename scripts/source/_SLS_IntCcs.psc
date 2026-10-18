Scriptname _SLS_IntCcs Hidden
{Creation Club Survival Mode (ccqdrsse001-survivalmode.esl) wrappers - the only place referencing its script types.
The quests come in as parameters (looked up by the caller), so nothing here resolves before Survival Mode is known
to be loaded. Needs run from 0 (best) to 1000 (worst): hunger and cold to NeedMaxValue 1000, exhaustion to 960.}

; Hunger ============================================================================================
Function DecreaseHunger(Quest HungerQuest, Float Amount) Global ; the same buffered path Survival Mode's food uses
	(HungerQuest as Survival_NeedHunger).DecreaseHungerBuffered(Amount)
EndFunction

Function IncreaseHunger(Quest HungerQuest, Float Amount) Global
	(HungerQuest as Survival_NeedHunger).IncreaseHunger(Amount)
EndFunction

; Exhaustion ========================================================================================
Function IncreaseExhaustion(Quest ExhaustionQuest, Float Amount) Global
	(ExhaustionQuest as Survival_NeedExhaustion).IncreaseExhaustion(Amount)
EndFunction

Function DecreaseExhaustion(Quest ExhaustionQuest, Float Amount) Global
	; qualitySleep = true: a plain decrease; false is Survival Mode's "slept outdoors" rule that refuses to go below stage 2
	(ExhaustionQuest as Survival_NeedExhaustion).DecreaseExhaustion(Amount, true)
EndFunction

; Cold ==============================================================================================
Function IncreaseCold(Quest ColdQuest, Float Amount) Global
	; customMaxValue -1: never colder than the current area and weather allow, like Survival Mode's own tick
	(ColdQuest as Survival_NeedCold).IncreaseCold(Amount, -1.0)
EndFunction

Function DecreaseCold(Quest ColdQuest, Float Amount) Global
	(ColdQuest as Survival_NeedCold).DecreaseCold(Amount, -1.0, true)
EndFunction

; Area/weather cold level Survival Mode computed on its last cold tick (0 = warm area)
Int Function GetColdLevel(Quest ColdQuest) Global
	Return (ColdQuest as Survival_NeedCold).currentColdLevel
EndFunction

; lowest area cold level that can push the player into "Chilly" (cold stage 2)
Int Function GetChillyColdLevel(Quest ColdQuest) Global
	Return (ColdQuest as Survival_NeedCold).coldStage2ColdLevelMin
EndFunction

Bool Function IsPlayerNearHeat(Quest HeatCheckQuest) Global
	Return (HeatCheckQuest as Survival_HeatCheck).IsPlayerNearHeatAndStanding()
EndFunction

; Shared ============================================================================================
; Lower bound of each stage, index 0..5 (stage 0 = "well fed" / "well rested" bonus below stage 1)
Float[] Function GetStageValues(Quest NeedQuest) Global
	Survival_NeedBase Need = NeedQuest as Survival_NeedBase
	Float[] Values = new Float[6]
	Values[0] = 0.0
	Values[1] = Need.needStage1Value
	Values[2] = Need.needStage2Value
	Values[3] = Need.needStage3Value
	Values[4] = Need.needStage4Value
	Values[5] = Need.needStage5Value
	Return Values
EndFunction

Float Function GetLastUpdateHours(Quest NeedQuest) Global ; in game hours (GameDaysPassed * 24)
	Return (NeedQuest as Survival_NeedBase).lastTimeInGameHours
EndFunction
