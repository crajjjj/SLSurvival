Scriptname _SLS_DancingCoins extends ObjectReference  


import debug
import utility

;_SLS_InterfaceSlsf Property Slsf Auto
;SLS_mcm Property TheMenu Auto

MiscObject property Gold001 auto
{Should be set to Coin01}
MiscObject property _SLS_DancingCoins01 auto

Int property coinMin auto Hidden
{minimum amount of coins player receives}

Int property coinMax auto Hidden
{maximum amount of coins player receives}

Actor Property PlayerRef Auto
;Spell Property _SLS_CheapWhoreTimer Auto
;MagicEffect Property _SLS_CheapWhoreTimerMgef Auto

;************************************

event OnLoad()
	BlockActivation()
endEvent

function CoinTake()
	;player has activated
	gotoState("done")
	;/
	If !PlayerRef.HasMagicEffect(_SLS_CheapWhoreTimerMgef)
		_SLS_CheapWhoreTimer.Cast(PlayerRef, PlayerRef)
		Debug.Notification("You scramble to pick up the coins. Hot cum still dripping from your face and tits")
	EndIf
	Slsf.IncreaseSexFame("Whore", 2)
	/;
	PlayerRef.removeitem(_SLS_DancingCoins01, aiCount = 999, abSilent = true)
	PlayerRef.addItem(Gold001, Utility.RandomInt(CoinMin, coinMax))
endFunction

auto State Waiting
	Event OnActivate (objectReference triggerRef)
		Actor actorRef = triggerRef as Actor
		if(actorRef == PlayerRef)
			CoinTake()
			disable()
			delete()
		endif
	endEvent

	Event OnContainerChanged(ObjectReference akNewContainer, ObjectReference akOldContainer)
		if akNewContainer == PlayerRef
			CoinTake()
		endif
	endEvent
endState

;************************************

State done
	;do nothing
endState

;************************************
