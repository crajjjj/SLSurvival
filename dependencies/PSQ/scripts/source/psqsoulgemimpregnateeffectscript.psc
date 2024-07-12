Scriptname PSQSoulGemImpregnateEffectScript Extends ActiveMagicEffect

PSQSoulGemIncubateQuestScript Property SGI Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	SGI.Filling()
	SGI.Impregnate()
EndEvent
