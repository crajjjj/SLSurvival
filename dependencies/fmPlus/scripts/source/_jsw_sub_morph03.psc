ScriptName		_JSW_SUB_Morph03		Extends		ActiveMagicEffect

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

endEvent

event	UpdateMorph(string a = " ", string b = " ", float ScaleStart = 0.0, form sender)

	RegisterForModEvent("FMPlusDoMorph", "UpdateMorph")
	int factionRank = thisActor.GetFactionRank(GenericFaction)
	ScaleStart = GVScaleStart.GetValue() - 1.0
	float percent
	float breastScale
	if factionRank > -1
		percent = (factionRank as float - ScaleStart) / (100.0 - ScaleStart)
		if percent > 1.0
			percent = 1.0
		elseIf percent < 0.0
			Dispel()
			return
		endIf
		percent *= GVBellyScMult.GetValue()
		breastScale = percent * GVBreastScMult.GetValue()
	else
		percent = (GVBellyScMult.GetValue() * ((110 + factionRank) as float)) / 100.0
		if percent < 0.0
			percent = 0.0
		endIf
		breastScale = GVBreastScMult.GetValue()
	endIf
	; SexLab Inflation Framework
	if percent > 0.0
		SLIFMorph(thisActor, "PregnancyBelly", percent)
	endIf
	SLIFMorph(thisActor, "BreastsSH", breastScale)
	SLIFMorph(thisActor, "BreastsNewSH", breastScale)

endEvent

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
