Scriptname SuccubusCurseEffectScript Extends ActiveMagicEffect

PlayerSuccubusQuestScript Property PSQ Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	PSQ.ChangeAccursedBodyPaint(akTarget)
EndEvent
