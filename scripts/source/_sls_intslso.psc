Scriptname _SLS_IntSlso Hidden

Int Function GetEnjoyment(SexlabFramework Sexlab, Int CurrentTid, Actor akTarget) Global
	Return Sexlab.GetController(CurrentTid).ActorAlias(akTarget).GetFullEnjoyment()
EndFunction

Function ModEnjoyment(SexlabFramework Sexlab, Int CurrentTid, Actor akTarget, Int Enjoyment) Global
	;Debug.Messagebox("Sexlab: " + Sexlab + "\nCurrentTid: " + CurrentTid + "\nEnjoyment: " + Enjoyment + "\nThread: " + Sexlab.GetController(CurrentTid))
	Sexlab.GetController(CurrentTid).ActorAlias(akTarget).BonusEnjoyment(akTarget, Enjoyment)
EndFunction

Function Orgasm(SexlabFramework Sexlab, Int CurrentTid, Actor akTarget, Bool Force = true) Global
	Sexlab.GetController(CurrentTid).ActorAlias(akTarget).OrgasmEffect()
EndFunction
	