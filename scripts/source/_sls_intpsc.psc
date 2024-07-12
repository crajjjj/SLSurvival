Scriptname _SLS_IntPsc Hidden 

Int Function GetPscBountyWhiterun(Quest PscQuest) Global
	PaySexCrimeMCM Psc = PscQuest as PaySexCrimeMCM
	Return (Psc.BountyViolent[8] + Psc.BountyNonViolent[8])
EndFunction

Int Function GetPscBountySolitude(Quest PscQuest) Global
	PaySexCrimeMCM Psc = PscQuest as PaySexCrimeMCM
	Return (Psc.BountyViolent[3] + Psc.BountyNonViolent[3])
EndFunction

Int Function GetPscBountyMarkarth(Quest PscQuest) Global
	PaySexCrimeMCM Psc = PscQuest as PaySexCrimeMCM
	Return (Psc.BountyViolent[6] + Psc.BountyNonViolent[6])
EndFunction

Int Function GetPscBountyWindhelm(Quest PscQuest) Global
	PaySexCrimeMCM Psc = PscQuest as PaySexCrimeMCM
	Return (Psc.BountyViolent[1] + Psc.BountyNonViolent[1])
EndFunction

Int Function GetPscBountyRiften(Quest PscQuest) Global
	PaySexCrimeMCM Psc = PscQuest as PaySexCrimeMCM
	Return (Psc.BountyViolent[7] + Psc.BountyNonViolent[7])
EndFunction
