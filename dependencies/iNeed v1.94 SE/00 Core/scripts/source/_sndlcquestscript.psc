Scriptname _SNDLCQuestScript extends Quest 

;====================================================================================

FormList Property _SNFood_Initial_DrinkList Auto
FormList Property _SNFood_Initial_DrinkNoAlcList Auto
FormList Property _SNFood_Initial_HeavyList Auto
FormList Property _SNFood_Initial_LightList Auto
FormList Property _SNFood_Initial_MedList Auto
FormList Property _SNFood_Initial_NoSpoilList Auto
FormList Property _SNFood_Initial_RawList Auto
FormList Property _SNFood_Initial_SoupList Auto

Form Milk_1
Form Milk_2

Keyword Property _DS_KW_Food_Soup Auto

_SNQuestScript Property _SNQuest Auto

Bool Property WildLootInstalled Auto
Bool Property CACOInstalled Auto
Bool Property HunterbornInstalled Auto
Bool SAFOInstalled
Bool CCFishInstalled
Bool USKPatchInstalled
Bool HearthfiresInstalled
Bool DawnguardInstalled
Bool DragonbornInstalled
Bool CFInstalled
Bool FalskaarInstalled
Bool CookingExpandInstalled
Bool HerbalTeaInstalled
Bool ImprovedFishInstalled
Bool MilkDrinkerInstalled
Bool RequiemInstalled
Bool HarvestOverhaulInstalled
Bool OsareFoodInstalled
Bool FiveTwoSevenInstalled
Bool WyrmstoothInstalled
Bool RealWildSkyrimInstalled
Bool FarmAnimalsInstalled
Bool NordicCookingInstalled
Bool CookingIngredientsInstalled
Bool ExtendedRecipesInstalled
Bool BrumaInstalled
Bool SetVanilla
Bool ResetLists = True

;====================================================================================

Function FillFormList(FormList InitialList, FormList FinalList)
	Int iIndex = InitialList.GetSize() as Int
	While iIndex > 0
		iIndex -= 1
		FinalList.AddForm(InitialList.GetAt(iIndex))
	EndWhile
EndFunction

Function SetVanilla()
	If !SetVanilla
		FillFormList(_SNFood_Initial_DrinkList, _SNQuest._SNFood_DrinkList)
		FillFormList(_SNFood_Initial_DrinkNoAlcList, _SNQuest._SNFood_DrinkNoAlcList)
		FillFormList(_SNFood_Initial_HeavyList, _SNQuest._SNFood_HeavyList)
		FillFormList(_SNFood_Initial_LightList, _SNQuest._SNFood_LightList)
		FillFormList(_SNFood_Initial_MedList, _SNQuest._SNFood_MedList)
		FillFormList(_SNFood_Initial_NoSpoilList, _SNQuest._SNFood_NoSpoilList)
		FillFormList(_SNFood_Initial_RawList, _SNQuest._SNFood_RawList)
		FillFormList(_SNFood_Initial_SoupList, _SNQuest._SNFood_SoupList)
		_SNQuest._SNFood_BloodList.AddForm(Game.GetFormFromFile(0x00018EF3, "Dawnguard.esm"))
		SetVanilla = True
	EndIf
EndFunction

Function SetMilk(Form Milk, String MilkPlugin)
	If !MilkDrinkerInstalled
		_SNQuest._SNFood_DrinkNoAlcList.AddForm(Milk)
		_SNQuest._SNFood_DrinkNoAlcList.AddForm(Game.GetFormFromFile(0x00008466, MilkPlugin))	;carrot
		_SNQuest._SNFood_DrinkNoAlcList.AddForm(Game.GetFormFromFile(0x00008467, MilkPlugin))	;snowberry
		_SNQuest._SNFood_DrinkNoAlcList.AddForm(Game.GetFormFromFile(0x00008469, MilkPlugin))	;apple
		_SNQuest._SNFood_DrinkNoAlcList.AddForm(Game.GetFormFromFile(0x0000846B, MilkPlugin))	;jazbay
		_SNQuest._SNFood_DrinkNoAlcList.AddForm(Game.GetFormFromFile(0x0000846D, MilkPlugin))	;juniper
		_SNQuest._SNFood_DrinkNoAlcList.AddForm(Game.GetFormFromFile(0x0000AF81, MilkPlugin))	;tomato
		_SNQuest._SNFood_DrinkNoAlcList.AddForm(Game.GetFormFromFile(0x0000AF8C, MilkPlugin))	;snowberry milk
		_SNQuest._SNFood_DrinkNoAlcList.AddForm(Game.GetFormFromFile(0x0000BA53, MilkPlugin))	;water
		_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x0000E006, MilkPlugin))		;cheese wedge
		_SNQuest._SNFood_HeavyList.AddForm(Game.GetFormFromFile(0x0000E007, MilkPlugin))		;cheese wheel
		_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x0000E009, MilkPlugin))		;sliced cheese
		If Milk_1
			_SNQuest._SNFood_DrinkList.AddForm(Game.GetFormFromFile(0x0000FAFE, MilkPlugin))	;canis root tea
		Else
			_SNQuest._SNFood_DrinkList.AddForm(Game.GetFormFromFile(0x0000EAD3, MilkPlugin))
		EndIf
		Utility.Wait(1.0)
	EndIf
	MilkDrinkerInstalled = True
EndFunction

Function SetWildLoot(Form RawBearMeat, String WildLootPlugin)
	If !WildLootInstalled
		_SNQuest._SNFood_RawList.AddForm(RawBearMeat)
		_SNQuest._SNFood_RawList.AddForm(Game.GetFormFromFile(0x00000D73, WildLootPlugin))		;raw skeever meat
		_SNQuest._SNFood_RawList.AddForm(Game.GetFormFromFile(0x00000D79, WildLootPlugin))		;raw mammoth meat
		_SNQuest._SNFood_RawList.AddForm(Game.GetFormFromFile(0x00000D7B, WildLootPlugin))		;raw sabre
		_SNQuest._SNFood_RawList.AddForm(Game.GetFormFromFile(0x00000D83, WildLootPlugin))		;raw wolf
		_SNQuest._SNFood_RawList.AddForm(Game.GetFormFromFile(0x00000D89, WildLootPlugin))		;raw mudcrab
		_SNQuest._SNFood_RawList.AddForm(Game.GetFormFromFile(0x00000D93, WildLootPlugin))		;raw slaughterfish
		_SNQuest._SNFood_RawList.AddForm(Game.GetFormFromFile(0x00000D97, WildLootPlugin))		;raw fox
		_SNQuest._SNFood_RawList.AddForm(Game.GetFormFromFile(0x000012FD, WildLootPlugin))		;raw goat
		_SNQuest._SNFood_RawList.AddForm(Game.GetFormFromFile(0x00001309, WildLootPlugin))		;raw venison
		_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x000018A6, WildLootPlugin))		;bear sausage
		_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x000018A8, WildLootPlugin))		;grilled fox
		_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x000018AA, WildLootPlugin))		;goat steak
		_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x000018AC, WildLootPlugin))		;garlic dog
		_SNQuest._SNFood_HeavyList.AddForm(Game.GetFormFromFile(0x000018B4, WildLootPlugin))	;marinated mammoth
		_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x000018B6, WildLootPlugin))		;mudcrab clam
		_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x000018B9, WildLootPlugin))		;spicy sabre stew
		_SNQuest._SNFood_HeavyList.AddForm(Game.GetFormFromFile(0x00001E0D, WildLootPlugin))	;bear roast
		_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x00001E20, WildLootPlugin))		;skeever stew
		_SNQuest._SNFood_HeavyList.AddForm(Game.GetFormFromFile(0x00001E25, WildLootPlugin))	;sabre roast
		_SNQuest._SNFood_HeavyList.AddForm(Game.GetFormFromFile(0x00001E28, WildLootPlugin))	;bear roast marin
		_SNQuest._SNFood_HeavyList.AddForm(Game.GetFormFromFile(0x00001E2C, WildLootPlugin))	;elk venison chop
		_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x00001E2F, WildLootPlugin))		;stew
		_SNQuest._SNFood_HeavyList.AddForm(Game.GetFormFromFile(0x00001E31, WildLootPlugin))	;wolf roast
		_SNQuest._SNFood_RawList.AddForm(Game.GetFormFromFile(0x000023D0, WildLootPlugin))		;raw rabbit
		_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x000023D2, WildLootPlugin))		;rabbit sandwich
		Utility.Wait(1.0)
	EndIf
	WildLootInstalled = True
EndFunction

Function SetFarmAnimals(Form GooseCooked, String FarmAnimalsPlugin)
	If !FarmAnimalsInstalled
		_SNQuest._SNFood_MedList.AddForm(GooseCooked)
		_SNQuest._SNFood_RawList.AddForm(Game.GetFormFromFile(0x0001B21A, FarmAnimalsPlugin))		;gooseraw
		_SNQuest._SNFood_RawList.AddForm(Game.GetFormFromFile(0x0001B21C, FarmAnimalsPlugin))		;duckraw
		_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x0001B21E, FarmAnimalsPlugin))		;duckcooked
		_SNQuest._SNFood_RawList.AddForm(Game.GetFormFromFile(0x0001B222, FarmAnimalsPlugin))		;beefsheepraw
		_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x0001B223, FarmAnimalsPlugin))		;beefsheepcooked
		_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x0001B225, FarmAnimalsPlugin))		;beefsheepstew
		_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x0001B22B, FarmAnimalsPlugin))		;duckstew
		_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x0001B22C, FarmAnimalsPlugin))		;goosestew
		_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x0001B795, FarmAnimalsPlugin))		;beefpigstew
		_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x0001B7A1, FarmAnimalsPlugin))		;pighamstew
		_SNQuest._SNFood_RawList.AddForm(Game.GetFormFromFile(0x0001B7A3, FarmAnimalsPlugin))		;pigbaconraw
		_SNQuest._SNFood_HeavyList.AddForm(Game.GetFormFromFile(0x0001B7A5, FarmAnimalsPlugin))		;pigbaconcooked
		_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x0001B7A7, FarmAnimalsPlugin))		;pigbaconstew
		_SNQuest._SNFood_RawList.AddForm(Game.GetFormFromFile(0x0001BD0B, FarmAnimalsPlugin))		;pigporkraw
		_SNQuest._SNFood_HeavyList.AddForm(Game.GetFormFromFile(0x0001BD0C, FarmAnimalsPlugin))		;pigporkcooked
		_SNQuest._SNFood_RawList.AddForm(Game.GetFormFromFile(0x0001BD0E, FarmAnimalsPlugin))		;pighamraw
		_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x0001BD10, FarmAnimalsPlugin))		;pighamcooked
		Utility.Wait(1.0)
	EndIf
	FarmAnimalsInstalled = True
EndFunction

;====================================================================================

Function DLCMaintenance()

	If ResetLists
		_SNQuest._SNFood_LightList.Revert()
		_SNQuest._SNFood_MedList.Revert()
		_SNQuest._SNFood_SoupList.Revert()
		_SNQuest._SNFood_HeavyList.Revert()
		_SNQuest._SNFood_DrinkList.Revert()
		_SNQuest._SNFood_DrinkNoAlcList.Revert()
		_SNQuest._SNFood_RawList.Revert()
		_SNQuest._SNFood_NoSpoilList.Revert()
		_SNQuest.DFSInstalled = False
		SetVanilla = False
		WildLootInstalled = False
		USKPatchInstalled = False
		HearthfiresInstalled = False
		DawnguardInstalled = False
		DragonbornInstalled = False
		FalskaarInstalled = False
		CookingExpandInstalled = False
		HunterbornInstalled = False
		HerbalTeaInstalled = False
		ImprovedFishInstalled = False
		MilkDrinkerInstalled = False
		RequiemInstalled = False
		HarvestOverhaulInstalled = False
		OsareFoodInstalled = False
		FiveTwoSevenInstalled = False
		WyrmstoothInstalled = False
		RealWildSkyrimInstalled = False
		FarmAnimalsInstalled = False
		NordicCookingInstalled = False
		CookingIngredientsInstalled = False
		CACOInstalled = False
		CCFishInstalled = False
		SAFOInstalled = False
		ResetLists = False
	EndIf
	
	SetVanilla()

	If Game.GetFormFromFile(0x000012C4, "iNeed - Dangerous Diseases.esp")
		_SNQuest._SNDiseaseToggle.SetValue(1)
		_SNQuest.iNeedDDInstalled = True
	Else
		_SNQuest._SNDiseaseToggle.SetValue(0)
		_SNQuest.CureDisease()
		If _SNQuest.iNeedDDInstalled
			_SNQuest.SetPotionLeveledLists(true)
		EndIf
		_SNQuest.iNeedDDInstalled = False
	EndIf
	If Game.GetFormFromFile(0x0000CA94, "iNeed - Extended.esp")		;Extended w/ recipes
		If !ExtendedRecipesInstalled
			_SNQuest.LItemFoodInnCommon.AddForm(_SNQuest._SNSoupFoodList, 1, 1)
			_SNQuest.LItemFoodInnCommon.AddForm(_SNQuest._SNSoupFoodList, 1, 2)
			_SNQuest.LItemFoodInnCommon.AddForm(_SNQuest._SNDLCFoodList, 1, 1)
			_SNQuest.LItemFoodInnCommon.AddForm(_SNQuest._SNDLCFoodList, 1, 2)
		EndIf
		ExtendedRecipesInstalled = True
	Else
		ExtendedRecipesInstalled = False
	EndIf

	_SNQuest.InTheCold = Game.GetFormFromFile(0x00028971, "WetandCold.esp") as GlobalVariable
	If _SNQuest.InTheCold
		_SNQuest.InTheColdTimed = Game.GetFormFromFile(0x0004A970, "WetandCold.esp") as GlobalVariable
	EndIf
	
	_SNQuest.IsHoliday = Game.GetFormFromFile(0x000127E0, "Holidays.esp") as GlobalVariable
	
	If Game.GetFormFromFile(0x00000EFF, "EFFCore.esm")		;EFF
		_SNQuest.EFFInstalled = True
	Else
		_SNQuest.EFFInstalled = False
	EndIf

	Form MeatPie = Game.GetFormFromFile(0x00000801, "Unofficial Skyrim Special Edition Patch.esp")
	If MeatPie
		If !USKPatchInstalled
			_SNQuest._SNFood_MedList.AddForm(MeatPie)
		EndIf
		USKPatchInstalled = True
	Else
		USKPatchInstalled = False
	EndIf

	Form RedSkooma = Game.GetFormFromFile(0x0001391D, "Dawnguard.esm")		;Dawnguard
	If RedSkooma
		If !DawnguardInstalled
			_SNQuest._SNFood_DrinkList.AddForm(RedSkooma)
			_SNQuest.DLC1HunterHQLocationInterior = Game.GetFormFromFile(0x000128FE, "Dawnguard.esm") as Location
		EndIf
		DawnguardInstalled = True
	Else
		DawnguardInstalled = False
	EndIf

	_SNQuest.CraftOven = Game.GetFormFromFile(0x000117F7, "Hearthfires.esm") as Keyword		;Hearthfire
	If _SNQuest.CraftOven
		If !HearthfiresInstalled
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x000009DB, "Hearthfires.esm"))		;Braidbread
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x000009DC, "HearthFires.esm"))		;garlic bread
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x00003533, "HearthFires.esm"))		;apple dumpling
			_SNQuest._SNFood_DrinkNoAlcList.AddForm(Game.GetFormFromFile(0x00003534, "HearthFires.esm"))	;milk
			_SNQuest._SNFood_DrinkList.AddForm(Game.GetFormFromFile(0x00003535, "HearthFires.esm"))		;argonian drink
			_SNQuest._SNFood_DrinkList.AddForm(Game.GetFormFromFile(0x00003536, "HearthFires.esm"))		;surilie
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x00003537, "HearthFires.esm"))		;potato bread
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x00003539, "HearthFires.esm"))		;juniper
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x0000353A, "HearthFires.esm"))		;jazberry
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x0000353B, "HearthFires.esm"))		;snowberry
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x0000353C, "HearthFires.esm"))		;butter
			_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x0000353D, "HearthFires.esm"))		;potato soup
			_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x0000353E, "HearthFires.esm"))		;clam chowder
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x0000353F, "HearthFires.esm"))		;steamed mudcrab
			_SNQuest._SNFood_RawList.AddForm(Game.GetFormFromFile(0x00003540, "HearthFires.esm"))		;raw mudcrab
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x00003541, "HearthFires.esm"))		;salmon
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x000117FF, "HearthFires.esm"))		;chicken dumpling
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x00011801, "HearthFires.esm"))		;lavender dumpling
			Utility.Wait(1.0)
		EndIf
		HearthfiresInstalled = True
	Else
		HearthfiresInstalled = False
	EndIf

	Form AshYam = Game.GetFormFromFile(0x000206E7, "Dragonborn.esm")		;Dragonborn
	If AshYam
		If !DragonbornInstalled
			_SNQuest._SNFood_LightList.AddForm(AshYam)
			_SNQuest._SNFood_DrinkList.AddForm(Game.GetFormFromFile(0x000207E5, "Dragonborn.esm"))		;flin
			_SNQuest._SNFood_DrinkList.AddForm(Game.GetFormFromFile(0x000207E6, "Dragonborn.esm"))		;sujamma
			_SNQuest._SNFood_DrinkList.AddForm(Game.GetFormFromFile(0x000248CC, "Dragonborn.esm"))		;shein
			_SNQuest._SNFood_DrinkList.AddForm(Game.GetFormFromFile(0x000248CE, "Dragonborn.esm"))		;matze
			_SNQuest._SNFood_DrinkList.AddForm(Game.GetFormFromFile(0x00024E0B, "Dragonborn.esm"))		;sadri sujamma
			_SNQuest._SNFood_DrinkList.AddForm(Game.GetFormFromFile(0x000320DF, "Dragonborn.esm"))		;emberbrand
			_SNQuest._SNFood_DrinkList.AddForm(Game.GetFormFromFile(0x0003572F, "Dragonborn.esm"))		;ashfire mead
			_SNQuest._SNFood_RawList.AddForm(Game.GetFormFromFile(0x0003BD14, "Dragonborn.esm"))		;boar meat
			_SNQuest._SNFood_RawList.AddForm(Game.GetFormFromFile(0x0003BD15, "Dragonborn.esm"))		;ash hopper
			_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x0003CD5B, "Dragonborn.esm"))		;horker ash yam stew
			_SNQuest._SNFood_HeavyList.AddForm(Game.GetFormFromFile(0x0003CF72, "Dragonborn.esm"))		;cooked boar
			_SNQuest._SNFood_RawList.AddForm(Game.GetFormFromFile(0x0003D125, "Dragonborn.esm"))		;hopper leg
			_SNQuest._SNHarvest_CropList.AddForm(Game.GetFormFromFile(0x00038A83, "Dragonborn.esm"))	;horker
			_SNQuest._SNHarvest_CropList.AddForm(Game.GetFormFromFile(0x00038A7A, "Dragonborn.esm"))	;horker meat
			_SNQuest._SNHarvest_CropList.AddForm(Game.GetFormFromFile(0x000206E8, "Dragonborn.esm"))	;ash yam flora
			_SNQuest._SNHarvest_CropIngredientList.AddForm(Game.GetFormFromFile(0x000206E7, "Dragonborn.esm"))	;ash yam
			_SNQuest._SNFollowerIgnoreList.AddForm(Game.GetFormFromFile(0x0001773A, "Dragonborn.esm"))	;neloth
			_SNQuest._SNFollowerIgnoreList.AddForm(Game.GetFormFromFile(0x00018FC8, "Dragonborn.esm"))	;tharstan
			_SNQuest.DiseaseBHB = Game.GetFormFromFile(0x0001FF2C, "Dragonborn.esm") as MagicEffect
			_SNQuest.DiseaseDroops = Game.GetFormFromFile(0x000285C0, "Dragonborn.esm") as MagicEffect
			_SNQuest.Solstheim = Game.GetFormFromFile(0x00000800, "Dragonborn.esm") as Worldspace
			_SNQuest.DLC2LItemIngredientNewRR75 = Game.GetFormFromFile(0x0003A247, "Dragonborn.esm") as LeveledItem
			Utility.Wait(1.0)
		EndIf
		DragonbornInstalled = True
	Else
		DragonbornInstalled = False
	EndIf
	
	Form Campfire_embers = Game.GetFormFromFile(0x00041B48, "Campfire.esm")						;Campfire
	If Campfire_embers
		If !CFInstalled
			_SNQuest._SNFireList.AddForm(Campfire_embers)
			_SNQuest._SNFireList.AddForm(Game.GetFormFromFile(0x000328B9, "Campfire.esm"))
			_SNQuest._SNFireList.AddForm(Game.GetFormFromFile(0x00033E69, "Campfire.esm"))
			_SNQuest._SNFireList.AddForm(Game.GetFormFromFile(0x0006ABB2, "Campfire.esm"))
			_SNQuest._SNFireList.AddForm(Game.GetFormFromFile(0x0002D03B, "Campfire.esm"))
			_SNQuest._SNFireList.AddForm(Game.GetFormFromFile(0x0002B533, "Campfire.esm"))
			_SNQuest._SNTentList.AddForm(Game.GetFormFromFile(0x00036594, "Campfire.esm"))
			_SNQuest._SNTentList.AddForm(Game.GetFormFromFile(0x00036B6C, "Campfire.esm"))
			_SNQuest._SNTentList.AddForm(Game.GetFormFromFile(0x00038CB2, "Campfire.esm"))
			_SNQuest._SNTentList.AddForm(Game.GetFormFromFile(0x000397B9, "Campfire.esm"))
			_SNQuest._SNTentList.AddForm(Game.GetFormFromFile(0x0003D43D, "Campfire.esm"))
			_SNQuest._SNTentList.AddForm(Game.GetFormFromFile(0x0003D43E, "Campfire.esm"))
			_SNQuest._SNTentList.AddForm(Game.GetFormFromFile(0x0003D43F, "Campfire.esm"))
			_SNQuest._SNTentList.AddForm(Game.GetFormFromFile(0x0003D440, "Campfire.esm"))
			_SNQuest._SNTentList.AddForm(Game.GetFormFromFile(0x0004DEFD, "Campfire.esm"))
			_SNQuest._SNTentList.AddForm(Game.GetFormFromFile(0x0004DEFE, "Campfire.esm"))
			_SNQuest._SNTentList.AddForm(Game.GetFormFromFile(0x0004DEFF, "Campfire.esm"))
			_SNQuest._SNTentList.AddForm(Game.GetFormFromFile(0x0004DF00, "Campfire.esm"))
			_SNQuest._SNTentList.AddForm(Game.GetFormFromFile(0x00052A8E, "Campfire.esm"))
			_SNQuest._SNTentList.AddForm(Game.GetFormFromFile(0x00052A98, "Campfire.esm"))
			_SNQuest._SNTentList.AddForm(Game.GetFormFromFile(0x00052A99, "Campfire.esm"))
			_SNQuest._SNTentList.AddForm(Game.GetFormFromFile(0x00052A9A, "Campfire.esm"))
		EndIf
		CFInstalled = True
	Else
		CFInstalled = False
	EndIf

	Form AmberMead =  Game.GetFormFromFile(0x000D69CE, "Falskaar.esm")
	If AmberMead
		If !FalskaarInstalled
			_SNQuest._SNFood_DrinkList.AddForm(AmberMead)
			_SNQuest._SNFood_DrinkList.AddForm(Game.GetFormFromFile(0x000DC0B9, "Falskaar.esm"))	;bjar special brew
			_SNQuest._SNFood_HeavyList.AddForm(Game.GetFormFromFile(0x00123534, "Falskaar.esm"))	;seasoned beef
			_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x0015DB76, "Falskaar.esm"))		;special stew
			_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x0015DB78, "Falskaar.esm"))		;spirit stew
			_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x0015DB7A, "Falskaar.esm"))		;vegetable medley
			_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x0015DB7C, "Falskaar.esm"))		;seasoned beef stew
			_SNQuest._SNFood_RawList.AddForm(Game.GetFormFromFile(0x0015DB7E, "Falskaar.esm"))		;venison
			Utility.Wait(1.0)
		EndIf
		FalskaarInstalled = True
	Else
		FalskaarInstalled = False
	EndIf
	
	Form RedCabbage =  Game.GetFormFromFile(0x00001421, "BSAssets.esm")
	If RedCabbage
		If !BrumaInstalled
			_SNQuest._SNFood_LightList.AddForm(RedCabbage)
			_SNQuest._SNFood_DrinkNoAlcList.AddForm(Game.GetFormFromFile(0x00001911, "BSAssets.esm"))	;watermelon
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x00001FB8, "BSAssets.esm"))	;parsnip
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x00001FC8, "BSAssets.esm"))	;pumpkin
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x00001FCA, "BSAssets.esm"))	;grapes
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x0000202D, "BSAssets.esm"))	;steamed rice
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x00002078, "BSAssets.esm"))	;pear
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x00002079, "BSAssets.esm"))	;peach
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x000020AC, "BSAssets.esm"))	;lettuce
			_SNQuest._SNFood_RawList.AddForm(Game.GetFormFromFile(0x000020AD, "BSAssets.esm"))		;rat meat
			_SNQuest._SNFood_RawList.AddForm(Game.GetFormFromFile(0x000020AE, "BSAssets.esm"))		;boar meat
			_SNQuest._SNFood_HeavyList.AddForm(Game.GetFormFromFile(0x000020AF, "BSAssets.esm"))	;cooked boar meat
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x00002564, "BSAssets.esm"))	;scrib cabbage
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x0000280A, "BSAssets.esm"))	;jug of cream
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x0000280B, "BSAssets.esm"))	;orange
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x0000280E, "BSAssets.esm"))	;boiled egg
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x0000280F, "BSAssets.esm"))	;flap jack
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x00002810, "BSAssets.esm"))	;jug of cream
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x00002812, "BSAssets.esm"))	;radish
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x00002839, "BSAssets.esm"))	;strawberry
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x0000283A, "BSAssets.esm"))	;banana
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x0000283C, "BSAssets.esm"))	;corn
			_SNQuest._SNFood_RawList.AddForm(Game.GetFormFromFile(0x000028B7, "BSAssets.esm"))		;mutton
			_SNQuest._SNFood_HeavyList.AddForm(Game.GetFormFromFile(0x000028B8, "BSAssets.esm"))	;mutton roast
			_SNQuest._SNFood_HeavyList.AddForm(Game.GetFormFromFile(0x000028C6, "BSAssets.esm"))	;roast lamb
			_SNQuest._SNFood_RawList.AddForm(Game.GetFormFromFile(0x000028D8, "BSAssets.esm"))		;lamb
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x00002941, "BSAssets.esm"))		;carrot cake
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x00002942, "BSAssets.esm"))	;carrot cake slice
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x00002943, "BSAssets.esm"))		;cabbage roll
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x00002945, "BSAssets.esm"))		;eyebread
			Utility.Wait(1.0)
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x00001D7F, "BSHeartland.esm"))	;applewatch pie
			_SNQuest._SNFood_RawList.AddForm(Game.GetFormFromFile(0x00049320, "BSHeartland.esm"))	;trout meat
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x0005F064, "BSHeartland.esm"))	;venison pasty
			_SNQuest._SNFood_DrinkList.AddForm(Game.GetFormFromFile(0x0005F065, "BSHeartland.esm"))	;cheap wine
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x0005F066, "BSHeartland.esm"))	;corn bread
			_SNQuest._SNFood_DrinkList.AddForm(Game.GetFormFromFile(0x0005F067, "BSHeartland.esm"))	;cheap wine
			_SNQuest._SNFood_DrinkList.AddForm(Game.GetFormFromFile(0x0005F068, "BSHeartland.esm"))	;mead
			_SNQuest._SNFood_DrinkList.AddForm(Game.GetFormFromFile(0x0005F069, "BSHeartland.esm"))	;beer
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x0005F06A, "BSHeartland.esm"))	;bear pasty
			_SNQuest._SNFood_DrinkList.AddForm(Game.GetFormFromFile(0x0005F06B, "BSHeartland.esm"))	;applewatch cider
			_SNQuest._SNFood_HeavyList.AddForm(Game.GetFormFromFile(0x0005F06C, "BSHeartland.esm"))	;sliced cheese
			_SNQuest._SNFood_HeavyList.AddForm(Game.GetFormFromFile(0x0005F06D, "BSHeartland.esm"))	;cheese wheel
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x0005F06E, "BSHeartland.esm"))	;cheese wedge
			_SNQuest._SNFood_DrinkList.AddForm(Game.GetFormFromFile(0x0005F06F, "BSHeartland.esm"))	;greenwood mead
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x0005F070, "BSHeartland.esm"))	;corn bread
			_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x0005F071, "BSHeartland.esm"))	;mudcrab stew
			_SNQuest._SNFood_DrinkList.AddForm(Game.GetFormFromFile(0x0005F072, "BSHeartland.esm"))	;flin
			_SNQuest._SNFood_DrinkList.AddForm(Game.GetFormFromFile(0x0005F073, "BSHeartland.esm"))	;ale
			_SNQuest._SNFood_RawList.AddForm(Game.GetFormFromFile(0x00062712, "BSHeartland.esm"))	;turkey breast
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x00062713, "BSHeartland.esm"))	;shepards pie
			_SNQuest._SNFood_DrinkList.AddForm(Game.GetFormFromFile(0x00062715, "BSHeartland.esm"))	;shadowbanish wine
			_SNQuest._SNFood_DrinkList.AddForm(Game.GetFormFromFile(0x00062716, "BSHeartland.esm"))	;colovian battlecry
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x00071A0F, "BSHeartland.esm"))	;rice bread
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x00071A10, "BSHeartland.esm"))	;rice bread
			_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x00071A13, "BSHeartland.esm"))	;watermelon salad
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x00071A14, "BSHeartland.esm"))	;garlic carrots
			_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x000721C6, "BSHeartland.esm"))	;imperial city stew
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x000721C7, "BSHeartland.esm"))	;roast turkey
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x000721C8, "BSHeartland.esm"))	;trout steak
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x000721C9, "BSHeartland.esm"))	;slaughterfish pie
			_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x000721CA, "BSHeartland.esm"))	;jugged rabbit
			_SNQuest._SNFood_DrinkList.AddForm(Game.GetFormFromFile(0x000858EF, "BSHeartland.esm"))	;brandy
			_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x000B6C52, "BSHeartland.esm"))	;colovian beef stew
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x000B6C53, "BSHeartland.esm"))	;lollipop
			_SNQuest._SNFood_NoSpoilList.AddForm(Game.GetFormFromFile(0x000B6C53, "BSHeartland.esm"))	;lollipop
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x000B6C54, "BSHeartland.esm"))	;candy bunnies
			_SNQuest._SNFood_NoSpoilList.AddForm(Game.GetFormFromFile(0x000B6C54, "BSHeartland.esm"))	;candy bunnies
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x000B6C55, "BSHeartland.esm"))	;beef skewer
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x000B6C56, "BSHeartland.esm"))	;baked apple
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x000B6C58, "BSHeartland.esm"))	;apple jam
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x000B6C59, "BSHeartland.esm"))	;grape jam
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x000B6C5A, "BSHeartland.esm"))	;cheese curds
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x000B6C5B, "BSHeartland.esm"))	;colovian bread wreath
			_SNQuest._SNFood_HeavyList.AddForm(Game.GetFormFromFile(0x000CC27D, "BSHeartland.esm"))	;olroy cheese wheel
			_SNQuest._SNFood_HeavyList.AddForm(Game.GetFormFromFile(0x000CC27E, "BSHeartland.esm"))	;sliced olroy
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x000CC27F, "BSHeartland.esm"))	;olroy wedge
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x000CC280, "BSHeartland.esm"))	;cooked rat
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x000D2F3D, "BSHeartland.esm"))	;sweet cake
			Utility.Wait(1.0)
		EndIf
		BrumaInstalled = True
	Else
		BrumaInstalled = False
	EndIf

	Form HuntersPie = Game.GetFormFromFile(0x00000801, "CookingExpanded.esp")
	If HuntersPie
		If !CookingExpandInstalled
			_SNQuest._SNFood_HeavyList.AddForm(HuntersPie)
			_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x00000D7E, "CookingExpanded.esp"))	;bread soup
			_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x00001000, "CookingExpanded.esp"))	;mushroom soup
			_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x00001002, "CookingExpanded.esp"))	;mammoth fondue
			_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x00001004, "CookingExpanded.esp"))	;pheasant stew
			_SNQuest._SNFood_HeavyList.AddForm(Game.GetFormFromFile(0x00001009, "CookingExpanded.esp"))	;braised beef
			_SNQuest._SNFood_RawList.AddForm(Game.GetFormFromFile(0x0000100A, "CookingExpanded.esp"))	;raw slaughterfish
			_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x0000100D, "CookingExpanded.esp"))	;chicken soup
			_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x00001DEB, "CookingExpanded.esp"))	;beggars stew
			_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x00002E1D, "CookingExpanded.esp"))	;equine stew
			_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x00CD0001, "CookingExpanded.esp"))	;rabbit stew
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x00CD0002, "CookingExpanded.esp"))	;egg
			_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x00CD0003, "CookingExpanded.esp"))	;seafood soup
			_SNQuest._SNFood_HeavyList.AddForm(Game.GetFormFromFile(0x00CD0004, "CookingExpanded.esp"))	;stuffed gourd
			_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x00CD0005, "CookingExpanded.esp"))	;goat stew
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x00CD0006, "CookingExpanded.esp"))	;steamed clam
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x00CD0007, "CookingExpanded.esp"))	;smoked salmon
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x00CD0008, "CookingExpanded.esp"))	;salted longfin
			Utility.Wait(1.0)
		EndIf
		CookingExpandInstalled = True
	Else
		CookingExpandInstalled = False
	EndIf

	Form StrangeBrew = Game.GetFormFromFile(0x0000B504, "Hunterborn.esp")
	If StrangeBrew
		If !HunterbornInstalled
			_SNQuest._SNFood_DrinkList.AddForm(StrangeBrew)
			_SNQuest._SNFood_RawList.AddForm(Game.GetFormFromFile(0x00012C6B, "Hunterborn.esp"))	;ox hear
			_SNQuest._SNFood_RawList.AddForm(Game.GetFormFromFile(0x00012C6C, "Hunterborn.esp"))	;horse heart
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x00014226, "Hunterborn.esp"))	;edible flower
			_SNQuest._SNFood_HorseList.AddForm(Game.GetFormFromFile(0x00014226, "Hunterborn.esp"))	;edible flower
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x00014228, "Hunterborn.esp"))	;edible insect
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x0001422A, "Hunterborn.esp"))	;edible mushroom
			_SNQuest._SNFood_HorseList.AddForm(Game.GetFormFromFile(0x0001422A, "Hunterborn.esp"))	;edible mushroom
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x0001422C, "Hunterborn.esp"))	;edible root
			_SNQuest._SNFood_HorseList.AddForm(Game.GetFormFromFile(0x0001422C, "Hunterborn.esp"))	;edible root
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x0001422E, "Hunterborn.esp"))	;edible berry
			_SNQuest._SNFood_HorseList.AddForm(Game.GetFormFromFile(0x0001422E, "Hunterborn.esp"))	;edible berry
			_SNQuest._SNFood_RawList.AddForm(Game.GetFormFromFile(0x00014795, "Hunterborn.esp"))		;raw bear
			_SNQuest._SNFood_RawList.AddForm(Game.GetFormFromFile(0x00014796, "Hunterborn.esp"))		;raw skeever
			_SNQuest._SNFood_RawList.AddForm(Game.GetFormFromFile(0x00014798, "Hunterborn.esp"))		;raw fox
			_SNQuest._SNFood_RawList.AddForm(Game.GetFormFromFile(0x0001479A, "Hunterborn.esp"))		;raw goat
			_SNQuest._SNFood_RawList.AddForm(Game.GetFormFromFile(0x0001479C, "Hunterborn.esp"))		;raw wolf
			_SNQuest._SNFood_RawList.AddForm(Game.GetFormFromFile(0x0001479E, "Hunterborn.esp"))		;raw mammoth
			_SNQuest._SNFood_RawList.AddForm(Game.GetFormFromFile(0x000147A0, "Hunterborn.esp"))		;raw sabre
			_SNQuest._SNFood_RawList.AddForm(Game.GetFormFromFile(0x000147A2, "Hunterborn.esp"))		;raw rabbit
			_SNQuest._SNFood_RawList.AddForm(Game.GetFormFromFile(0x00014D21, "Hunterborn.esp"))		;venison elk
			_SNQuest._SNFood_RawList.AddForm(Game.GetFormFromFile(0x00014D22, "Hunterborn.esp"))		;raw mudcrab
			_SNQuest._SNFood_RawList.AddForm(Game.GetFormFromFile(0x00014D24, "Hunterborn.esp"))		;raw slaughterfish
			_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x00017E08, "Hunterborn.esp"))		;bear carrot stew
			_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x00017E09, "Hunterborn.esp"))		;hunters stew
			_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x00017E0B, "Hunterborn.esp"))		;fox apple stew
			_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x00017E0D, "Hunterborn.esp"))		;spiced diced goat
			_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x00017E0F, "Hunterborn.esp"))		;rabbit mushroom stew
			_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x00017E11, "Hunterborn.esp"))		;mammoth tomato stew
			_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x00017E13, "Hunterborn.esp"))		;mudcrab chowder
			_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x00017E15, "Hunterborn.esp"))		;salty sabred stew
			_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x00017E17, "Hunterborn.esp"))		;skeevender stew
			_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x00017E19, "Hunterborn.esp"))		;wolf cabbage stew
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x00017E1B, "Hunterborn.esp"))		;venison jerky
			_SNQuest._SNFood_NoSpoilList.AddForm(Game.GetFormFromFile(0x00017E1B, "Hunterborn.esp"))	;venison jerky
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x00017E1D, "Hunterborn.esp"))		;horse jerky
			_SNQuest._SNFood_NoSpoilList.AddForm(Game.GetFormFromFile(0x00017E1D, "Hunterborn.esp"))	;horse jerky
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x00017E1F, "Hunterborn.esp"))		;seared fox
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x00017E21, "Hunterborn.esp"))		;seared rabbit
			_SNQuest._SNFood_HeavyList.AddForm(Game.GetFormFromFile(0x00017E23, "Hunterborn.esp"))		;mutt chop
			_SNQuest._SNFood_HeavyList.AddForm(Game.GetFormFromFile(0x00017E25, "Hunterborn.esp"))		;ale braised saber
			_SNQuest._SNFood_HeavyList.AddForm(Game.GetFormFromFile(0x00017E27, "Hunterborn.esp"))		;wolf chop snowberry
			_SNQuest._SNFood_HeavyList.AddForm(Game.GetFormFromFile(0x00017E29, "Hunterborn.esp"))		;mead braised bear
			_SNQuest._SNFood_HeavyList.AddForm(Game.GetFormFromFile(0x00017E2B, "Hunterborn.esp"))		;venison tenderloin
			_SNQuest._SNFood_HeavyList.AddForm(Game.GetFormFromFile(0x00017E2D, "Hunterborn.esp"))		;breaded elk
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x00017E2F, "Hunterborn.esp"))		;fox herb cutlet
			_SNQuest._SNFood_HeavyList.AddForm(Game.GetFormFromFile(0x00017E31, "Hunterborn.esp"))		;mullwine braised mammoth
			_SNQuest._SNFood_HeavyList.AddForm(Game.GetFormFromFile(0x00017E33, "Hunterborn.esp"))		;sabre pot roast
			_SNQuest._SNFood_HeavyList.AddForm(Game.GetFormFromFile(0x00017E35, "Hunterborn.esp"))		;elk steak
			_SNQuest._SNFood_HeavyList.AddForm(Game.GetFormFromFile(0x00017E37, "Hunterborn.esp"))		;goat haunch
			_SNQuest._SNFood_HeavyList.AddForm(Game.GetFormFromFile(0x00017E39, "Hunterborn.esp"))		;wolf haunch
			Utility.Wait(1.0)
			_SNQuest._SNFood_HeavyList.AddForm(Game.GetFormFromFile(0x00017E3B, "Hunterborn.esp"))		;smoked elf roast
			_SNQuest._SNFood_HeavyList.AddForm(Game.GetFormFromFile(0x00017E3D, "Hunterborn.esp"))		;honey mammoth roast
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x00017E3F, "Hunterborn.esp"))		;minced mari bear
			_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x00017E41, "Hunterborn.esp"))		;root bear
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x00017E43, "Hunterborn.esp"))		;elf ear elk
			_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x00017E45, "Hunterborn.esp"))		;goat and potatoes
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x00017E47, "Hunterborn.esp"))		;dragon stuffed rabbit
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x00017E49, "Hunterborn.esp"))		;hot honey horker
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x00017E4B, "Hunterborn.esp"))		;mari mammoth elsweyr
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x00017E4D, "Hunterborn.esp"))		;boiled mudcrab
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x00017E4F, "Hunterborn.esp"))		;mudcrab egg
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x00017E51, "Hunterborn.esp"))		;skewered skeever
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x00017E53, "Hunterborn.esp"))		;velvet slaughter
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x00017E55, "Hunterborn.esp"))		;sweet wolf
			_SNQuest._SNFood_RawList.AddForm(Game.GetFormFromFile(0x00027783, "Hunterborn.esp"))		;raw chaurus
			_SNQuest._SNFood_RawList.AddForm(Game.GetFormFromFile(0x00029846, "Hunterborn.esp"))		;raw spider
			_SNQuest._SNFood_RawList.AddForm(Game.GetFormFromFile(0x00029847, "Hunterborn.esp"))		;raw troll
			_SNQuest._SNFood_RawList.AddForm(Game.GetFormFromFile(0x00029849, "Hunterborn.esp"))		;raw dragon
			_SNQuest._SNFood_HeavyList.AddForm(Game.GetFormFromFile(0x00029854, "Hunterborn.esp"))		;chaurus pie
			_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x00029DB9, "Hunterborn.esp"))		;spider soup
			_SNQuest._SNFood_HeavyList.AddForm(Game.GetFormFromFile(0x00029DBA, "Hunterborn.esp"))		;charred troll
			_SNQuest._SNFood_HeavyList.AddForm(Game.GetFormFromFile(0x00029DBC, "Hunterborn.esp"))		;dragon steak
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x000314C4, "Hunterborn.esp"))		;spider fry
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x000314C5, "Hunterborn.esp"))		;boiled spider paste
			_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x000314C9, "Hunterborn.esp"))		;poisoners soup
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x000314CC, "Hunterborn.esp"))		;chaurus chops
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x000314CD, "Hunterborn.esp"))		;troll jerky
			_SNQuest._SNFood_NoSpoilList.AddForm(Game.GetFormFromFile(0x000314CD, "Hunterborn.esp"))	;troll jerky
			_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x000314D1, "Hunterborn.esp"))		;dragon heart stew
			_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x000314D4, "Hunterborn.esp"))		;dragon blood pudding
			_SNQuest._SNFood_HeavyList.AddForm(Game.GetFormFromFile(0x000314D7, "Hunterborn.esp"))		;wyrm and chips
			_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x00031A49, "Hunterborn.esp"))		;carrot pot dragon
			_SNQuest._SNFood_DrinkNoAlcList.AddForm(Game.GetFormFromFile(0x0003FD68, "Hunterborn.esp"))	;ten dragon tea
			_SNQuest._SNFood_DrinkNoAlcList.AddForm(Game.GetFormFromFile(0x000402D7, "Hunterborn.esp"))	;juniper tea
			_SNQuest._SNFood_DrinkNoAlcList.AddForm(Game.GetFormFromFile(0x000402DA, "Hunterborn.esp"))	;lavender tea
			_SNQuest._SNFood_DrinkNoAlcList.AddForm(Game.GetFormFromFile(0x000402DC, "Hunterborn.esp"))	;mt flower tea
			_SNQuest._SNFood_DrinkNoAlcList.AddForm(Game.GetFormFromFile(0x000402DE, "Hunterborn.esp"))	;moon dance tea
			_SNQuest._SNFood_DrinkNoAlcList.AddForm(Game.GetFormFromFile(0x000402E0, "Hunterborn.esp"))	;nirn spring tea
			_SNQuest._SNFood_DrinkNoAlcList.AddForm(Game.GetFormFromFile(0x000402E2, "Hunterborn.esp"))	;snowberry tea
			_SNQuest._SNFood_DrinkNoAlcList.AddForm(Game.GetFormFromFile(0x000402E4, "Hunterborn.esp"))	;wheat boon tea
			Utility.Wait(1.0)
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x00055772, "Hunterborn.esp"))		;watermelon
			_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x00078EA9, "Hunterborn.esp"))		;boarpotatostew
			_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x00078EAB, "Hunterborn.esp"))		;boarleakstew
			_SNQuest._SNFood_HeavyList.AddForm(Game.GetFormFromFile(0x00078EAD, "Hunterborn.esp"))		;roastboar
			_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x0007DFB3, "Hunterborn.esp"))		;watermelongazpacho
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x0009C5C9, "Hunterborn.esp"))		;petcarrot
			_SNQuest._SNFood_HorseList.AddForm(Game.GetFormFromFile(0x0009C5C9, "Hunterborn.esp"))		;petcarrot
			_SNQuest._SNFood_RawList.AddForm(Game.GetFormFromFile(0x0009C5CF, "Hunterborn.esp"))		;petchicken
			_SNQuest._SNFood_RawList.AddForm(Game.GetFormFromFile(0x0009C5D7, "Hunterborn.esp"))		;petmeat
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x000C4E31, "Hunterborn.esp"))		;edibleberry
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x000E8564, "Hunterborn.esp"))		;salmonbake
			_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x000ED667, "Hunterborn.esp"))		;highkingsstew
			_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x000ED66A, "Hunterborn.esp"))		;rarebit
			_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x000ED66C, "Hunterborn.esp"))		;beggarbroth
			_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x000ED66E, "Hunterborn.esp"))		;spidersurprise
			_SNQuest._SNFood_HeavyList.AddForm(Game.GetFormFromFile(0x000ED670, "Hunterborn.esp"))		;goatloin
			_SNQuest._SNFood_HeavyList.AddForm(Game.GetFormFromFile(0x000ED672, "Hunterborn.esp"))		;spotteddog
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x000ED674, "Hunterborn.esp"))		;fishcrabsauce
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x000ED676, "Hunterborn.esp"))		;morthalmudders
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x000ED678, "Hunterborn.esp"))		;oceanskiss
			_SNQuest._SNFood_HeavyList.AddForm(Game.GetFormFromFile(0x000ED67A, "Hunterborn.esp"))		;farmersbreak
			_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x000ED67C, "Hunterborn.esp"))		;woolcoat
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x000ED67E, "Hunterborn.esp"))		;deviledchaurus
			_SNQuest._SNFood_HeavyList.AddForm(Game.GetFormFromFile(0x000ED680, "Hunterborn.esp"))		;fattyfinfry
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x000F2783, "Hunterborn.esp"))		;mashedtroll
			_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x000F2785, "Hunterborn.esp"))		;flamingdragon
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x000F2787, "Hunterborn.esp"))		;mammothballs
			_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x000F2789, "Hunterborn.esp"))		;foxhole
			_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x000F278B, "Hunterborn.esp"))		;predatorsprice
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x000F278D, "Hunterborn.esp"))		;skeeverscramble
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x000F278F, "Hunterborn.esp"))		;bearbeer
			_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x000F2791, "Hunterborn.esp"))		;reachmensoup
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x000F2794, "Hunterborn.esp"))		;sausagedrat
			_SNQuest._SNFood_RawList.AddForm(Game.GetFormFromFile(0x0011AFC8, "Hunterborn.esp"))		;petchickenarctic
			Utility.Wait(1.0)
		EndIf
		_DS_KW_Food_Soup = Game.GetFormFromFile(0x0028CD32, "Hunterborn.esp") as Keyword
		HunterbornInstalled = True
	Else
		HunterbornInstalled = False
	EndIf

	Form GeldallTea = Game.GetFormFromFile(0x00000D62, "HerbalTea.esp")
	If GeldallTea
		If !HerbalTeaInstalled
			_SNQuest._SNFood_DrinkNoAlcList.AddForm(GeldallTea)
			_SNQuest._SNFood_DrinkNoAlcList.AddForm(Game.GetFormFromFile(0x00000D6A, "HerbalTea.esp"))	;caravan
			_SNQuest._SNFood_DrinkNoAlcList.AddForm(Game.GetFormFromFile(0x00000D6B, "HerbalTea.esp"))	;mountain
			_SNQuest._SNFood_DrinkNoAlcList.AddForm(Game.GetFormFromFile(0x00000D6D, "HerbalTea.esp"))	;grayquarter
			_SNQuest._SNFood_DrinkNoAlcList.AddForm(Game.GetFormFromFile(0x00000D6F, "HerbalTea.esp"))	;akaviri
			_SNQuest._SNFood_DrinkNoAlcList.AddForm(Game.GetFormFromFile(0x00000D71, "HerbalTea.esp"))	;orsinian
			_SNQuest._SNFood_DrinkNoAlcList.AddForm(Game.GetFormFromFile(0x00002868, "HerbalTea.esp"))	;sap
			_SNQuest._SNFood_DrinkNoAlcList.AddForm(Game.GetFormFromFile(0x00002869, "HerbalTea.esp"))	;dremora
			_SNQuest._SNFood_DrinkNoAlcList.AddForm(Game.GetFormFromFile(0x0000286F, "HerbalTea.esp"))	;gryphon
			_SNQuest._SNFood_DrinkNoAlcList.AddForm(Game.GetFormFromFile(0x00002870, "HerbalTea.esp"))	;vanus
			_SNQuest._SNFood_DrinkNoAlcList.AddForm(Game.GetFormFromFile(0x00002872, "HerbalTea.esp"))	;efficacy
			_SNQuest._SNFood_DrinkNoAlcList.AddForm(Game.GetFormFromFile(0x00002874, "HerbalTea.esp"))	;stinger
			_SNQuest._SNFood_DrinkNoAlcList.AddForm(Game.GetFormFromFile(0x000038A5, "HerbalTea.esp"))	;kahfee
			_SNQuest._SNFood_DrinkNoAlcList.AddForm(Game.GetFormFromFile(0x000038A6, "HerbalTea.esp"))	;murkmuck
			_SNQuest._SNFood_DrinkNoAlcList.AddForm(Game.GetFormFromFile(0x000038A8, "HerbalTea.esp"))	;tomb
			_SNQuest._SNFood_DrinkNoAlcList.AddForm(Game.GetFormFromFile(0x000038AA, "HerbalTea.esp"))	;ice
			_SNQuest._SNFood_DrinkNoAlcList.AddForm(Game.GetFormFromFile(0x000038AC, "HerbalTea.esp"))	;transcendence
			_SNQuest._SNFood_DrinkNoAlcList.AddForm(Game.GetFormFromFile(0x000038AE, "HerbalTea.esp"))	;crown
			Utility.Wait(1.0)
		EndIf
		HerbalTeaInstalled = True
	Else
		HerbalTeaInstalled = False
	EndIf

	Form CharcoalHikel = Game.GetFormFromFile(0x000084F7, "ImprovedFishBASIC.esp")
	If CharcoalHikel
		If !ImprovedFishInstalled
			_SNQuest._SNFood_RawList.AddForm(CharcoalHikel)
			_SNQuest._SNFood_RawList.AddForm(Game.GetFormFromFile(0x00008FC3, "ImprovedFishBASIC.esp"))	;amago
			_SNQuest._SNFood_RawList.AddForm(Game.GetFormFromFile(0x00008FC7, "ImprovedFishBASIC.esp"))	;amur catfish
			_SNQuest._SNFood_RawList.AddForm(Game.GetFormFromFile(0x00009A8F, "ImprovedFishBASIC.esp"))	;ayu
			_SNQuest._SNFood_RawList.AddForm(Game.GetFormFromFile(0x00009A93, "ImprovedFishBASIC.esp"))	;herabuna
			_SNQuest._SNFood_RawList.AddForm(Game.GetFormFromFile(0x00009A97, "ImprovedFishBASIC.esp"))	;flathead
			_SNQuest._SNFood_RawList.AddForm(Game.GetFormFromFile(0x00009A9B, "ImprovedFishBASIC.esp"))	;carp
			_SNQuest._SNFood_RawList.AddForm(Game.GetFormFromFile(0x00009A9F, "ImprovedFishBASIC.esp"))	;cherry
			_SNQuest._SNFood_RawList.AddForm(Game.GetFormFromFile(0x00009AA3, "ImprovedFishBASIC.esp"))	;dolly
			_SNQuest._SNFood_RawList.AddForm(Game.GetFormFromFile(0x00009AA7, "ImprovedFishBASIC.esp"))	;large mouth
			_SNQuest._SNFood_RawList.AddForm(Game.GetFormFromFile(0x00009AAB, "ImprovedFishBASIC.esp"))	;rainbow
			_SNQuest._SNFood_RawList.AddForm(Game.GetFormFromFile(0x00009AAF, "ImprovedFishBASIC.esp"))	;blue gill
			_SNQuest._SNFood_RawList.AddForm(Game.GetFormFromFile(0x00009AB7, "ImprovedFishBASIC.esp"))	;three spined
			_SNQuest._SNFood_RawList.AddForm(Game.GetFormFromFile(0x00009ABB, "ImprovedFishBASIC.esp"))	;tanago
			_SNQuest._SNFood_RawList.AddForm(Game.GetFormFromFile(0x00009ABF, "ImprovedFishBASIC.esp"))	;yellowfin
			_SNQuest._SNFood_RawList.AddForm(Game.GetFormFromFile(0x0000A025, "ImprovedFishBASIC.esp"))	;white spotted
			_SNQuest._SNFood_RawList.AddForm(Game.GetFormFromFile(0x0000A1ED, "ImprovedFishBASIC.esp"))	;tiger trout
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x0000A1EE, "ImprovedFishBASIC.esp"))	;tiger trout
			_SNQuest._SNFood_RawList.AddForm(Game.GetFormFromFile(0x0000A58A, "ImprovedFishBASIC.esp"))	;oriental
			_SNQuest._SNFood_RawList.AddForm(Game.GetFormFromFile(0x0000AAEE, "ImprovedFishBASIC.esp"))	;bocaccio
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x0000B053, "ImprovedFishBASIC.esp"))	;cherry
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x0000B055, "ImprovedFishBASIC.esp"))	;amago
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x0000B058, "ImprovedFishBASIC.esp"))	;amur
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x0000B05B, "ImprovedFishBASIC.esp"))	;ayu
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x0000CB79, "ImprovedFishBASIC.esp"))	;blue gill
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x0000D0DE, "ImprovedFishBASIC.esp"))	;bocaccio
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x0000D0E1, "ImprovedFishBASIC.esp"))	;carp
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x0000D0E4, "ImprovedFishBASIC.esp"))	;charcoal
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x0000D0E6, "ImprovedFishBASIC.esp"))	;dolly
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x0000D0E9, "ImprovedFishBASIC.esp"))	;flathead
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x0000D0ED, "ImprovedFishBASIC.esp"))	;herabuna
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x0000D0EF, "ImprovedFishBASIC.esp"))	;large mouth
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x0000D0F2, "ImprovedFishBASIC.esp"))	;oriental
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x0000D0F6, "ImprovedFishBASIC.esp"))	;rainbow
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x0000D0F8, "ImprovedFishBASIC.esp"))	;tanago
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x0000D0FB, "ImprovedFishBASIC.esp"))	;three spined
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x0000D0FF, "ImprovedFishBASIC.esp"))	;white spotted
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x0000D664, "ImprovedFishBASIC.esp"))	;yellowfin
			Utility.Wait(1.0)
		EndIf
		ImprovedFishInstalled = True
	Else
		ImprovedFishInstalled = False
	EndIf

	Form BestialStew = Game.GetFormFromFile(0x002897D4, "Requiem.esp")
	If BestialStew
		If !RequiemInstalled
			_SNQuest._SNFood_RawList.AddForm(BestialStew)
			_SNQuest._SNFood_DrinkNoAlcList.AddForm(Game.GetFormFromFile(0x0003DFE8, "Requiem.esp"))	;water
			_SNQuest._SNFood_DrinkList.AddForm(Game.GetFormFromFile(0x00AD3910, "Requiem.esp"))			;cinnabar beer
			_SNQuest._SNFood_RawList.AddForm(Game.GetFormFromFile(0x00030D05, "Requiem.esp"))			;skeever meat
			_SNQuest._SNFood_RawList.AddForm(Game.GetFormFromFile(0x00284894, "Requiem.esp"))			;strange meat
			_SNQuest.EnableAlcohol = False
			_SNQuest.EnableSkooma = False
		EndIf
		RequiemInstalled = True
	Else
		RequiemInstalled = False
	EndIf

	Form RawBearMeat_1 = Game.GetFormFromFile(0x00000D6D, "Realistic Wildlife Loot - Realistic.esp")
	Form RawBearMeat_2 = Game.GetFormFromFile(0x00000D6D, "Realistic Wildlife Loot - Reduced.esp")
	If RawBearMeat_1
		SetWildLoot(RawBearMeat_1, "Realistic Wildlife Loot - Realistic.esp")
	ElseIf RawBearMeat_2
		SetWildLoot(RawBearMeat_2, "Realistic Wildlife Loot - Reduced.esp")
	Else
		WildLootInstalled = False
	EndIf

	Form FoxMeat = Game.GetFormFromFile(0x000048B8, "HarvestOverhaulCreatures.esp")
	If FoxMeat
		If !HarvestOverhaulInstalled
			_SNQuest._SNFood_RawList.AddForm(FoxMeat)
			_SNQuest._SNFood_RawList.AddForm(Game.GetFormFromFile(0x000048BE, "HarvestOverhaulCreatures.esp"))		;skeever
			_SNQuest._SNFood_RawList.AddForm(Game.GetFormFromFile(0x000048C0, "HarvestOverhaulCreatures.esp"))		;wolf
			_SNQuest._SNFood_RawList.AddForm(Game.GetFormFromFile(0x000048C4, "HarvestOverhaulCreatures.esp"))		;sabre
			_SNQuest._SNFood_RawList.AddForm(Game.GetFormFromFile(0x000048C8, "HarvestOverhaulCreatures.esp"))		;bear
			_SNQuest._SNFood_HeavyList.AddForm(Game.GetFormFromFile(0x000048CA, "HarvestOverhaulCreatures.esp"))	;roastedbear
			_SNQuest._SNFood_RawList.AddForm(Game.GetFormFromFile(0x000048CC, "HarvestOverhaulCreatures.esp"))		;mammoth
			_SNQuest._SNFood_HeavyList.AddForm(Game.GetFormFromFile(0x00004E6B, "HarvestOverhaulCreatures.esp"))	;roasted mammoth
			_SNQuest._SNFood_RawList.AddForm(Game.GetFormFromFile(0x000053DA, "HarvestOverhaulCreatures.esp"))		;slaughter
			_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x0000698D, "HarvestOverhaulCreatures.esp"))		;man's best stew
			_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x0000699B, "HarvestOverhaulCreatures.esp"))		;bosmer surprise
			_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x00006F03, "HarvestOverhaulCreatures.esp"))		;woodsman
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x0000AFC5, "HarvestOverhaulCreatures.esp"))	;hardboiled egg
			_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x00050856, "HarvestOverhaulCreatures.esp"))		;question
			_SNQuest._SNFood_RawList.AddForm(Game.GetFormFromFile(0x0005085A, "HarvestOverhaulCreatures.esp"))		;tern
			_SNQuest._SNFood_RawList.AddForm(Game.GetFormFromFile(0x0005085C, "HarvestOverhaulCreatures.esp"))		;hawk
			_SNQuest._SNFood_HeavyList.AddForm(Game.GetFormFromFile(0x00050862, "HarvestOverhaulCreatures.esp"))	;stuffed gourd
			_SNQuest._SNFood_HeavyList.AddForm(Game.GetFormFromFile(0x0005596C, "HarvestOverhaulCreatures.esp"))	;basted chaurus
			_SNQuest._SNFood_HeavyList.AddForm(Game.GetFormFromFile(0x0005596E, "HarvestOverhaulCreatures.esp"))	;pie chaurus
			_SNQuest._SNFood_HeavyList.AddForm(Game.GetFormFromFile(0x00055972, "HarvestOverhaulCreatures.esp"))	;chaurus
			_SNQuest._SNFood_HeavyList.AddForm(Game.GetFormFromFile(0x0007E18A, "HarvestOverhaulCreatures.esp"))	;ash hopper
			Form NewRaw_1 = Game.GetFormFromFile(0x000C4FA7, "HarvestOverhaulCreatures.esp")
			If NewRaw_1
				_SNQuest._SNFood_RawList.AddForm(NewRaw_1)
				_SNQuest._SNFood_RawList.AddForm(Game.GetFormFromFile(0x000C4FA9, "HarvestOverhaulCreatures.esp"))
				_SNQuest._SNFood_RawList.AddForm(Game.GetFormFromFile(0x000C4FAB, "HarvestOverhaulCreatures.esp"))
			EndIf
		EndIf
		HarvestOverhaulInstalled = True
	Else
		HarvestOverhaulInstalled = False
	EndIf

	Form BarChocolate = Game.GetFormFromFile(0x00001831, "Osare Food.esp")
	If BarChocolate
		If !OsareFoodInstalled
			_SNQuest._SNFood_LightList.AddForm(BarChocolate)
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x00000D63, "Osare Food.esp"))		;beef curry
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x00002DC6, "Osare Food.esp"))		;chocdonut
			_SNQuest._SNFood_DrinkNoAlcList.AddForm(Game.GetFormFromFile(0x000063BB, "Osare Food.esp"))	;coffee
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x00004E27, "Osare Food.esp"))		;flan
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x000048C2, "Osare Food.esp"))		;fries
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x00003893, "Osare Food.esp"))		;friedegg
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x00006920, "Osare Food.esp"))		;hamburger
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x0000435D, "Osare Food.esp"))		;laputa
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x0000332E, "Osare Food.esp"))		;laver
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x0000538C, "Osare Food.esp"))		;spaghetti
			_SNQuest._SNFood_DrinkNoAlcList.AddForm(Game.GetFormFromFile(0x00001D94, "Osare Food.esp"))	;milk
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x00005E56, "Osare Food.esp"))		;onion
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x0000332B, "Osare Food.esp"))		;rice
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x000012CC, "Osare Food.esp"))		;rice salmon
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x000058F1, "Osare Food.esp"))		;steak
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x00000D62, "Osare Food.esp"))		;sushisalmon
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x00003DF8, "Osare Food.esp"))		;toast
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x00000D64, "Osare Food.esp"))		;unaju
		EndIf
		OsareFoodInstalled = True
	Else
		OsareFoodInstalled = False
	EndIf

	Form Skittles = Game.GetFormFromFile(0x00000D65, "DeliciousCake.esp")
	If Skittles
		If !FiveTwoSevenInstalled
			_SNQuest._SNFood_LightList.AddForm(Skittles)
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x000012CF, "DeliciousCake.esp"))		;strawberry pie
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x00001D9B, "DeliciousCake.esp"))		;invis loaf
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x00001DA3, "DeliciousCake.esp"))	;purp donut
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x00006CDF, "DeliciousCake.esp"))	;choc
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x00009481, "DeliciousCake.esp"))	;dark choc
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x00009489, "DeliciousCake.esp"))	;white choc
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x00009491, "DeliciousCake.esp"))	;cookie
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x0000BC33, "DeliciousCake.esp"))	;blacktart
		EndIf
		FiveTwoSevenInstalled = True
	Else
		FiveTwoSevenInstalled = False
	EndIf

	Form Soln = Game.GetFormFromFile(0x0240ADC8, "Wyrmstooth.esp")
	If Soln
		If !WyrmstoothInstalled
			_SNQuest._SNFood_DrinkList.AddForm(Soln)
			_SNQuest._SNFood_DrinkList.AddForm(Game.GetFormFromFile(0x0240AE43, "Wyrmstooth.esp"))	;ichor
			_SNQuest._SNFood_DrinkList.AddForm(Game.GetFormFromFile(0x0240D1B3, "Wyrmstooth.esp"))	;greef
		EndIf
		WyrmstoothInstalled = True
	Else
		WyrmstoothInstalled = False
	EndIf

	_SNQuest.DFSFountain = Game.GetFormFromFile(0x00002E71, "Drinking Fountains of Skyrim.esp") as Activator
	If _SNQuest.DFSFountain
		If !_SNQuest.DFSInstalled
			_SNQuest._SNFood_DrinkNoAlcList.AddForm(Game.GetFormFromFile(0x00002E6F, "Drinking Fountains of Skyrim.esp"))
		EndIf
		_SNQuest.DFSInstalled = True
	Else
		_SNQuest.DFSInstalled = False
	EndIf

	Form RawDisBearMeat = Game.GetFormFromFile(0x00001003, "Real Wildlife Skyrim 0.1.esp")
	If RawDisBearMeat
		If !RealWildSkyrimInstalled
			_SNQuest._SNFood_RawList.AddForm(RawDisBearMeat)
			_SNQuest._SNFood_RawList.AddForm(Game.GetFormFromFile(0x0000100D, "Real Wildlife Skyrim 0.1.esp"))		;diseasedwolf
			_SNQuest._SNFood_RawList.AddForm(Game.GetFormFromFile(0x0000100E, "Real Wildlife Skyrim 0.1.esp"))		;rawsaber
			_SNQuest._SNFood_RawList.AddForm(Game.GetFormFromFile(0x0000100F, "Real Wildlife Skyrim 0.1.esp"))		;rawbear
			_SNQuest._SNFood_RawList.AddForm(Game.GetFormFromFile(0x00001010, "Real Wildlife Skyrim 0.1.esp"))		;hawkbreast
			_SNQuest._SNFood_RawList.AddForm(Game.GetFormFromFile(0x00001011, "Real Wildlife Skyrim 0.1.esp"))		;wolfmeat
			_SNQuest._SNFood_RawList.AddForm(Game.GetFormFromFile(0x00001012, "Real Wildlife Skyrim 0.1.esp"))		;mammothmeat
			_SNQuest._SNFood_RawList.AddForm(Game.GetFormFromFile(0x00001014, "Real Wildlife Skyrim 0.1.esp"))		;rawsabermeat
			_SNQuest._SNFood_RawList.AddForm(Game.GetFormFromFile(0x00001018, "Real Wildlife Skyrim 0.1.esp"))		;giant
			_SNQuest._SNFood_RawList.AddForm(Game.GetFormFromFile(0x0000101F, "Real Wildlife Skyrim 0.1.esp"))		;fox
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x0000102C, "Real Wildlife Skyrim 0.1.esp"))		;cookedbear
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x0000102D, "Real Wildlife Skyrim 0.1.esp"))		;cookedsabre
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x0000102E, "Real Wildlife Skyrim 0.1.esp"))		;roastdog
			_SNQuest._SNFood_HeavyList.AddForm(Game.GetFormFromFile(0x0000102F, "Real Wildlife Skyrim 0.1.esp"))	;mammothmeatloaf
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x00001030, "Real Wildlife Skyrim 0.1.esp"))		;roastedwolf
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x00001032, "Real Wildlife Skyrim 0.1.esp"))		;roastedfox
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x00001033, "Real Wildlife Skyrim 0.1.esp"))		;grilledhawk
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x00001034, "Real Wildlife Skyrim 0.1.esp"))		;roastedgiant
			_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x00001035, "Real Wildlife Skyrim 0.1.esp"))		;mammothstew
			_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x00001036, "Real Wildlife Skyrim 0.1.esp"))		;elsweyrstew
			_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x00001037, "Real Wildlife Skyrim 0.1.esp"))		;hunter'shotpot
			_SNQuest._SNFood_RawList.AddForm(Game.GetFormFromFile(0x000170FE, "Real Wildlife Skyrim 0.1.esp"))		;grouse
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x00017100, "Real Wildlife Skyrim 0.1.esp"))		;grilledgrouse
			_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x0001CED7, "Real Wildlife Skyrim 0.1.esp"))		;tripestew
			Utility.Wait(1.0)
		EndIf
		RealWildSkyrimInstalled = True
	Else
		RealWildSkyrimInstalled = False
	EndIf

	Form NordicJerky = Game.GetFormFromFile(0x00000D62, "NordicCooking.esp")
	If NordicJerky
		If !NordicCookingInstalled
			_SNQuest._SNFood_LightList.AddForm(NordicJerky)
			_SNQuest._SNFood_NoSpoilList.AddForm(NordicJerky)
			_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x00000D63, "NordicCooking.esp"))		;beefstew
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x00000D65, "NordicCooking.esp"))			;mammothcheesesteak
			_SNQuest._SNFood_DrinkList.AddForm(Game.GetFormFromFile(0x00000D67, "NordicCooking.esp"))		;redapplecider
			_SNQuest._SNFood_DrinkNoAlcList.AddForm(Game.GetFormFromFile(0x00000D69, "NordicCooking.esp"))	;carrotjuice
			_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x000012EF, "NordicCooking.esp"))		;horkerstew
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x00001856, "NordicCooking.esp"))			;hash
			_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x00002322, "NordicCooking.esp"))		;cheesesoup
			_SNQuest._SNFood_DrinkList.AddForm(Game.GetFormFromFile(0x00003349, "NordicCooking.esp"))		;greenappleale
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x000038B0, "NordicCooking.esp"))			;salmonsalad
			_SNQuest._SNFood_HeavyList.AddForm(Game.GetFormFromFile(0x000038B3, "NordicCooking.esp"))		;roastedgoat
			_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x000038B6, "NordicCooking.esp"))		;clamchowder
			_SNQuest._SNFood_HeavyList.AddForm(Game.GetFormFromFile(0x000038B9, "NordicCooking.esp"))		;roastedgourd
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x000038BC, "NordicCooking.esp"))			;roastedchicken
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x00003E24, "NordicCooking.esp"))			;smokedsalmon
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x000048EB, "NordicCooking.esp"))			;cheesehero
			_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x00004E51, "NordicCooking.esp"))		;venisonstew
			_SNQuest._SNFood_DrinkNoAlcList.AddForm(Game.GetFormFromFile(0x000053B9, "NordicCooking.esp"))	;coffee
			_SNQuest._SNFood_DrinkNoAlcList.AddForm(Game.GetFormFromFile(0x000053BF, "NordicCooking.esp"))	;tea
			_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x00005924, "NordicCooking.esp"))		;chickensoup
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x00005E8A, "NordicCooking.esp"))			;veggiehero
			_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x00005E8D, "NordicCooking.esp"))		;veggiestew
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x00005E91, "NordicCooking.esp"))			;salad
			_SNQuest._SNFood_DrinkList.AddForm(Game.GetFormFromFile(0x00009478, "NordicCooking.esp"))		;redapplewine
			_SNQuest._SNFood_DrinkList.AddForm(Game.GetFormFromFile(0x00009479, "NordicCooking.esp"))		;greenapplewine
		EndIf
		NordicCookingInstalled = True
	Else
		NordicCookingInstalled = False
	EndIf

	Form GrilledSilverside = Game.GetFormFromFile(0x00000D62, "SL00CookingIngredient.esp")
	If GrilledSilverside
		If !CookingIngredientsInstalled
			_SNQuest._SNFood_MedList.AddForm(GrilledSilverside)
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x00000D64, "SL00CookingIngredient.esp"))		;riverbetty
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x00000D65, "SL00CookingIngredient.esp"))		;cyrodilic
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x00000D66, "SL00CookingIngredient.esp"))		;histcarp
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x00000D68, "SL00CookingIngredient.esp"))		;abecean
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x00000D71, "SL00CookingIngredient.esp"))		;moratap
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x00000D74, "SL00CookingIngredient.esp"))		;steamedmudcrab
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x00001D9E, "SL00CookingIngredient.esp"))			;chauruspie
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x00002DC6, "SL00CookingIngredient.esp"))		;chaurusegg
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x00002DC8, "SL00CookingIngredient.esp"))		;slaughterfishegg
			_SNQuest._SNFood_DrinkNoAlcList.AddForm(Game.GetFormFromFile(0x0000332E, "SL00CookingIngredient.esp"))	;canisroottea
			_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x00003899, "SL00CookingIngredient.esp"))		;potage1
			_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x0000389B, "SL00CookingIngredient.esp"))		;potage2
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x00003DFF, "SL00CookingIngredient.esp"))			;glowingmushroom
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x0000538D, "SL00CookingIngredient.esp"))		;scalypholiota
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x00005E53, "SL00CookingIngredient.esp"))		;jamsnoberry
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x000063B8, "SL00CookingIngredient.esp"))		;jamjazbay
			_SNQuest._SNFood_HeavyList.AddForm(Game.GetFormFromFile(0x0000691E, "SL00CookingIngredient.esp"))		;slaughterfish
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x00006E83, "SL00CookingIngredient.esp"))			;chaurusmeat
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x000073E8, "SL00CookingIngredient.esp"))		;flyamanita
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x000073EA, "SL00CookingIngredient.esp"))		;whitecap
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x000073EC, "SL00CookingIngredient.esp"))		;impstool
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x00007953, "SL00CookingIngredient.esp"))		;flyamanitaroast
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x00007956, "SL00CookingIngredient.esp"))		;blisterwort
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x00007957, "SL00CookingIngredient.esp"))		;namirasrotgrilled
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x00007959, "SL00CookingIngredient.esp"))		;namirasrotroast
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x0000795E, "SL00CookingIngredient.esp"))		;blisterwortroast
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x00007EC8, "SL00CookingIngredient.esp"))		;whitecaproast
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x0000842C, "SL00CookingIngredient.esp"))		;clammeatgrilled
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x00008431, "SL00CookingIngredient.esp"))			;beefcooked
			_SNQuest._SNFood_HeavyList.AddForm(Game.GetFormFromFile(0x00008433, "SL00CookingIngredient.esp"))		;venisoncooked
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x00008999, "SL00CookingIngredient.esp"))		;briarheartgrilled
			_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x0000899A, "SL00CookingIngredient.esp"))		;heartstew
		EndIf
		CookingIngredientsInstalled = True
	Else
		CookingIngredientsInstalled = False
	EndIf

	Form GooseCooked_1 = Game.GetFormFromFile(0x0001B219, "Farm Animals.esp")
	Form GooseCooked_2 = Game.GetFormFromFile(0x0001B219, "Farm Animals_HF.esp")
	If GooseCooked_1
		SetFarmAnimals(GooseCooked_1, "Farm Animals.esp")
	ElseIf GooseCooked_2
		SetFarmAnimals(GooseCooked_2, "Farm Animals_HF.esp")
	Else
		FarmAnimalsInstalled = False
	EndIf

	Milk_1 = Game.GetFormFromFile(0x00000D62, "MilkSSE.esp")
	Milk_2 = Game.GetFormFromFile(0x00000D62, "Milk.esp")
	If Milk_1
		SetMilk(Milk_1, "MilkSSE.esp")
	ElseIf Milk_2
		SetMilk(Milk_2, "Milk.esp")
	Else
		MilkDrinkerInstalled = False
	EndIf

	_SNQuest._SNMagicEffect_CureList.AddForm(Game.GetFormFromFile(0x000389BB, "PerkusMaximus_Master.esp"))
	
	If (Game.GetFormFromFile(0x004E3D31, "Complete Alchemy & Cooking Overhaul.esp") as Bool)
		CACOInstalled = True
	Else
		CACOInstalled = False
	EndIf
	
	Form AtlanticCodCooked = Game.GetFormFromFile(0x0000087A, "ccBGSSSE001-Fish.esm")
	If AtlanticCodCooked
		If !CCFishInstalled
			_SNQuest._SNFood_MedList.AddForm(AtlanticCodCooked)
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x0000087B, "ccBGSSSE001-Fish.esm"))	;Austrolebias
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x0000087C, "ccBGSSSE001-Fish.esm"))	;BucketFish
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x0000087D, "ccBGSSSE001-Fish.esm"))	;Cabezon
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x0000087E, "ccBGSSSE001-Fish.esm"))	;Carp
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x0000087F, "ccBGSSSE001-Fish.esm"))	;CuckooCatfish
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x00000880, "ccBGSSSE001-Fish.esm"))	;Dragonfish
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x00000881, "ccBGSSSE001-Fish.esm"))	;FlameAngel
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x00000882, "ccBGSSSE001-Fish.esm"))	;GlassCatfish
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x00000883, "ccBGSSSE001-Fish.esm"))	;Goldfish
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x00000884, "ccBGSSSE001-Fish.esm"))	;LyretailAnthias
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x00000885, "ccBGSSSE001-Fish.esm"))	;PygmySunfish
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x00000886, "ccBGSSSE001-Fish.esm"))	;PinnateSpadefish
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x00000887, "ccBGSSSE001-Fish.esm"))	;TripodFish
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x00000888, "ccBGSSSE001-Fish.esm"))	;VampireFish
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x0000088A, "ccBGSSSE001-Fish.esm"))	;TunaSalmon
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x0000088C, "ccBGSSSE001-Fish.esm"))	;ArcticGrayling
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x0000088D, "ccBGSSSE001-Fish.esm"))	;ArcticChar
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x0000088E, "ccBGSSSE001-Fish.esm"))	;AnglerLarvae
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x0000088F, "ccBGSSSE001-Fish.esm"))	;AsiaticGlassfish
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x000008A5, "ccBGSSSE001-Fish.esm"))	;Angler
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x00000F78, "ccBGSSSE001-Fish.esm"))	;CrabCakes
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x0000089A, "ccBGSSSE001-Fish.esm"))	;JuvenileMudcrab
			Utility.Wait(1.0)
			_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x00000F02, "ccBGSSSE001-Fish.esm"))	;SoupCreamy
			_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x00000F04, "ccBGSSSE001-Fish.esm"))	;SoupTomatoCrabBisque
			_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x00000F06, "ccBGSSSE001-Fish.esm"))	;SoupPotatoCrabChowder
			_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x00000F0A, "ccBGSSSE001-Fish.esm"))	;SoupCreamyCrabHOT
			_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x00000F0B, "ccBGSSSE001-Fish.esm"))	;SoupPotatoCrabChowderHOT
			_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x00000F0C, "ccBGSSSE001-Fish.esm"))	;SoupTomatoCrabBisqueHOT
			_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x00000F76, "ccBGSSSE001-Fish.esm"))	;SoupCrabStew
			_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x00000F77, "ccBGSSSE001-Fish.esm"))	;SoupCrabStewHOT
			_SNQuest._SNFood_RawList.AddForm(Game.GetFormFromFile(0x0000088B, "ccBGSSSE001-Fish.esm"))	;Raw_VampireFish
			_SNQuest._SNFood_RawList.AddForm(Game.GetFormFromFile(0x00000890, "ccBGSSSE001-Fish.esm"))	;Raw_Angler
			_SNQuest._SNFood_RawList.AddForm(Game.GetFormFromFile(0x00000891, "ccBGSSSE001-Fish.esm"))	;Raw_TunaSalmon
			_SNQuest._SNFood_RawList.AddForm(Game.GetFormFromFile(0x00000896, "ccBGSSSE001-Fish.esm"))	;Raw_Dragonfish
			_SNQuest._SNFood_RawList.AddForm(Game.GetFormFromFile(0x00000897, "ccBGSSSE001-Fish.esm"))	;Raw_CuckooCatfish
			_SNQuest._SNFood_RawList.AddForm(Game.GetFormFromFile(0x00000898, "ccBGSSSE001-Fish.esm"))	;Raw_Carp
			_SNQuest._SNFood_RawList.AddForm(Game.GetFormFromFile(0x0000089B, "ccBGSSSE001-Fish.esm"))	;Raw_Salmon
			_SNQuest._SNFood_RawList.AddForm(Game.GetFormFromFile(0x0000089C, "ccBGSSSE001-Fish.esm"))	;Raw_BucketFish
			_SNQuest._SNFood_RawList.AddForm(Game.GetFormFromFile(0x0000089E, "ccBGSSSE001-Fish.esm"))	;Raw_TripodFish
			_SNQuest._SNFood_RawList.AddForm(Game.GetFormFromFile(0x000008A0, "ccBGSSSE001-Fish.esm"))	;Raw_GlassCatfish
			_SNQuest._SNFood_RawList.AddForm(Game.GetFormFromFile(0x000008A1, "ccBGSSSE001-Fish.esm"))	;Raw_Cabezon
			_SNQuest._SNFood_RawList.AddForm(Game.GetFormFromFile(0x000008A2, "ccBGSSSE001-Fish.esm"))	;Raw_AtlanticCod
			_SNQuest._SNFood_RawList.AddForm(Game.GetFormFromFile(0x000008A3, "ccBGSSSE001-Fish.esm"))	;Raw_ArcticGrayling
			_SNQuest._SNFood_RawList.AddForm(Game.GetFormFromFile(0x000008A4, "ccBGSSSE001-Fish.esm"))	;Raw_ArcticChar
			_SNQuest._SNFood_RawList.AddForm(Game.GetFormFromFile(0x00000EFE, "ccBGSSSE001-Fish.esm"))	;Raw_CrabMeat
			_SNQuest._SNFood_RawList.AddForm(Game.GetFormFromFile(0x00000F25, "ccBGSSSE001-Fish.esm"))	;Raw_Slaughterfish
			_SNQuest._SNFood_DrinkList.AddForm(Game.GetFormFromFile(0x00000C2D, "ccBGSSSE001-Fish.esm"))	;Khajiit_AgedFlin
			Utility.Wait(1.0)
		EndIf
		CCFishInstalled = True
	Else
		CCFishInstalled = False
	EndIf

	Form SAFOBottledWater = Game.GetFormFromFile(0x0069ECD4, "SAFO.esp")
	If SAFOBottledWater
		If !SAFOInstalled
			_SNQuest._SNFood_DrinkNoAlcList.AddForm(SAFOBottledWater)
			_SNQuest._SNFood_DrinkNoAlcList.AddForm(Game.GetFormFromFile(0x0069ECD3, "SAFO.esp"))	;Bottled Milk
			_SNQuest._SNFood_DrinkNoAlcList.AddForm(Game.GetFormFromFile(0x0000B03A, "SAFO.esp"))	;Cow Milk
			_SNQuest._SNFood_DrinkNoAlcList.AddForm(Game.GetFormFromFile(0x0000B03A, "SAFO.esp"))	;Goat Milk
			_SNQuest._SNFood_DrinkNoAlcList.AddForm(Game.GetFormFromFile(0x0000B03E, "SAFO.esp"))	;Mammoth Milk
			_SNQuest._SNFood_DrinkNoAlcList.AddForm(Game.GetFormFromFile(0x00009483, "SAFO.esp"))	;Apple Juice
			_SNQuest._SNFood_DrinkNoAlcList.AddForm(Game.GetFormFromFile(0x0000B041, "SAFO.esp"))	;Watermelon Juice
			_SNQuest._SNFood_DrinkNoAlcList.AddForm(Game.GetFormFromFile(0x0000947F, "SAFO.esp"))	;Peach Juice
			Utility.Wait(1.0)
		EndIf
		SAFOInstalled = True
	Else
		SAFOInstalled = False
	EndIf
	
EndFunction