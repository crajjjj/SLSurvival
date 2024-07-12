Scriptname SOS_SetupNPCMagicEffect_Script extends activemagiceffect  

;----------PROPERTIES----------

Spell Property SOS_ActorSpell Auto

;----------EVENTS----------

Event OnEffectStart(Actor akTarget, Actor akCaster)
	If !SOS_ActorSpell || SOS_ActorSpell as String == "[SPELL <None>]"
		; Probably this script is a remainder of a previous SOS installation, baked in the savegame.
		; It points to None references, dispel and let the NPC get a fresh spell
		Debug.Trace("SOS SetupNPC: leftover script on " + akTarget)
		Dispel()
		If akTarget
			Spell actorSpell = Game.GetFormFromFile(0x12e9, "Schlongs of Skyrim.esp") as Spell
			If actorSpell
				akTarget.AddSpell(actorSpell, false)
			EndIf
		EndIf
	Else
		akTarget.AddSpell(SOS_ActorSpell, false)
	EndIf
EndEvent
