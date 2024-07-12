Scriptname _SLS_IntSos Hidden

Function SetRevealing(Armor akArmor) Global
	SOS_Data.AddRevealingArmor(akArmor) ; Make half naked cover revealing
EndFunction

Form Function FindSchlongByName(String SchlongName) Global
	Return SOS_API.Get().FindSchlongByName(SchlongName)
EndFunction

Form Function GetSchlong(Actor akActor) Global
	Return SOS_API.Get().GetSchlong(akActor)
EndFunction

Function SetSchlong(Actor akActor, Form Schlong) Global
	SOS_API.Get().SetSchlong(akActor, Schlong)
EndFunction

Function RemoveSchlong(Actor akActor) Global
	SOS_API.Get().RemoveSchlong(akActor)
EndFunction
