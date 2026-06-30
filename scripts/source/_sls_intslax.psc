Scriptname _SLS_IntSlax  Hidden

Int Function GetVersion(Quest SlaxConfigQuest) Global
	Return (SlaxConfigQuest as slaConfigScr).GetVersion()
EndFunction

; Packed framework version (MMmmppp, e.g. 30200001 for NG 3.2.1; OSL=20140124, SLAXSE=20190720).
; This is the documented portable fork/feature gate - distinct from the config GetVersion above.
Int Function GetFrameworkVersion(Quest sla_FrameworkQuest) Global
	Return (sla_FrameworkQuest as slaFrameworkScr).GetVersion()
EndFunction

Int Function GetActorArousal(Quest sla_FrameworkQuest, Actor who) Global
	Return (sla_FrameworkQuest as slaFrameworkScr).GetActorArousal(who)
EndFunction

; The SLA adapter quest in SL Survival.esp. Lets gameplay scripts reach the presence-gated interface
; without a CK-filled property; may be None only if the plugin form ever fails to resolve.
_SLS_InterfaceSlax Function GetInterface() Global
	Return Game.GetFormFromFile(0x07DF73, "SL Survival.esp") as _SLS_InterfaceSlax
EndFunction

; Convenience read used across SLS gameplay scripts: live arousal (0-100) for `who`, routed through the
; presence-gated interface so it safely returns 0 when SLA is absent. Replaces direct sla_Arousal
; faction-rank reads, which lag SLA's scan cycle and return -1 for actors SLA hasn't scanned yet.
Int Function GetArousal(Actor who) Global
	_SLS_InterfaceSlax sla = GetInterface()
	If sla
		Return sla.GetActorArousal(who)
	EndIf
	Return 0
EndFunction

; Tease nudge for `who` (teasemyself, sex-scene minimum): a DECAYING arousal bump that fades on its own.
; Routed through the presence-gated interface (no-op when SLA absent).
Function TeaseArousal(Actor who, Float amount) Global
	_SLS_InterfaceSlax sla = GetInterface()
	If sla
		sla.TeaseArousal(who, amount)
	EndIf
EndFunction

; Fondling nudge for `who`: a decaying, capped arousal bump (applied at creature-sex start).
Function FondleArousal(Actor who, Float amount) Global
	_SLS_InterfaceSlax sla = GetInterface()
	If sla
		sla.FondleArousal(who, amount)
	EndIf
EndFunction

Int Function SetActorExposure(Quest sla_InternalQuest, Actor who, Int newActorExposure) Global
	Return (sla_InternalQuest as slaFrameworkScr).SetActorExposure(who, newActorExposure)
EndFunction

; --- Named dynamic arousal effects via SLA NG's SloangNative API (SLA NG 3.2.0+) ----------------------
; These keep SLS's contribution in its own named channel instead of the shared exposure. Each pairs a
; ModDynamicEffect (accumulate toward a cap) with a SetDynamicEffect that pins the timed behaviour --
; initialValue 0 is ignored by the engine, so the Set keeps the accumulated value and only sets the
; function. SloangNative resolves by name at runtime; callers must gate on GetFrameworkVersion (>= 3.2.0).

; Accumulate `modifier`, then (re)apply a decay so the bump fades toward 0. halfLifeDays = half-life in game days.
Function ModDecayingArousalEffect(Actor who, String effectId, Float modifier, Float halfLifeDays, Float cap = 100.0) Global
	Float limit = cap ; upper bound for a positive modifier (the seed / tease ceiling)
	If modifier < 0.0
		limit = 0.0 ; limit direction follows the sign of modifier (lower bound when negative)
	EndIf
	SloangNative.ModDynamicEffect(who, effectId, modifier, limit)
	SloangNative.SetDynamicEffect(who, effectId, 0.0, SloangNative.FuncDecay(), halfLifeDays, 0.0)
EndFunction

