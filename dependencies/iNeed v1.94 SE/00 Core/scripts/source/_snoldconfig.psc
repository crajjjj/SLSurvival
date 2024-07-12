Scriptname _snoldconfig extends activemagiceffect  

Sound Property _SNRoastLP Auto

Message Property _SNConfigNeedsVolHungerMsg Auto
Message Property _SNConfigNeedsVolThirstMsg Auto
Message Property _SNConfigNeedsVolFatigueMsg Auto
Message Property _SNConfigNeedsRateHungerMsg Auto
Message Property _SNConfigNeedsRateThirstMsg Auto
Message Property _SNConfigNeedsRateFatigueMsg Auto
Message Property _SNConfigNeedsAutoMsg Auto
Message Property _SNConfigNeedsHorseMsg Auto
Message Property _SNConfigNeedsGenericMsg Auto
Message Property _SNConfigNeedsPerspectiveMsg Auto
Message Property _SNConfigNeedsMsg Auto
Message Property _SNConfigDiffAlcoholMsg Auto
Message Property _SNConfigDiffDeathMsg Auto
Message Property _SNConfigDiffFoodRemovalMsg Auto
Message Property _SNConfigDiffReducedCarryMsg Auto
Message Property _SNConfigDiffAdrenalineMsg Auto
Message Property _SNConfigDiffUnknownAllMsg Auto
Message Property _SNConfigDiffMsg Auto
Message Property _SNConfigMiscMsg Auto
Message Property _SNConfigMiscVampireMsg Auto
Message Property _SNConfigMiscVisWaterskinMsg Auto
Message Property _SNConfigNeedsMealsFollowersMsg Auto
Message Property _SNConfigMiscAnimationsMsg Auto
Message Property _SNConfigMiscRestorationMsg Auto
Message Property _SNConfigMiscCannibalMsg Auto
Message Property _SNConfigMsg Auto
Message Property _SNConfigTimescaleMsg Auto
Message Property _SNConfigRecategorizeMsg Auto
Message Property _SNConfigRestartMsg Auto
Message Property _SNConfigGuideMsg Auto
Message Property _SNHotkeyMsg Auto
Message Property _SNHotkeyRoast1Msg Auto
Message Property _SNHotkeyRoast2Msg Auto
Message Property _SNHotkeyDrinkUnknownMsg Auto

Potion Property BYOHFoodMudcrabLegs Auto
Potion Property BYOHFoodMudcrabLegsCooked Auto
Potion Property DLC2FoodBoarMeat Auto
Potion Property DLC2FoodBoarMeatCooked Auto
Potion Property FoodBeef Auto
Potion Property FoodBeefCooked Auto
Potion Property FoodChicken Auto
Potion Property FoodChickenCooked Auto
Potion Property FoodGoatMeat Auto
Potion Property FoodGoatMeatCooked Auto
Potion Property FoodHorkerMeat Auto
Potion Property FoodHorkerMeatCooked Auto
Potion Property FoodHorseMeat Auto
Potion Property FoodHorseMeatCooked Auto
Potion Property FoodLeek Auto
Potion Property FoodLeeksGrilled Auto
Potion Property FoodMammothMeat Auto
Potion Property FoodMammothMeatCooked Auto
Potion Property FoodPheasant Auto
Potion Property FoodPheasantCooked Auto
Potion Property FoodPotato Auto
Potion Property FoodPotatoesBaked Auto
Potion Property FoodRabbit Auto
Potion Property FoodRabbitCooked Auto
Potion Property FoodSalmon Auto
Potion Property FoodSalmonCooked01 Auto
Potion Property FoodVenison Auto
Potion Property FoodVenisonCooked Auto

Bool Restart

Actor targ

_SNQuestScript Property _SNQuest Auto

;====================================================================================

Function Menu(Int iButton = -1)
	iButton = _SNConfigMsg.Show()
	If iButton == 0						;Needs
		NeedsMenu()
	ElseIf iButton == 1					;Difficulty
		DiffMenu()
	ElseIf iButton == 2					;Misc
		MiscMenu()
	ElseIf iButton == 3					;Recategorize
		RecategorizeMenu()
	ElseIf iButton == 4					;Timescale
		TimescaleMenu()
	ElseIf iButton == 5					;Restart
		RestartMenu()
	ElseIf iButton == 6					;Guide
		GuideMenu()
	ElseIf iButton == 7					;Exit
		If Restart
			_SNQuest.Restart()
		EndIf
	EndIf
EndFunction

Function NeedsMenu(Int iButton = -1)
	iButton = _SNConfigNeedsMsg.Show()
	If iButton == 0						;Rates
		NeedsRatesMenu()
	ElseIf iButton == 1					;Vol
		NeedsVolMenu()
	ElseIf iButton == 2					;Auto
		NeedsAutoMenu()
	ElseIf iButton == 3					;Perspective
		NeedsPerspectiveMenu()
	ElseIf iButton == 4					;Followers
		NeedsFollowersMenu()
	ElseIf iButton == 5					;Horse
		NeedsHorseMenu()
	ElseIf iButton == 6					;Back
		Menu()
	EndIf
EndFunction

Function DiffMenu(Int iButton = -1)
	iButton = _SNConfigDiffMsg.Show()
	If iButton == 0						;Food removal
		DiffFoodRemovalMenu()
	ElseIf iButton == 1					;Alcohol dehydrates
		DiffAlcoholMenu()
	ElseIf iButton == 2					;Death
		DiffDeathMenu()
	ElseIf iButton == 3					;Reduced Carry
		DiffReducedCarryMenu()
	ElseIf iButton == 4					;Adrenaline
		DiffAdrenalineMenu()
	ElseIf iButton == 5					;Unknown All
		DiffUnknownAllMenu()
	ElseIf iButton == 6					;Back
		Menu()
	EndIf
EndFunction

Function MiscMenu(Int iButton = -1)
	iButton = _SNConfigMiscMsg.Show()
	If iButton == 0
		MiscAnimationsMenu()
	ElseIf iButton == 1
		MiscVisWaterskinMenu()
	ElseIf iButton == 2
		MiscRestorationMenu()
	ElseIf iButton == 3
		MiscVampireMenu()
	ElseIf iButton == 4
		MiscCannibalMenu()
	ElseIf iButton == 5
		Menu()
	EndIf
EndFunction

Function TimescaleMenu(Int iButton = -1)
	iButton = _SNConfigTimescaleMsg.Show()
	If iButton == 0						;8
		_SNQuest.Timescale.SetValue(8)
	ElseIf iButton == 1					;10
		_SNQuest.Timescale.SetValue(10)
	ElseIf iButton == 2					;12
		_SNQuest.Timescale.SetValue(12)			
	ElseIf iButton == 3					;14
		_SNQuest.Timescale.SetValue(14)			
	ElseIf iButton == 4					;16
		_SNQuest.Timescale.SetValue(16)			
	ElseIf iButton == 5					;18
		_SNQuest.Timescale.SetValue(18)			
	ElseIf iButton == 6					;20
		_SNQuest.Timescale.SetValue(20)			
	ElseIf iButton == 7					;Back
		Menu()
	EndIf
	If iButton < 7
		Debug.Notification(_SNQuest.ConfigText)
		TimescaleMenu()
	EndIf
EndFunction

Function RestartMenu(Int iButton = -1)
	iButton = _SNConfigRestartMsg.Show()
	If iButton == 0
		_SNQuest.Restart()
		Debug.Notification(_SNQuest.RestartText)
	Else
		Menu()
	EndIf
EndFunction

Function GuideMenu(Int iButton = -1)
	iButton = _SNConfigGuideMsg.Show()
	If iButton == 0						;1
		Debug.MessageBox(_SNQuest.Tip01Text)
	ElseIf iButton == 1					;2
		Debug.MessageBox(_SNQuest.Tip02Text)
	ElseIf iButton == 2					;3
		Debug.MessageBox(_SNQuest.Tip03Text)			
	ElseIf iButton == 3					;4
		Debug.MessageBox(_SNQuest.Tip04Text)			
	ElseIf iButton == 4					;5
		Debug.MessageBox(_SNQuest.Tip05Text)			
	ElseIf iButton == 5					;6
		Debug.MessageBox(_SNQuest.Tip06Text)			
	ElseIf iButton == 6					;7
		Debug.MessageBox(_SNQuest.Tip07Text)			
	ElseIf iButton == 7					;8
		Debug.MessageBox(_SNQuest.Tip08Text)			
	ElseIf iButton == 8					;9
		Debug.MessageBox(_SNQuest.Tip09Text)			
	ElseIf iButton == 9					;Back
		Menu()
	EndIf
	If iButton < 9
		GuideMenu()
	EndIf
EndFunction
		
;======================================================			
		
Function NeedsRatesMenu(Int iButton = -1)
	iButton = _SNConfigNeedsGenericMsg.Show()			;rates
	If iButton == 0						;H
		NeedsRatesHungerMenu()
	ElseIf iButton == 1					;T
		NeedsRatesThirstMenu()
	ElseIf iButton == 2					;F
		NeedsRatesFatigueMenu()
	ElseIf iButton == 3					;Back
		NeedsMenu()
	EndIf
EndFunction

Function NeedsVolMenu(Int iButton = -1)
	iButton = _SNConfigNeedsGenericMsg.Show()			;vol
	If iButton == 0						;H
		NeedsVolHungerMenu()
	ElseIf iButton == 1					;T
		NeedsVolThirstMenu()
	ElseIf iButton == 2					;F
		NeedsVolFatigueMenu()
	ElseIf iButton == 3					;Back
		NeedsMenu()
	EndIf
EndFunction

Function NeedsAutoMenu(Int iButton = -1)
	iButton = _SNConfigNeedsAutoMsg.Show()
	If iButton == 0						;EatOff
		_SNQuest._SNAutoHungerToggle.SetValue(0)
	ElseIf iButton == 1					;EatOn
		_SNQuest._SNAutoHungerToggle.SetValue(1)
	ElseIf iButton == 2					;DrinkOff
		_SNQuest._SNAutoThirstToggle.SetValue(0)
	ElseIf iButton == 3					;DrinkOn
		_SNQuest._SNAutoThirstToggle.SetValue(1)
	ElseIf iButton == 4					;RefillOff
		_SNQuest.AutoRefill = False
	ElseIf iButton == 5					;RefillOn
		_SNQuest.AutoRefill = True
	ElseIf iButton == 6					;Back
		NeedsMenu()
	EndIf
	If iButton < 6
		Debug.Notification(_SNQuest.ConfigText)
		NeedsAutoMenu()
	EndIf
EndFunction

Function NeedsFollowersMenu(Int iButton = -1)
	iButton = _SNConfigNeedsMealsFollowersMsg.Show()
	If iButton == 0						;Off
		_SNQuest._SNFollowerToggle.SetValue(0)
		_SNQuest._SNFollowerNeedsToggle.SetValue(0)
	ElseIf iButton == 1					;On
		_SNQuest._SNFollowerToggle.SetValue(1)
		_SNQuest._SNFollowerNeedsToggle.SetValue(2)
	ElseIf iButton == 2					;Back
		NeedsMenu()
	EndIf
	If iButton < 2
		Debug.Notification(_SNQuest.ConfigText)
		NeedsFollowersMenu()
	EndIf
EndFunction

Function NeedsHorseMenu(Int iButton = -1)
	iButton = _SNConfigNeedsHorseMsg.Show()
	If iButton == 0						;Off
		_SNQuest._SNHorseNeedsToggle.SetValue(0)
	ElseIf iButton == 1					;On
		_SNQuest._SNHorseNeedsToggle.SetValue(1)
	ElseIf iButton == 2					;Back
		NeedsMenu()
	EndIf
	If iButton < 2
		Debug.Notification(_SNQuest.ConfigText)
		NeedsHorseMenu()
	EndIf
EndFunction

Function NeedsPerspectiveMenu(Int iButton = -1)
	iButton = _SNConfigNeedsPerspectiveMsg.Show()
	If iButton == 0						;1st
		_SNQuest.SetPerspective(true)
	ElseIf iButton == 1					;2nd
		_SNQuest.SetPerspective()
	ElseIf iButton == 2					;Back
		NeedsMenu()
	EndIf
	If iButton < 2
		Debug.Notification(_SNQuest.ConfigText)
		NeedsPerspectiveMenu()
	EndIf
EndFunction

;======================================================	
		
Function DiffFoodRemovalMenu(Int iButton = -1)
	iButton = _SNConfigDiffFoodRemovalMsg.Show()
	If iButton == 0						;off
		_SNQuest._SNFoodRemovalToggle.SetValue(0)
	ElseIf iButton == 1					;containers
		_SNQuest.FoodLeveledList()
		_SNQuest._SNFoodRemovalToggle.SetValue(0)
	ElseIf iButton == 2					;interiors
		_SNQuest._SNFoodRemovalToggle.SetValue(1)
	ElseIf iButton == 3					;both
		_SNQuest.FoodLeveledList()
		_SNQuest._SNFoodRemovalToggle.SetValue(1)
	ElseIf iButton == 4					;back
		DiffMenu()
	EndIf
	If iButton < 4
		Debug.Notification(_SNQuest.ConfigText)
		DiffFoodRemovalMenu()
	EndIf
EndFunction

Function DiffAlcoholMenu(Int iButton = -1)
	iButton = _SNConfigDiffAlcoholMsg.Show()
	If iButton == 0						;Off
		_SNQuest.AlcoholDehydrates = False
	ElseIf iButton == 1					;On
		_SNQuest.AlcoholDehydrates = True
	ElseIf iButton == 2					;Back
		DiffMenu()
	EndIf
	If iButton < 2
		Debug.Notification(_SNQuest.ConfigText)
		DiffAlcoholMenu()
	EndIf
EndFunction

Function DiffDeathMenu(Int iButton = -1)
	iButton = _SNConfigDiffDeathMsg.Show()
	If iButton == 0						;Off
		_SNQuest.Death = False
	ElseIf iButton == 1					;On
		_SNQuest.Death = True
	ElseIf iButton == 2					;Back
		DiffMenu()
	EndIf
	If iButton < 2
		Debug.Notification(_SNQuest.ConfigText)
		DiffDeathMenu()
	EndIf
EndFunction

Function DiffReducedCarryMenu(Int iButton = -1)
	iButton = _SNConfigDiffReducedCarryMsg.Show()
	If iButton == 0						;0
		_SNQuest._SNCarryWeightMag.SetValue(0)
	ElseIf iButton == 1					;-50
		_SNQuest._SNCarryWeightMag.SetValue(50)			
	ElseIf iButton == 2					;-100
		_SNQuest._SNCarryWeightMag.SetValue(100)			
	ElseIf iButton == 3					;-150
		_SNQuest._SNCarryWeightMag.SetValue(150)			
	ElseIf iButton == 4					;-200
		_SNQuest._SNCarryWeightMag.SetValue(200)
	ElseIf iButton == 5					;Back
		DiffMenu()
	EndIf
	If iButton < 5
		Debug.Notification(_SNQuest.ConfigText)
		DiffReducedCarryMenu()
	EndIf
EndFunction

Function DiffAdrenalineMenu(Int iButton = -1)
	iButton = _SNConfigDiffAdrenalineMsg.Show()
	If iButton == 0						;Off
		_SNQuest._SNAdrenalineToggle.SetValue(0)
		targ.RemoveSpell(_SNQuest._SNAdrenalineSpell)
		targ.RemoveSpell(_SNQuest._SNWearySpell)
	ElseIf iButton == 1					;On
		_SNQuest._SNAdrenalineToggle.SetValue(1)
	ElseIf iButton == 2					;Back
		DiffMenu()
	EndIf
	If iButton < 2
		Debug.Notification(_SNQuest.ConfigText)
		DiffAdrenalineMenu()
	EndIf
EndFunction

Function DiffUnknownAllMenu(Int iButton = -1)
	iButton = _SNConfigDiffUnknownAllMsg.Show()
	If iButton == 0						;Off
		_SNQuest._SNUnknownAllToggle.SetValue(0)
	ElseIf iButton == 1					;On
		_SNQuest._SNUnknownAllToggle.SetValue(1)
	ElseIf iButton == 2					;Back
		DiffMenu()
	EndIf
	If iButton < 2
		Debug.Notification(_SNQuest.ConfigText)
		DiffUnknownAllMenu()
	EndIf
EndFunction

;======================================================				

Function MiscVisWaterskinMenu(Int iButton = -1)
	iButton = _SNConfigMiscVisWaterskinMsg.Show()
	If iButton == 0						;Off
		_SNQuest._SNWaterskinEquipToggle.SetValue(0)
	ElseIf iButton == 1					;front right
		_SNQuest._SNWaterskinEquipToggle.SetValue(1)
	ElseIf iButton == 2					;front left
		_SNQuest._SNWaterskinEquipToggle.SetValue(2)
	ElseIf iButton == 3					;back low
		_SNQuest._SNWaterskinEquipToggle.SetValue(3)
	ElseIf iButton == 4					;Back
		MiscMenu()
	EndIf
	If iButton < 4
		Debug.Notification(_SNQuest.ConfigText)
		MiscVisWaterskinMenu()
	EndIf
EndFunction

Function MiscVampireMenu(Int iButton = -1)
	iButton = _SNConfigMiscVampireMsg.Show()
	If iButton == 0						;Mortal
		_SNQuest._SNVampWereToggle.SetValue(0)
	ElseIf iButton == 1					;Hybrid
		_SNQuest._SNVampWereToggle.SetValue(1)	
	ElseIf iButton == 2					;Pure
		_SNQuest._SNVampWereToggle.SetValue(2)	
	ElseIf iButton == 3					;Back
		MiscMenu()			
	EndIf
	If iButton < 3
		Debug.Notification(_SNQuest.ConfigText)
		MiscVampireMenu()
	EndIf
EndFunction

Function MiscAnimationsMenu(Int iButton = -1)
	iButton = _SNConfigMiscAnimationsMsg.Show()
	If iButton == 0						;animate off
		_SNQuest.Animations = 0
	ElseIf iButton == 1					;animate sitting only
		_SNQuest.Animations = 1
	ElseIf iButton == 2					;animate on
		_SNQuest.Animations = 2
	ElseIf iButton == 3					;refill off
		_SNQuest.RefillAnimate = False
	ElseIf iButton == 4					;refill on
		_SNQuest.RefillAnimate = True
	ElseIf iButton == 5					;force camera off
		_SNQuest.ForceThird = False
	ElseIf iButton == 6					;force camera on
		_SNQuest.ForceThird = True
	ElseIf iButton == 7					;back
		MiscMenu()
	EndIf
	If iButton < 7
		Debug.Notification(_SNQuest.ConfigText)
		MiscAnimationsMenu()
	EndIf
EndFunction

Function MiscRestorationMenu(Int iButton = -1)
	iButton = _SNConfigMiscRestorationMsg.Show()
	If iButton == 0
		_SNQuest.Restore = False
	ElseIf iButton == 1
		_SNQuest.Restore = True
	ElseIf iButton == 2					;Back
		MiscMenu()			
	EndIf
	If iButton < 2
		Debug.Notification(_SNQuest.ConfigText)
		MiscRestorationMenu()
	EndIf
EndFunction

Function MiscCannibalMenu(Int iButton = -1)
	iButton = _SNConfigMiscCannibalMsg.Show()
	If iButton == 0
		_SNQuest._SNCannibalToggle.SetValue(0)
	ElseIf iButton == 1
		_SNQuest._SNCannibalToggle.SetValue(1)
	ElseIf iButton == 2					;Back
		MiscMenu()			
	EndIf
	If iButton < 2
		Debug.Notification(_SNQuest.ConfigText)
		MiscCannibalMenu()
	EndIf
EndFunction

;======================================================	

Function NeedsRatesHungerMenu(Int iButton = -1)
	iButton = _SNConfigNeedsRateHungerMsg.Show()
	If iButton == 0						;0
		_SNQuest.HungerRate = 0.0
		_SNQuest._SNHungerRate.SetValue(0.0)
	ElseIf iButton == 1					;1
		_SNQuest.HungerRate = 4.5
		_SNQuest._SNHungerRate.SetValue(4.5)
	ElseIf iButton == 2					;2
		_SNQuest.HungerRate = 6.5
		_SNQuest._SNHungerRate.SetValue(6.5)				
	ElseIf iButton == 3					;3
		_SNQuest.HungerRate = 8.5
		_SNQuest._SNHungerRate.SetValue(8.5)
	ElseIf iButton == 4					;4
		_SNQuest.HungerRate = 10.5
		_SNQuest._SNHungerRate.SetValue(10.5)
	ElseIf iButton == 5					;5
		_SNQuest.HungerRate = 12.5
		_SNQuest._SNHungerRate.SetValue(12.5)
	ElseIf iButton == 6					;6
		_SNQuest.HungerRate = 14.5
		_SNQuest._SNHungerRate.SetValue(14.5)
	ElseIf iButton == 7					;7
		_SNQuest.HungerRate = 16.5
		_SNQuest._SNHungerRate.SetValue(16.5)
	ElseIf iButton == 8					;Back
		NeedsRatesMenu()
	EndIf
	If iButton < 8
		Debug.Notification(_SNQuest.ConfigText)
		NeedsRatesHungerMenu()
	EndIf
EndFunction

Function NeedsRatesThirstMenu(Int iButton = -1)
	iButton = _SNConfigNeedsRateThirstMsg.Show()
	If iButton == 0						;0
		_SNQuest.ThirstRate = 0.0
		_SNQuest._SNThirstRate.SetValue(0.0)
	ElseIf iButton == 1					;1
		_SNQuest.ThirstRate = 7.0
		_SNQuest._SNThirstRate.SetValue(7.0)
	ElseIf iButton == 2					;2
		_SNQuest.ThirstRate = 9.0
		_SNQuest._SNThirstRate.SetValue(9.0)
	ElseIf iButton == 3					;3
		_SNQuest.ThirstRate = 11.0
		_SNQuest._SNThirstRate.SetValue(11.0)
	ElseIf iButton == 4					;4
		_SNQuest.ThirstRate = 13.0
		_SNQuest._SNThirstRate.SetValue(13.0)
	ElseIf iButton == 5					;5
		_SNQuest.ThirstRate = 15.0
		_SNQuest._SNThirstRate.SetValue(15.0)
	ElseIf iButton == 6					;6
		_SNQuest.ThirstRate = 17.0
		_SNQuest._SNThirstRate.SetValue(17.0)
	ElseIf iButton == 7					;7
		_SNQuest.ThirstRate = 19.0
		_SNQuest._SNThirstRate.SetValue(19.0)
	ElseIf iButton == 8					;Back
		NeedsRatesMenu()
	EndIf
	If iButton < 8
		Debug.Notification(_SNQuest.ConfigText)
		NeedsRatesThirstMenu()
	EndIf
EndFunction

Function NeedsRatesFatigueMenu(Int iButton = -1)
	iButton = _SNConfigNeedsRateFatigueMsg.Show()
	If iButton == 0						;0
		_SNQuest.FatigueRate = 0.0
		_SNQuest._SNFatigueRate.SetValue(0.0)
	ElseIf iButton == 1					;1
		_SNQuest.FatigueRate = 2.0
		_SNQuest._SNFatigueRate.SetValue(2.0)
	ElseIf iButton == 2					;2
		_SNQuest.FatigueRate = 3.0
		_SNQuest._SNFatigueRate.SetValue(3.0)
	ElseIf iButton == 3					;3
		_SNQuest.FatigueRate = 4.0
		_SNQuest._SNFatigueRate.SetValue(4.0)
	ElseIf iButton == 4					;4
		_SNQuest.FatigueRate = 5.0
		_SNQuest._SNFatigueRate.SetValue(5.0)
	ElseIf iButton == 5					;5
		_SNQuest.FatigueRate = 6.0
		_SNQuest._SNFatigueRate.SetValue(6.0)
	ElseIf iButton == 6					;6
		_SNQuest.FatigueRate = 7.0
		_SNQuest._SNFatigueRate.SetValue(7.0)
	ElseIf iButton == 7					;7
		_SNQuest.FatigueRate = 8.0
		_SNQuest._SNFatigueRate.SetValue(8.0)
	ElseIf iButton == 8					;Back
		NeedsRatesMenu()
	EndIf
	If iButton < 8
		Debug.Notification(_SNQuest.ConfigText)
		NeedsRatesFatigueMenu()
	EndIf
EndFunction

;======================================================	

Function NeedsVolHungerMenu(Int iButton = -1)
	iButton = _SNConfigNeedsVolHungerMsg.Show()
	If iButton == 0						;0
		_SNQuest.HungerVol = 0.0
	ElseIf iButton == 1					;2
		_SNQuest.HungerVol = 0.2
	ElseIf iButton == 2					;3
		_SNQuest.HungerVol = 0.3			
	ElseIf iButton == 3					;4
		_SNQuest.HungerVol = 0.4			
	ElseIf iButton == 4					;5
		_SNQuest.HungerVol = 0.5			
	ElseIf iButton == 5					;6
		_SNQuest.HungerVol = 0.6
	ElseIf iButton == 6					;7
		_SNQuest.HungerVol = 0.7			
	ElseIf iButton == 7					;8
		_SNQuest.HungerVol = 0.8			
	ElseIf iButton == 8					;9
		_SNQuest.HungerVol = 0.9			
	ElseIf iButton == 9					;Back
		NeedsVolMenu()
	EndIf
	If iButton < 9
		Debug.Notification(_SNQuest.ConfigText)
		NeedsVolHungerMenu()
	EndIf
EndFunction

Function NeedsVolThirstMenu(Int iButton = -1)
	iButton = _SNConfigNeedsVolThirstMsg.Show()
	If iButton == 0						;0
		_SNQuest.ThirstVol = 0.0
	ElseIf iButton == 1					;2
		_SNQuest.ThirstVol = 0.2
	ElseIf iButton == 2					;3
		_SNQuest.ThirstVol = 0.3			
	ElseIf iButton == 3					;4
		_SNQuest.ThirstVol = 0.4			
	ElseIf iButton == 4					;5
		_SNQuest.ThirstVol = 0.5			
	ElseIf iButton == 5					;6
		_SNQuest.ThirstVol = 0.6
	ElseIf iButton == 6					;7
		_SNQuest.ThirstVol = 0.7			
	ElseIf iButton == 7					;8
		_SNQuest.ThirstVol = 0.8			
	ElseIf iButton == 8					;9
		_SNQuest.ThirstVol = 0.9	
	ElseIf iButton == 9					;Back
		NeedsVolMenu()
	EndIf
	If iButton < 9
		Debug.Notification(_SNQuest.ConfigText)
		NeedsVolThirstMenu()
	EndIf
EndFunction

Function NeedsVolFatigueMenu(Int iButton = -1)
	iButton = _SNConfigNeedsVolFatigueMsg.Show()
	If iButton == 0						;0
		_SNQuest.FatigueVol = 0.0
	ElseIf iButton == 1					;2
		_SNQuest.FatigueVol = 0.2
	ElseIf iButton == 2					;3
		_SNQuest.FatigueVol = 0.3			
	ElseIf iButton == 3					;4
		_SNQuest.FatigueVol = 0.4			
	ElseIf iButton == 4					;5
		_SNQuest.FatigueVol = 0.5			
	ElseIf iButton == 5					;6
		_SNQuest.FatigueVol = 0.6
	ElseIf iButton == 6					;7
		_SNQuest.FatigueVol = 0.7			
	ElseIf iButton == 7					;8
		_SNQuest.FatigueVol = 0.8			
	ElseIf iButton == 8					;9
		_SNQuest.FatigueVol = 0.9	
	ElseIf iButton == 9					;Back
		NeedsVolMenu()
	EndIf
	If iButton < 9
		Debug.Notification(_SNQuest.ConfigText)
		NeedsVolFatigueMenu()
	EndIf
EndFunction

;======================================================				

Function RecategorizeMenu(Int iButton = -1)
	iButton = _SNConfigRecategorizeMsg.Show()
	If iButton == 0						;Off
		_SNQuest.Recategorize = False
	ElseIf iButton == 1					;On
		_SNQuest.Recategorize = True
	ElseIf iButton == 2					;Back
		Menu()
	EndIf
	If iButton < 2
		Debug.Notification(_SNQuest.ConfigText)
	EndIf		
EndFunction

;====================================================================================
;====================================================================================

Function Roast(Form RawFood, Form CookedFood)
	If targ.GetItemCount(RawFood) as Int > 0
		_SNRoastLP.Play(targ)
		targ.RemoveItem(RawFood, 1, true)
		targ.AddItem(CookedFood, 1)
	Else
		Debug.Notification(_SNQuest.NoRoastItemText)
	EndIf
EndFunction

Function HotkeyMenu(Int iButton = -1)
	iButton = _SNHotkeyMsg.Show()
	If iButton == 0
		_SNQuest.CheckStatus()
	ElseIf iButton == 1													;Eat
		_SNQuest.AutoEat(targ)
	ElseIf iButton == 2													;Drink
		_SNQuest.AutoDrink(targ)
	ElseIf iButton == 3													;Refill
		If _SNQuest.IsInWater
			If !_SNQuest.IsInSaltWater()
				Location CurrentLoc = targ.GetCurrentLocation()
				If CurrentLoc
					If _SNQuest.IsSafeLocation(CurrentLoc)
						_SNQuest.RefillNDrink()
					ElseIf _SNQuest.RefillUnknown(targ)
					Else
						HotkeyDrinkUnknownMenu()
					EndIf
				Else
					If !_SNQuest.IsInWarmWater
						_SNQuest.RefillNDrink()
					ElseIf _SNQuest.RefillUnknown(targ)
					Else
						HotkeyDrinkUnknownMenu()
					EndIf
				EndIf
			Else
				If !_SNQuest.PlayRefillAnim()
					_SNQuest._SNWaterskinWaterBodyRefillLP.Play(targ)
				EndIf
				targ.RemoveItem(_SNQuest._SNWaterSkin_0, 1, true)
				targ.AddItem(_SNQuest._SNWaterskin_Salt, 1)
			EndIf
		Else
			Debug.Notification(_SNQuest.NoWaterSourceText)
		EndIf
	ElseIf iButton == 4													;Sit
		Game.ForceThirdPerson()
		Game.DisablePlayerControls(false, false, true, false, false, false, false)
		Debug.SendAnimationEvent(targ, "IdleSitCrossLeggedEnter")
		_SNQuest.IsSitting = True
		RegisterForAnimationEvent(_SNQuest.PlayerRef, "JumpUp")
	ElseIf iButton == 5													;Inventory
		_SNQuest.CheckInventory()
	ElseIf iButton == 6													;Roast
		If Game.FindClosestReferenceOfAnyTypeInListFromRef(_SNQuest._SNFireList, targ, 384.0)
			HotkeyRoast1Menu()
		Else
			Debug.Notification(_SNQuest.NoFireText)
		EndIf
	ElseIf iButton == 7
		Menu()
	EndIf
EndFunction

Function HotkeyDrinkUnknownMenu(Int iButton = -1)
	iButton = _SNHotkeyDrinkUnknownMsg.Show()
	If iButton == 0
		_SNQuest.Drink(targ)
		_SNQuest.DiseaseRoll()
	EndIf
EndFunction

Function HotkeyRoast1Menu(Int iButton = -1)
	iButton = _SNHotkeyRoast1Msg.Show()
	If iButton == 0
		Roast(FoodLeek, FoodLeeksGrilled)
	ElseIf iButton == 1
		Roast(FoodPotato, FoodPotatoesBaked)
	ElseIf iButton == 2
		Roast(FoodRabbit, FoodRabbitCooked)
	ElseIf iButton == 3
		Roast(FoodChicken, FoodChickenCooked)
	ElseIf iButton == 4
		Roast(FoodPheasant, FoodPheasantCooked)
	ElseIf iButton == 5
		Roast(FoodSalmon, FoodSalmonCooked01)
	ElseIf iButton == 6
		Roast(FoodBeef, FoodBeefCooked)
	ElseIf iButton == 7
		Roast(FoodVenison, FoodVenisonCooked)
	ElseIf iButton == 8
		HotkeyRoast2Menu()
	ElseIf iButton == 9
		HotkeyMenu()
	EndIf
	If iButton < 8
		HotkeyRoast1Menu()
	EndIf
EndFunction

Function HotkeyRoast2Menu(Int iButton = -1)
	iButton = _SNHotkeyRoast2Msg.Show()
	If iButton == 0
		HotkeyRoast1Menu()
	ElseIf iButton == 1
		Roast(FoodHorkerMeat, FoodHorkerMeatCooked)
	ElseIf iButton == 2
		Roast(FoodMammothMeat, FoodMammothMeatCooked)
	ElseIf iButton == 3
		Roast(FoodGoatMeat, FoodGoatMeatCooked)
	ElseIf iButton == 4
		Roast(FoodHorseMeat, FoodHorseMeatCooked)
	ElseIf iButton == 5
		Roast(DLC2FoodBoarMeat, DLC2FoodBoarMeatCooked)
	ElseIf iButton == 6
		Roast(BYOHFoodMudcrabLegs, BYOHFoodMudcrabLegsCooked)
	ElseIf iButton == 7
		HotkeyMenu()
	EndIf
	If iButton > 0 && iButton < 7
		HotkeyRoast2Menu()
	EndIf
EndFunction
		
;====================================================================================

Event OnEffectStart(Actor akTarget, Actor akCaster)
	targ = akTarget
	If targ == _SNQuest.PlayerRef
		HotkeyMenu()
	EndIf
EndEvent

Event OnAnimationEvent(ObjectReference akSource, string asEventName)
	Game.EnablePlayerControls()
	_SNQuest.IsSitting = False
	If _SNQuest.SKSEVersion > 0.0
		SendModEvent("_SN_PlayerSits", "Jumping")
	EndIf
	UnregisterForAnimationEvent(_SNQuest.PlayerRef, "JumpUp")
EndEvent