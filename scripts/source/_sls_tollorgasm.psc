Scriptname _SLS_TollOrgasm extends Quest  

Function Setup(Actor akActor)
	Blowjobee = akActor
	; P+ folds SLSO in: it always sends SexlabOrgasmSeparate but skips HookOrgasmStart in its
	; per-actor climax mode, so P+ must take the separate-event path even without SLSO.esp
	If Game.GetModByName("SLSO.esp") != 255 || _SLS_IntSlpp.GetIsInstalled()
		RegisterForModEvent("SexLabOrgasmSeparate", "OnSexLabOrgasmSeparate")
	Else
		RegisterForModEvent("HookOrgasmStart", "OnOrgasmStart")
	EndIf
	RegisterForModEvent("HookAnimationEnd", "OnAnimationEnd")
EndFunction

Event OnOrgasmStart(int tid, bool HasPlayer)
	If HasPlayer
		OrgasmEvent()
	EndIf
EndEvent

Event OnSexLabOrgasmSeparate(Form ActorRef, Int tid)
	If ActorRef == Blowjobee
		OrgasmEvent()
	EndIf
EndEvent

Function OrgasmEvent()
	Utility.Wait(2.5) ; Not very high priority.
	SLS_TollGuard GuardScript = (Blowjobee as objectReference) as SLS_TollGuard
	Init.CanDoBlowjob = 0
	;GuardScript.PaidGuard()
	
	TollUtil.PaidGuard(GuardScript.AssociatedDoor)
EndFunction

Event OnAnimationEnd(int tid, bool HasPlayer)
	If HasPlayer
		UnRegisterForAllModEvents()
	EndIf
EndEvent

Actor Blowjobee

SLS_Init Property Init Auto

_SLS_TollUtil Property TollUtil Auto
