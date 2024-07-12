Scriptname _SLS_IntSlax  Hidden

Int Function GetVersion(Quest SlaxConfigQuest) Global
	Return (SlaxConfigQuest as slaConfigScr).GetVersion()
EndFunction

Int Function GetActorArousal(Quest sla_FrameworkQuest, Actor who) Global
	Return (sla_FrameworkQuest as slaFrameworkScr).GetActorArousal(who)
EndFunction

Int Function SetActorExposure(Quest sla_InternalQuest, Actor who, Int newActorExposure) Global
	Return (sla_InternalQuest as slaFrameworkScr).SetActorExposure(who, newActorExposure)
EndFunction
