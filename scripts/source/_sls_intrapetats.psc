Scriptname _SLS_IntRapeTats Hidden

Function AddRapeTat(Quest TatsQuest, Actor akTarget) Global
	(TatsQuest as rapeTattoos).doTattooActionFor(akTarget)
	Debug.Trace("_SLS_: AddTat to " + akTarget)
EndFunction
