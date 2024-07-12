Scriptname _SLS_CumRemedyTrigger extends activemagiceffect  

Event OnEffectStart(Actor akTarget, Actor akCaster)
	Float Mag = GetMagnitude()
	_SLS_CumRemedySpell.SetNthEffectMagnitude(0, Mag)
	_SLS_CumRemedySpell.SetNthEffectDuration(0, ((24 * 60 * 60) / TimeScale.GetValue()) as Int)
	
	akTarget.DispelSpell(_SLS_CumRemedySpell)
	Utility.Wait(0.5)
	_SLS_CumRemedySpell.Cast(akTarget, akTarget)
EndEvent

Spell Property _SLS_CumRemedySpell Auto

GlobalVariable Property TimeScale Auto
