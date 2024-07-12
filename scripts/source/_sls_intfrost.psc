Scriptname _SLS_IntFrost Hidden

Int Function GetPlayerHeatSourceLevel() Global
	Return FrostUtil.GetPlayerHeatSourceLevel()
EndFunction

Int Function IsColdEnvironment() Global
	Return FrostUtil.GetCurrentTemperature()
EndFunction

Int Function GetTemperature() Global
	Return FrostUtil.GetCurrentTemperature()
EndFunction

Function ModWetness(Float Amount) Global ; amount: The amount to modify the player's wetness by. Positive numbers increase wetness, negative values decrease wetness.
	FrostUtil.ModPlayerWetness(Amount)
EndFunction

Function ModExposure(Float Amount) Global ; amount: The amount to modify the player's exposure by. Positive numbers increase exposure, negative values decrease exposure.
	FrostUtil.ModPlayerExposure(Amount)
EndFunction

Bool Function IsCurrentWeatherSevere() Global
	Return FrostUtil.IsWeatherSevere(FrostUtil.GetCurrentWeatherActual())
EndFunction

ObjectReference Function GetCurrentTent() Global
	Return CampUtil.GetCurrentTent()
EndFunction

Bool Function IsPlayerTakingShelter() Global
	Return FrostUtil.IsPlayerTakingShelter()
EndFunction

