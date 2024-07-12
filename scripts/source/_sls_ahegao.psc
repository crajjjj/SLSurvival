Scriptname _SLS_Ahegao extends Quest

Event OnInit()
	If Self.IsRunning()
		RegForEvents()
	EndIf
EndEvent

Function RegForEvents()
	If Game.GetModByName("Slso.esp") != 255
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
		If !sslBaseExpression.IsMouthOpen(PlayerRef)
			If StorageUtil.CountObjIntListPrefix(PlayerRef, "_SLS_AhegaoExpression") > 0
				Aio.DoAhegaoExpression(PlayerRef, StorageUtil.IntListToArray(PlayerRef, "_SLS_AhegaoExpression"))
			Else
				SexLab.OpenMouth(PlayerRef)
			EndIf
		EndIf
		If IsAhegaoing
			RegisterForSingleUpdate(0.1)
		EndIf
	
	Else ; Is in scene
		If CanAhegao && !IsAhegaoing && (CameDuringSex || Slso.GetEnjoyment(CurrentTid, PlayerRef) >= 70)
			;Debug.Messagebox("DO AHEGAO")
			IsAhegaoing = true
			Aio.AhegaoFaceRandom(PlayerRef)
		Else
			RegisterForSingleUpdate(1.5)
		EndIf
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
		Timer.BeginAhegao(6.0 + (OrgasmCount * DurPerOrgasm))
		Aio.AhegaoFaceRandom(PlayerRef)
		RegisterForSingleUpdate(0.1)
	EndIf
EndFunction

Function EndAhegao()
	;Debug.Messagebox("END")
	UnRegisterForUpdate()
	Aio.AhegaoClear(PlayerRef)
	IsAhegaoing = false
EndFunction

Bool CameDuringSex = false
Bool CanAhegao = false
Bool IsAhegaoing = false

Int CurrentTid = -1

Float OrgasmCount
Float OrgFatOrgasms

Float Property DurPerOrgasm = 6.0 Auto Hidden

Actor Property PlayerRef Auto

_SLS_AllInOneKey Property Aio Auto
SexlabFramework Property Sexlab Auto

_SLS_AhegaoTimer Property Timer Auto
_SLS_InterfaceSlso Property Slso Auto
