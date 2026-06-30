Scriptname mzinInterfaceSexLab

Actor[] Function GetSexActors(Quest SlQuest, Int tid) Global
	if SlQuest
		Return (SLQuest as SexLabFramework).GetController(tid).Positions
	endIf
	Return (new Actor[1])
EndFunction

Bool Function IsActorActive(Quest SlQuest, Actor akTarget) Global
	if SlQuest
		Return (SLQuest as SexLabFramework).IsActorActive(akTarget)
	endIf
	Return false
EndFunction

Bool Function IsVictim(Quest SlQuest, Int tid, Actor akTarget) Global
	if SlQuest
		Return (SLQuest as SexLabFramework).IsVictim(tid, akTarget)
	endIf
	Return False
EndFunction

Function ClearCum(Quest SlQuest, Actor akTarget) Global
	if SlQuest
		(SLQuest as SexLabFramework).ClearCum(akTarget)
	endIf
EndFunction

Function TrackActor(Quest SlQuest, Actor akTarget, String fid_s) Global
	if SlQuest
		(SLQuest as SexLabFramework).TrackActor(akTarget, "BiS_" + fid_s + "Track")
	endIf
EndFunction

Function UntrackActor(Quest SlQuest, Actor akTarget, String fid_s) Global
	if SlQuest
		(SLQuest as SexLabFramework).UntrackActor(akTarget, "BiS_" + fid_s + "Track")
	endIf
EndFunction