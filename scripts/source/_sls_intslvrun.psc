Scriptname _SLS_IntSlvrun Hidden 

Function DecreaseResistance(Bool Increase = true, int value = 1, Quest SlvUtilQuest) Global
	(SlvUtilQuest as SLV_Utilities).SLV_FreeSubmissiveChange(Increase, Value)
EndFunction

Function BeginSlaverun(Quest SlvEnslaveProgQuest) Global
	(SlvEnslaveProgQuest as SLV_EnslavingProgress).OnUpdateGameTime()
EndFunction

; True = free. False = Enslaved
; Cities
Bool Function IsFreeTownWhiterun(Quest SlvLocCheckQuest) Global
	Return (SlvLocCheckQuest as SLV_EnforcerLocationCheck).SLV_IsWhiterunFree()
EndFunction

Bool Function IsFreeTownRiften(Quest SlvLocCheckQuest) Global
	Return (SlvLocCheckQuest as SLV_EnforcerLocationCheck).SLV_IsRiftenFree()
EndFunction

Bool Function IsFreeTownWindhelm(Quest SlvLocCheckQuest) Global
	Return (SlvLocCheckQuest as SLV_EnforcerLocationCheck).SLV_IsWindhelmFree()
EndFunction

Bool Function IsFreeTownMarkarth(Quest SlvLocCheckQuest) Global
	Return (SlvLocCheckQuest as SLV_EnforcerLocationCheck).SLV_IsMarkarthFree()
EndFunction

Bool Function IsFreeTownSolitude(Quest SlvLocCheckQuest) Global
	Return (SlvLocCheckQuest as SLV_EnforcerLocationCheck).SLV_IsSolitudeFree()
EndFunction

; Towns
Bool Function IsFreeTownRiverwood(Quest SlvLocCheckQuest) Global
	Return (SlvLocCheckQuest as SLV_EnforcerLocationCheck).SLV_IsRiverwoodFree()
EndFunction

Bool Function IsFreeTownFalkreath(Quest SlvLocCheckQuest) Global
	Return (SlvLocCheckQuest as SLV_EnforcerLocationCheck).SLV_IsFalkreathFree()
EndFunction

Bool Function IsFreeTownDawnstar(Quest SlvLocCheckQuest) Global
	Return (SlvLocCheckQuest as SLV_EnforcerLocationCheck).SLV_IsDawnstarFree()
EndFunction

Bool Function IsFreeTownMorthal(Quest SlvLocCheckQuest) Global
	Return (SlvLocCheckQuest as SLV_EnforcerLocationCheck).SLV_IsMorthalFree()
EndFunction

Bool Function IsFreeTownWinterhold(Quest SlvLocCheckQuest) Global
	Return (SlvLocCheckQuest as SLV_EnforcerLocationCheck).SLV_IsWinterholdFree()
EndFunction

Bool Function IsFreeTownRavenRock(Quest SlvLocCheckQuest) Global
	Return (SlvLocCheckQuest as SLV_EnforcerLocationCheck).SLV_IsRavenRockFree()
EndFunction
