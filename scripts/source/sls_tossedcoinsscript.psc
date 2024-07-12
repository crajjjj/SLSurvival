Scriptname SLS_TossedCoinsScript  extends ObjectReference  Conditional

import debug
import utility

_SLS_InterfaceSlsf Property Slsf Auto
SLS_mcm Property TheMenu Auto

MiscObject property coinObj auto
{Should be set to Coin01}
MiscObject property TGCoinpurse auto
Int property coinMin auto
{minimum amount of coins player receives}

Int property coinMax auto
{maximum amount of coins player receives}

Actor Property PlayerRef Auto
Spell Property _SLS_CheapWhoreTimer Auto
MagicEffect Property _SLS_CheapWhoreTimerMgef Auto

;************************************

event OnLoad()
	BlockActivation()
endEvent

function CoinTake()
	;player has activated
	int numOfCoins = Math.Ceiling(RandomInt(coinMin, coinMax) * TheMenu.BegGold)
	gotoState("done")
	
	If !PlayerRef.HasMagicEffect(_SLS_CheapWhoreTimerMgef)
		_SLS_CheapWhoreTimer.Cast(PlayerRef, PlayerRef)
		Debug.Notification("You scramble to pick up the coins. Hot cum still dripping from your face and tits")
	EndIf
	Slsf.IncreaseSexFame("Whore", 2)
	PlayerRef.removeitem(tgcoinpurse, abSilent = true)
	PlayerRef.addItem(coinObj, numOfCoins)
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
