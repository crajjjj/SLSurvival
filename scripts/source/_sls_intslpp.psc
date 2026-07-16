Scriptname _SLS_IntSlpp Hidden
{SexLab P+ (SLPP) wrappers. The only place referencing the P+-only script type SexLabThread.
P+ replaces SexLab.esm in place, so presence is probed via its SKSE plugin version rather
than Game.GetModByName. Compile note: SexLabThread resolves from
"dependencies/SexLab Framework PPLUS", which the ppj imports LAST - only P+ script names that
do NOT collide with the bundled legacy SexLab (like it) may be referenced here; colliding
names (sslThreadModel, SexLabFramework, ...) resolve to the legacy sources.}

Bool Function GetIsInstalled() Global
	; SexLab P+ 2.17.1+ packs its DLL version as (major<<24)|(minor<<16)|(patch<<4)|build;
	; 2.17.1.0 = 34668560. Legacy SexLab loads no "SexLabUtil" plugin so this is negative
	; there, and P+ builds older than 2.17.1 (predating the packing change and gated out
	; with them the SexLabThread interaction API) fall back to the legacy checks.
	Return SKSE.GetPluginVersion("SexLabUtil") >= 34668560
EndFunction

; --- Pair-precise P+ queries. GetThread backs the enjoyment wrappers below; GetOralState
; --- verifies the orifice SexLabApplyCumFX reports (P+ falls back to scene tags when a scene
; --- registered no collision data). GetOralPartner has no caller yet - kept as a building block
; --- for future pair-precise queries (e.g. CumAddict auto-suck).

; The P+ public thread API for a thread id. The compile-time type must widen to Quest first
; because the legacy sslThreadController this compiles against doesn't extend SexLabThread;
; at runtime under P+ the controller IS a SexLabThread descendant, so the cast holds.
; None on legacy SexLab.
SexLabThread Function GetThread(SexlabFramework Sexlab, Int tid) Global
	Quest t = Sexlab.GetController(tid)
	Return t as SexLabThread
EndFunction

; -1 = no P+ collision data for this scene (caller must fall back to legacy checks)
;  0 = collision data registered and akSucker is NOT orally on akPartner
;  1 = akSucker is orally on akPartner (actor-pair precise)
Int Function GetOralState(SexlabFramework Sexlab, Int tid, Actor akSucker, Actor akPartner) Global
	SexLabThread t = GetThread(Sexlab, tid)
	If !t || !t.IsInteractionRegistered()
		Return -1
	EndIf
	; Mirror P+'s own oral test in sslThreadModel.ApplyCumFX - "any_oral = pOral || pDeepthroat ||
	; pLickingShaft". These are independent collision flags, so CTYPE_Oral alone would report 0 for a
	; deepthroat/shaft-licking load that P+ reports as oral, and the caller would downgrade a real
	; swallow to a facial.
	If t.HasInteractionType(t.CTYPE_Oral, akSucker, akPartner) || t.HasInteractionType(t.CTYPE_Deepthroat, akSucker, akPartner) || t.HasInteractionType(t.CTYPE_LickingShaft, akSucker, akPartner)
		Return 1
	EndIf
	Return 0
EndFunction

; Whom akSucker is orally pleasuring right now, or None. CTYPE_Oral is genderless - the
; partner can be female (cunnilingus) - so callers wanting a cum source must gender-check.
Actor Function GetOralPartner(SexlabFramework Sexlab, Int tid, Actor akSucker) Global
	SexLabThread t = GetThread(Sexlab, tid)
	If t && t.IsInteractionRegistered()
		Return t.GetPartnerByType(akSucker, t.CTYPE_Oral)
	EndIf
	Return None
EndFunction

; --- P+ native enjoyment. P+ folded SexLab Separate Orgasm into its core and exposes enjoyment
; --- on SexLabThread under different names than SLSO's sslActorAlias (GetEnjoyment/AdjustEnjoyment/
; --- ForceOrgasm vs GetFullEnjoyment/BonusEnjoyment/OrgasmEffect). These mirror _SLS_IntSlso so
; --- _sls_cumswallow can route its bonus-enjoyment/forced-orgasm feature to whichever framework is
; --- loaded; without them the feature no-ops under P+ (Slso interface inactive, no SLSO.esp). Same
; --- 0-100 scale as SLSO (100 = orgasm-ready), so the caller's >=100 gate carries over unchanged.
; --- Enjoyment only tracks when the P+ user has separate orgasms / internal enjoyment enabled.
Int Function GetEnjoyment(SexlabFramework Sexlab, Int tid, Actor akTarget) Global
	SexLabThread t = GetThread(Sexlab, tid)
	If t
		Return t.GetEnjoyment(akTarget)
	EndIf
	Return 0
EndFunction

Function ModEnjoyment(SexlabFramework Sexlab, Int tid, Actor akTarget, Int Enjoyment) Global
	SexLabThread t = GetThread(Sexlab, tid)
	If t
		t.AdjustEnjoyment(akTarget, Enjoyment)
	EndIf
EndFunction

Function Orgasm(SexlabFramework Sexlab, Int tid, Actor akTarget) Global
	SexLabThread t = GetThread(Sexlab, tid)
	If t
		t.ForceOrgasm(akTarget)
	EndIf
EndFunction
