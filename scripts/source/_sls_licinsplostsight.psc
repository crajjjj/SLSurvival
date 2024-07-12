Scriptname _SLS_LicInspLostSight extends activemagiceffect  
;/
Actor Me

Event OnEffectStart(Actor akTarget, Actor akCaster)
	Me = akTarget
	RegisterForSingleUpdate(2.0)
EndEvent

Event OnUpdate()
	Debug.Messagebox("Pack: " + Me.GetCurrentPackage())
RegisterForSingleUpdate(2.0)

EndEvent
/;

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	akTarget.RemoveFromFaction(_SLS_LicInspLostSightFact)
	akTarget.EvaluatePackage()
	;Debug.Messagebox("Remove from fact")
EndEvent

Faction Property _SLS_LicInspLostSightFact Auto