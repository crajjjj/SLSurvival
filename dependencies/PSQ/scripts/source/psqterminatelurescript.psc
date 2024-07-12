ScriptName PSQTerminateLureScript Extends ActiveMagicEffect  

Package Property PSQFishPackage Auto

Event OnEffectStart(Actor Target, Actor Caster)
	ActorUtil.RemovePackageOverride(Target, PSQFishPackage)
	Target.EvaluatePackage()
EndEvent
