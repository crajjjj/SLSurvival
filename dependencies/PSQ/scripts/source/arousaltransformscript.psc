Scriptname ArousalTransformScript Extends ActiveMagicEffect

PlayerSuccubusQuestScript Property PSQ Auto
SlaUtilScr Property SlaUtil Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	RegisterForSingleUpdate(3.0)
EndEvent

Event OnUpdate()
	RegisterForSingleUpdate(3.0)
	If PSQ.PlayerIsSuccubus.GetValueInt() == 1
		If SlaUtil.GetActorArousal(PSQ.PlayerRef) >= PSQ.TransformThreshold as Int
			If !PSQ.IsHenshined && PSQ.ArousedForceTransform
				PSQ.HenshinSpell.Cast(PSQ.PlayerRef)
			EndIf
		ElseIf SlaUtil.GetActorArousal(PSQ.PlayerRef) <= PSQ.DeTransformThreshold as Int
			If PSQ.IsHenshined && PSQ.ArousedForceDeTransform
				PSQ.HenshinSpell.Cast(PSQ.PlayerRef)
			EndIf
		EndIf
	EndIf
EndEvent
