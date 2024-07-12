Scriptname _SLS_LicBikiniCurseLingerBegin extends activemagiceffect  

Event OnEffectStart(Actor akTarget, Actor akCaster)
	akTarget.DispelSpell(_SLS_LicBikiniCurseLingerSpell)
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	_SLS_LicBikiniCurseLingerSpell.Cast(akTarget, akTarget)
EndEvent

Spell Property _SLS_LicBikiniCurseLingerSpell Auto
