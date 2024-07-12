ScriptName mzinBatheAttemptSuccess Extends ActiveMagicEffect
{ this script bathes a dirty actor }

mzinBatheQuest Property BatheQuest Auto
MiscObject Property WashProp Auto

Event OnEffectStart(Actor Target, Actor Caster)
	BatheQuest.BatheActor(Target, WashProp)
EndEvent
