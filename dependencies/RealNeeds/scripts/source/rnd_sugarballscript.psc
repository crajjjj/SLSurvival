Scriptname RND_SugarBallScript extends activemagiceffect  
{this script brings up the main menu}

Potion Property RND_SugarBall Auto
GlobalVariable Property RND_State Auto
GlobalVariable Property RND_DebugMode Auto
Quest Property RNDTrackingQuest Auto
Quest Property RNDReminderQuest Auto
Quest Property RNDSpoilageQuest Auto

Message Property RND_MainMenu Auto
Message Property RND_MenuConfiguration Auto

Message Property RND_MenuDebug Auto
Message Property RND_MenuDisease Auto
Message Property RND_MenuCamping Auto

Message Property RND_MenuBasicNeeds Auto
Message Property RND_MenuHungerConfig Auto
Message Property RND_MenuThirstConfig Auto
Message Property RND_MenuSleepConfig Auto
Message Property RND_MenuFastTravelSlowRateConfig Auto
Message Property RND_MenuReminder0 Auto
Message Property RND_MenuReminder1 Auto

Message Property RND_MenuDiseaseChance Auto
Message Property RND_MenuDisRawFoodConfig Auto
Message Property RND_MenuDisStaleFoodConfig Auto
Message Property RND_MenuDisDirtyBedrollConfig Auto

Message Property RND_MenuAlcohol Auto
Message Property RND_MenuAlcWeakConfig Auto
Message Property RND_MenuAlcNormalConfig Auto
Message Property RND_MenuAlcStrongConfig Auto

Message Property RND_MenuAnimationToggle Auto
Message Property RND_QuitMessage Auto

GlobalVariable Property RND_AnimEat Auto
GlobalVariable Property RND_AnimDrink Auto
GlobalVariable Property RND_AnimInebriation Auto
GlobalVariable Property RND_AnimRefill Auto
GlobalVariable Property RND_AnimMisc Auto
GlobalVariable Property RND_IsmInebriation Auto

GlobalVariable Property RND_HungerPoints Auto
GlobalVariable Property RND_HungerPointsPerHour Auto
GlobalVariable Property RND_ThirstPoints Auto
GlobalVariable Property RND_ThirstPointsPerHour Auto
GlobalVariable Property RND_InebriationPoints Auto
GlobalVariable Property RND_InebriationPointsPerHour Auto
GlobalVariable Property RND_SleepPoints Auto
GlobalVariable Property RND_SleepPointsPerHour Auto

GlobalVariable Property RND_ForceSatiation Auto
GlobalVariable Property RND_DieOfThirst Auto

GlobalVariable Property RND_FastTravelSlowRate Auto
GlobalVariable Property RND_ReminderInterval Auto
GlobalVariable Property RND_ReminderSound Auto
GlobalVariable Property RND_ReminderMessage Auto

GlobalVariable Property RND_AlcoholPointsWeak Auto
GlobalVariable Property RND_AlcoholPointsNormal Auto
GlobalVariable Property RND_AlcoholPointsStrong Auto

GlobalVariable Property RND_DiseaseChanceRawFood Auto
GlobalVariable Property RND_DiseaseChanceStaleFood Auto
GlobalVariable Property RND_DiseaseChanceDirtyBedroll Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	MainMenu()
EndEvent

; Main Menu
Function MainMenu()

	Int iClick = RND_MainMenu.Show()
	If iClick == 0
		RND_Start()
		Configuration()
	ElseIf iClick == 1
		RND_Stop()
	ElseIf iClick == 2
		Configuration()
	ElseIf iClick == 3
		DebugMenu()
	Else
		Game.GetPlayer().AddItem(RND_SugarBall,1)
		Return
	EndIf

EndFunction

Function Configuration()

	Int iClick = RND_MenuConfiguration.Show(RND_HungerPointsPerHour.GetValue(),\
					RND_ThirstPointsPerHour.GetValue(), RND_SleepPointsPerHour.GetValue(),\
					RND_DiseaseChanceRawFood.GetValue(), RND_DiseaseChanceStaleFood.GetValue(),\
					RND_DiseaseChanceDirtyBedroll.GetValue())
	If iClick ==0
		AlcoholConfig()
	ElseIf iClick == 1
		NeedsConfig()
	ElseIf iClick == 2
		DiseaseChanceConfig()
	ElseIf iClick == 3
		AnimationToggle()
	Else
		MainMenu()
	EndIf

EndFunction

; basic needs ----------------------------------
Function NeedsConfig()

	Int iClick = RND_MenuBasicNeeds.Show(RND_HungerPointsPerHour.GetValue(),\
					RND_ThirstPointsPerHour.GetValue(), RND_SleepPointsPerHour.GetValue(), RND_FastTravelSlowRate.GetValue())
	If iClick == 0
		HungerConfig()
	ElseIf iClick == 1
		ThirstConfig()
	ElseIf iClick == 2
		SleepConfig()
	ElseIf iClick == 3
		SlowRateConfig()
	ElseIf iClick == 4
		If RNDReminderQuest.IsRunning()
			ReminderConfig()
		Else
			ReminderEnable()
		EndIf	
	Else
		Configuration()
	EndIf

EndFunction

Function HungerConfig()
	Bool loop = True
	While loop == True
		Int iClick = RND_MenuHungerConfig.Show(RND_HungerPointsPerHour.GetValue())
		If iClick == 0
			RND_HungerPointsPerHour.SetValue(RND_HungerPointsPerHour.GetValue() - 1)
			If RND_HungerPointsPerHour.GetValue() <= 1
				RND_HungerPointsPerHour.SetValue(1)
			EndIf
		ElseIf iClick == 2
			RND_HungerPointsPerHour.SetValue(RND_HungerPointsPerHour.GetValue() + 1)
		ElseIf iClick == 3
			RND_ForceSatiation.SetValue(0)
		ElseIf iClick == 4
			RND_ForceSatiation.SetValue(1)
		Else
			loop = False
			NeedsConfig()
		EndIf
	EndWhile
EndFunction

Function ThirstConfig()
	Bool loop = True
	While loop == True
		Int iClick = RND_MenuThirstConfig.Show(RND_ThirstPointsPerHour.GetValue())
		If iClick == 0
			RND_ThirstPointsPerHour.SetValue(RND_ThirstPointsPerHour.GetValue() - 1)
			If RND_ThirstPointsPerHour.GetValue() <= 1
				RND_ThirstPointsPerHour.SetValue(1)
			EndIf
		ElseIf iClick == 2
			RND_ThirstPointsPerHour.SetValue(RND_ThirstPointsPerHour.GetValue() + 1)
		ElseIf iClick == 3
			RND_DieOfThirst.SetValue(0)
		ElseIf iClick == 4
			RND_DieOfThirst.SetValue(1)
		Else
			loop = False
			NeedsConfig()
		EndIf
	EndWhile
EndFunction

Function SleepConfig()
	Bool loop = True
	While loop == True
		Int iClick = RND_MenuSleepConfig.Show(RND_SleepPointsPerHour.GetValue())
		If iClick == 0
			RND_SleepPointsPerHour.SetValue(RND_SleepPointsPerHour.GetValue() - 1)
			If RND_SleepPointsPerHour.GetValue() <= 1
				RND_SleepPointsPerHour.SetValue(1)
			EndIf
		ElseIf iClick == 2
			RND_SleepPointsPerHour.SetValue(RND_SleepPointsPerHour.GetValue() + 1)
		Else
			loop = False
			NeedsConfig()
		EndIf
	EndWhile
EndFunction

Function SlowRateConfig()
	Bool loop = True
	While loop == True
		Int iClick = RND_MenuFastTravelSlowRateConfig.Show(RND_FastTravelSlowRate.GetValue())
		If iClick == 0
			RND_FastTravelSlowRate.SetValue(RND_FastTravelSlowRate.GetValue() - 10)
		ElseIf iClick == 1
			RND_FastTravelSlowRate.SetValue(RND_FastTravelSlowRate.GetValue() - 1)
		ElseIf iClick == 3
			RND_FastTravelSlowRate.SetValue(RND_FastTravelSlowRate.GetValue() + 1)
		ElseIf iClick == 4
			RND_FastTravelSlowRate.SetValue(RND_FastTravelSlowRate.GetValue() + 10)
		Else
			loop = False
			If RND_FastTravelSlowRate.GetValue() < 0 
				RND_FastTravelSlowRate.SetValue(0)
			ElseIf RND_FastTravelSlowRate.GetValue() > 100 
				RND_FastTravelSlowRate.SetValue(100)
			EndIf
			NeedsConfig()
		EndIf
	EndWhile
EndFunction

Function ReminderEnable()
	Int iClick = RND_MenuReminder0.Show()
	If iClick == 0
		RNDReminderQuest.Start()
		ReminderConfig()
	Else
		NeedsConfig()
	EndIf
EndFunction

Function ReminderConfig()
	Bool loop = True
	While loop == True
		Int iClick = RND_MenuReminder1.Show(RND_ReminderInterval.GetValue())
		If iClick == 0
			RND_ReminderSound.SetValue(0)
		ElseIf iClick == 1
			RND_ReminderSound.SetValue(1)
		ElseIf iClick == 2
			RND_ReminderMessage.SetValue(0)
		ElseIf iClick == 3
			RND_ReminderMessage.SetValue(1)
		ElseIf iClick == 4
			RND_ReminderInterval.SetValue(RND_ReminderInterval.GetValue() - 3)
			If RND_ReminderInterval.GetValue() < 3
				RND_ReminderInterval.SetValue(3)
			ElseIf RND_ReminderInterval.GetValue() > 60
				RND_ReminderInterval.SetValue(60)
			EndIf
		ElseIf iClick == 6
			RND_ReminderInterval.SetValue(RND_ReminderInterval.GetValue() + 3)
			If RND_ReminderInterval.GetValue() < 3
				RND_ReminderInterval.SetValue(3)
			ElseIf RND_ReminderInterval.GetValue() > 60
				RND_ReminderInterval.SetValue(60)
			EndIf
		ElseIf iClick == 7
			loop = False
			RNDReminderQuest.Stop()
			NeedsConfig()
		ElseIf iClick == 8
			loop = False
			NeedsConfig()
		EndIf
	EndWhile
EndFunction


; disease chance -----------------------------------
Function DiseaseChanceConfig()

	Int iClick = RND_MenuDiseaseChance.Show(RND_DiseaseChanceRawFood.GetValue(),\
					RND_DiseaseChanceStaleFood.GetValue(), RND_DiseaseChanceDirtyBedroll.GetValue())
	If iClick == 0
		DisRawFoodConfig()
	ElseIf iClick == 1
		DisStaleFoodConfig()
	ElseIf iClick == 2
		DisDirtyBedrollConfig()
	Else
		Configuration()
	EndIf

EndFunction

Function DisRawFoodConfig()
	Bool loop = True
	While loop == True
		Int iClick = RND_MenuDisRawFoodConfig.Show(RND_DiseaseChanceRawFood.GetValue())
		If iClick == 0
			RND_DiseaseChanceRawFood.SetValue(RND_DiseaseChanceRawFood.GetValue() - 10)
		ElseIf iClick == 1
			RND_DiseaseChanceRawFood.SetValue(RND_DiseaseChanceRawFood.GetValue() - 1)
		ElseIf iClick == 3
			RND_DiseaseChanceRawFood.SetValue(RND_DiseaseChanceRawFood.GetValue() + 1)
		ElseIf iClick == 4
			RND_DiseaseChanceRawFood.SetValue(RND_DiseaseChanceRawFood.GetValue() + 10)
		Else
			loop = False
			If RND_DiseaseChanceRawFood.GetValue() < 0 
				RND_DiseaseChanceRawFood.SetValue(0)
			ElseIf RND_DiseaseChanceRawFood.GetValue() > 100 
				RND_DiseaseChanceRawFood.SetValue(100)
			EndIf
			DiseaseChanceConfig()
		EndIf
	EndWhile
EndFunction

Function DisStaleFoodConfig()
	Bool loop = True
	While loop == True
		Int iClick = RND_MenuDisStaleFoodConfig.Show(RND_DiseaseChanceStaleFood.GetValue())
		If iClick == 0
			RND_DiseaseChanceStaleFood.SetValue(RND_DiseaseChanceStaleFood.GetValue() - 10)
		ElseIf iClick == 1
			RND_DiseaseChanceStaleFood.SetValue(RND_DiseaseChanceStaleFood.GetValue() - 1)
		ElseIf iClick == 3
			RND_DiseaseChanceStaleFood.SetValue(RND_DiseaseChanceStaleFood.GetValue() + 1)
		ElseIf iClick == 4
			RND_DiseaseChanceStaleFood.SetValue(RND_DiseaseChanceStaleFood.GetValue() + 10)
		Else
			loop = False
			If RND_DiseaseChanceStaleFood.GetValue() < 0 
				RND_DiseaseChanceStaleFood.SetValue(0)
			ElseIf RND_DiseaseChanceStaleFood.GetValue() > 100 
				RND_DiseaseChanceStaleFood.SetValue(100)
			EndIf
			DiseaseChanceConfig()
		EndIf
	EndWhile
EndFunction

Function DisDirtyBedrollConfig()
	Bool loop = True
	While loop == True
		Int iClick = RND_MenuDisDirtyBedrollConfig.Show(RND_DiseaseChanceDirtyBedroll.GetValue())
		If iClick == 0
			RND_DiseaseChanceDirtyBedroll.SetValue(RND_DiseaseChanceDirtyBedroll.GetValue() - 10)
		ElseIf iClick == 1
			RND_DiseaseChanceDirtyBedroll.SetValue(RND_DiseaseChanceDirtyBedroll.GetValue() - 1)
		ElseIf iClick == 3
			RND_DiseaseChanceDirtyBedroll.SetValue(RND_DiseaseChanceDirtyBedroll.GetValue() + 1)
		ElseIf iClick == 4
			RND_DiseaseChanceDirtyBedroll.SetValue(RND_DiseaseChanceDirtyBedroll.GetValue() + 10)
		Else
			loop = False
			If RND_DiseaseChanceDirtyBedroll.GetValue() < 0 
				RND_DiseaseChanceDirtyBedroll.SetValue(0)
			ElseIf RND_DiseaseChanceDirtyBedroll.GetValue() > 100 
				RND_DiseaseChanceDirtyBedroll.SetValue(100)
			EndIf
			DiseaseChanceConfig()
		EndIf
	EndWhile
EndFunction

; alcohol level-----------------------------------

Function AlcoholConfig()

	Int iClick = RND_MenuAlcohol.Show(RND_AlcoholPointsWeak.GetValue(),\
					RND_AlcoholPointsNormal.GetValue(), RND_AlcoholPointsStrong.GetValue())
	If iClick == 0
		AlcWeakConfig()
	ElseIf iClick == 1
		AlcNormalConfig()
	ElseIf iClick == 2
		AlcStrongConfig()
	Else
		Configuration()
	EndIf

EndFunction

Function AlcWeakConfig()
	Bool loop = True
	While loop == True
		Int iClick = RND_MenuAlcWeakConfig.Show(RND_AlcoholPointsWeak.GetValue())
		If iClick == 0
			RND_AlcoholPointsWeak.SetValue(RND_AlcoholPointsWeak.GetValue() - 10)
		ElseIf iClick == 1
			RND_AlcoholPointsWeak.SetValue(RND_AlcoholPointsWeak.GetValue() - 1)
		ElseIf iClick == 3
			RND_AlcoholPointsWeak.SetValue(RND_AlcoholPointsWeak.GetValue() + 1)
		ElseIf iClick == 4
			RND_AlcoholPointsWeak.SetValue(RND_AlcoholPointsWeak.GetValue() + 10)
		Else
			loop = False
			If RND_AlcoholPointsWeak.GetValue() < 1 
				RND_AlcoholPointsWeak.SetValue(1)
			ElseIf RND_AlcoholPointsWeak.GetValue() > 99 
				RND_AlcoholPointsWeak.SetValue(99)
			EndIf
			AlcoholConfig()
		EndIf
	EndWhile
EndFunction

Function AlcNormalConfig()
	Bool loop = True
	While loop == True
		Int iClick = RND_MenuAlcNormalConfig.Show(RND_AlcoholPointsNormal.GetValue())
		If iClick == 0
			RND_AlcoholPointsNormal.SetValue(RND_AlcoholPointsNormal.GetValue() - 10)
		ElseIf iClick == 1
			RND_AlcoholPointsNormal.SetValue(RND_AlcoholPointsNormal.GetValue() - 1)
		ElseIf iClick == 3
			RND_AlcoholPointsNormal.SetValue(RND_AlcoholPointsNormal.GetValue() + 1)
		ElseIf iClick == 4
			RND_AlcoholPointsNormal.SetValue(RND_AlcoholPointsNormal.GetValue() + 10)
		Else
			loop = False
			If RND_AlcoholPointsNormal.GetValue() < 1 
				RND_AlcoholPointsNormal.SetValue(1)
			ElseIf RND_AlcoholPointsNormal.GetValue() > 99 
				RND_AlcoholPointsNormal.SetValue(99)
			EndIf
			AlcoholConfig()
		EndIf
	EndWhile
EndFunction

Function AlcStrongConfig()
	Bool loop = True
	While loop == True
		Int iClick = RND_MenuAlcStrongConfig.Show(RND_AlcoholPointsStrong.GetValue())
		If iClick == 0
			RND_AlcoholPointsStrong.SetValue(RND_AlcoholPointsStrong.GetValue() - 10)
		ElseIf iClick == 1
			RND_AlcoholPointsStrong.SetValue(RND_AlcoholPointsStrong.GetValue() - 1)
		ElseIf iClick == 3
			RND_AlcoholPointsStrong.SetValue(RND_AlcoholPointsStrong.GetValue() + 1)
		ElseIf iClick == 4
			RND_AlcoholPointsStrong.SetValue(RND_AlcoholPointsStrong.GetValue() + 10)
		Else
			loop = False
			If RND_AlcoholPointsStrong.GetValue() < 1 
				RND_AlcoholPointsStrong.SetValue(1)
			ElseIf RND_AlcoholPointsStrong.GetValue() > 99 
				RND_AlcoholPointsStrong.SetValue(99)
			EndIf
			AlcoholConfig()
		EndIf
	EndWhile
EndFunction


Function AnimationToggle()
	Bool loop = True
	While loop == True
		Int iClick = RND_MenuAnimationToggle.Show(RND_AnimEat.GetValue(),\
						RND_AnimDrink.GetValue(), RND_AnimRefill.GetValue(),\
						RND_AnimInebriation.GetValue(), RND_AnimMisc.GetValue(), RND_IsmInebriation.GetValue())
		
		If iClick == 0
			toggle(RND_AnimEat)
			
		ElseIf iClick == 1
			toggle(RND_AnimDrink)

		ElseIf iClick == 2
			toggle(RND_AnimRefill)

		ElseIf iClick == 3
			toggle(RND_AnimInebriation)

		ElseIf iClick == 4
			toggle(RND_AnimMisc)
			
		ElseIf iClick == 5
			toggle(RND_IsmInebriation)
			
		Else
			loop = False
			Configuration()
		EndIf
	EndWhile
EndFunction

; Debug menu----------------------------

Function DebugMenu()
	Bool loop = True
	While loop == True
		loop = False
		Int iClick = RND_MenuDebug.Show()
		If iClick == 0
			RND_DebugMode.SetValue(0)
			loop = True
		ElseIf iClick == 1
			RND_DebugMode.SetValue(1)
			loop = True
		ElseIf iClick == 2
			DiseaseMenu()
		ElseIf iClick == 3
			CampingMenu()
		Else
			MainMenu()
		EndIf
	EndWhile
EndFunction


Spell Property TrapDiseaseAtaxia Auto
Spell Property TrapDiseaseBoneBreakFever Auto
Spell Property TrapDiseaseBrainRot Auto
Spell Property TrapDiseaseRattles Auto
Spell Property TrapDiseaseRockjoint Auto
Spell Property TrapDiseaseWitbane Auto

Function DiseaseMenu()
; fast track disease testing menu
	Int iClick = RND_MenuDisease.Show()
	If iClick == 0
		Game.GetPlayer().DoCombatSpellApply(TrapDiseaseAtaxia, Game.GetPlayer())
		MainMenu()
	ElseIf iClick == 1
		Game.GetPlayer().DoCombatSpellApply(TrapDiseaseBoneBreakFever, Game.GetPlayer())
		MainMenu()
	ElseIf iClick == 2		
		Game.GetPlayer().DoCombatSpellApply(TrapDiseaseBrainRot, Game.GetPlayer())
		MainMenu()
	ElseIf iClick == 3
		Game.GetPlayer().DoCombatSpellApply(TrapDiseaseRattles, Game.GetPlayer())
		MainMenu()
	ElseIf iClick == 4
		Game.GetPlayer().DoCombatSpellApply(TrapDiseaseRockjoint, Game.GetPlayer())
		MainMenu()
	ElseIf iClick == 5
		Game.GetPlayer().DoCombatSpellApply(TrapDiseaseWitbane, Game.GetPlayer())
		MainMenu()
	Else
		MainMenu()
	EndIf

EndFunction

MiscObject Property Firewood01  Auto 
MiscObject Property CastIronPotMedium01 Auto
MiscObject Property RND_Tinderbox Auto
MiscObject Property RND_PortableBedroll Auto
MiscObject Property RND_PortableTent Auto

Function CampingMenu()

	Int iClick = RND_MenuCamping.Show()
	If iClick == 0
		Game.GetPlayer().addItem(RND_Tinderbox,1)
		Game.GetPlayer().addItem(RND_PortableBedroll,2)
		Game.GetPlayer().addItem(RND_PortableTent,1)
		Game.GetPlayer().addItem(CastIronPotMedium01,1)
		Game.GetPlayer().addItem(Firewood01,9)
		MainMenu()
	Else
		MainMenu()
	EndIf

EndFunction


Spell Property RND_InitNeedsSpell Auto

Function RND_Start()

	RND_State.SetValue(1)
	RNDTrackingQuest.Start()
	RNDReminderQuest.Start()
	RNDSpoilageQuest.Start()
	RND_InitNeedsSpell.Cast(Game.GetPlayer(), Game.GetPlayer())
Endfunction

Spell Property RND_CureDiseaseSpell Auto
Spell Property RND_RemoveNeedsSpell Auto

Function RND_Stop()
	; clean up the mess
	RND_State.SetValue(0)
	RNDSpoilageQuest.Stop()
	RNDReminderQuest.Stop()
	RNDTrackingQuest.Stop()
	RND_RemoveNeedsSpell.Cast(Game.GetPlayer(), Game.GetPlayer())
	Int iClick = RND_QuitMessage.Show()
	If iClick == 0
		RND_CureDiseaseSpell.Cast(Game.GetPlayer(), Game.GetPlayer())
		Game.GetPlayer().AddItem(RND_SugarBall,1)
	Else
		MainMenu()
	EndIf
EndFunction

Function toggle(GlobalVariable gVar)
	if gVar.getValueInt() == 0
		gVar.setValueInt(1)
	else
		gVar.setValueInt(0)
	endif
EndFunction



