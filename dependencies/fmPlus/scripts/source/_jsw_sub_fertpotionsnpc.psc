ScriptName			_JSW_SUB_FertPotionsNPC			Extends			ActiveMagicEffect

Form			Property			PotFert				Auto	; potion of fertility
Form			Property			PotNoFert			Auto	; potion of reduced fertility

event	OnEffectStart(actor akTarget, actor akCaster)

	if akTarget
		if akTarget.GetItemCount(PotFert)
			akTarget.EquipItem(PotFert)
		elseIf akTarget.GetItemCount(PotNoFert)
			akTarget.EquipItem(PotNoFert)
		endIf
	endIf

endEvent
