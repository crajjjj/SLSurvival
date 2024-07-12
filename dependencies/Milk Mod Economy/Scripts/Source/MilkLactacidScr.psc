Scriptname MilkLactacidScr extends activemagiceffect Hidden

Event OnEffectStart( Actor akTarget, Actor akCaster )
	MilkQUEST MilkQ = Quest.GetQuest("MME_MilkQUEST") as MilkQUEST
	Actor PlayerRef = Game.Getplayer()
	
	if MilkQ.Plugin_SlSW && akTarget == PlayerREF && !MilkQ.DisableSkoomaLactacid
		akTarget.equipitem(Game.GetFormFromFile(0x57A7A, "Skyrim.esm"),false,true)
	endif
	
	if akTarget.GetLeveledActorBase().GetSex() == 1 || MilkQ.MaleMaids == true
		String MaidName = akTarget.GetLeveledActorBase().getname()
		if MilkQ.MILKmaid.find(akTarget) != -1; || MilkQ.MILKSlave.Find(akTarget) != -1
			if akTarget.HasSpell(MilkQ.MME_Spells_Buffs.GetAt(3) as Spell)\
			|| akTarget.HasSpell(MilkQ.MME_Spells_Buffs.GetAt(4) as Spell)
			
				if akTarget.HasSpell(MilkQ.MME_Spells_Buffs.GetAt(3) as Spell)
					akTarget.RemoveSpell(MilkQ.MME_Spells_Buffs.GetAt(3) as Spell)
				endif
				
				if akTarget.HasSpell(MilkQ.MME_Spells_Buffs.GetAt(4) as Spell)
					akTarget.RemoveSpell( MilkQ.MME_Spells_Buffs.GetAt(4) as Spell )
				endif
				
				Debug.Notification(MilkQ.formatString(JsonUtil.GetStringValue("/MME/Strings", "exhaustiongone"), MaidName))
			endif
			
			MME_Storage.changeLactacidCurrent(akTarget, 1)
			MilkQ.CurrentSize(akTarget)
		elseif !akTarget.IsInCombat() && !akTarget.IsOnMount() && MilkQ.MILKSlave.Find(akTarget) == -1
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
					
					if MilkQ.MILKmaid.find(akTarget) != -1 
						MME_Storage.changeLactacidCurrent(akTarget, 1)
						MilkQ.CurrentSize(akTarget)
					EndIf
				EndIf
			EndIf
			
			If (MilkQ.SexLab.IsValidActor(akTarget))
				If !(akTarget.GetSitState() <= 3 && akTarget.GetSitState() > 0)
					if (akTarget == PlayerREF)
						If MilkQ.MilkStory
							Debug.Messagebox(JsonUtil.GetStringValue("/MME/Strings", "lactacidstory"))
						EndIf
						
						Utility.Wait(1.0)
						
						Game.DisablePlayerControls(1, 1, 0, 0, 1, 1, 0) ;(True,True,False,False,True,True,True,True,0)
						Game.ForceThirdPerson()
						Game.ShakeCamera(none, Utility.RandomFloat(0.5 , 1), 10)
					endif
					
					Debug.SendAnimationEvent(akTarget,"ZaZAPCHorFd")
					akTarget.Setunconscious(true)
					
					MilkQ.SexLab.PickVoice(akTarget).Moan(akTarget, Utility.RandomInt (70, 100), false)
					
					if akTarget == PlayerREF
						SendModEvent("PlayerOrgasmStart")
					endIf
					
					Utility.Wait( 10.0 )
					
					if akTarget == PlayerREF
						SendModEvent("PlayerOrgasmEnd")
					endIf
					
					If MilkQ.MilkStory
						Debug.Messagebox(MilkQ.formatString(JsonUtil.GetStringValue("/MME/Strings", "lactacidorgasm"), MaidName))
					EndIf
					
					Debug.SendAnimationEvent(akTarget,"IdleForceDefaultState")
					akTarget.Setunconscious(false)
					
					if akTarget == PlayerREF && !MilkQ.SexLab.IsActorActive(akTarget)
						Game.EnablePlayerControls() ;(True,True,True,True,True,True,True,True,0)
					endif
				endif
			endif
		endif
	endif
EndEvent