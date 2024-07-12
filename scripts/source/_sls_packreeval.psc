Scriptname _SLS_PackReEval extends activemagiceffect  

Event OnEffectStart(Actor akTarget, Actor akCaster)
	;Debug.Messagebox("Refresh")
	Utility.Wait(0.1)
	akTarget.EvaluatePackage()
EndEvent
