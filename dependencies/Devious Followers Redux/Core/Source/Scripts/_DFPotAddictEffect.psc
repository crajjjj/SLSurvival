Scriptname _DFPotAddictEffect extends activemagiceffect  

Quest property _DFlowPotion Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	If _DFlowPotion.GetStage() == 0
		_DFlowPotion.SetStage(10)
	endif
endevent