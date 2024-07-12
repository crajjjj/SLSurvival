Scriptname _MA_GetHasNotMilk extends activemagiceffect  

Event OnEffectStart(Actor akTarget, Actor akCaster)
	Main.PlayerHasMilkInventory = false
EndEvent

_MA_Main Property Main Auto