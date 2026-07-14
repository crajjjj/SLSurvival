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
	If t.HasInteractionType(t.CTYPE_Oral, akSucker, akPartner)
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
