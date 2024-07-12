ScriptName		_JSW_SUB_Morph02		Extends		ActiveMagicEffect

GlobalVariable		Property		GVBellyScMax		Auto	; 
GlobalVariable		Property		GVBellyScMult		Auto	; 
GlobalVariable		Property		GVScaleStart		Auto	; what % into the pregnancy does scaling start

Faction				Property		GenericFaction		Auto	; 

actor		thisActor

event	OnEffectStart(actor akTarget, actor akCaster)

	thisActor	=	akTarget
	UpdateMorph(sender = none)

endEvent

event	OnEffectFinish(actor akTarget, actor akCaster)

	; NiOverride
	NiOverride.RemoveNodeTransformScale(akTarget, false, true, "NPC Belly", "Fertility Mode")
	NiOverride.RemoveNodeTransformScale(akTarget, true, true, "NPC Belly", "Fertility Mode")
	NiOverride.RemoveNodeTransformScale(akTarget, false, true, "NPC L Breast", "Fertility Mode")
	NiOverride.RemoveNodeTransformScale(akTarget, true, true, "NPC L Breast", "Fertility Mode")
	NiOverride.RemoveNodeTransformScale(akTarget, false, true, "NPC R Breast", "Fertility Mode")
	NiOverride.RemoveNodeTransformScale(akTarget, true, true, "NPC R Breast", "Fertility Mode")
	NiOverride.UpdateNodeTransform(akTarget, false, true, "NPC Belly")
	NiOverride.UpdateNodeTransform(akTarget, true, true, "NPC Belly")
	NiOverride.UpdateNodeTransform(akTarget, false, true, "NPC L Breast")
	NiOverride.UpdateNodeTransform(akTarget, true, true, "NPC L Breast")
	NiOverride.UpdateNodeTransform(akTarget, false, true, "NPC R Breast")
	NiOverride.UpdateNodeTransform(akTarget, true, true, "NPC R Breast")

endEvent

event	UpdateMorph(string a = " ", string b = " ", float ScaleStart = 0.0, form sender)

	RegisterForModEvent("FMPlusDoMorph", "UpdateMorph")
	int factionRank = thisActor.GetFactionRank(GenericFaction)
	ScaleStart = GVScaleStart.GetValue() - 1.0
	float percent
	float breastScaleNode
	if factionRank > -1
		percent = (factionRank as float - ScaleStart) / (100.0 - ScaleStart)
		if percent > 1.0
			percent = 1.0
		elseIf percent < 0.0
			Dispel()
			return
		endIf
		percent *= GVBellyScMult.GetValue() * GVBellyScMax.GetValue()
		breastScaleNode = percent / 10.0
	else
		percent = (GVBellyScMult.GetValue() * GVBellyScMax.GetValue() * ((110 + factionRank) as float)) / 100.0
		if percent < 0.0
			percent = 0.0
		endIf
		breastScaleNode = GVBellyScMax.GetValue() / 10.0
	endIf
	; NiOverride
	NiOverride.AddNodeTransformScale(thisActor, false, true, "NPC Belly", "Fertility Mode", percent + 1.0)
	NiOverride.AddNodeTransformScale(thisActor, true, true, "NPC Belly", "Fertility Mode", percent + 1.0)
	NiOverride.AddNodeTransformScale(thisActor, false, true, "NPC L Breast", "Fertility Mode", breastScaleNode + 1.0)
	NiOverride.AddNodeTransformScale(thisActor, true, true, "NPC L Breast", "Fertility Mode", breastScaleNode + 1.0)
	NiOverride.AddNodeTransformScale(thisActor, false, true, "NPC R Breast", "Fertility Mode", breastScaleNode + 1.0)
	NiOverride.AddNodeTransformScale(thisActor, true, true, "NPC R Breast", "Fertility Mode", breastScaleNode + 1.0)
	NiOverride.UpdateNodeTransform(thisActor, false, true, "NPC Belly")
	NiOverride.UpdateNodeTransform(thisActor, true, true, "NPC Belly")
	NiOverride.UpdateNodeTransform(thisActor, false, true, "NPC L Breast")
	NiOverride.UpdateNodeTransform(thisActor, true, true, "NPC L Breast")
	NiOverride.UpdateNodeTransform(thisActor, false, true, "NPC R Breast")
	NiOverride.UpdateNodeTransform(thisActor, true, true, "NPC R Breast")

endEvent
