ScriptName		_JSW_SUB_Morph00		Extends		ActiveMagicEffect

GlobalVariable		Property		GVBellyScMult		Auto	; 
GlobalVariable		Property		GVBreastScMult		Auto	; 
GlobalVariable		Property		GVScaleStart		Auto	; what % into the pregnancy does scaling start

Faction				Property		GenericFaction		Auto	; 

actor		thisActor

event	OnEffectStart(actor akTarget, actor akCaster)

	thisActor	=	akTarget
	UpdateMorph(sender = none)

endEvent

event	OnEffectFinish(actor akTarget, actor akCaster)

	NiOverride.ClearBodyMorph(akTarget, "PregnancyBelly", "Fertility Mode")
	NiOverride.ClearBodyMorph(akTarget, "BreastsSH", "Fertility Mode")
	NiOverride.ClearBodyMorph(akTarget, "BreastsNewSH", "Fertility Mode")
	NiOverride.UpdateModelWeight(akTarget)

endEvent

event	UpdateMorph(string a = " ", string b = " ", float ScaleStart = 0.0, form sender)

	RegisterForModEvent("FMPlusDoMorph", "UpdateMorph")
	int factionRank = thisActor.GetFactionRank(GenericFaction)
	ScaleStart = GVScaleStart.GetValue() - 1.0
	float breastScale = GVBreastScMult.GetValue()
	float percent
	if factionRank > -1
		percent = (factionRank as float - ScaleStart) / (100.0 - ScaleStart)
		if percent > 1.0
			percent = 1.0
		elseIf percent < 0.0
			Dispel()
			return
		endIf
		percent *= GVBellyScMult.GetValue()
		breastScale *= percent
	else
		percent = ((110 + factionRank) as float / 100.0)
		if percent < 0.0
			percent = 0.0
		endIf
	endIf
	; BodyMorph
	NiOverride.SetBodyMorph(thisActor, "PregnancyBelly", "Fertility Mode", percent)
	NiOverride.SetBodyMorph(thisActor, "BreastsSH", "Fertility Mode", breastScale)
	NiOverride.SetBodyMorph(thisActor, "BreastsNewSH", "Fertility Mode", breastScale)
	NiOverride.UpdateModelWeight(thisActor)

endEvent
