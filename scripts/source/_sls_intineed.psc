Scriptname _SLS_IntIneed Hidden 

Bool Function IsNeedsModActive(Quest SnQuest) Global
	Return (SnQuest as _SNQuestScript).EnableMod
EndFunction

Function Eat(Float FoodPoints, Quest SnQuest) Global
	(SnQuest as _SNQuestScript).ModHunger(FoodPoints)
EndFunction

Function Drink(Float WaterPoints, Quest SnQuest) Global
	(SnQuest as _SNQuestScript).ModThirst(WaterPoints)
EndFunction

Function ModFatigue(Float SleepAmount, Quest SnQuest) Global ; +SleepAmount = Remove Fatigue. -SleepAmount = Add Fatigue
	;(SnQuest as _SNQuestScript).TimePassed = 100
	(SnQuest as _SNQuestScript).ModFatigue(SleepAmount)
EndFunction

Float Function GetLastHungerUpdateTime(Quest SnQuest) Global
	Return (SnQuest as _SNQuestScript).TimeUpdate
EndFunction

Float Function GetFatigue(Quest SnQuest) Global
	Return (SnQuest as _SNQuestScript).FatigueState
EndFunction
