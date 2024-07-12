Scriptname SLSF_FameGainCounter_Per extends activemagiceffect  
SLSF_Configuration Property Config Auto
SLSF_FameMaintenance Property FameMain Auto

Actor Property PlayerRef Auto


Event OnEffectStart(Actor akTarget, Actor akCaster)
	If Config.NeedLosForFameGainRequest && !akTarget.HasLOS(PlayerRef)
		If akTarget.GetDistance(PlayerRef) > Config.DistanceWithoutLosNeeded
			Return
		EndIf
	EndIf
	
	Float Prob = 1.0
	Int RelRank = AkTarget.GetRelationshipRank(PlayerRef)

	If RelRank < 0	;Enemy
		Prob = Config.FameIncreaseByEnemy
	ElseIf RelRank == 0	;Neutral
		Prob = Config.FameIncreaseByNeutral
	ElseIf RelRank >= 1 && RelRank < 4	;Frend
		Prob = Config.FameIncreaseByFriend
	Else	; RelRank == 4		;Lover
		Prob = Config.FameIncreaseByLover
	EndIf
	
	If Utility.RandomFloat(0.0, 1.0) < Prob
		FameMain.CountListIncrease(0)
	EndIf
EndEvent