Scriptname MME_StartMilking extends activemagiceffect Hidden

Event OnEffectStart( Actor akTarget, Actor akCaster )
	MilkQUEST MilkQ = Quest.GetQuest("MME_MilkQUEST") as MilkQUEST
	IF !akTarget.HasSpell( MilkQ.BeingMilkedPassive ) && !akTarget.IsInCombat() && !akTarget.IsOnMount() && MilkQ.SexLab.IsValidActor(akTarget)
		MilkQ.Milking(akTarget, 0, 1, 1)
	ELSEIF !akTarget.HasSpell( MilkQ.BeingMilkedPassive ) && (akTarget.IsInCombat() || akTarget.IsOnMount())
		MilkQ.Milking(akTarget, 0, 4, 0)
	ENDIF
EndEvent