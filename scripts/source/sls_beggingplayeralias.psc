Scriptname SLS_BeggingPlayerAlias extends ReferenceAlias  

Event OnInit()
	RegForEvents()
EndEvent

Event OnPlayerLoadGame()
	RegForEvents()
EndEvent

Function RegForEvents()
	RegisterForModEvent("_SLS_PlayerSwallowedCum", "On_SLS_PlayerSwallowedCum")
	RegisterForModEvent("HookAnimationEnd", "OnAnimationEnd")
	If Game.GetModByName("SLSO.esp") != 255
		RegisterForModEvent("SexLabOrgasmSeparate", "OnSexLabOrgasmSeparate")
	Else
		RegisterForModEvent("HookOrgasmStart", "OnOrgasmStart")
	EndIf
EndFunction

Event OnAnimationEnd(int tid, bool HasPlayer)
	If HasPlayer
		Init.IsTollSwallowDeal = false
		If Init.ClientOrgasmState == 2 ; If player failed to make client cum set job state as failed
			Init.ClientOrgasmState = 4
		EndIf
		If Init.IsGagDeal ; Reequip gag
			Devious.EquipDevice(PlayerRef, Init.BegDealGag)
			If Init.BegDealHeavyBondage != None
				Devious.EquipDevice(PlayerRef, Init.BegDealHeavyBondage)
			EndIf
			Init.IsGagDeal = false
			UnRegisterForMenu("InventoryMenu")
		EndIf
		If Init.TollGag != None
			Devious.EquipDevice(PlayerRef, Init.TollGag)
			Init.TollGag = None
		EndIf
	EndIf
EndEvent

Event OnOrgasmStart(int tid, bool HasPlayer)
	OrgasmEvent(ActorRef = None, tid = tid, HasPlayer = HasPlayer)
EndEvent

Event OnSexLabOrgasmSeparate(Form ActorRef, Int tid)
	OrgasmEvent(ActorRef = None, tid = tid, HasPlayer = Sexlab.FindPlayerController() == tid)
EndEvent

Function OrgasmEvent(Form ActorRef = None, Int tid, Bool HasPlayer)
	If HasPlayer
		If ActorRef != PlayerRef ; ActorRef will either be None (if SLSO is not installed) or another actor in a scene with the player
			If Init.ClientOrgasmState == 2 ; If player is in an active job set job state as successful
				Init.ClientOrgasmState = 3
			EndIf
		EndIf
	EndIf
EndFunction

Event On_SLS_PlayerSwallowedCum(Form akSource, Bool Swallowed, Float LoadSize, Float LoadSizeBase, Bool IsCumPotion)
	If Swallowed
		If Init.BegSwallowDeal == 2
			Init.BegSwallowDeal = 3
		EndIf
	
	Else
		If Init.BegSwallowDeal == 2
			Init.BegSwallowDeal = 4
		EndIf
	EndIf
EndEvent

Event OnObjectEquipped(Form akBaseObject, ObjectReference akReference)
	
EndEvent

Event OnObjectUnEquipped(Form akBaseObject, ObjectReference akReference)
	
EndEvent

State Devious
	Event OnObjectEquipped(Form akBaseObject, ObjectReference akReference)
		If akBaseObject.HasKeyword(Devious.zad_DialGagHard)
		
		
		EndIf
	EndEvent
	
	Event OnObjectUnEquipped(Form akBaseObject, ObjectReference akReference)
		If akBaseObject.HasKeyword(Devious.zad_DialGagHard)
		
		
		EndIf
	EndEvent
EndState

Location Property WhiterunLocation Auto

Actor Property PlayerRef Auto

SLS_Init Property Init Auto
SLS_Mcm Property Menu Auto
_SLS_InterfaceDevious Property Devious Auto
SexLabFramework Property Sexlab Auto
