Scriptname MME_MilkSuccubus extends activemagiceffect Hidden

Event OnEffectStart( Actor akTarget, Actor akCaster )
	MilkQUEST MilkQ = Quest.GetQuest("MME_MilkQUEST") as MilkQUEST
	Actor PlayerRef = Game.Getplayer()

	if akTarget == PlayerRef && MilkQ.MilkSuccubusTransform 
		if MilkQ.Plugin_PSQ
			if !(StorageUtil.GetIntValue(akTarget, "PSQ_PlayerIsSuccubus") > 0)
				MilkQ.PSQ.BecomeSuccubus()
			endif
		endif
		SendModEvent("HoSLDD_GivePlayerPowers")									;Sexlab Deadly Drain
		if !(StorageUtil.GetIntValue(akTarget, "Angrim_iSuccubusCurse") > 0)
			SendModEvent("HoSLDD_GivePlayerPowers")								;Angrim's Apprentice
		endif
	endif
	
	Cell akTargetCell = PlayerREF.GetParentCell()
	int iRef = 0
	while iRef <= akTargetCell.getNumRefs(43) 									;GetType() 62-char,44-lvchar,43-npc
		Actor aNPC = akTargetCell.getNthRef(iRef, 43) as Actor
		If aNPC.HasLOS(akTarget)
			MilkQ.SLA.UpdateActorExposure(aNPC, 25)								;increase arousal by 25 for everyone(who has LoS) in current cell
		EndIf
		iRef = iRef + 1
	endWhile
EndEvent