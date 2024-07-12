Scriptname _SLS_HighlightItemsBoostTrigger extends activemagiceffect  

Event OnEffectStart(Actor akTarget, Actor akCaster)
	akTarget.DispelSpell(_SLS_HighlightItemsBoostSpell)
	Utility.Wait(0.5)
	_SLS_HighlightItemsBoostSpell.SetNthEffectDuration(0, ((24 * 60 * 60) / TimeScale.GetValueInt()) as Int)
	_SLS_HighlightItemsBoostSpell.Cast(akTarget, akTarget)
EndEvent

Spell Property _SLS_HighlightItemsBoostSpell Auto

GlobalVariable Property TimeScale Auto
