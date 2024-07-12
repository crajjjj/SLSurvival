ScriptName		_JSW_SUB_MorphPC		Extends		ActiveMagicEffect

GlobalVariable		Property		GVBellyScMult		Auto	; 
GlobalVariable		Property		GVBellyScMax		Auto	; 
GlobalVariable		Property		GVBreastScMult		Auto	; 
GlobalVariable		Property		GVScaleMethod		Auto	; 
GlobalVariable		Property		GVScaleStart		Auto	; what % into the pregnancy does scaling start

Faction				Property		GenericFaction		Auto	; 

actor		thisActor
;/		_scaleTypeMenu[0]	=	"BodyMorph"
		_scaleTypeMenu[1]	=	"NetImmerse"
		_scaleTypeMenu[2]	=	"NiOverride"
		_scaleTypeMenu[3]	=	"SLIF"
		_scaleTypeMenu[4]	=	"No Morphs"/;

event	OnEffectStart(actor akTarget, actor akCaster)

	GoToState("Method0" + GVScaleMethod.GetValue() as int)
	thisActor = akTarget
	RegisterForModEvent("FMPlusDoMorph", "UpdateMorph")
	ApplyMorph()

endEvent

event	OnEffectFinish(actor akTarget, actor akCaster)

	RemoveMorph(akTarget)

endEvent

event	UpdateMorph(string a = " ", string b = " ", float c = 0.0, form sender)

	if GetState() != ("Method0" + GVScaleMethod.GetValue() as int)
		RemoveMorph(thisActor)
		OnEffectStart(thisActor, none)
		return
	endIf
	ApplyMorph()
	RegisterForModEvent("FMPlusDoMorph", "UpdateMorph")

endEvent

function	ApplyMorph()
endFunction
function	RemoveMorph(actor akTarget)
endFunction
function	SLIFMorph(Actor akActor, string morphName, float scale)
endFunction

state Method00

	function	ApplyMorph()

		; 2.21
		int factionRank = thisActor.GetFactionRank(GenericFaction)
		float ScaleStart = GVScaleStart.GetValue() - 1.0
		float breastScale = GVBreastScMult.GetValue()
		float percent
		if factionRank > -1
			percent = (factionRank as float - ScaleStart) / (100.0 - ScaleStart)
			if percent > 1.0
				percent = 1.0
			elseIf percent < 0.0
				return
			endIf
			percent *= GVBellyScMult.GetValue()
			breastScale *= percent
		else
			percent = ((110 + factionRank) as float) / 100.0
			if percent < 0.0
				percent = 0.0
			endIf
		endIf
		; BodyMorph
		NiOverride.SetBodyMorph(thisActor, "PregnancyBelly", "Fertility Mode", percent)
		NiOverride.SetBodyMorph(thisActor, "BreastsSH", "Fertility Mode", breastScale)
		NiOverride.SetBodyMorph(thisActor, "BreastsNewSH", "Fertility Mode", breastScale)
		NiOverride.UpdateModelWeight(thisActor)

	endFunction

	function	RemoveMorph(actor akTarget)

		NiOverride.ClearBodyMorph(akTarget, "PregnancyBelly", "Fertility Mode")
		NiOverride.ClearBodyMorph(akTarget, "BreastsSH", "Fertility Mode")
		NiOverride.ClearBodyMorph(akTarget, "BreastsNewSH", "Fertility Mode")
		NiOverride.UpdateModelWeight(akTarget)

	endFunction

endState

state Method01

	function	ApplyMorph()

		; 2.21
		int factionRank = thisActor.GetFactionRank(GenericFaction)
		float ScaleStart = GVScaleStart.GetValue() - 1.0
		float percent
		float breastScalenode
		if factionRank > -1
			percent = (factionRank as float - ScaleStart) / (100.0 - ScaleStart)
			if percent > 1.0
				percent = 1.0
			elseIf percent < 0.0
				return
			endIf
			breastScaleNode = percent / 10.0
		else
			percent = (GVBellyScMult.GetValue() * GVBellyScMax.GetValue() * ((110 + factionRank) as float)) / 100.0
			if percent < 0.0
				percent = 0.0
			endIf
			breastScaleNode = GVBellyScMax.GetValue() * GVBreastScMult.GetValue() / 10.0
		endIf
		; NetImmerse
		NetImmerse.SetNodeScale(thisActor, "NPC Belly", percent + 1.0, false)
		NetImmerse.SetNodeScale(thisActor, "NPC Belly", percent + 1.0, true)
		NetImmerse.SetNodeScale(thisActor, "NPC L Breast", breastScaleNode + 1.0, false)
		NetImmerse.SetNodeScale(thisActor, "NPC L Breast", breastScaleNode + 1.0, true)
		NetImmerse.SetNodeScale(thisActor, "NPC R Breast", breastScaleNode + 1.0, false)
		NetImmerse.SetNodeScale(thisActor, "NPC R Breast", breastScaleNode + 1.0, true)

	endFunction

	function	RemoveMorph(actor akTarget)

		; NetImmerse
		NetImmerse.SetNodeScale(akTarget, "NPC Belly", 1.0, false)
		NetImmerse.SetNodeScale(akTarget, "NPC Belly", 1.0, true)
		NetImmerse.SetNodeScale(akTarget, "NPC L Breast", 1.0, false)
		NetImmerse.SetNodeScale(akTarget, "NPC L Breast", 1.0, true)
		NetImmerse.SetNodeScale(akTarget, "NPC R Breast", 1.0, false)
		NetImmerse.SetNodeScale(akTarget, "NPC R Breast", 1.0, true)

	endFunction

endState

state Method02

	function	ApplyMorph()

		int factionRank = thisActor.GetFactionRank(GenericFaction)
		float ScaleStart = GVScaleStart.GetValue() - 1.0
		float percent
		float breastScaleNode
		if factionRank > -1
			percent = (factionRank as float - ScaleStart) / (100.0 - ScaleStart)
			if percent > 1.0
				percent = 1.0
			elseIf percent < 0.0
				return
			endIf
			percent *= GVBellyScMult.GetValue() * GVBellyScMax.GetValue()
			breastScaleNode = percent / 10.0
		else
			percent = (GVBellyScMult.GetValue() * GVBellyScMax.GetValue() * ((110 + factionRank) as float)) / 100.0
			if percent < 0.0
				percent = 0.0
			endIf
			breastScaleNode = GVBellyScMax.GetValue() * GVBreastScMult.GetValue() / 10.0
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

	endFunction

	function	RemoveMorph(actor akTarget)

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

	endFunction

endState

state Method03

	function	ApplyMorph()

		int factionRank = thisActor.GetFactionRank(GenericFaction)
		float ScaleStart = GVScaleStart.GetValue() - 1.0
		float percent
		float breastScale
		if factionRank > -1
			percent = (factionRank as float - ScaleStart) / (100.0 - ScaleStart)
			if percent > 1.0
				percent = 1.0
			elseIf percent < 0.0
				return
			endIf
			percent *= GVBellyScMult.GetValue()
			breastScale = percent * GVBreastScMult.GetValue()
		else
			percent = (GVBellyScMult.GetValue() * GVBellyScMax.GetValue() * ((110 + factionRank) as float)) /100.0
			if percent < 0.0
				percent = 0.0
			endIf
			breastScale = GVBreastScMult.GetValue()
		endIf
		; SexLab Inflation Framework
		SLIFMorph(thisActor, "PregnancyBelly", percent)
		SLIFMorph(thisActor, "BreastsSH", breastScale)
		SLIFMorph(thisActor, "BreastsNewSH", breastScale)

	endFunction

	function	RemoveMorph(actor akTarget)

		string[] morphName = new string[3]
		morphName[0] = "PregnancyBelly"
		morphName[1] = "BreastsSH"
		morphName[2] = "BreastsNewSH"
		; SexLab Inflation Framework
		int handle
		int iterations = 3
		while (iterations > 0)
			iterations -= 1
			handle = ModEvent.Create("SLIF_unregisterMorph")
			ModEvent.PushForm(handle, akTarget as form)
			ModEvent.PushString(handle, "Fertility Mode")
			ModEvent.PushString(handle, morphName[iterations])
			ModEvent.Send(handle)
		endWhile

	endFunction

	function	SLIFMorph(Actor akActor, string morphName, float scale)
	{Helper function for scaling morphs through SLIF}

		int handle = ModEvent.Create("SLIF_morph")
		ModEvent.PushForm(handle, akActor as form)
		ModEvent.PushString(handle, "Fertility Mode")
		ModEvent.PushString(handle, morphName)
		ModEvent.PushFloat(handle, scale)
		ModEvent.PushString(handle, "Fertility Mode.esm")
		ModEvent.Send(handle)

	endFunction


endState

state Method04

	event OnBeginState()
		GoToState("")
	endEvent

endState
