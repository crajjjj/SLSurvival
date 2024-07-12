Scriptname _SLS_IntEsd  Hidden

Bool Function IsNeedsModActive(Quest _knnQuest) Global
	Return (_knnQuest as aaaKNNBasicNeedsQuest).aaaKNNIsEnableMessage.GetValueInt()
EndFunction

Function Eat(Float FoodPoints) Global
	KNNPlugin_Utility.ModBasicNeeds("hungry", FoodPoints)
EndFunction

Function Drink(Float WaterPoints) Global
	KNNPlugin_Utility.ModBasicNeeds("thirsty", WaterPoints)
EndFunction

Function ModFatigue(Float SleepAmount) Global ; +SleepAmount = Remove Fatigue. -SleepAmount = Add Fatigue
	KNNPlugin_Utility.ModBasicNeeds("Sleepiness", SleepAmount)
EndFunction

Float Function GetHunger() Global
	Return KNNPlugin_Utility.GetBasicNeeds("hungry")
EndFunction

Float Function GetThirst() Global
	Return KNNPlugin_Utility.GetBasicNeeds("thirsty")
EndFunction

Float Function GetFatigue() Global
	Return KNNPlugin_Utility.GetBasicNeeds("Sleepiness")
EndFunction

Float Function GetLastHungerUpdateTime() Global
	Return 0.0
EndFunction
