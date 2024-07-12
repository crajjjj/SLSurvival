ScriptName			_JSW_SUB_AbortPotionNPC			Extends			ActiveMagicEffect

Form			Property			PotAbort			Auto	; the potion of abort

event	OnEffectStart(actor akTarget, actor akCaster)

	if akTarget
		if akTarget.GetItemCount(PotAbort)
			akTarget.EquipItem(PotAbort)
		endIf
	endIf

endEvent
