Scriptname MME_BreastEnlargePotion extends activemagiceffect Hidden

Event OnEffectStart( Actor akTarget, Actor akCaster )
	MilkQUEST MilkQ = Quest.GetQuest("MME_MilkQUEST") as MilkQUEST
	Actor PlayerRef = Game.Getplayer()
	
	if MilkQ.MILKmaid.find(akTarget) == -1 && MilkQ.MILKSlave.Find(akTarget) == -1
		int ButtonPressed
		int count = 0
		int C = 0

		if akTarget != PlayerREF
			While C+1 < MilkQ.MilkMaid.Length
				C += 1
				If MilkQ.MilkMaid[C] != None
					count += 1
				EndIf
			EndWhile
		EndIf
		
		if akTarget == MilkQ.PlayerREF || count < MilkQ.Milklvl0fix()
			if akTarget != PlayerREF
				ButtonPressed = (MilkQ.MakeMilkMaid).Show()
			EndIf
			
			if akTarget == PlayerREF || ButtonPressed == 0
				;insert quest here
				MilkQ.AssignSlotMaid(akTarget)
				Utility.Wait( 1.0 )
			EndIf
		EndIf
	EndIf
	
	if MilkQ.MILKmaid.find(akTarget) != -1 || MilkQ.MILKSlave.Find(akTarget) != -1
		StorageUtil.AdjustFloatValue(akTarget, "MME.MilkMaid.BreastBaseModPotion", 0.1)
	endif
EndEvent