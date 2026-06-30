Scriptname FWAbilityBFOnMagicEffectApply extends ActiveMagicEffect

;Magic Effect Monitoring Script for BeeingFemale by Bane Master 03/07/2019 V1.0
;Utilizes States to provide spam protection & allow OnMagicEffectApply to be Enabled/Disabled via the BF MCM
;Due to the requirment to register for ModEvents on each game load NPC Actors will only respond to enable/disable after the first location change in game each session 

FWSystem property System Auto

Actor ActorRef
Actor Property PlayerRef Auto
FWAddOnManager property Manager auto

Event OnEffectStart(Actor target, Actor caster) ; BF re-adds the magic effect to nearby NPC's at each location change but to the Player only on an MCM Reset
	ActorRef = target
	RegisterForModEvent("FW_OMEAToggle", "SetState"); Register the Instance for the MCM enable/disable ModEvent - For NPC's this will be lost on game save/load but reinstated on first location change
	If StorageUtil.GetIntValue(PlayerRef, "FWAbiltyOnMEApplyDisabled")
		GoToState("Disabled")
	EndIf
EndEvent

Event OnMagicEffectApply(ObjectReference akCaster, MagicEffect akEffect)
	GoToState("Processing")
	Manager.OnMagicEffectApply(ActorRef,akCaster, akEffect)
EndEvent

Event OnPlayerLoadGame() ;This event is only received by the instance attached to the Player
	RegisterForModEvent("FW_OMEAToggle", "SetState") ; The MCM toggle ModEvent on the Player must be registered at each Game Load
EndEvent

Event OnUpdate()
	;No Action
EndEvent

Function SetState(string eventName, string strArg, float numArg, Form sender) ;Called by SendModEvent in the MCM  
	If StorageUtil.GetIntValue(ActorRef, "FWAbiltyOnMEApplyDisabled") ;Toggle value as set in MCM
		GoToState("Disabled")
		Debug.Notification("BF: OnMagicEffectApply Disabled")
	Else
		GoToState("")
		Debug.Notification("BF: OnMagicEffectApply Enabled")
	Endif
EndFunction

State Processing
	Event OnBeginState()
		RegisterForSingleUpdate(2) ;Wait 2 seconds before rearming the OnMagicEffectApply process - this could also be a storageutil float parameter value set in the MCM if desired
	EndEvent
	
	Event OnMagicEffectApply(ObjectReference akCaster, MagicEffect akEffect)
		;Ignore additional MagicEffect hits whilst busy
	EndEvent

	Event OnUpdate()
		GoToState("") ;Rearm
	EndEvent
EndState

State Disabled
	Event OnMagicEffectApply(ObjectReference akCaster, MagicEffect akEffect)
		;Disabled
	EndEvent

	Event OnUpdate()
		;Disabled
	EndEvent
EndState