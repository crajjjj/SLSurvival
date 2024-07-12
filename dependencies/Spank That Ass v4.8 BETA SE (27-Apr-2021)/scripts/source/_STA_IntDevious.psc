Scriptname _STA_IntDevious Hidden 

Bool  Function GetIsVibrating(Quest zadQuest, Actor akTarget) Global
	Return (zadQuest as zadLibs).IsVibrating(akTarget)
EndFunction

Bool Function GetIsAnimating(Quest zadQuest, Actor akTarget) Global
	Return (zadQuest as zadLibs).IsAnimating(akTarget)
EndFunction

Int Function VibrateEffect(Quest zadQuest, Actor akActor, Int vibStrength, Int duration, Bool teaseOnly = false, Bool silent = true) Global
	Return (zadQuest as zadLibs).VibrateEffect(akActor, vibStrength, duration, teaseOnly, silent)
EndFunction

Function EdgeActor(Quest zadQuest, Actor akTarget) Global
	(zadQuest as zadLibs).EdgeActor(akTarget)
EndFunction
