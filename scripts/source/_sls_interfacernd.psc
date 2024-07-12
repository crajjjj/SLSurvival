Scriptname _SLS_InterfaceRnd extends Quest  

Event OnInit()
	RegisterForModEvent("_SLS_Int_PlayerLoadsGame", "On_SLS_Int_PlayerLoadsGame")
EndEvent

Event On_SLS_Int_PlayerLoadsGame(string eventName, string strArg, float numArg, Form sender)
	PlayerLoadsGame()
EndEvent

Function PlayerLoadsGame()
	If Game.GetModByName("RealisticNeedsandDiseases.esp") != 255
		If GetState() != "Installed"
			GoToState("Installed")
		EndIf
		
	Else
		If GetState() != ""
			GoToState("")
		EndIf
	EndIf
EndFunction

Bool Function GetIsInterfaceActive()
	If GetState() == "Installed"
		Return true
	EndIf
	Return false
EndFunction

Event OnEndState()
	Utility.Wait(5.0) ; Wait before entering active state to help avoid making function calls to scripts that may not have initialized yet.

	RndPlayerAlias = (Game.GetFormFromFile(0x00EB43, "RealisticNeedsandDiseases.esp") as Quest).GetNthAlias(0) as ReferenceAlias

	; Should probably change all this crap to arrays....
	
	RND_HungerEffect00 = Game.GetFormFromFile(0x000D62, "RealisticNeedsandDiseases.esp") as MagicEffect
	RND_HungerEffect01 = Game.GetFormFromFile(0x0012C5, "RealisticNeedsandDiseases.esp") as MagicEffect
	RND_HungerEffect02 = Game.GetFormFromFile(0x0012C6, "RealisticNeedsandDiseases.esp") as MagicEffect
	RND_HungerEffect03 = Game.GetFormFromFile(0x0012C7, "RealisticNeedsandDiseases.esp") as MagicEffect
	RND_HungerEffect04 = Game.GetFormFromFile(0x001834, "RealisticNeedsandDiseases.esp") as MagicEffect
	RND_HungerEffect05 = Game.GetFormFromFile(0x0012C8, "RealisticNeedsandDiseases.esp") as MagicEffect

	RND_ThirstEffect00 = Game.GetFormFromFile(0x0012CD, "RealisticNeedsandDiseases.esp") as MagicEffect
	RND_ThirstEffect01 = Game.GetFormFromFile(0x0012CE, "RealisticNeedsandDiseases.esp") as MagicEffect
	RND_ThirstEffect02 = Game.GetFormFromFile(0x0012CF, "RealisticNeedsandDiseases.esp") as MagicEffect
	RND_ThirstEffect03 = Game.GetFormFromFile(0x002DF8, "RealisticNeedsandDiseases.esp") as MagicEffect
	RND_ThirstEffect04 = Game.GetFormFromFile(0x0012D0, "RealisticNeedsandDiseases.esp") as MagicEffect
	
	RND_SleepEffect00 = Game.GetFormFromFile(0x026FB1, "RealisticNeedsandDiseases.esp") as MagicEffect
	RND_SleepEffect01 = Game.GetFormFromFile(0x00337C, "RealisticNeedsandDiseases.esp") as MagicEffect
	RND_SleepEffect02 = Game.GetFormFromFile(0x00337D, "RealisticNeedsandDiseases.esp") as MagicEffect
	RND_SleepEffect03 = Game.GetFormFromFile(0x00337E, "RealisticNeedsandDiseases.esp") as MagicEffect
	RND_SleepEffect04 = Game.GetFormFromFile(0x00337F, "RealisticNeedsandDiseases.esp") as MagicEffect

	RND_HungerPoints = Game.GetFormFromFile(0x002884, "RealisticNeedsandDiseases.esp") as GlobalVariable
	RND_HungerPointsPerHour = Game.GetFormFromFile(0x002DE7, "RealisticNeedsandDiseases.esp") as GlobalVariable
	RND_HungerLastUpdateTimeStamp = Game.GetFormFromFile(0x002DE8, "RealisticNeedsandDiseases.esp") as GlobalVariable
	
	RND_AnimEat = Game.GetFormFromFile(0x024488, "RealisticNeedsandDiseases.esp") as GlobalVariable
	RND_1stPersonMsg = Game.GetFormFromFile(0x0900CA, "RealisticNeedsandDiseases.esp") as GlobalVariable
	
	RND_ForceSatiation = Game.GetFormFromFile(0x0536D7, "RealisticNeedsandDiseases.esp") as GlobalVariable
	
	RND_HungerLevel00 = Game.GetFormFromFile(0x002DE9, "RealisticNeedsandDiseases.esp") as GlobalVariable
	RND_HungerLevel01 = Game.GetFormFromFile(0x002DEA, "RealisticNeedsandDiseases.esp") as GlobalVariable
	RND_HungerLevel02 = Game.GetFormFromFile(0x002DEB, "RealisticNeedsandDiseases.esp") as GlobalVariable
	RND_HungerLevel03 = Game.GetFormFromFile(0x002DEC, "RealisticNeedsandDiseases.esp") as GlobalVariable
	RND_HungerLevel04 = Game.GetFormFromFile(0x002DED, "RealisticNeedsandDiseases.esp") as GlobalVariable
	RND_HungerLevel05 = Game.GetFormFromFile(0x002DEE, "RealisticNeedsandDiseases.esp") as GlobalVariable
	
	RND_HungerSpell00 = Game.GetFormFromFile(0x001D97, "RealisticNeedsandDiseases.esp") as Spell
	RND_HungerSpell01 = Game.GetFormFromFile(0x001D99, "RealisticNeedsandDiseases.esp") as Spell
	RND_HungerSpell02 = Game.GetFormFromFile(0x001D9B, "RealisticNeedsandDiseases.esp") as Spell
	RND_HungerSpell03 = Game.GetFormFromFile(0x001D9D, "RealisticNeedsandDiseases.esp") as Spell
	RND_HungerSpell04 = Game.GetFormFromFile(0x00231B, "RealisticNeedsandDiseases.esp") as Spell
	RND_HungerSpell05 = Game.GetFormFromFile(0x00231C, "RealisticNeedsandDiseases.esp") as Spell
	
	RND_HungerLevel00ConsumeMessage = Game.GetFormFromFile(0x0053F5, "RealisticNeedsandDiseases.esp") as Message
	RND_HungerLevel01ConsumeMessage = Game.GetFormFromFile(0x0053F6, "RealisticNeedsandDiseases.esp") as Message
	RND_HungerLevel02ConsumeMessage = Game.GetFormFromFile(0x0053F7, "RealisticNeedsandDiseases.esp") as Message
	RND_HungerLevel03ConsumeMessage = Game.GetFormFromFile(0x0053F8, "RealisticNeedsandDiseases.esp") as Message
	RND_HungerLevel04ConsumeMessage = Game.GetFormFromFile(0x0053F9, "RealisticNeedsandDiseases.esp") as Message
	RND_HungerLevel05ConsumeMessage = Game.GetFormFromFile(0x0053FA, "RealisticNeedsandDiseases.esp") as Message
	
	RND_HungerLevel00ConsumeMessageB = Game.GetFormFromFile(0x0900C4, "RealisticNeedsandDiseases.esp") as Message
	RND_HungerLevel01ConsumeMessageB = Game.GetFormFromFile(0x0900C5, "RealisticNeedsandDiseases.esp") as Message
	RND_HungerLevel02ConsumeMessageB = Game.GetFormFromFile(0x0900C6, "RealisticNeedsandDiseases.esp") as Message
	RND_HungerLevel03ConsumeMessageB = Game.GetFormFromFile(0x0900C7, "RealisticNeedsandDiseases.esp") as Message
	RND_HungerLevel04ConsumeMessageB = Game.GetFormFromFile(0x0900C8, "RealisticNeedsandDiseases.esp") as Message
	RND_HungerLevel05ConsumeMessageB = Game.GetFormFromFile(0x0900C9, "RealisticNeedsandDiseases.esp") as Message
	
	; ======================

	RND_ThirstPoints = Game.GetFormFromFile(0x002E07, "RealisticNeedsandDiseases.esp") as GlobalVariable
	RND_ThirstPointsPerHour = Game.GetFormFromFile(0x002E08, "RealisticNeedsandDiseases.esp") as GlobalVariable
	RND_ThirstLastUpdateTimeStamp = Game.GetFormFromFile(0x002E09, "RealisticNeedsandDiseases.esp") as GlobalVariable
	RND_AnimDrink = Game.GetFormFromFile(0x024489, "RealisticNeedsandDiseases.esp") as GlobalVariable
	
	RND_ThirstLevel00 = Game.GetFormFromFile(0x002E0A, "RealisticNeedsandDiseases.esp") as GlobalVariable
	RND_ThirstLevel01 = Game.GetFormFromFile(0x002E0B, "RealisticNeedsandDiseases.esp") as GlobalVariable
	RND_ThirstLevel02 = Game.GetFormFromFile(0x002E0C, "RealisticNeedsandDiseases.esp") as GlobalVariable
	RND_ThirstLevel03 = Game.GetFormFromFile(0x002E0D, "RealisticNeedsandDiseases.esp") as GlobalVariable
	RND_ThirstLevel04 = Game.GetFormFromFile(0x002E0E, "RealisticNeedsandDiseases.esp") as GlobalVariable
	
	RND_ThirstSpell00 = Game.GetFormFromFile(0x001DA1, "RealisticNeedsandDiseases.esp") as Spell
	RND_ThirstSpell01 = Game.GetFormFromFile(0x001DA3, "RealisticNeedsandDiseases.esp") as Spell
	RND_ThirstSpell02 = Game.GetFormFromFile(0x001DA5, "RealisticNeedsandDiseases.esp") as Spell
	RND_ThirstSpell03 = Game.GetFormFromFile(0x002DFA, "RealisticNeedsandDiseases.esp") as Spell
	RND_ThirstSpell04 = Game.GetFormFromFile(0x002DFC, "RealisticNeedsandDiseases.esp") as Spell
	
	RND_ThirstLevel00ConsumeMessage = Game.GetFormFromFile(0x0053F5, "RealisticNeedsandDiseases.esp") as Message
	RND_ThirstLevel01ConsumeMessage = Game.GetFormFromFile(0x005ECD, "RealisticNeedsandDiseases.esp") as Message
	RND_ThirstLevel02ConsumeMessage = Game.GetFormFromFile(0x005ECE, "RealisticNeedsandDiseases.esp") as Message
	RND_ThirstLevel03ConsumeMessage = Game.GetFormFromFile(0x005ECF, "RealisticNeedsandDiseases.esp") as Message
	RND_ThirstLevel04ConsumeMessage = Game.GetFormFromFile(0x005ED0, "RealisticNeedsandDiseases.esp") as Message
	
	RND_ThirstLevel00ConsumeMessageB = Game.GetFormFromFile(0x090B97, "RealisticNeedsandDiseases.esp") as Message
	RND_ThirstLevel01ConsumeMessageB = Game.GetFormFromFile(0x090B98, "RealisticNeedsandDiseases.esp") as Message
	RND_ThirstLevel02ConsumeMessageB = Game.GetFormFromFile(0x090B99, "RealisticNeedsandDiseases.esp") as Message
	RND_ThirstLevel03ConsumeMessageB = Game.GetFormFromFile(0x090B96, "RealisticNeedsandDiseases.esp") as Message
	RND_ThirstLevel04ConsumeMessageB = Game.GetFormFromFile(0x090B95, "RealisticNeedsandDiseases.esp") as Message
	
	; =========================
	RND_Rested = Game.GetFormFromFile(0x0264E5, "RealisticNeedsandDiseases.esp") as Spell
	RND_WellRested = Game.GetFormFromFile(0x0264E1, "RealisticNeedsandDiseases.esp") as Spell
	RND_RestlessBeast = Game.GetFormFromFile(0x02B5B6, "RealisticNeedsandDiseases.esp") as Spell
	RND_MarriageRested = Game.GetFormFromFile(0x0264E3, "RealisticNeedsandDiseases.esp") as Spell
	
	RND_SleepSpell00 = Game.GetFormFromFile(0x00BACD, "RealisticNeedsandDiseases.esp") as Spell
	RND_SleepSpell01 = Game.GetFormFromFile(0x00231E, "RealisticNeedsandDiseases.esp") as Spell
	RND_SleepSpell02 = Game.GetFormFromFile(0x002320, "RealisticNeedsandDiseases.esp") as Spell
	RND_SleepSpell03 = Game.GetFormFromFile(0x001DB3, "RealisticNeedsandDiseases.esp") as Spell
	RND_SleepSpell04 = Game.GetFormFromFile(0x001DB5, "RealisticNeedsandDiseases.esp") as Spell
	
	RND_SleepDisease = Game.GetFormFromFile(0x014740, "RealisticNeedsandDiseases.esp") as Spell
	
	RND_SleepLevel00 = Game.GetFormFromFile(0x02B5B3, "RealisticNeedsandDiseases.esp") as GlobalVariable
	RND_SleepLevel01 = Game.GetFormFromFile(0x00BAC5, "RealisticNeedsandDiseases.esp") as GlobalVariable
	RND_SleepLevel02 = Game.GetFormFromFile(0x00BAC6, "RealisticNeedsandDiseases.esp") as GlobalVariable
	RND_SleepLevel03 = Game.GetFormFromFile(0x00BAC7, "RealisticNeedsandDiseases.esp") as GlobalVariable
	RND_SleepLevel04 = Game.GetFormFromFile(0x00BAC8, "RealisticNeedsandDiseases.esp") as GlobalVariable
	
	RND_SleepPoints = Game.GetFormFromFile(0x00BAC2, "RealisticNeedsandDiseases.esp") as GlobalVariable
	RND_SleepPointsPerHour = Game.GetFormFromFile(0x00BAC3, "RealisticNeedsandDiseases.esp") as GlobalVariable
	RND_SleepLastUpdateTimeStamp = Game.GetFormFromFile(0x00BAC4, "RealisticNeedsandDiseases.esp") as GlobalVariable
	
	RND_RestedMessage = Game.GetFormFromFile(0x0264E7, "RealisticNeedsandDiseases.esp") as Message
	RND_WellRestedMessage = Game.GetFormFromFile(0x0264E8, "RealisticNeedsandDiseases.esp") as Message
	RND_MarriageRestedMessage = Game.GetFormFromFile(0x0264E9, "RealisticNeedsandDiseases.esp") as Message
	RND_BeastBloodMessage = Game.GetFormFromFile(0x0264EB, "RealisticNeedsandDiseases.esp") as Message
	
	RND_HungerSpell00.SetNthEffectMagnitude(0, Menu.GluttedSpeed)
EndEvent

; Installed State ====================================================
State Installed
	Bool Function IsNeedsModActive()
		Return _SLS_IntRnd.IsNeedsModActive(RndPlayerAlias)
	EndFunction

	Function Eat(Int FoodPoints)
		
		if _SLS_IntRnd.isVampire(RndPlayerAlias)
			RND_HungerPoints.SetValue(10)
			RemoveHungerSpells()	
		else
			; eat food
			int AdjPoints = Utility.RandomInt(-5,5)
			float HungerPoints = RND_HungerPoints.GetValue()
			RND_HungerPoints.SetValue(RND_HungerPoints.GetValue() - FoodPoints - AdjPoints)
			
			if RND_ForceSatiation.GetValue() == 1
				if HungerPoints >= RND_HungerLevel02.GetValue() && RND_HungerPoints.GetValue() < RND_HungerLevel01.GetValue()
					RND_HungerPoints.SetValue(RND_HungerLevel01.GetValue())
				endif
			endif

			; Hunger points cap between 0-RND_HungerLevel05, 
			; so you don't end up eating a lot and still starving
			; or eating one huge meal hoping to last for a week
			if RND_HungerPoints.GetValue() > RND_HungerLevel05.GetValue()
				RND_HungerPoints.SetValue(RND_HungerLevel05.GetValue())
			elseif RND_HungerPoints.GetValue() < 0
				RND_HungerPoints.SetValue(0)
			endif
		
			; update time stamp
			RND_HungerLastUpdateTimeStamp.SetValue(Utility.GetCurrentGameTime())
		
			; new spell to add
			Spell HungerSpell = RND_HungerSpell02
			Message HungerLevelMessage = None
		
			if RND_HungerPoints.GetValue() < RND_HungerLevel01.GetValue()
				HungerSpell = RND_HungerSpell00
				if RND_1stPersonMsg.GetValue() == 1
					HungerLevelMessage = RND_HungerLevel00ConsumeMessage
				else
					HungerLevelMessage = RND_HungerLevel00ConsumeMessageB
				endif
		
			elseif RND_HungerPoints.GetValue() >= RND_HungerLevel01.GetValue() && RND_HungerPoints.GetValue() < RND_HungerLevel02.GetValue()
				HungerSpell = RND_HungerSpell01
				if RND_1stPersonMsg.GetValue() == 1
					HungerLevelMessage = RND_HungerLevel01ConsumeMessage
				else
					HungerLevelMessage = RND_HungerLevel01ConsumeMessageB
				endif
		
			elseif RND_HungerPoints.GetValue() >= RND_HungerLevel02.GetValue() && RND_HungerPoints.GetValue() < RND_HungerLevel03.GetValue()
				HungerSpell = RND_HungerSpell02
				if RND_1stPersonMsg.GetValue() == 1
					HungerLevelMessage = RND_HungerLevel02ConsumeMessage
				else
					HungerLevelMessage = RND_HungerLevel02ConsumeMessageB
				endif
		
			elseif RND_HungerPoints.GetValue() >= RND_HungerLevel03.GetValue() && RND_HungerPoints.GetValue() < RND_HungerLevel04.GetValue()
				HungerSpell = RND_HungerSpell03
				if RND_1stPersonMsg.GetValue() == 1
					HungerLevelMessage = RND_HungerLevel03ConsumeMessage
				else
					HungerLevelMessage = RND_HungerLevel03ConsumeMessageB
				endif
		
			elseif RND_HungerPoints.GetValue() >= RND_HungerLevel04.GetValue() && RND_HungerPoints.GetValue() < RND_HungerLevel05.GetValue()
				HungerSpell = RND_HungerSpell04
				if RND_1stPersonMsg.GetValue() == 1
					HungerLevelMessage = RND_HungerLevel04ConsumeMessage
				else
					HungerLevelMessage = RND_HungerLevel04ConsumeMessageB
				endif
		
			elseif RND_HungerPoints.GetValue() >= RND_HungerLevel05.GetValue()
				HungerSpell = RND_HungerSpell05
				if RND_1stPersonMsg.GetValue() == 1
					HungerLevelMessage = RND_HungerLevel05ConsumeMessage
				else
					HungerLevelMessage = RND_HungerLevel05ConsumeMessageB
				endif
		
			endif
			if PlayerRef.HasSpell(HungerSpell)
				HungerLevelMessage.Show()
			else
				RemoveHungerSpells()
				PlayerRef.AddSpell(HungerSpell, false)
				HungerLevelMessage.Show()
			endIf
			
		endIf
		
		;/
		if RND_AnimEat.GetValue() == 1
			if PlayerRef.GetAnimationVariableInt("i1stPerson") != 1
			
				if PlayerRef.GetSitState () == 3
					;PlayerRef.PlayIdle(ChairEatingStart)
					Debug.sendAnimationEvent(PlayerRef, "ChairEatingStart")
				else		
					PlayerRef.PlayIdle(idleEatingStandingStart)
				endif
				Utility.Wait(10)
				PlayerRef.PlayIdle(idleStop_Loose)
			endif
		endIf
		/;
	EndFunction

	Function Drink(Int WaterPoints)
		if _SLS_IntRnd.isVampire(RndPlayerAlias)
			RND_ThirstPoints.SetValue(10)
			RemoveThirstSpells()
		else
			; drink water
			int AdjPoints = Utility.RandomInt(-5,5)
			RND_ThirstPoints.SetValue(RND_ThirstPoints.GetValue() - WaterPoints - AdjPoints)

			if RND_ThirstPoints.GetValue() > RND_ThirstLevel04.GetValue()
				RND_ThirstPoints.SetValue(RND_ThirstLevel04.GetValue())
			elseif RND_ThirstPoints.GetValue() < 0
				RND_ThirstPoints.SetValue(0)
			endif
		
			RND_ThirstLastUpdateTimeStamp.SetValue(Utility.GetCurrentGameTime())
		
			; new spell to add
			Spell ThirstSpell = RND_ThirstSpell02
			Message ThirstLevelMessage = None
		
			if RND_ThirstPoints.GetValue() < RND_ThirstLevel01.GetValue()
				ThirstSpell = RND_ThirstSpell00
				if RND_1stPersonMsg.GetValue() == 1
					ThirstLevelMessage = RND_ThirstLevel00ConsumeMessage
				else
					ThirstLevelMessage = RND_ThirstLevel00ConsumeMessageB
				endif
		
			elseif RND_ThirstPoints.GetValue() >= RND_ThirstLevel01.GetValue() && RND_ThirstPoints.GetValue() < RND_ThirstLevel02.GetValue()
				ThirstSpell = RND_ThirstSpell01
				if RND_1stPersonMsg.GetValue() == 1
					ThirstLevelMessage = RND_ThirstLevel01ConsumeMessage
				else
					ThirstLevelMessage = RND_ThirstLevel01ConsumeMessageB
				endif
		
			elseif RND_ThirstPoints.GetValue() >= RND_ThirstLevel02.GetValue() && RND_ThirstPoints.GetValue() < RND_ThirstLevel03.GetValue()
				ThirstSpell = RND_ThirstSpell02
				if RND_1stPersonMsg.GetValue() == 1
					ThirstLevelMessage = RND_ThirstLevel02ConsumeMessage
				else
					ThirstLevelMessage = RND_ThirstLevel02ConsumeMessageB
				endif
		
			elseif RND_ThirstPoints.GetValue() >= RND_ThirstLevel03.GetValue() && RND_ThirstPoints.GetValue() < RND_ThirstLevel04.GetValue()
				ThirstSpell = RND_ThirstSpell03
				if RND_1stPersonMsg.GetValue() == 1
					ThirstLevelMessage = RND_ThirstLevel03ConsumeMessage
				else
					ThirstLevelMessage = RND_ThirstLevel03ConsumeMessageB
				endif
		
			elseif RND_ThirstPoints.GetValue() >= RND_ThirstLevel04.GetValue() 
				ThirstSpell = RND_ThirstSpell04
				if RND_1stPersonMsg.GetValue() == 1
					ThirstLevelMessage = RND_ThirstLevel04ConsumeMessage
				else
					ThirstLevelMessage = RND_ThirstLevel04ConsumeMessageB
				endif
		
			endif
			if PlayerRef.HasSpell(ThirstSpell)
				ThirstLevelMessage.Show()
			else
				RemoveThirstSpells()
				PlayerRef.AddSpell(ThirstSpell, false)
				ThirstLevelMessage.Show()
			endif
			
		endif
		
		;/
		if RND_AnimDrink.GetValue() == 1 && idleDrink
			if !PlayerRef.GetAnimationVariableInt("i1stPerson") == 1
			
				if PlayerRef.GetSitState () == 3
					PlayerRef.PlayIdle(ChairDrinkingStart)
					Utility.Wait(10)
					PlayerRef.PlayIdle(idleStop_Loose)
				else
					PlayerRef.PlayIdle(idleDrink)
				endif
			endif
		endif
		/;
	EndFunction

	Float Function GetFatigue()
		Return RND_SleepPoints.GetValue()
	EndFunction

	Function ModFatigue(Int SleepAmount, Bool Notify = false) ; +SleepAmount = Add Fatigue. -SleepAmount = Remove Fatigue
		RemoveSleepSpells()
		RND_SleepPoints.SetValue(RND_SleepPoints.GetValue() + SleepAmount)
		
		; Sleep points cap between 0-RND_SleepLevel03, 
		If RND_SleepPoints.GetValue() > RND_SleepLevel04.GetValue()
			RND_SleepPoints.SetValue(RND_SleepLevel04.GetValue())
		EndIf
		
		If RND_SleepPoints.GetValue() < 0
			RND_SleepPoints.SetValue(0)
		EndIf
		
		if RND_SleepPoints.GetValue() <= 0.0
		
			if _SLS_IntRnd.isWerewolf(RndPlayerAlias)			
				PlayerRef.AddSpell(RND_RestlessBeast, false)
				If Notify
					RND_BeastBloodMessage.Show()
				EndIf
				
			elseif PlayerRef.HasSpell(DoomLoverAbility) == 1			
				PlayerRef.AddSpell(RND_SleepSpell00, false)
				If Notify
					RND_RestedMessage.Show()
				EndIf
				
			else
				
				if RelationshipMarriageFIN.IsRunning() == True && RelationshipMarriageFIN.GetStage() > 10 \
						&& PlayerRef.GetCurrentLocation() == LoveInterest.GetActorRef().GetCurrentLocation()
						PlayerRef.AddSpell(RND_MarriageRested, false)
						If Notify
							RND_MarriageRestedMessage.Show()
						EndIf
				else
					Location Loc = PlayerRef.GetCurrentLocation()				
					if Loc != None
						if (Loc.HasKeyword(LocTypeInn) == True) || (Loc.HasKeyword(LocTypePlayerHouse) == True)
							PlayerRef.AddSpell(RND_WellRested, false)
							If Notify
								RND_WellRestedMessage.Show()
							EndIf
							
						else
							PlayerRef.AddSpell(RND_Rested, false)
							If Notify
								RND_RestedMessage.Show()
							EndIf
						endif
					else				
						PlayerRef.AddSpell(RND_Rested, false)
						If Notify
							RND_RestedMessage.Show()
						EndIf
					endif
				endif
			endif
			
		elseif RND_SleepPoints.GetValue() > 0 && RND_SleepPoints.GetValue() < RND_SleepLevel01.GetValue()
			PlayerRef.AddSpell(RND_SleepSpell00, false)		
				
		elseif RND_SleepPoints.GetValue() >= RND_SleepLevel01.GetValue() && RND_SleepPoints.GetValue() < RND_SleepLevel02.GetValue()
			PlayerRef.AddSpell(RND_SleepSpell01, false)
				
		elseif RND_SleepPoints.GetValue() >= RND_SleepLevel02.GetValue() && RND_SleepPoints.GetValue() < RND_SleepLevel03.GetValue()
			PlayerRef.AddSpell(RND_SleepSpell02, false)
				
		elseif RND_SleepPoints.GetValue() >= RND_SleepLevel03.GetValue() && RND_SleepPoints.GetValue() < RND_SleepLevel04.GetValue()
			PlayerRef.AddSpell(RND_SleepSpell03, false)
				
		elseif RND_SleepPoints.GetValue() >= RND_SleepLevel04.GetValue()
			PlayerRef.AddSpell(RND_SleepSpell04, false)
		
		endif
		
		;RND_SleepDisease.Cast(PlayerRef, PlayerRef)
	EndFunction

	Function RemoveHungerSpells()
		PlayerRef.RemoveSpell(RND_HungerSpell00)
		PlayerRef.RemoveSpell(RND_HungerSpell01)
		PlayerRef.RemoveSpell(RND_HungerSpell02)
		PlayerRef.RemoveSpell(RND_HungerSpell03)
		PlayerRef.RemoveSpell(RND_HungerSpell04)
		PlayerRef.RemoveSpell(RND_HungerSpell05)
	EndFunction

	Function RemoveThirstSpells()
		PlayerRef.RemoveSpell(RND_ThirstSpell00)
		PlayerRef.RemoveSpell(RND_ThirstSpell01)
		PlayerRef.RemoveSpell(RND_ThirstSpell02)
		PlayerRef.RemoveSpell(RND_ThirstSpell03)
		PlayerRef.RemoveSpell(RND_ThirstSpell04)
	EndFunction

	Function RemoveSleepSpells()
		PlayerRef.RemoveSpell(RND_Rested)
		PlayerRef.RemoveSpell(RND_WellRested)
		PlayerRef.RemoveSpell(RND_RestlessBeast)
		PlayerRef.RemoveSpell(RND_MarriageRested)	
		PlayerRef.RemoveSpell(RND_SleepSpell00)
		PlayerRef.RemoveSpell(RND_SleepSpell01)
		PlayerRef.RemoveSpell(RND_SleepSpell02)
		PlayerRef.RemoveSpell(RND_SleepSpell03)
		PlayerRef.RemoveSpell(RND_SleepSpell04)
	EndFunction

	Bool Function IsDesperate()
		If PlayerRef.HasMagicEffect(RND_ThirstEffect04) || PlayerRef.HasMagicEffect(RND_HungerEffect05)
			Return true
		EndIf
		Return false
	EndFunction

	Bool Function GetBegIsHungry()
		If RND_HungerPoints.GetValueInt() >= RND_HungerLevel03.GetValueInt()
			Return true
		EndIf
		Return false
	EndFunction

	Bool Function GetBegIsThirsty()
		If RND_ThirstPoints.GetValueInt() >= RND_ThirstLevel02.GetValueInt()
			Return true
		EndIf
		Return false
	EndFunction

	Float Function GetBellyScale()
		If PlayerRef.HasMagicEffect(RND_HungerEffect00) ; Glutted
			Return BellyScaleRnd00
		ElseIf PlayerRef.HasMagicEffect(RND_HungerEffect01)
			Return BellyScaleRnd01
		ElseIf PlayerRef.HasMagicEffect(RND_HungerEffect02)
			Return BellyScaleRnd02
		ElseIf PlayerRef.HasMagicEffect(RND_HungerEffect03)
			Return BellyScaleRnd03
		ElseIf PlayerRef.HasMagicEffect(RND_HungerEffect04)
			Return BellyScaleRnd04
		ElseIf PlayerRef.HasMagicEffect(RND_HungerEffect05) ; Starving
			Return BellyScaleRnd05
		
		Else ; magic effect is currently being swapped out - wait
			Return -1.0
		EndIf
	EndFunction

	Function CorrectFatigue(Float SleepPenalty, Float StartingFatigue, Float HoursSlept) ; Not Tired - 0.0, Slightly Tired - 30.0, Tired - 60.0, Very Tired - 120.0, Exhausted - 240.0. Capped between 0.0 - 240.0
		
		; Convert Rnd scale to linear
		; 5 different levels of tiredness => SleepPenalty / 5.0 = 0.2 per step.
		; (1.0 / Step) to calculate sleep penalties inbetween step sizes.
		If Init.DebugMode
			Debug.Messagebox("SleepPenalty: " + SleepPenalty + ". StartingFatigue: "+ StartingFatigue + ". HoursSlept: " + HoursSlept)
		EndIf
		
		Float TargetFatigue
		If SleepPenalty <= 0.2
			TargetFatigue = SleepPenalty * (1.0 / 0.2) * 30.0
		ElseIf SleepPenalty <= 0.4
			TargetFatigue = SleepPenalty * (1.0 / 0.4) * 60.0
		ElseIf SleepPenalty <= 0.6
			TargetFatigue = SleepPenalty * (1.0 / 0.6) * 120.0
		ElseIf SleepPenalty <= 0.8
			TargetFatigue = SleepPenalty * (1.0 / 0.8) * 240.0
		Else
			TargetFatigue = SleepPenalty * (1.0 / 1.0) * 340.0 ; Pulled 340.0 out of my ass
		EndIf
		
		;Debug.Messagebox("SleepPenalty: " + SleepPenalty + ". TargetFatigue: " + TargetFatigue)
		Float CurrentFatigue = GetFatigue()
		If StartingFatigue > TargetFatigue ; Player was more tired when sleep began - cap rest gained
			If CurrentFatigue < TargetFatigue 
				Float Delta = (TargetFatigue) - CurrentFatigue
				;Debug.Messagebox("Delta: " + Delta)
				ModFatigue(Delta as Int)
			;Else	; Else player is still more tired than the cap - Do nothing
			EndIf

		Else ; Player was less tired when sleep began - slowly decrease rest to target
			
			Float Delta = (TargetFatigue + StartingFatigue) - CurrentFatigue
			Float ThisNapFatigue = (Delta / 8.0) * HoursSlept ; 8 hours of sleeping to reach target fatigue
			;Debug.MessageBox("ThisNapFatigue: " + ThisNapFatigue)
			ModFatigue(ThisNapFatigue as Int)
		EndIf
	EndFunction

	String Function GetConditionsStatement(Float SleepPenalty)
		String ConditionString = "Maximum rest in these conditions is: "	
		If SleepPenalty <= 0.2
			Return ConditionString + "Well rested. "
		ElseIf SleepPenalty <= 0.4
			Return ConditionString + "Slightly tired. "
		ElseIf SleepPenalty <= 0.6
			Return ConditionString + "Tired. "
		ElseIf SleepPenalty <= 0.8
			Return ConditionString + "Very tired. "
		Else
			Return ConditionString + "Exhausted. "
		EndIf
	EndFunction
	
	Float Function GetHungerSleepPenalty()
		If PlayerRef.HasMagicEffect(RND_HungerEffect00) ; Glutted
			Return JsonUtil.GetFloatValue("SL Survival/SleepDepriv.json", "hunger_rnd_glutted") ; 0.0
		ElseIf PlayerRef.HasMagicEffect(RND_HungerEffect01) ; Satiated
			Return JsonUtil.GetFloatValue("SL Survival/SleepDepriv.json", "hunger_rnd_satisfied") ; -0.05
		ElseIf PlayerRef.HasMagicEffect(RND_HungerEffect02) ; Slightly hungry
			Return JsonUtil.GetFloatValue("SL Survival/SleepDepriv.json", "hunger_rnd_slightlyhungry") ; 0.0
		ElseIf PlayerRef.HasMagicEffect(RND_HungerEffect03) ; Hungry
			Return JsonUtil.GetFloatValue("SL Survival/SleepDepriv.json", "hunger_rnd_hungry") ; 0.10
		ElseIf PlayerRef.HasMagicEffect(RND_HungerEffect04) ; Very hungry
			Return JsonUtil.GetFloatValue("SL Survival/SleepDepriv.json", "hunger_rnd_veryhungry") ; 0.15
		ElseIf PlayerRef.HasMagicEffect(RND_HungerEffect05) ; Starving
			Return JsonUtil.GetFloatValue("SL Survival/SleepDepriv.json", "hunger_rnd_starving") ; 0.3
		Else
			Return 0.0
		EndIf
	EndFunction

	Float Function GetThirstSleepPenalty()
		If PlayerRef.HasMagicEffect(RND_ThirstEffect00) ; Quenched
			Return JsonUtil.GetFloatValue("SL Survival/SleepDepriv.json", "thirst_rnd_quenched") ; -0.05
		ElseIf PlayerRef.HasMagicEffect(RND_ThirstEffect01) ; Slightly thirsty
			Return JsonUtil.GetFloatValue("SL Survival/SleepDepriv.json", "thirst_rnd_slightlythirsty") ; 0.00
		ElseIf PlayerRef.HasMagicEffect(RND_ThirstEffect02) ; Thirsty
			Return JsonUtil.GetFloatValue("SL Survival/SleepDepriv.json", "thirst_rnd_thirsty") ; 0.10
		ElseIf PlayerRef.HasMagicEffect(RND_ThirstEffect03) ; Very Thirsty
			Return JsonUtil.GetFloatValue("SL Survival/SleepDepriv.json", "thirst_rnd_verythirsty") ; 0.15
		ElseIf PlayerRef.HasMagicEffect(RND_ThirstEffect04) ; Dehydrated
			Return JsonUtil.GetFloatValue("SL Survival/SleepDepriv.json", "thirst_rnd_dehydrated") ; 0.30
		Else
			Return 0.0
		EndIf
	EndFunction
	
	String Function GetAioHunger()
		If PlayerRef.HasMagicEffect(RND_HungerEffect00) ; Glutted
			Return "Glutted "
		ElseIf PlayerRef.HasMagicEffect(RND_HungerEffect01) ; Satiated
			Return "Satiated "
		ElseIf PlayerRef.HasMagicEffect(RND_HungerEffect02) ; Slightly hungry
			Return "Slightly hungry "
		ElseIf PlayerRef.HasMagicEffect(RND_HungerEffect03) ; Hungry
			Return "Hungry "
		ElseIf PlayerRef.HasMagicEffect(RND_HungerEffect04) ; Very hungry
			Return "Very hungry "
		ElseIf PlayerRef.HasMagicEffect(RND_HungerEffect05) ; Starving
			Return "Starving "
		EndIf
		Return "" ; Mod disabled?
	EndFunction

	String Function GetAioThirst()
		If PlayerRef.HasMagicEffect(RND_ThirstEffect00) ; Quenched
			Return "Quenched"
		ElseIf PlayerRef.HasMagicEffect(RND_ThirstEffect01) ; Slightly thirsty
			Return "Slightly thirsty"
		ElseIf PlayerRef.HasMagicEffect(RND_ThirstEffect02) ; Thirsty
			Return "Thirsty"
		ElseIf PlayerRef.HasMagicEffect(RND_ThirstEffect03) ; Very Thirsty
			Return "Very Thirsty"
		ElseIf PlayerRef.HasMagicEffect(RND_ThirstEffect04) ; Dehydrated
			Return "Dehydrated"
		EndIf
		Return "" ; Mod disabled?
	EndFunction
	
	String Function GetAioFatigue()
		;/
	
		If PlayerRef.HasMagicEffect(RND_SleepEffect00) || PlayerRef.HasMagicEffect() ; Not Tired
			Return "Not Tired"
		ElseIf PlayerRef.HasMagicEffect(RND_SleepEffect01) ; Slightly Tired
			Return "Slightly Tired"
		ElseIf PlayerRef.HasMagicEffect(RND_SleepEffect02) ; Tired
			Return "Tired "
		ElseIf PlayerRef.HasMagicEffect(RND_SleepEffect03) ; Very Tired
			Return "Very Tired"
		ElseIf PlayerRef.HasMagicEffect(RND_SleepEffect04) ; Exhausted
			Return "Exhausted"	
		EndIf
		Return "" ; Mod disabled?
		/;
		
		If RND_SleepPoints.GetValue() < RND_SleepLevel01.GetValue() ; Not Tired
			Return "Not Tired"
		ElseIf RND_SleepPoints.GetValue() >= RND_SleepLevel01.GetValue() && RND_SleepPoints.GetValue() < RND_SleepLevel02.GetValue() ; Slightly Tired
			Return "Slightly Tired"
		ElseIf RND_SleepPoints.GetValue() >= RND_SleepLevel02.GetValue() && RND_SleepPoints.GetValue() < RND_SleepLevel03.GetValue() ; Tired
			Return "Tired "
		ElseIf RND_SleepPoints.GetValue() >= RND_SleepLevel03.GetValue() && RND_SleepPoints.GetValue() < RND_SleepLevel04.GetValue() ; Very Tired
			Return "Very Tired"
		ElseIf RND_SleepPoints.GetValue() >= RND_SleepLevel04.GetValue() ; Exhausted
			Return "Exhausted"	
		EndIf
	EndFunction
EndState

; Empty State ===============================================================================
Bool Function IsNeedsModActive()
	Return false
EndFunction

Function Eat(Int FoodPoints)
EndFunction

Function Drink(Int WaterPoints)
EndFunction

Float Function GetFatigue()
	Return 0.0
EndFunction

Function ModFatigue(Int SleepAmount, Bool Notify = false)
EndFunction

Function RemoveHungerSpells()
EndFunction

Function RemoveThirstSpells()
EndFunction

Function RemoveSleepSpells()
EndFunction

Bool Function IsDesperate()
	Return false
EndFunction

Bool Function GetBegIsHungry()
	Return false
EndFunction

Bool Function GetBegIsThirsty()
	Return false
EndFunction

Float Function GetBellyScale()
	Return 1.0
EndFunction

Function CorrectFatigue(Float SleepPenalty, Float StartingFatigue, Float HoursSlept)
EndFunction

String Function GetConditionsStatement(Float SleepPenalty)
	Return ""
EndFunction

Float Function GetHungerSleepPenalty()
	Return 0.0
EndFunction

Float Function GetThirstSleepPenalty()
	Return 0.0
EndFunction

String Function GetAioHunger()
	Return ""
EndFunction

String Function GetAioThirst()
	Return ""
EndFunction

String Function GetAioFatigue()
	Return ""
EndFunction

SLS_Mcm Property Menu Auto
SLS_Init Property Init Auto

Float Property BellyScaleRnd00 = 1.5 Auto Hidden
Float Property BellyScaleRnd01 = 0.4 Auto Hidden
Float Property BellyScaleRnd02 = 0.3 Auto Hidden
Float Property BellyScaleRnd03 = 0.2 Auto Hidden
Float Property BellyScaleRnd04 = 0.1 Auto Hidden
Float Property BellyScaleRnd05 = 0.0 Auto Hidden

; Vanilla Properties
Idle Property ChairEatingStart Auto
Idle Property idleEatingStandingStart Auto
Idle Property idleStop_Loose Auto

Idle Property idleDrink Auto
Idle Property ChairDrinkingStart Auto
Idle Property idleBarDrinkingStart Auto

Actor Property PlayerRef Auto

Spell Property DoomLoverAbility Auto

ReferenceAlias Property LoveInterest Auto

Quest Property RelationshipMarriageFIN Auto

Keyword Property LocTypeInn Auto
Keyword Property LocTypePlayerHouse Auto

; CLEAN UP ===========================================================
ReferenceAlias RndPlayerAlias



; Rnd Properties
MagicEffect Property RND_HungerEffect00 Auto Hidden
MagicEffect Property RND_HungerEffect01 Auto Hidden
MagicEffect Property RND_HungerEffect02 Auto Hidden
MagicEffect Property RND_HungerEffect03 Auto Hidden
MagicEffect Property RND_HungerEffect04 Auto Hidden
MagicEffect Property RND_HungerEffect05 Auto Hidden

MagicEffect Property RND_ThirstEffect00 Auto Hidden
MagicEffect Property RND_ThirstEffect01 Auto Hidden
MagicEffect Property RND_ThirstEffect02 Auto Hidden
MagicEffect Property RND_ThirstEffect03 Auto Hidden
MagicEffect Property RND_ThirstEffect04 Auto Hidden

MagicEffect Property RND_SleepEffect00 Auto Hidden
MagicEffect Property RND_SleepEffect01 Auto Hidden
MagicEffect Property RND_SleepEffect02 Auto Hidden
MagicEffect Property RND_SleepEffect03 Auto Hidden
MagicEffect Property RND_SleepEffect04 Auto Hidden

; Food Properties
GlobalVariable Property RND_HungerPoints Auto Hidden
GlobalVariable Property RND_HungerPointsPerHour Auto Hidden
GlobalVariable Property RND_HungerLastUpdateTimeStamp Auto Hidden

GlobalVariable Property RND_AnimEat Auto Hidden
GlobalVariable Property RND_1stPersonMsg Auto Hidden

GlobalVariable Property RND_FoodPoints  Auto  Hidden ; ***********
GlobalVariable Property RND_ForceSatiation Auto Hidden

GlobalVariable Property RND_HungerLevel00 Auto Hidden
GlobalVariable Property RND_HungerLevel01 Auto Hidden
GlobalVariable Property RND_HungerLevel02 Auto Hidden
GlobalVariable Property RND_HungerLevel03 Auto Hidden
GlobalVariable Property RND_HungerLevel04 Auto Hidden
GlobalVariable Property RND_HungerLevel05 Auto Hidden

Spell Property RND_HungerSpell00 Auto Hidden
Spell Property RND_HungerSpell01 Auto Hidden
Spell Property RND_HungerSpell02 Auto Hidden
Spell Property RND_HungerSpell03 Auto Hidden
Spell Property RND_HungerSpell04 Auto Hidden
Spell Property RND_HungerSpell05 Auto Hidden

Message Property RND_HungerLevel00ConsumeMessage Auto Hidden
Message Property RND_HungerLevel01ConsumeMessage Auto Hidden
Message Property RND_HungerLevel02ConsumeMessage Auto Hidden
Message Property RND_HungerLevel03ConsumeMessage Auto Hidden
Message Property RND_HungerLevel04ConsumeMessage Auto Hidden
Message Property RND_HungerLevel05ConsumeMessage Auto Hidden

Message Property RND_HungerLevel00ConsumeMessageB Auto Hidden
Message Property RND_HungerLevel01ConsumeMessageB Auto Hidden
Message Property RND_HungerLevel02ConsumeMessageB Auto Hidden
Message Property RND_HungerLevel03ConsumeMessageB Auto Hidden
Message Property RND_HungerLevel04ConsumeMessageB Auto Hidden
Message Property RND_HungerLevel05ConsumeMessageB Auto Hidden

; Drink Properties
GlobalVariable Property RND_ThirstPoints Auto Hidden
GlobalVariable Property RND_ThirstPointsPerHour Auto Hidden
GlobalVariable Property RND_ThirstLastUpdateTimeStamp Auto Hidden
GlobalVariable Property RND_AnimDrink Auto Hidden

GlobalVariable Property RND_ThirstLevel00 Auto Hidden
GlobalVariable Property RND_ThirstLevel01 Auto Hidden
GlobalVariable Property RND_ThirstLevel02 Auto Hidden
GlobalVariable Property RND_ThirstLevel03 Auto Hidden
GlobalVariable Property RND_ThirstLevel04 Auto Hidden

Spell Property RND_ThirstSpell00 Auto Hidden
Spell Property RND_ThirstSpell01 Auto Hidden
Spell Property RND_ThirstSpell02 Auto Hidden
Spell Property RND_ThirstSpell03 Auto Hidden
Spell Property RND_ThirstSpell04 Auto Hidden

Message Property RND_ThirstLevel00ConsumeMessage Auto Hidden
Message Property RND_ThirstLevel01ConsumeMessage Auto Hidden
Message Property RND_ThirstLevel02ConsumeMessage Auto Hidden
Message Property RND_ThirstLevel03ConsumeMessage Auto Hidden
Message Property RND_ThirstLevel04ConsumeMessage Auto Hidden

Message Property RND_ThirstLevel00ConsumeMessageB Auto Hidden
Message Property RND_ThirstLevel01ConsumeMessageB Auto Hidden
Message Property RND_ThirstLevel02ConsumeMessageB Auto Hidden
Message Property RND_ThirstLevel03ConsumeMessageB Auto Hidden
Message Property RND_ThirstLevel04ConsumeMessageB Auto Hidden

; Sleep Properties
Spell Property RND_Rested Auto Hidden
Spell Property RND_WellRested Auto Hidden
Spell Property RND_RestlessBeast Auto Hidden
Spell Property RND_MarriageRested Auto Hidden

Spell Property RND_SleepSpell00 Auto Hidden
Spell Property RND_SleepSpell01 Auto Hidden
Spell Property RND_SleepSpell02 Auto Hidden
Spell Property RND_SleepSpell03 Auto Hidden
Spell Property RND_SleepSpell04 Auto Hidden

Spell Property RND_SleepDisease Auto Hidden

GlobalVariable Property RND_SleepLevel00 Auto Hidden
GlobalVariable Property RND_SleepLevel01 Auto Hidden
GlobalVariable Property RND_SleepLevel02 Auto Hidden
GlobalVariable Property RND_SleepLevel03 Auto Hidden
GlobalVariable Property RND_SleepLevel04 Auto Hidden

GlobalVariable Property RND_SleepPoints Auto Hidden
GlobalVariable Property RND_SleepPointsPerHour Auto Hidden
GlobalVariable Property RND_SleepLastUpdateTimeStamp Auto Hidden

Message Property RND_RestedMessage  Auto Hidden
Message Property RND_WellRestedMessage  Auto Hidden
Message Property RND_MarriageRestedMessage  Auto Hidden
Message Property RND_BeastBloodMessage  Auto Hidden
