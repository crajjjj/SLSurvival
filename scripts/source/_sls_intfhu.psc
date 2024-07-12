Scriptname _SLS_IntFhu Hidden 

Float Function GetCumCapacityMax(Quest FhuConfigQuest) Global
	Return (FhuConfigQuest as sr_inflateConfig).maxInflation
EndFunction

Function InflateTo(Quest FhuInflateQuest, Actor akActor, int Hole, float time, float targetLevel = -1.0, String callback = "") Global ; Unused for now
	; Hole: 1 - Vaginal, 2 - Anal
	(FhuInflateQuest as sr_inflateQuest).InflateTo(akActor, Hole, time, targetLevel, callback)
EndFunction

Float Function GetCumAmountForActor(Quest FhuInflateQuest, Actor a, Actor[] all) Global ; a: Receiving actor, all: All actors in thread
	Return (FhuInflateQuest as sr_inflateQuest).GetCumAmountForActor(a, all)
EndFunction

Function DrainCum(ReferenceAlias DeflateAlias) Global
	sr_infDeflateAbility Deflate = DeflateAlias as sr_infDeflateAbility
	Deflate.OnKeyDown(Deflate.config.defKey)
EndFunction
