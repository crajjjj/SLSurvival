ScriptName mzinFactionScent Extends ActiveMagicEffect
{ this script adds or removes actors from a faction }

Faction Property ImpersonateFaction Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)

	akTarget.AddToFaction(ImpersonateFaction)

EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)

	akTarget.RemoveFromFaction(ImpersonateFaction)

EndEvent
