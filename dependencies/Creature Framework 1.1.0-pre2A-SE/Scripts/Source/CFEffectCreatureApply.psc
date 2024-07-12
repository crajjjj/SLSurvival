Scriptname CFEffectCreatureApply extends ActiveMagicEffect
{The effect script that adds the creature spell to actors that are in the cloak | Creature Framework}

; The effect has started
event OnEffectStart(Actor target, Actor caster)
	CreatureFramework api = CreatureFrameworkUtil.GetAPI()
	Armor skin = api.GetSkinOrFakeFromActor(target)
	if api.IsCreatureRegistered(target.GetRace(), skin)
		if api.GetActiveMod(target.GetRace(), skin) != "" || api.GetActiveMod(target.GetRace(), none) != ""
			api.ActivateActor(target)
		else
			if !(JFormDB.GetInt(target, ".CFFormLog.Logged") as bool)
				CFDebug.Log("[Creature Apply] Not activating " + CreatureFrameworkUtil.GetDetailedActorName(target) + "; creature has no active mod; race=" + CreatureFrameworkUtil.GetDetailedFormName(target.GetRace()) + " skin=" + CreatureFrameworkUtil.GetDetailedFormName(skin))
				JFormDB.SetInt(target, ".CFFormLog.Logged", true as int)
			endIf
		endIf
	else
		if !(JFormDB.GetInt(target, ".CFFormLog.Logged") as bool)
			CFDebug.Log("[Creature Apply] Not activating " + CreatureFrameworkUtil.GetDetailedActorName(target) + "; creature isn't registered; race=" + CreatureFrameworkUtil.GetDetailedFormName(target.GetRace()) + " skin=" + CreatureFrameworkUtil.GetDetailedFormName(skin))
			JFormDB.SetInt(target, ".CFFormLog.Logged", true as int)
		endIf
	endIf
endEvent
