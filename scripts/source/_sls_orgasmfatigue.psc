Scriptname _SLS_OrgasmFatigue extends Quest  

Event OnInit()
	If Self.IsRunning()
		RegisterForEvents()
		Setup()
	EndIf
EndEvent

Function Shutdown()
	Int i = 0
	While i < FatigueSpellList.Length
		PlayerRef.RemoveSpell(FatigueSpellList[i])
		i += 1
	EndWhile
	Self.Stop()
EndFunction

Function Setup()
	OrgasmCount = 0.0
	_SLS_OrgasmFatigueLevel.SetValueInt(0)
	
	FatigueSpellList = new Spell[3]
	FatigueSpellList[0] = Game.GetFormFromFile(0x0E857C, "SL Survival.esp") as Spell
	FatigueSpellList[1] = Game.GetFormFromFile(0x0E8AE3, "SL Survival.esp") as Spell
	FatigueSpellList[2] = Game.GetFormFromFile(0x0E8AE5, "SL Survival.esp") as Spell
	
	FatigeStrs = new String[4]
	FatigeStrs[0] = "Fresh "
	FatigeStrs[1] = "Fatigued "
	FatigeStrs[2] = "Exhausted "
	FatigeStrs[3] = "Drained "
EndFunction

Function RegisterForEvents()
	UnRegisterForSleep()
	UnRegisterForAllModEvents()
	If Game.GetModByName("SLSO.esp") != 255
		RegisterForModEvent("SexLabOrgasmSeparate", "OnSexLabOrgasmSeparate")
	Else
		RegisterForModEvent("HookOrgasmStart", "OnOrgasmStart")
	EndIf
	RegisterForModEvent("PlayerOrgasmStart", "On_MmeOrgasmEvent")
	RegisterForModEvent("DeviceActorOrgasm", "OnDeviceActorOrgasm")
	RegisterForSleep()
	RegisterForSingleUpdateGameTime(24.0)
EndFunction

Event OnUpdateGameTime()
	If DailyOrgasmCount > OrgasmThreshold && OrgasmThreshold < 19.0
		OrgasmThreshold += 1.0
		Debug.Notification("I can handle more orgasms now")
	ElseIf DailyOrgasmCount < OrgasmThreshold && OrgasmThreshold > 1.0
		OrgasmThreshold -= 1.0
		Debug.Notification("I'm more sensitive and can't have as many orgasms now")
	EndIf
	SetFatigue()
	DailyOrgasmCount = 0.0
	RegisterForSingleUpdateGameTime(24.0)
EndEvent

Event OnSleepStart(float afSleepStartTime, float afDesiredSleepEndTime)
	SleepStartTime = afSleepStartTime
EndEvent

Event OnSleepStop(bool abInterrupted)
	Utility.Wait(2.0) ; Not high priority
	Float Recover
	Float HoursSlept = (Utility.GetCurrentGameTime() - SleepStartTime) * 24.0
	If Needs.LastSleepPenalty != -1.0
		Recover = (HoursSlept * OrgasmRecoveryPerHour) * (1.0 - Needs.LastSleepPenalty)
	Else
		Recover = HoursSlept * OrgasmRecoveryPerHour
	EndIf
	AdjustOrgasmCount(-(Recover))
	;Debug.Messagebox("Recovered from: " + Recover + " orgasms\nCount: " + OrgasmCount)
	SetFatigue()
EndEvent

Event OnDeviceActorOrgasm(string eventName, string argString, float argNum, form sender)
	If argString == PlayerRef.GetLeveledActorBase().GetName()
		OutOfSexOrgasmEvent()
	EndIf
EndEvent

Event On_MmeOrgasmEvent(string eventName, string strArg, float numArg, Form sender)
	;Debug.Messagebox("MME Orgasm")
	OutOfSexOrgasmEvent()
EndEvent

Function OutOfSexOrgasmEvent()
	AdjustOrgasmCount(1.0)
	;Debug.Messagebox("Player orgasm\nCount: " + OrgasmCount)
	If OrgasmCount > OrgasmThreshold
		SetFatigue()
	Else
		RemoveFatigue()
	EndIf
	Ahegao.CaptureVibeEvent(OrgasmCount as Int)
EndFunction

Event OnOrgasmStart(int tid, bool HasPlayer) ;(string eventName, string argString, float argNum, form sender)
	OrgasmEvent(ActorRef = None, tid = tid, HasPlayer = HasPlayer)
EndEvent

Event OnSexLabOrgasmSeparate(Form ActorRef, Int tid)
	;Bool HasPlayer = Sexlab.FindPlayerController() == tid
	OrgasmEvent(ActorRef = ActorRef as Actor, tid = tid, HasPlayer = Sexlab.FindPlayerController() == tid)
EndEvent

Function OrgasmEvent(Actor ActorRef = None, Int tid, Bool HasPlayer)
	If ActorRef == PlayerRef || (!ActorRef && HasPlayer) ; Player had orgasm
		AdjustOrgasmCount(1.0)
		;Debug.Messagebox("Player orgasm\nCount: " + OrgasmCount)
		If OrgasmCount > OrgasmThreshold
			RegisterForModEvent("HookAnimationEnd", "OnAnimationEnd")
		Else
			RemoveFatigue()
		EndIf
	EndIf
EndFunction

Event OnAnimationEnd(int tid, bool HasPlayer)
	UnRegisterForModEvent("HookAnimationEnd")
	Utility.Wait(2.0) ; Not high priority
	SetFatigue()
EndEvent

Function SetFatigue()
	Spell FatigueSpell = GetDebuff(SetFatigueLevel())
	If FatigueSpell
		Float StaminaPerOrgasm = PlayerRef.GetBaseActorValue("Stamina") / 10.0
		Float MagickaPerOrgasm = PlayerRef.GetBaseActorValue("Magicka") / 10.0
		If StaminaPerOrgasm > MagickaPerOrgasm
			FatigueSpell.SetNthEffectMagnitude(0, PapyrusUtil.ClampFloat(StaminaPerOrgasm * ((OrgasmCount - OrgasmThreshold) as Float), 0.0, PlayerRef.GetBaseActorValue("Stamina")))
		Else
			FatigueSpell.SetNthEffectMagnitude(0, PapyrusUtil.ClampFloat(MagickaPerOrgasm * ((OrgasmCount - OrgasmThreshold) as Float), 0.0, PlayerRef.GetBaseActorValue("Magicka")))
		EndIf
		RemoveFatigue()
		Utility.Wait(0.1)
		PlayerRef.AddSpell(FatigueSpell, false)
	Else
		RemoveFatigue()
	EndIf
EndFunction

Function RemoveFatigue()
	Int i = 0
	While i < FatigueSpellList.Length
		PlayerRef.RemoveSpell(FatigueSpellList[i])
		i += 1
	EndWhile
EndFunction

Function AdjustOrgasmCount(Float Value)
	Float NewVal = OrgasmCount + Value
	OrgasmCount = PapyrusUtil.ClampFloat(NewVal, 0.0, 20.0)
	If Value > 0.0 ; Is Orgasm
		DailyOrgasmCount += 1.0
	EndIf
EndFunction

Int Function SetFatigueLevel()
	Float Div = (20.0 - OrgasmThreshold) / 3.0
	If OrgasmCount >= OrgasmThreshold + (2.0 * Div)
		_SLS_OrgasmFatigueLevel.SetValueInt(3)
		Return 3
	ElseIf OrgasmCount >= OrgasmThreshold + Div
		_SLS_OrgasmFatigueLevel.SetValueInt(2)
		Return 2
	ElseIf OrgasmCount >= OrgasmThreshold
		_SLS_OrgasmFatigueLevel.SetValueInt(1)
		Return 1
	EndIf
	_SLS_OrgasmFatigueLevel.SetValueInt(0)
	Return 0
EndFunction

Spell Function GetDebuff(Int Level)
	If Level > 0
		Return FatigueSpellList[(Level - 1)]
	EndIf
	Return None
EndFunction

String Function GetOrgasmFatigueString()
	If Self.IsRunning()
		Return FatigeStrs[_SLS_OrgasmFatigueLevel.GetValueInt()] + "(" + SnipToDecimalPlaces(OrgasmCount as String, 1) + "/" + SnipToDecimalPlaces(OrgasmThreshold as String, 1) + ")"
	EndIf
	Return ""
EndFunction

String Function SnipToDecimalPlaces(String StrInput, Int Places)
	Return StringUtil.Substring(StrInput, startIndex = 0, len =  Places + 1 + StringUtil.Find(StrInput, ".", startIndex = 0))
EndFunction

Function DrinkAlcohol(Form Alcohol)
	AdjustOrgasmCount(-2.0)
	SetFatigue()
	Debug.Notification("The alcohol helps me relax a little")
EndFunction

Float SleepStartTime
Float Property OrgasmCount = 0.0 Auto Hidden
Float Property DailyOrgasmCount = 0.0 Auto Hidden
Float Property OrgasmThreshold = 1.0 Auto Hidden
Float Property OrgasmRecoveryPerHour = 0.8 Auto Hidden

Spell[] FatigueSpellList
String[] FatigeStrs

GlobalVariable Property _SLS_OrgasmFatigueLevel Auto

Actor Property PlayerRef Auto

_SLS_Ahegao Property Ahegao Auto
_SLS_Needs Property Needs Auto
SexlabFramework Property Sexlab Auto
