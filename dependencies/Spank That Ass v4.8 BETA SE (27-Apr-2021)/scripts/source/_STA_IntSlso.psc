Scriptname _STA_IntSlso Hidden 

Function DoSpankModEnjoyment(Int CurrentTid, Actor akTarget, Int Enjoyment, Quest SexLabQuestFramework) Global
	(SexLabQuestFramework as SexlabFramework).GetController(CurrentTid).ActorAlias(akTarget).BonusEnjoyment(akTarget, Enjoyment)
EndFunction
