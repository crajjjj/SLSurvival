Scriptname FWInterfaceArousal Hidden

; Beeing Female arousal integration with SexLab Aroused (SLA).
; Wraps the BF-specific arousal use cases — ovulation ramp and PMS debuff.
; SLA effect ids and functionId choices are encapsulated here, so callers
; don't need to know the underlying SLA event shape.
;
; Compat: OSL Aroused ships its own SexLabAroused.esm with a stubbed
; slaframeworkscr (GetVersion() = 20140124) that forwards framework reads
; but does NOT register slaSetArousalEffect. SLAXSE2022 (20190720) similar.
; Real SLA NG (>= 20200000) registers it.
;
; Each public BF call: tries the SLA NG event path first, falls back to
; slaframeworkscr.UpdateActorExposure (anonymous one-shot bump) on legacy
; installs. Stop/Clear is a no-op on the legacy path — fallback writes
; aren't tracked, so they can't be reversed.

bool function IsPresent() global
	if Game.GetModByName("SexLabAroused.esm") != 255
		return true
	endif
	if Game.GetModByName("SexLabAroused.esp") != 255
		return true
	endif
	return false
endFunction

; SLA framework quest. Editor ID "sla_Framework" exists on every fork on
; disk (real SLA NG and OSL Aroused's stub).
Quest function GetFrameworkQuest() global
	return Quest.GetQuest("sla_Framework")
endFunction

; True only when the installed fork understands slaSetArousalEffect ModEvent.
; OSL stub returns 20140124 — below threshold.
bool function SupportsEffectEvents() global
	Quest sla = GetFrameworkQuest()
	if !sla
		return false
	endif
	return (sla as slaframeworkscr).GetVersion() > 20200000
endFunction

; ============================================================================
; Ovulation arousal ramp
; ============================================================================
; Linear climb toward `cap` at `perDayDelta` per game day while ovulation is
; active. Both args MUST be positive (climbing up). SLA NG path uses
; functionId 2 (ramp). Legacy fallback applies a one-shot bump of
; `perDayDelta` — direction preserved, magnitude approximate.

function StartOvulationRamp(Actor target, float perDayDelta, float cap) global
	if !target || perDayDelta <= 0.0 || cap <= 0.0
		return
	endif
	if SupportsEffectEvents()
		_SendEffect(target, "BF_Ovulation", 0.0, 2, perDayDelta, cap)
		return
	endif
	_ApplyFallback(target, "BF_Ovulation", perDayDelta)
endFunction

function StopOvulationRamp(Actor target) global
	if !target || !SupportsEffectEvents()
		return
	endif
	; SLA NG only erases a dynamic effect when both function==0 AND value==0,
	; and slaSetArousalEffect ignores initialValue==0. A bare Set with
	; functionId=0 stops the ramp but leaves the accumulated value (up to
	; cap=100) in the dynamic map, still contributing to total arousal
	; forever. Mod first with limit=0 clamps the value down, then Set clears
	; the function so the entry satisfies the removal predicate. The Mod
	; modifier just has to overshoot any plausible accumulated value; SLA's
	; clamp at limit=0 bounds the actual delta applied.
	float clearOvershoot = 200.0
	_SendMod(target, "BF_Ovulation", 0.0 - clearOvershoot, 0.0)
	_SendEffect(target, "BF_Ovulation", 0.0, 0, 0.0, 0.0)
endFunction

; ============================================================================
; PMS arousal debuff
; ============================================================================
; Linear decline toward `floor` at `perDayDelta` per game day during the
; menstruation phase. Both args MUST be negative (sagging down) — caller
; performs the negation, function passes the values straight to SLA. SLA NG
; path uses functionId 2 (ramp). Legacy fallback applies a one-shot bump.

function StartPMSDebuff(Actor target, float perDayDelta, float floor) global
	if !target || perDayDelta >= 0.0 || floor >= 0.0
		return
	endif
	if SupportsEffectEvents()
		_SendEffect(target, "BF_PMS", 0.0, 2, perDayDelta, floor)
		return
	endif
	_ApplyFallback(target, "BF_PMS", perDayDelta)
endFunction

function StopPMSDebuff(Actor target) global
	if !target || !SupportsEffectEvents()
		return
	endif
	; Same removal trick as StopOvulationRamp, but value is negative — Mod with
	; a large positive modifier and limit=0 clamps back up to 0 from the floor.
	float clearOvershoot = 200.0
	_SendMod(target, "BF_PMS", clearOvershoot, 0.0)
	_SendEffect(target, "BF_PMS", 0.0, 0, 0.0, 0.0)
endFunction

; ============================================================================
; Internals
; ============================================================================

function _SendEffect(Actor target, string effectId, float value, int functionId, float param, float threshold) global
	if !IsPresent()
		return
	endif
	int handle = ModEvent.Create("slaSetArousalEffect")
	if handle
		ModEvent.PushForm(handle, target)
		ModEvent.PushString(handle, effectId)
		ModEvent.PushFloat(handle, value)
		ModEvent.PushInt(handle, functionId)
		ModEvent.PushFloat(handle, param)
		ModEvent.PushFloat(handle, threshold)
		ModEvent.Send(handle)
	endif
endFunction

function _SendMod(Actor target, string effectId, float modifier, float limit) global
	if !IsPresent()
		return
	endif
	int handle = ModEvent.Create("slaModArousalEffect")
	if handle
		ModEvent.PushForm(handle, target)
		ModEvent.PushString(handle, effectId)
		ModEvent.PushFloat(handle, modifier)
		ModEvent.PushFloat(handle, limit)
		ModEvent.Send(handle)
	endif
endFunction

function _ApplyFallback(Actor target, string effectId, float delta) global
	Quest sla = GetFrameworkQuest()
	if !sla || delta == 0.0
		return
	endif
	(sla as slaframeworkscr).UpdateActorExposure(target, delta as int, "FW " + effectId)
endFunction
