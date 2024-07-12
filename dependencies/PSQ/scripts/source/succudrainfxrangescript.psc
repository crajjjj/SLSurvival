Scriptname SuccuDrainFXRangeScript extends ActiveMagicEffect  

Float Property fMaxFXRangeValue = 2048.0 Auto
Float Property fUpdateTime = 0.1 Auto

Actor CastingActor
Actor TargetActor

bool bKeepUpdating = True

Event OnEffectStart(Actor Target, Actor Caster)
	CastingActor = Caster
	TargetActor = Target
	RunDistanceChecksAndStuff()
	
EndEvent

Function RunDistanceChecksAndStuff()
	float fCurrentRangeValue = 0.0

	While bKeepUpdating
		
		fCurrentRangeValue = CastingActor.GetDistance(TargetActor)
		fCurrentRangeValue = ((fCurrentRangeValue) / fMaxFXRangeValue)
		
		AdjustGraphValueForRange(CastingActor,fCurrentRangeValue)
		AdjustGraphValueForRange(TargetActor,fCurrentRangeValue)

		Utility.wait(fUpdateTime)
	EndWhile
EndFunction

Function AdjustGraphValueForRange(Actor ActiveActor,Float fDistance)
	ActiveActor.SetSubGraphFloatVariable("fAbsorbRangeValue",fDistance)
EndFunction
	
Event OnEffectFinish(Actor Target, Actor Caster)
	bKeepUpdating = False
EndEvent
