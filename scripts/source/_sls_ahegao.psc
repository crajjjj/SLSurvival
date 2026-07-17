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
	; P+ counts as a separate-orgasm provider: it sends SexLabOrgasmSeparate natively and the
	; Slso interface routes GetEnjoyment to it. Probe P+ directly rather than via
	; Slso.GetIsInterfaceActive() - _SLS_InterfaceSlso calls this BEFORE flipping its state,
	; so the interface reads stale here. Without this, P+ setups self-disabled ahegao (forced
	; AhegaoEnable off and stopped the quest) on every load.
	If _SLS_IntSlpp.GetIsInstalled() || Game.GetModByName("Slso.esp") != 255
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
		BeginAhegaoPeriod(6.0 + (OrgFatOrgasms * DurPerOrgasm))
		UnRegisterForModEvent("DeviceVibrateEffectStop")
	EndIf
EndEvent

Function OnUpdate()
	If CurrentTid == -1 ; After scene
		If !IsAhegaoing ; nothing to maintain - a stray leftover update must not force the mouth open
			Return
		EndIf
		; Self-terminating: Timer's single update is easy to lose (dropped across a save/load, or the
		; quest stopping) and it was the only way out of this 0.1s re-apply loop - exactly the
		; "updates that never stopped" the 0.642 gate in sls_main had to clean up once. The deadline
		; ends the period on its own, leaving Timer as the prompt path rather than the only one.
		If AhegaoDeadline > 0.0 && Utility.GetCurrentRealTime() >= AhegaoDeadline
			EndAhegao()
			Return
		EndIf
		If !sslBaseExpression.IsMouthOpen(PlayerRef)
			If StorageUtil.CountObjIntListPrefix(PlayerRef, "_SLS_AhegaoExpression") > 0
				Aio.DoAhegaoExpression(PlayerRef, StorageUtil.IntListToArray(PlayerRef, "_SLS_AhegaoExpression"))
			Else
				SexLab.OpenMouth(PlayerRef)
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
			IsAhegaoing = true
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
			IsAhegaoing = false
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
		IsAhegaoing = true
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
	IsAhegaoing = false
	AhegaoDeadline = 0.0
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
