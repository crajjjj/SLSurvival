ScriptName mzinBatheAttemptFailure Extends ActiveMagicEffect
{ this script tells the player to find water to bathe }

Message Property BathingNeedsWaterMessage Auto

Actor DirtyActor

Event OnEffectStart(Actor Target, Actor Caster)
	If Target == Game.GetPlayer()
		BathingNeedsWaterMessage.Show()
	EndIf
	Self.Dispel()
EndEvent
