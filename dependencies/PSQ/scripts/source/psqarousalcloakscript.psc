Scriptname PSQArousalCloakScript Extends ActiveMagicEffect

slaUtilScr Property slaUtil Auto
GlobalVariable Property SuccubusRank Auto
Int Property Magnitude Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	slaUtil.UpdateActorExposure(akTarget, SuccubusRank.GetValueInt() * Magnitude)
EndEvent
