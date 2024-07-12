Scriptname _MA_PowerAttackRipMgef extends activemagiceffect  

Event OnEffectStart(Actor akTarget, Actor akCaster)
	Main.TryRip(Menu.TearMultPowerAttack)
endEvent

_MA_Main Property Main Auto
_MA_Mcm Property Menu Auto