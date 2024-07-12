Scriptname _MA_AttackRipMgef extends activemagiceffect  

Event OnEffectStart(Actor akTarget, Actor akCaster)
	Main.TryRip(Menu.TearMultAttack)
endEvent

_MA_Main Property Main Auto
_MA_Mcm Property Menu Auto