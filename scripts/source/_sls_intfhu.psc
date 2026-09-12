Scriptname _SLS_IntFhu Hidden 

Float Function GetCumCapacityMax(Quest FhuConfigQuest) Global
	Return (FhuConfigQuest as sr_inflateConfig).maxInflation
EndFunction

Float Function GetOralCumCapacityMax(Quest FhuConfigQuest) Global
	; Oral has its own pool size, separate from maxInflation. sr_inflateConfig builds without
	; the property (pre-Baka FHU) read back as 0.0 and log, so callers must guard the divide.
	Return (FhuConfigQuest as sr_inflateConfig).OralmaxInflation
EndFunction

Function InflateTo(Quest FhuInflateQuest, Actor akActor, int Hole, float time, float targetLevel = -1.0, String callback = "") Global ; Unused for now
	; Hole: 1 - Vaginal, 2 - Anal
	; FHU 2.x reordered InflateTo params (time/targetLevel swapped) - use named args so order can't bite us
	(FhuInflateQuest as sr_inflateQuest).InflateTo(akActor, Hole, targetLevel = targetLevel, time = time, callback = callback)
EndFunction

Float Function GetCumAmountForActor(Quest FhuInflateQuest, Actor a, Actor[] all) Global ; a: Receiving actor, all: All actors in thread
	Return (FhuInflateQuest as sr_inflateQuest).GetCumAmountForActor(a, all)
EndFunction

Function DrainCum(ReferenceAlias DeflateAlias) Global
	sr_infDeflateAbility Deflate = DeflateAlias as sr_infDeflateAbility
	Deflate.OnKeyDown(Deflate.config.defKey)
EndFunction
