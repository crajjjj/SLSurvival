Scriptname StarkRealityEffectScript Extends ActiveMagicEffect

Event OnEffectStart(Actor akTarget, Actor akCaster)
	akTarget.UnequipItemSlot(30)
	Game.GetPlayer().UnequipItemSlot(30)
	akTarget.UnequipItemSlot(32)
	Game.GetPlayer().UnequipItemSlot(32)
	akTarget.UnequipItemSlot(33)
	Game.GetPlayer().UnequipItemSlot(33)
	akTarget.UnequipItemSlot(34)
	Game.GetPlayer().UnequipItemSlot(34)
	akTarget.UnequipItemSlot(37)
	Game.GetPlayer().UnequipItemSlot(37)
EndEvent
