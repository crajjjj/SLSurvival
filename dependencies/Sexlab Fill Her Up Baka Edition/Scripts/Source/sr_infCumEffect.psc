Scriptname sr_infCumEffect extends ActiveMagicEffect

sr_inflateQuest Property inflater auto

Spell theSpell ; seems safer than dispel()
GlobalVariable Property sr_totalEffects auto
int Property totalEff hidden
	int Function Get()
		return sr_totalEffects.GetValueInt()
	EndFunction

	Function Set(int val)
		sr_totalEffects.SetValueInt(val)
	EndFunction
EndProperty

float absoluteZero = 1.0 ; remove the effect when cum drops below this
bool anal

Event OnEffectStart(Actor akTarget, Actor akCaster)
	RegisterForModEvent("fhu.playerCumEffectStart", "CumParameters")
	RegisterForModEvent("fhu.playerCumUpdate", "OnCumChange")
	totalEff += 1
	RegisterForSingleUpdate(5.0) ; Timeout, remove effect if no parameters are received
	inflater.log("Starting cum effect")
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	totalEff -= 1
EndEvent

Event OnPlayerLoadGame()
	RegisterForModEvent("fhu.playerCumUpdate", "OnCumChange")
EndEvent

Event CumParameters(float zero, bool isAnal, Form thisSpell)
	UnregisterForModEvent("fhu.playerCumEffectStart")
	UnregisterForUpdate()
	absoluteZero = zero
	anal = isAnal
	theSpell = thisSpell as Spell
	inflater.log("Received starting parameters for " + theSpell.GetName() + ", zero: " + absoluteZero + ", anal: " + anal)
EndEvent

Event OnCumChange(float currentCum, bool isAnal)
	If currentCum <= absoluteZero && anal == isAnal
		dispel()
		inflater.player.RemoveSpell(theSpell)
		inflater.log(theSpell.GetName() + " removed.")
	EndIf
EndEvent

Event OnUpdate()
	inflater.log("	Timed out waiting for params.")
	dispel()
	inflater.player.RemoveSpell(theSpell)
EndEvent 