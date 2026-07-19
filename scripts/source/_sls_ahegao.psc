Scriptname _SLS_Ahegao extends Quest

Event OnInit()
	If Self.IsRunning()
		RegForEvents()
	EndIf
EndEvent

Function RegForEvents()
	; A 6-30s cosmetic period must never outlive a save/load. Both cleanup paths can be missed -
	; the timer quest's single update can be dropped across a load, and the in-scene face arms no
	; timer at all - which strands IsAhegaoing true and leaves the face re-applied on a loop. Heal
	; on every load rather than needing another one-shot migration (see sls_main's 0.642 gate).
	If IsAhegaoing
		EndAhegao()
	EndIf
	; The API mirror persists in the co-save while ahegao itself never survives a load (the heal
	; above just ended any period). Force it to 0 so a save from before the key existed, or one
	; stranded by a mid-period quest stop, can't advertise a stale "running" to other mods.
	StorageUtil.SetIntValue(None, "_SLS_IsAhegaoing", 0)
	; P+ counts as a separate-orgasm provider: it sends SexLabOrgasmSeparate natively and the
	; Slso interface routes GetEnjoyment to it. Probe P+ directly rather than via
	; Slso.GetIsInterfaceActive() - _SLS_InterfaceSlso calls this BEFORE flipping its state,
	; so the interface reads stale here. Without this, P+ setups self-disabled ahegao (forced
	; AhegaoEnable off and stopped the quest) on every load.
	If _SLS_IntSlpp.GetIsInstalled() || Game.GetModByName("SLSO.esp") != 255
		RegisterForModEvent("HookAnimationStart", "OnAnimationStart")
		;RegisterForModEvent("HookStageStart", "OnStageStart")
		RegisterForModEvent("HookAnimationEnd", "OnAnimationEnd")
		RegisterForModEvent("SexLabOrgasmSeparate", "OnSexLabOrgasmSeparate")
	Else
		UnRegisterForAllModEvents()
		StorageUtil.SetIntValue(Aio.Menu, "AhegaoEnable", 0)
		Self.Stop()
	EndIf
EndFunction

Function CaptureVibeEvent(Float Orgasms)
	If Self.IsRunning()
		OrgFatOrgasms = Orgasms
		RegisterForModEvent("DeviceVibrateEffectStop", "OnVibrateStop")
	EndIf
EndFunction

Event OnVibrateStop(string eventName, string argString, float argNum, form sender)
	If argString == PlayerRef.GetLeveledActorBase().GetName()
		; Orgasm COUNT - BeginAhegaoPeriod applies the 6 + N*DurPerOrgasm formula itself. Passing a
		; precomputed duration here ran the formula twice (78s instead of 12s for one orgasm) and
		; left OrgasmCount holding a duration, inflating the post-scene fallback deadline too.
		BeginAhegaoPeriod(OrgFatOrgasms)
		UnRegisterForModEvent("DeviceVibrateEffectStop")
	EndIf
EndEvent

Function OnUpdate()
	; Deadline first, and in EVERY state: Timer's single update is easy to lose (dropped across a
	; save/load, or the quest stopping) and was the only way out of the 0.1s loop below - the
	; "updates that never stopped" the 0.642 gate in sls_main had to clean up once. Checking it only
	; in the post-scene branch was not enough: a new scene sets CurrentTid while a period is still
	; running, and the in-scene branch would then never evaluate it, handing the job back to Timer.
	If IsAhegaoing && AhegaoDeadline > 0.0 && Utility.GetCurrentRealTime() >= AhegaoDeadline
		EndAhegao()
		Return
	EndIf
	If CurrentTid == -1 ; After scene
		If !IsAhegaoing ; nothing to maintain - a stray leftover update must not force the mouth open
			Return
		EndIf
		; This loop re-applies the face every 0.1s, so it MUST always have a bound. The in-scene face
		; arms no deadline (it is meant to last the scene), so whenever that state reaches this branch
		; - via the scene-end watchdog, or the window inside OnAnimationEnd before BeginAhegaoPeriod
		; arms one - the check above sees 0.0 and the loop runs with only Timer to stop it. That is
		; the stuck face: the period never expires and re-applies faster than anything can clear it.
		If AhegaoDeadline <= 0.0
			AhegaoDeadline = Utility.GetCurrentRealTime() + 6.0 + (OrgasmCount * DurPerOrgasm)
		EndIf
		If !sslBaseExpression.IsMouthOpen(PlayerRef)
			; Only ever re-apply a face we actually stored. This used to fall back to
			; SexLab.OpenMouth when the list was empty, which on a 0.1s loop forces the mouth open
			; ~10x a second - and AhegaoFace empties the list for the 0.5s AhegaoClear waits, so
			; every face change landed in here. Nothing stored means nothing to maintain; the
			; deadline above ends the period either way.
			If StorageUtil.CountObjIntListPrefix(PlayerRef, "_SLS_AhegaoExpression") > 0
				Aio.DoAhegaoExpression(PlayerRef, StorageUtil.IntListToArray(PlayerRef, "_SLS_AhegaoExpression"))
			EndIf
		EndIf
		RegisterForSingleUpdate(0.1)

	Else ; Is in scene
		; Watchdog: the in-scene face is cleared only by OnAnimationEnd and arms no timer, so if that
		; event never reaches us (aborted scene, lost registration) it would stay on for the rest of
		; the save. Treat "player is no longer in a scene" as the end. Keep polling after the face is
		; applied too - otherwise this check stops running exactly when it is needed.
		If !Sexlab.IsActorActive(PlayerRef)
			CurrentTid = -1
			If IsAhegaoing
				EndAhegao()
			EndIf
			Return
		EndIf
		If CanAhegao && !IsAhegaoing && (CameDuringSex || Slso.GetEnjoyment(CurrentTid, PlayerRef) >= 70)
			;Debug.Messagebox("DO AHEGAO")
			SetIsAhegaoing(true)
			Aio.AhegaoFaceRandom(PlayerRef)
		EndIf
		RegisterForSingleUpdate(1.5)
	EndIf
EndFunction

Event OnAnimationStart(int tid, bool HasPlayer)
	If HasPlayer
		CurrentTid = tid
		CameDuringSex = false
		sslBaseAnimation Anim = sexlab.HookAnimation(tid)
		CanAhegao = false
		OrgasmCount = 0.0
		If Anim
			CanAhegao = !Anim.HasTag("Oral")
			If CanAhegao
				RegisterForSingleUpdate(1.5)
			EndIf
		EndIf
	EndIf
EndEvent
;/
Event OnStageStart(int tid, bool HasPlayer)
	If HasPlayer
		;Debug.Messagebox(Slso.GetEnjoyment(CurrentTid, PlayerRef))
		If CanAhegao && !IsAhegaoing && (CameDuringSex || Slso.GetEnjoyment(CurrentTid, PlayerRef) >= 60)
			IsAhegaoing = true
			Aio.AhegaoFaceRandom(PlayerRef)
		EndIf
	EndIf
EndEvent
/;
Event OnAnimationEnd(int tid, bool HasPlayer)
	If HasPlayer
		CurrentTid = -1
		If CameDuringSex
			Utility.Wait(1.0)
			BeginAhegaoPeriod(OrgasmCount)
			RegisterForSingleUpdate(0.1)
		Else
			Aio.AhegaoClear(PlayerRef)
			SetIsAhegaoing(false)
		EndIf
	EndIf
EndEvent

Event OnSexLabOrgasmSeparate(Form ActorRef, Int tid)
	If ActorRef == PlayerRef
		CameDuringSex = true
		OrgasmCount += 1.0
	EndIf
EndEvent

Function BeginAhegaoPeriod(Float Orgasms)
	If Self.IsRunning()
		SetIsAhegaoing(true)
		OrgasmCount = Orgasms
		Float Dur = 6.0 + (OrgasmCount * DurPerOrgasm)
		AhegaoDeadline = Utility.GetCurrentRealTime() + Dur ; backstop if Timer's update never lands
		Timer.BeginAhegao(Dur)
		Aio.AhegaoFaceRandom(PlayerRef)
		RegisterForSingleUpdate(0.1)
	EndIf
EndFunction

Function EndAhegao()
	;Debug.Messagebox("END")
	UnRegisterForUpdate()
	Aio.AhegaoClear(PlayerRef)
	SetIsAhegaoing(false)
	AhegaoDeadline = 0.0
	; Both callers can land mid-scene (the deadline check, when a period carries into a new scene;
	; Timer, at any moment) - the UnRegisterForUpdate above then kills the 1.5s in-scene poll,
	; taking the enjoyment trigger and the scene-end watchdog with it for the rest of the scene.
	; Re-arm it; if CurrentTid is stale the watchdog sees no active scene and resets it.
	If CurrentTid != -1
		RegisterForSingleUpdate(1.5)
	EndIf
EndFunction

Function SetIsAhegaoing(Bool AhegaoActive)
	; Sole writer of IsAhegaoing, so the API mirror can't drift from it. Only an actual change
	; reaches the API - the in-scene trigger and BeginAhegaoPeriod overlap when a period carries
	; out of a scene, and firing "started" twice would confuse listeners.
	If IsAhegaoing != AhegaoActive
		IsAhegaoing = AhegaoActive
		Aio.Api.SendAhegaoStateEvent(AhegaoActive)
	EndIf
EndFunction

Bool CameDuringSex = false
Bool CanAhegao = false
Bool IsAhegaoing = false

Int CurrentTid = -1

Float OrgasmCount
Float OrgFatOrgasms

; Real-time stamp the current ahegao period expires at, 0.0 when idle. GetCurrentRealTime restarts
; with the process, so a deadline saved in one session is meaningless in the next - RegForEvents
; ends any in-progress period on load, which clears this before it can be compared.
Float AhegaoDeadline

Float Property DurPerOrgasm = 6.0 Auto Hidden

Actor Property PlayerRef Auto

_SLS_AllInOneKey Property Aio Auto
SexlabFramework Property Sexlab Auto

_SLS_AhegaoTimer Property Timer Auto
_SLS_InterfaceSlso Property Slso Auto
