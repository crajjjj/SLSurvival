Scriptname CreatureFrameworkPuppet extends ActiveMagicEffect
{The effect script to set the API's puppet to the effect target}

event OnEffectStart(Actor target, Actor caster)
	if target == none
		CreatureFrameworkUtility.Log("[Puppet Target] Started with no target; Skyrim shit its pants")
		return
	endIf
	CreatureFrameworkUtility.GetAPI().SetPuppet(target)
endEvent
