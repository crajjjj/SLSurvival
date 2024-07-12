Scriptname _SLS_IntPsq Hidden 

Float Function GetEnergyMax(Quest PsqQuest) Global
	Return (PsqQuest as PlayerSuccubusQuestScript).MaxEnergy
EndFunction

Function UpdateEnergyBar(Quest PsqQuest, Float Manpukudo) Global
	(PsqQuest as PlayerSuccubusQuestScript).SEBU.UpdateEnergyBar(Manpukudo)
EndFunction
