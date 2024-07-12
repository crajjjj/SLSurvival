ScriptName		_JSW_SUB_Morph01		Extends		ActiveMagicEffect

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

	; NetImmerse
	NetImmerse.SetNodeScale(akTarget, "NPC Belly", 1.0, false)
	NetImmerse.SetNodeScale(akTarget, "NPC Belly", 1.0, true)
	NetImmerse.SetNodeScale(akTarget, "NPC L Breast", 1.0, false)
	NetImmerse.SetNodeScale(akTarget, "NPC L Breast", 1.0, true)
	NetImmerse.SetNodeScale(akTarget, "NPC R Breast", 1.0, false)
	NetImmerse.SetNodeScale(akTarget, "NPC R Breast", 1.0, true)

endEvent

event	UpdateMorph(string a = " ", string b = " ", float ScaleStart = 0.0, form sender)

	RegisterForModEvent("FMPlusDoMorph", "UpdateMorph")
	int factionRank = thisActor.GetFactionRank(GenericFaction)
	ScaleStart = GVScaleStart.GetValue() - 1.0
	float percent
	float breastScalenode
	if factionRank > -1
		percent = (factionRank as float - ScaleStart) / (100.0 - ScaleStart)
		if percent > 1.0
			percent = 1.0
		elseIf percent < 0.0
			Dispel()
			return
		endIf
		breastScaleNode = percent / 10.0
	else
		percent = (GVBellyScMult.GetValue() * GVBellyScMax.GetValue() * ((110 + factionRank) as float)) / 100.0
		if percent < 0.0
			percent = 0.0
		endIf
		breastScaleNode = GVBellyScMax.GetValue() / 10.0
	endIf
	; NetImmerse
	NetImmerse.SetNodeScale(thisActor, "NPC Belly", percent + 1.0, false)
	NetImmerse.SetNodeScale(thisActor, "NPC Belly", percent + 1.0, true)
	NetImmerse.SetNodeScale(thisActor, "NPC L Breast", breastScaleNode + 1.0, false)
	NetImmerse.SetNodeScale(thisActor, "NPC L Breast", breastScaleNode + 1.0, true)
	NetImmerse.SetNodeScale(thisActor, "NPC R Breast", breastScaleNode + 1.0, false)
	NetImmerse.SetNodeScale(thisActor, "NPC R Breast", breastScaleNode + 1.0, true)

endEvent
