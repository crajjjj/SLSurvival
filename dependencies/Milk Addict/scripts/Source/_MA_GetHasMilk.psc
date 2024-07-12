Scriptname _MA_GetHasMilk extends activemagiceffect  

Event OnEffectStart(Actor akTarget, Actor akCaster)
	Main.PlayerHasMilkInventory = true
EndEvent

_MA_Main Property Main Auto