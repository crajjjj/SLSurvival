ScriptName	_JSW_SUB_CellScan	Extends	ActiveMagicEffect

Actor	Property	playerRef	Auto	

Spell	Property	CellScanSpell	Auto

event OnEffectStart(Actor akTarget, Actor akCaster)

	RegisterForSingleUpdate(1.8)

endEvent

event OnUpdate()

	playerRef.RemoveSpell(CellScanSpell)

endEvent
