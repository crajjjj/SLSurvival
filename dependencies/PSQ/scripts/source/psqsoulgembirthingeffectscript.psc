Scriptname PSQSoulGemBirthingEffectScript Extends ActiveMagicEffect

PSQSoulGemIncubateQuestScript Property SGI Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	If !SGI.BirthingNow
		SGI.Birthing()
	EndIf
EndEvent
