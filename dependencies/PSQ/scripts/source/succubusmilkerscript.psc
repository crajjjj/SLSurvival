Scriptname SuccubusMilkerScript Extends ObjectReference

Spell Property PSQMilkingSpell Auto

Event OnEquipped(Actor akActor)
	akActor.AddSpell(PSQMilkingSpell)
	akActor.EquipSpell(PSQMilkingSpell, 2)
EndEvent

Event OnUnequipped(Actor akActor)
	akActor.RemoveSpell(PSQMilkingSpell)
EndEvent
