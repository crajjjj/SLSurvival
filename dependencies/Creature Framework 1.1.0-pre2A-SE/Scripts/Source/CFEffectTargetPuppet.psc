Scriptname CFEffectTargetPuppet extends ActiveMagicEffect
{The effect script to set the API's puppet to the effect target}

event OnEffectStart(Actor target, Actor caster)
	if target == none
		CFDebug.Log("[Puppet Target] Started with no target; Skyrim shit its pants")
		return
	endIf
	CreatureFrameworkUtil.GetAPI().SetPuppet(target)
endEvent
