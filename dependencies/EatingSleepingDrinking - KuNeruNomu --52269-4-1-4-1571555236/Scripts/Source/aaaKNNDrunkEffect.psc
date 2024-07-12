Scriptname aaaKNNDrunkEffect extends activemagiceffect  

ImageSpaceModifier Property aaaKNNDrunkVisual auto

Event OnEffectStart(actor akTarget, actor akCaster)
	;Debug.Notification("Alcholl Effect Start")
	aaaKNNDrunkVisual.Apply(1.0)
EndEvent

Event OnEffectFinish(actor akTarget, actor akCaster)
	;Debug.Notification("Alcholl Effect Finish")
	aaaKNNDrunkVisual.Remove()
EndEvent