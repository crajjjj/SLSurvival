Scriptname _SLS_IntSlso Hidden

; GetController(tid) returns None for an expired/invalid thread id, and ActorAlias() returns None when
; the actor isn't in that thread - guard the whole chain so a thread-end race can't spam None warnings
; and silently no-op. GetAlias centralizes the two None-prone links.
Int Function GetEnjoyment(SexlabFramework Sexlab, Int CurrentTid, Actor akTarget) Global
	sslActorAlias a = GetAlias(Sexlab, CurrentTid, akTarget)
	If a
		Return a.GetFullEnjoyment()
	EndIf
	Return 0
EndFunction

Function ModEnjoyment(SexlabFramework Sexlab, Int CurrentTid, Actor akTarget, Int Enjoyment) Global
	sslActorAlias a = GetAlias(Sexlab, CurrentTid, akTarget)
	If a
		a.BonusEnjoyment(akTarget, Enjoyment)
	EndIf
EndFunction

Function Orgasm(SexlabFramework Sexlab, Int CurrentTid, Actor akTarget, Bool Force = true) Global
	sslActorAlias a = GetAlias(Sexlab, CurrentTid, akTarget)
	If a
		a.OrgasmEffect()
	EndIf
EndFunction

sslActorAlias Function GetAlias(SexlabFramework Sexlab, Int CurrentTid, Actor akTarget) Global
	sslThreadController c = Sexlab.GetController(CurrentTid)
	If c
		Return c.ActorAlias(akTarget)
	EndIf
	Return None
EndFunction
	