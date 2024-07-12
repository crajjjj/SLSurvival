Scriptname _SLS_Sensitivity extends Quest  

Event OnInit()
	RegisterForModEvent("_SLS_IncPlayerSexSensitivity", "On_SLS_IncPlayerSexSensitivity")
	RegisterForModEvent("_SLS_DecPlayerSexSensitivity", "On_SLS_DecPlayerSexSensitivity")
EndEvent

Function Shutdown()
	PlayerRef.RemoveSpell(_SLS_SensitivitySpell)
	UnRegisterForUpdate()
	UnRegisterForUpdateGameTime()
	UnRegForEvents()
EndFunction

Event On_SLS_IncPlayerSexSensitivity(string eventName, string strArg, float numArg, Form sender)
	IncreaseSensitivity(numArg)
EndEvent

Event On_SLS_DecPlayerSexSensitivity(string eventName, string strArg, float numArg, Form sender)
	DecreaseSensitivity(numArg)
EndEvent

Function IncreaseSensitivity(Float Value)
	StorageUtil.AdjustFloatValue(None, "_SLS_PlayerSexSensitivity", Value)
	If StorageUtil.GetFloatValue(None, "_SLS_PlayerSexSensitivity", Missing = 0.0) > 10.0
		StorageUtil.SetFloatValue(None, "_SLS_PlayerSexSensitivity", 10.0)
	EndIf
	RefreshDisplaySpell()
	RegForEvents()
	RegisterForSingleUpdateGameTime(24.0)
EndFunction

Event OnUpdateGameTime()
	DecreaseSensitivity(0.5)
	If StorageUtil.GetFloatValue(None, "_SLS_PlayerSexSensitivity", Missing = 0.0) > 0.0
		RegisterForSingleUpdateGameTime(24.0)
	EndIf
EndEvent

Function DecreaseSensitivity(Float Value)
	StorageUtil.AdjustFloatValue(None, "_SLS_PlayerSexSensitivity", -(Value))
	If StorageUtil.GetFloatValue(None, "_SLS_PlayerSexSensitivity", Missing = 0.0) <= 0.0
		StorageUtil.SetFloatValue(None, "_SLS_PlayerSexSensitivity", 0.0)
		Shutdown()
	Else
		RefreshDisplaySpell()
	EndIf
EndFunction

Function RegForEvents()
	RegisterForModEvent("HookAnimationStart", "OnAnimationStart")
	RegisterForModEvent("HookAnimationEnd", "OnAnimationEnd")
	RegisterForModEvent("SexLabOrgasmSeparate", "OnSexLabOrgasmSeparate")
EndFunction

Function UnRegForEvents()
	UnRegisterForModEvent("HookAnimationStart")
	UnRegisterForModEvent("HookAnimationEnd")
	UnRegisterForModEvent("SexLabOrgasmSeparate")
EndFunction

Event OnAnimationStart(int tid, bool HasPlayer)
	If HasPlayer
		OrgasmCount = 0.0
		CurrentTid = tid
		RegisterForSingleUpdate(2.0)
	EndIf
EndEvent

Event OnSexLabOrgasmSeparate(Form ActorRef, Int tid)
	If ActorRef == PlayerRef
		OrgasmCount += 1.0
	EndIf
EndEvent

Event OnAnimationEnd(int tid, bool HasPlayer)
	If HasPlayer
		UnRegisterForUpdate()
	EndIf
EndEvent

Event OnUpdate()
	Float Value = Utility.RandomInt(1, 1 + Math.Ceiling(StorageUtil.GetFloatValue(None, "_SLS_PlayerSexSensitivity", Missing = 0.0)))
	Value = Value / (1.0 + (OrgasmCount / 3.0))
	;Debug.Messagebox("Value: " + Value)
	Slso.ModEnjoyment(CurrentTid, PlayerRef, Value as Int)
	RegisterForSingleUpdate(2.0)
EndEvent

Function RefreshDisplaySpell()
	PlayerRef.RemoveSpell(_SLS_SensitivitySpell)
	_SLS_SensitivitySpell.SetNthEffectMagnitude(0, StorageUtil.GetFloatValue(None, "_SLS_PlayerSexSensitivity"))
	Utility.Wait(0.1)
	PlayerRef.AddSpell(_SLS_SensitivitySpell, false)
EndFunction

Int CurrentTid

Float OrgasmCount

Actor Property PlayerRef Auto

Spell Property _SLS_SensitivitySpell Auto

_SLS_InterfaceSlso Property Slso Auto
