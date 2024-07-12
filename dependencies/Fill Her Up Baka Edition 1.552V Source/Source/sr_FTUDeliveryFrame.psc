;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 8
Scriptname sr_FTUDeliveryFrame Extends Quest Hidden

;BEGIN ALIAS PROPERTY Pump1Handler
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Pump1Handler Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY PlayerRef
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_PlayerRef Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Pump3Handler
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Pump3Handler Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Pump2Handler
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Pump2Handler Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Odall
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Odall Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_5
Function Fragment_5()
;BEGIN CODE
; Player walked away from the job offer
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_6
Function Fragment_6()
;BEGIN CODE
; Player has accepted the job
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_7
Function Fragment_7()
;BEGIN CODE
; Introductionary SHB quest done
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_4
Function Fragment_4()
;BEGIN CODE
; Player has met Odall
sr_RumorQuest.SetStage(255)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Armor Property QSTOpenBelt auto
Armor Property QSTOpenBeltRendered auto
Armor Property QSTFullBelt auto
Armor Property QSTFullBeltRendered auto
Armor Property QSTCollar auto
Armor Property QSTCollarRendered auto

Keyword Property QSTCollarKW auto
Keyword Property QSTBeltKW auto

zadLibs Property zad auto
slaFrameworkScr Property aroused auto

GlobalVariable Property sr_DeliveryStart auto
GlobalVariable Property sr_DeliveryDuration auto
GlobalVariable Property sr_FTUFavorFinish auto

MiscObject Property Gold001 auto
Faction Property sr_QuickSilverTradingFaction auto 

GlobalVariable Property _sr_PlayerInPump auto
int property playerInPump hidden
	int function Get()
		return _sr_PlayerInPump.GetValueInt()
	EndFunction
EndProperty

GlobalVariable Property _sr_OdallDisposition auto
int Property disposition hidden
	int function get()
		return _sr_OdallDisposition.GetValueInt()
	endFunction

	Function set(int v)
		If v > 20
			v = 20
		ElseIf v < -20
			v = -20
		EndIf
		_sr_OdallDisposition.SetValueInt(v)
	EndFunction
endProperty

sr_FTUQuestBase property sr_OrcPickupQuest Auto

Quest Property sr_RumorQuest Auto
bool monitoring = false
GlobalVariable Property sr_Contaminated auto
sr_inflateQuest Property inflater auto
String cb = ""
Race[] allowed
Actor aa1
SexLabFramework SexLab
int blocked = 0

Function StartMonitoring(int whatToMonitor, Actor a1 = none, Race rce1 = none, Race rce2 = none, Race rce3 = none, String callback = "")
	monitoring = true
	allowed = new Race[3]
	allowed[0] = rce1
	allowed[1] = rce2
	allowed[2] = rce3
	SexLab = SexLabUtil.GetAPI()
	sr_Contaminated.SetValueInt(0)
	cb = callback
	blocked = whatToMonitor
	aa1 = a1
	Maintenance()
EndFunction

Function StopMonitoring()
	monitoring = false
	UnregisterForModEvent("PlayerHookOrgasmStart")
EndFunction

Function Maintenance()
	If monitoring
		RegisterForModEvent("PlayerHookOrgasmStart", "PurityMonitor")
	EndIf
EndFunction

Event PurityMonitor(int threadID, bool hasPlayer)
	If !hasPlayer
		return
	EndIf
	
	sslBaseAnimation anim = SexLab.HookAnimation(threadID)
	Actor[] actors = SexLab.HookActors(threadId)
	actor pl = Game.GetPlayer()
	int pli = actors.Find(pl)
	int cumSpot = anim.AccessPosition(pli, 1)
	If ( ( anim.HasTag("vaginal") && ( blocked == 1 || blocked == 3 ) ) || (anim.HasTag("anal") && ( blocked == 2 || blocked == 3 ) ) ) && cumSpot != -1 && cumSpot != 2

		int i = actors.length
		
		while i > 0
			i -= 1
			if actors[i] != pl && ( allowed.Find(actors[i].GetLeveledActorBase().GetRace()) == -1 || ( aa1 && actors[i] != aa1 ) ) && ( SexLab.GetGender(actors[i]) != 1 || sexlab.config.AllowFFCum )
				sr_Contaminated.SetValueInt(1)
				If cb != ""
					int eid = ModEvent.Create(cb)
					ModEvent.Send(eid)
				EndIf
				return
			endIf
		endWhile
		
	EndIf
EndEvent

; apparently calling quest.quest.property from a tif doesn't work properly
Function ModDisposition(int delta)
	disposition += delta
EndFunction

Function Pay(int baseAmount)
	int rank = inflater.player.GetFactionRank(sr_QuickSilverTradingFaction)
	if rank < 0
		rank = 0
	EndIf
	
	inflater.player.AddItem(Gold001, baseAmount + (rank * 15))
EndFunction


Function StartMoanLoop(Actor a)
	RegisterForModEvent("ftu.MoanLoop", "MoanLoop")
	StorageUtil.SetIntValue(a, "ftu.Moaning", 1)
	int eid = ModEvent.Create("ftu.MoanLoop")
	ModEvent.PushForm(eid, a)
	ModEvent.Send(eid)
EndFunction

Event MoanLoop(Form act)
	Actor a = act as Actor
	while(StorageUtil.GetIntValue(a, "ftu.Moaning") > 0)
		inflater.Moan(a)
		Utility.Wait(Utility.RandomFloat(1.0, 3.0))
	endWhile
EndEvent

Function StopMoanLoop(Actor a)
	StorageUtil.UnsetIntValue(a, "ftu.Moaning")
EndFunction

Function PlayPumpAnim(Actor a, bool bound = false)
	If bound
		Debug.SendAnimationEvent(a, "ZaZMOMBoundFurn_06")
	Else
		Debug.SendAnimationEvent(a, "ZaZMOMFreeFurn_06")
	EndIf 
EndFunction

Function StopPumpAnim(Actor a, bool bound = false)
	If bound
		Debug.SendAnimationEvent(a, "ZaZMOMBoundFurn_02")
	Else
		Debug.SendAnimationEvent(a, "ZaZMOMFreeFurn_02")
	EndIf 
EndFunction

Function EquipUniform(bool belt = true, bool collar = false, bool open = true, Actor courier = none)
	If courier == none
		courier = Alias_PlayerRef.GetActorReference()
	EndIf
	If belt
		ManipulateDevice(courier, zad.plugInflatableVag, true, false, true)
		If open
			ManipulateDevice(courier, QSTOpenBelt, true, false, true)
		Else
			ManipulateDevice(courier, zad.plugInflatableAn, true, false, true)
			ManipulateDevice(courier, QSTFullBelt, true, false, true)
		EndIf
	endIf
	if( !courier.WornHasKeyword(zad.zad_DeviousCollar) && collar)
		ManipulateDevice(courier, QSTCollar, true, true, true)
	endIf	
EndFunction

Function UnequipUniform(bool belt = true, bool collar = false, Actor courier = none)
	If courier == none
		courier = Alias_PlayerRef.GetActorReference()
	EndIf
	If belt
		If courier.WornHasKeyword(QSTBeltKW)
			If courier.IsEquipped(QSTOpenBeltRendered)
				ManipulateDevice(courier, QSTOpenBelt, false, false, true)
			EndIf
			If courier.IsEquipped(QSTFullBeltRendered)
				ManipulateDevice(courier, QSTFullBelt, false, false, true)
			EndIf
			If courier.WornHasKeyword(zad.zad_DeviousPlugVaginal)
				zad.ManipulateGenericDeviceByKeyword(courier, zad.zad_DeviousPlugVaginal, false, false, true)
			EndIf
			If courier.WornHasKeyword(zad.zad_DeviousPlugAnal)
				zad.ManipulateGenericDeviceByKeyword(courier, zad.zad_DeviousPlugAnal, false, false, true)
			EndIf
		EndIf
	EndIf
	If collar && courier.WornHasKeyword(QSTCollarKW)
		ManipulateDevice(courier, QSTCollar, false, true, true)
	EndIf
EndFunction

Function RemoveUniform()
	UnequipUniform(true, true)
	Utility.Wait(1.5)
	inflater.player.RemoveItem(QSTCollar)
	inflater.player.RemoveItem(QSTOpenBelt)
EndFunction

Function ManipulateDevice(actor akActor, armor device, bool equipOrUnequip, bool skipEvents = false, bool skipMutex = false)
	If device == None
		return
	EndIf
	Armor deviceRendered
	Keyword deviceKeyword
	if device == QSTOpenBelt
		deviceRendered = QSTOpenBeltRendered
		deviceKeyword = zad.zad_DeviousBelt
	ElseIf device == QSTFullBelt
		deviceRendered = QSTFullBeltRendered
		deviceKeyword = zad.zad_DeviousBelt
	ElseIf device == QSTCollar
		deviceRendered = QSTCollarRendered
		deviceKeyword = zad.zad_DeviousCollar
	Else
		zad.ManipulateDevice(akActor, device, equipOrUnequip, skipEvents)
		return
	EndIf
	if equipOrUnequip
		zad.EquipDevice(akActor, device, deviceRendered, deviceKeyword, skipEvents = skipEvents, skipMutex = skipMutex)
	else
		zad.RemoveDevice(akActor, device, deviceRendered, deviceKeyword, skipEvents = skipEvents, skipMutex = skipMutex)
	EndIf
EndFunction

Function StartDelivery()
	sr_DeliveryStart.SetValue(Utility.GetCurrentGameTime())
EndFunction 

Function CalculateDeliveryDuration()
	float start = sr_DeliveryStart.GetValue()
	sr_DeliveryDuration.SetValue((Utility.GetCurrentGameTime() - start) * 24.0)
EndFunction

Function AnimateAndFillPlayer()
	If playerInPump == 1
		Debug.SendAnimationEvent(inflater.player, "ZaZMOMFreeFurn_06")
	Else
		Debug.SendAnimationEvent(inflater.player, "ZaZMOMBoundFurn_06")
	EndIf
	StartMoanLoop(inflater.Player)
	inflater.inflateTo(inflater.player, 1, 20.0)
EndFunction

Function InflationDone()
	aroused.UpdateActorExposure(inflater.player, 15, "getting flooded with cum")
	If playerInPump == 1
		Debug.SendAnimationEvent(inflater.player, "ZaZMOMFreeFurn_02")
	Else
		Debug.SendAnimationEvent(inflater.player, "ZaZMOMBoundFurn_02")
	EndIf
	StopMoanLoop(inflater.player)
EndFunction

Function ExtendFavorTime()
	sr_FTUFavorFinish.Mod(Utility.RandomFloat(0.4, 0.9))
EndFunction
