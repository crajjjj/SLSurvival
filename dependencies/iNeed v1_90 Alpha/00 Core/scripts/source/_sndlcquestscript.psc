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

_SNQuestScript Property _SNQuest Auto

Bool Property WildLootInstalled Auto
Bool USKPatchInstalled
Bool HearthfiresInstalled
Bool DawnguardInstalled
Bool DragonbornInstalled
Bool CFInstalled
Bool FalskaarInstalled
Bool CookingExpandInstalled
Bool HunterbornInstalled
Bool HerbalTeaInstalled
Bool ImprovedFishInstalled
Bool BabetteInstalled
Bool MilkDrinkerInstalled
Bool RequiemInstalled
Bool sky_BirdsInstalled
Bool PhittOverhaulInstalled
Bool NernieCityInstalled
Bool ETACISInstalled
Bool HarvestOverhaulInstalled
Bool OsareFoodInstalled
Bool FiveTwoSevenInstalled
Bool WyrmstoothInstalled
Bool Bon_AppetitInstalled
Bool DrinksThirstyInstalled
Bool HighlandFarmInstalled
Bool RealWildSkyrimInstalled
Bool FarmAnimalsInstalled
Bool GromitInstalled
Bool ZFOInstalled
Bool SpecialFloraInstalled
Bool NordicCookingInstalled
Bool DovahCookInstalled
Bool AnotherRecipeInstalled
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

Function SetNern(Form WhiteBread, String NernPlugin)
	If !NernieCityInstalled
		_SNQuest._SNFood_MedList.AddForm(WhiteBread)
		_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x00001B31, NernPlugin))				;barleybread
		_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x00001B33, NernPlugin))				;nutbread
		_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x00001B35, NernPlugin))				;spicecake
		_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x00001B37, NernPlugin))				;blackbread
		_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x00001B3B, NernPlugin))			;currantbiscuit
		_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x00001B3D, NernPlugin))			;honeybiscuit
		_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x00001B3F, NernPlugin))				;tart
		_SNQuest._SNFood_HeavyList.AddForm(Game.GetFormFromFile(0x00001B41, NernPlugin))				;beefalepie
		_SNQuest._SNFood_HeavyList.AddForm(Game.GetFormFromFile(0x00001B43, NernPlugin))				;gamepie
		_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x000020C3, NernPlugin))			;licorice
		_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x000020C6, NernPlugin))			;sugar
		_SNQuest._SNFood_HeavyList.AddForm(Game.GetFormFromFile(0x000020C9, NernPlugin))			;sicedhaafcheese
		_SNQuest._SNFood_HeavyList.AddForm(Game.GetFormFromFile(0x000020CA, NernPlugin))			;sicedivarcheese
		_SNQuest._SNFood_HeavyList.AddForm(Game.GetFormFromFile(0x000020CC, NernPlugin))			;sicedrorikcheese
		_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x000020D6, NernPlugin))				;porridge
		_SNQuest._SNFood_HeavyList.AddForm(Game.GetFormFromFile(0x00002C40, NernPlugin))			;haafcheesewheel
		_SNQuest._SNFood_HeavyList.AddForm(Game.GetFormFromFile(0x00002C41, NernPlugin))			;ivarcheesewheel
		_SNQuest._SNFood_HeavyList.AddForm(Game.GetFormFromFile(0x00002C43, NernPlugin))			;rorikcheesewheel
		_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x00002C45, NernPlugin))				;Haafcheese
		_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x00002C47, NernPlugin))				;ivarcheese
		_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x00002C49, NernPlugin))				;rorikcheese
		_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x00007F6A, NernPlugin))				;fish stew
		_SNQuest._SNFood_DrinkNoAlcList.AddForm(Game.GetFormFromFile(0x0000E08E, NernPlugin))		;cider
		_SNQuest._SNFood_DrinkList.AddForm(Game.GetFormFromFile(0x00018A4A, NernPlugin))			;black wine
		_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x0001AA2E, NernPlugin))				;gourd and carrot stew
		_SNQuest._SNFood_DrinkNoAlcList.AddForm(Game.GetFormFromFile(0x0001D77E, NernPlugin))		;barley tea
		_SNQuest._SNFood_DrinkNoAlcList.AddForm(Game.GetFormFromFile(0x0001DCEB, NernPlugin))		;milk
		_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x000242DE, NernPlugin))				;grilledfish
		Utility.Wait(1.0)
	EndIf
	NernieCityInstalled = True
EndFunction

Function SetBF(Form Wayrest, String BFPlugin)
	If !BabetteInstalled
		_SNQuest._SNFood_SoupList.AddForm(Wayrest)
		_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x00001001, BFPlugin))		;spadetail
		_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x00001002, BFPlugin))		;jehannoise
		_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x00001003, BFPlugin))		;clam
		_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x00001004, BFPlugin))		;snowberry pie
		_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x00001005, BFPlugin))		;coq
		_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x00001006, BFPlugin))		;soupe
		_SNQuest._SNFood_DrinkNoAlcList.AddForm(Game.GetFormFromFile(0x00001007, BFPlugin))	;milk
		_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x00001008, BFPlugin))		;beef stro
		_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x00001009, BFPlugin))		;glenpoint pit
		_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x00001010, BFPlugin))		;mushroom
		_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x00001011, BFPlugin))	;gravlaks
		Utility.Wait(1.0)
	EndIf
	BabetteInstalled = True
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
		_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x0000E006, MilkPlugin))	;cheese wedge
		_SNQuest._SNFood_HeavyList.AddForm(Game.GetFormFromFile(0x0000E007, MilkPlugin))	;cheese wheel
		_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x0000E009, MilkPlugin))	;sliced cheese
		If Milk_1
			_SNQuest._SNFood_DrinkList.AddForm(Game.GetFormFromFile(0x0000FAFE, MilkPlugin))	;canis root tea
		Else
			_SNQuest._SNFood_DrinkList.AddForm(Game.GetFormFromFile(0x0000EAD3, MilkPlugin))
		EndIf
		Utility.Wait(1.0)
	EndIf
	MilkDrinkerInstalled = True
EndFunction

Function SetClam(Form ClamStew, String PhittPlugin)
	If !PhittOverhaulInstalled
		_SNQuest._SNFood_SoupList.AddForm(ClamStew)
		_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x0001051F, PhittPlugin))
		_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x00010521, PhittPlugin))
		_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x00010A87, PhittPlugin))
		_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x00010FEA, PhittPlugin))
	EndIf
	PhittOverhaulInstalled = True
EndFunction

Function SetWildLoot(Form RawBearMeat, String WildLootPlugin)
	If !WildLootInstalled
		_SNQuest._SNFood_RawList.AddForm(RawBearMeat)
		_SNQuest._SNFood_RawList.AddForm(Game.GetFormFromFile(0x00000D73, WildLootPlugin))	;raw skeever meat
		_SNQuest._SNFood_RawList.AddForm(Game.GetFormFromFile(0x00000D79, WildLootPlugin))	;raw mammoth meat
		_SNQuest._SNFood_RawList.AddForm(Game.GetFormFromFile(0x00000D7B, WildLootPlugin))	;raw sabre
		_SNQuest._SNFood_RawList.AddForm(Game.GetFormFromFile(0x00000D83, WildLootPlugin))	;raw wolf
		_SNQuest._SNFood_RawList.AddForm(Game.GetFormFromFile(0x00000D89, WildLootPlugin))	;raw mudcrab
		_SNQuest._SNFood_RawList.AddForm(Game.GetFormFromFile(0x00000D93, WildLootPlugin))	;raw slaughterfish
		_SNQuest._SNFood_RawList.AddForm(Game.GetFormFromFile(0x00000D97, WildLootPlugin))	;raw fox
		_SNQuest._SNFood_RawList.AddForm(Game.GetFormFromFile(0x000012FD, WildLootPlugin))	;raw goat
		_SNQuest._SNFood_RawList.AddForm(Game.GetFormFromFile(0x00001309, WildLootPlugin))	;raw venison
		_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x000018A6, WildLootPlugin))	;bear sausage
		_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x000018A8, WildLootPlugin))	;grilled fox
		_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x000018AA, WildLootPlugin))	;goat steak
		_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x000018AC, WildLootPlugin))	;garlic dog
		_SNQuest._SNFood_HeavyList.AddForm(Game.GetFormFromFile(0x000018B4, WildLootPlugin))	;marinated mammoth
		_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x000018B6, WildLootPlugin))	;mudcrab clam
		_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x000018B9, WildLootPlugin))	;spicy sabre stew
		_SNQuest._SNFood_HeavyList.AddForm(Game.GetFormFromFile(0x00001E0D, WildLootPlugin))	;bear roast
		_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x00001E20, WildLootPlugin))	;skeever stew
		_SNQuest._SNFood_HeavyList.AddForm(Game.GetFormFromFile(0x00001E25, WildLootPlugin))	;sabre roast
		_SNQuest._SNFood_HeavyList.AddForm(Game.GetFormFromFile(0x00001E28, WildLootPlugin))	;bear roast marin
		_SNQuest._SNFood_HeavyList.AddForm(Game.GetFormFromFile(0x00001E2C, WildLootPlugin))	;elk venison chop
		_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x00001E2F, WildLootPlugin))	;stew
		_SNQuest._SNFood_HeavyList.AddForm(Game.GetFormFromFile(0x00001E31, WildLootPlugin))	;wolf roast
		_SNQuest._SNFood_RawList.AddForm(Game.GetFormFromFile(0x000023D0, WildLootPlugin))	;raw rabbit
		_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x000023D2, WildLootPlugin))	;rabbit sandwich
		Utility.Wait(1.0)
	EndIf
	WildLootInstalled = True
EndFunction

Function SetElfEar(Form ElfEar, String ThirstyPlugin)
	If !DrinksThirstyInstalled
		_SNQuest._SNFood_DrinkNoAlcList.AddForm(ElfEar)
		_SNQuest._SNFood_DrinkNoAlcList.AddForm(Game.GetFormFromFile(0x00000D64, ThirstyPlugin))	;redberrytea
		_SNQuest._SNFood_DrinkNoAlcList.AddForm(Game.GetFormFromFile(0x00000D68, ThirstyPlugin))	;carrotjuice
		_SNQuest._SNFood_DrinkNoAlcList.AddForm(Game.GetFormFromFile(0x00000D6A, ThirstyPlugin))	;thistletea
		_SNQuest._SNFood_DrinkNoAlcList.AddForm(Game.GetFormFromFile(0x00000D6C, ThirstyPlugin))	;milk
		_SNQuest._SNFood_DrinkNoAlcList.AddForm(Game.GetFormFromFile(0x00000D74, ThirstyPlugin))	;mixedberryjuice
		_SNQuest._SNFood_DrinkNoAlcList.AddForm(Game.GetFormFromFile(0x000012D7, ThirstyPlugin))	;appleberry punch
		_SNQuest._SNFood_DrinkNoAlcList.AddForm(Game.GetFormFromFile(0x000012DA, ThirstyPlugin))	;applejuice
		_SNQuest._SNFood_DrinkNoAlcList.AddForm(Game.GetFormFromFile(0x000012DD, ThirstyPlugin))	;cider
		_SNQuest._SNFood_DrinkNoAlcList.AddForm(Game.GetFormFromFile(0x000012DE, ThirstyPlugin))	;canistea
		_SNQuest._SNFood_DrinkList.AddForm(Game.GetFormFromFile(0x000012E2, ThirstyPlugin))			;bosmeriwine
		_SNQuest._SNFood_DrinkNoAlcList.AddForm(Game.GetFormFromFile(0x000012E6, ThirstyPlugin))	;elsweyrcoffee
		_SNQuest._SNFood_DrinkList.AddForm(Game.GetFormFromFile(0x000012EE, ThirstyPlugin))			;wildbloodwine
		_SNQuest._SNFood_DrinkList.AddForm(Game.GetFormFromFile(0x000012EF, ThirstyPlugin))			;darkbloodwine
		_SNQuest._SNFood_DrinkList.AddForm(Game.GetFormFromFile(0x000012F1, ThirstyPlugin))			;richbloodwine
		_SNQuest._SNFood_DrinkList.AddForm(Game.GetFormFromFile(0x000012F6, ThirstyPlugin))			;bosmerimead
		_SNQuest._SNFood_DrinkNoAlcList.AddForm(Game.GetFormFromFile(0x00001865, ThirstyPlugin))	;tomatojuice
		_SNQuest._SNFood_DrinkNoAlcList.AddForm(Game.GetFormFromFile(0x00001DCC, ThirstyPlugin))	;medtea
		Utility.Wait(1.0)
	EndIf
	DrinksThirstyInstalled = True
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

Function SetGromit(Form ChickenSoup, String GromitPlugin)
	If !GromitInstalled
		_SNQuest._SNFood_SoupList.AddForm(ChickenSoup)
		_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x00001003, GromitPlugin))		;pheasantsoup
		_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x00001004, GromitPlugin))		;rabbitsoup
		_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x00001016, GromitPlugin))		;steakpie
		_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x0000102F, GromitPlugin))		;mushchicksoup
		_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x00001030, GromitPlugin))		;mushsoup
		_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x00001031, GromitPlugin))		;chickstew
		_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x00001032, GromitPlugin))		;pheasstew
		_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x00001038, GromitPlugin))		;venisoncass
		_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x0000103E, GromitPlugin))		;heavyveg
		_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x0000103F, GromitPlugin))		;mushstew
		_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x00001040, GromitPlugin))		;beefpheascass
		_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x00001041, GromitPlugin))		;omeletterock
		_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x00001042, GromitPlugin))		;horkerpheasant
		_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x00001043, GromitPlugin))		;omelettepine
		_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x00001047, GromitPlugin))		;beefcass
		_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x00001048, GromitPlugin))		;horkercass
		_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x00001049, GromitPlugin))		;goatstew
		_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x0000104A, GromitPlugin))		;beefchickcass
		_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x0000104B, GromitPlugin))		;dragonslayer
		_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x00001053, GromitPlugin))		;rabbitstew
		_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x00001054, GromitPlugin))		;potatohash
		_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x00001055, GromitPlugin))		;pieapplegreen
		_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x00001056, GromitPlugin))		;steakalepie
		_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x00001057, GromitPlugin))		;chickenpie
		_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x00001058, GromitPlugin))		;pheasantpie
		_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x00003611, GromitPlugin))		;omelettechicken
		Utility.Wait(1.0)
	EndIf
	GromitInstalled = True
EndFunction

Function SetZFO(Form PotatoCarrot, String ZFOPlugin)
	If !ZFOInstalled
		_SNQuest._SNFood_SoupList.AddForm(PotatoCarrot)
		_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x00023F30, ZFOPlugin))		;shecrabsoup
		_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x00023F32, ZFOPlugin))		;cannibalsoup
		_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x00023F34, ZFOPlugin))		;hopperstew
		_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x00023F36, ZFOPlugin))		;boarmeatstew
		_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x00023F38, ZFOPlugin))		;goatstew
		_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x00023F3A, ZFOPlugin))		;horsestew
		_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x00023F3C, ZFOPlugin))		;mammothstew
		_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x00023F3E, ZFOPlugin))		;rabbitstew
		_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x00023F40, ZFOPlugin))		;poultrysoup
		_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x00023F42, ZFOPlugin))		;ashhopperroast
		Utility.Wait(1.0)
	EndIf
	ZFOInstalled = True
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
		BabetteInstalled = False
		MilkDrinkerInstalled = False
		RequiemInstalled = False
		sky_BirdsInstalled = False
		PhittOverhaulInstalled = False
		NernieCityInstalled = False
		ETACISInstalled = False
		HarvestOverhaulInstalled = False
		OsareFoodInstalled = False
		FiveTwoSevenInstalled = False
		WyrmstoothInstalled = False
		Bon_AppetitInstalled = False
		DrinksThirstyInstalled = False
		HighlandFarmInstalled = False
		RealWildSkyrimInstalled = False
		FarmAnimalsInstalled = False
		GromitInstalled = False
		ZFOInstalled = False
		SpecialFloraInstalled = False
		NordicCookingInstalled = False
		DovahCookInstalled = False
		AnotherRecipeInstalled = False
		CookingIngredientsInstalled = False
		ResetLists = False
	EndIf
	
	SetVanilla()

	;If Game.GetFormFromFile(0x000012C4, "iNeed - Dangerous Diseases.esp")					disease
		;_SNQuest._SNDiseaseToggle.SetValue(1)
		;_SNQuest.iNeedDDInstalled = True
	;Else
		;_SNQuest._SNDiseaseToggle.SetValue(0)
		;_SNQuest.CureDisease()
		;If _SNQuest.iNeedDDInstalled
			;_SNQuest.SetPotionLeveledLists(true)
		;EndIf
		;_SNQuest.iNeedDDInstalled = False
	;EndIf
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
			_SNQuest._SNFood_DrinkList.AddForm(Game.GetFormFromFile(0x000248CC, "Dragonborn.esm"))	;shein
			_SNQuest._SNFood_DrinkList.AddForm(Game.GetFormFromFile(0x000248CE, "Dragonborn.esm"))	;matze
			_SNQuest._SNFood_DrinkList.AddForm(Game.GetFormFromFile(0x00024E0B, "Dragonborn.esm"))		;sadri sujamma
			_SNQuest._SNFood_DrinkList.AddForm(Game.GetFormFromFile(0x000320DF, "Dragonborn.esm"))	;emberbrand
			_SNQuest._SNFood_DrinkList.AddForm(Game.GetFormFromFile(0x0003572F, "Dragonborn.esm"))		;ashfire mead
			_SNQuest._SNFood_RawList.AddForm(Game.GetFormFromFile(0x0003BD14, "Dragonborn.esm"))		;boar meat
			_SNQuest._SNFood_RawList.AddForm(Game.GetFormFromFile(0x0003BD15, "Dragonborn.esm"))		;ash hopper
			_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x0003CD5B, "Dragonborn.esm"))	;horker ash yam stew
			_SNQuest._SNFood_HeavyList.AddForm(Game.GetFormFromFile(0x0003CF72, "Dragonborn.esm"))	;cooked boar
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
			_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x0015DB7A, "Falskaar.esm"))	;vegetable medley
			_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x0015DB7C, "Falskaar.esm"))	;seasoned beef stew
			_SNQuest._SNFood_RawList.AddForm(Game.GetFormFromFile(0x0015DB7E, "Falskaar.esm"))	;venison
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
			_SNQuest._SNFood_RawList.AddForm(Game.GetFormFromFile(0x00012C6B, "Hunterborn.esp"))		;ox hear
			_SNQuest._SNFood_RawList.AddForm(Game.GetFormFromFile(0x00012C6C, "Hunterborn.esp"))		;horse heart
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
			_SNQuest._SNFood_NoSpoilList.AddForm(Game.GetFormFromFile(0x00017E1B, "Hunterborn.esp"))		;venison jerky
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x00017E1D, "Hunterborn.esp"))		;horse jerky
			_SNQuest._SNFood_NoSpoilList.AddForm(Game.GetFormFromFile(0x00017E1D, "Hunterborn.esp"))		;horse jerky
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x00017E1F, "Hunterborn.esp"))		;seared fox
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x00017E21, "Hunterborn.esp"))		;seared rabbit
			_SNQuest._SNFood_HeavyList.AddForm(Game.GetFormFromFile(0x00017E23, "Hunterborn.esp"))	;mutt chop
			_SNQuest._SNFood_HeavyList.AddForm(Game.GetFormFromFile(0x00017E25, "Hunterborn.esp"))	;ale braised saber
			_SNQuest._SNFood_HeavyList.AddForm(Game.GetFormFromFile(0x00017E27, "Hunterborn.esp"))	;wolf chop snowberry
			_SNQuest._SNFood_HeavyList.AddForm(Game.GetFormFromFile(0x00017E29, "Hunterborn.esp"))		;mead braised bear
			_SNQuest._SNFood_HeavyList.AddForm(Game.GetFormFromFile(0x00017E2B, "Hunterborn.esp"))		;venison tenderloin
			_SNQuest._SNFood_HeavyList.AddForm(Game.GetFormFromFile(0x00017E2D, "Hunterborn.esp"))		;breaded elk
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x00017E2F, "Hunterborn.esp"))		;fox herb cutlet
			_SNQuest._SNFood_HeavyList.AddForm(Game.GetFormFromFile(0x00017E31, "Hunterborn.esp"))		;mullwine braised mammoth
			_SNQuest._SNFood_HeavyList.AddForm(Game.GetFormFromFile(0x00017E33, "Hunterborn.esp"))		;sabre pot roast
			_SNQuest._SNFood_HeavyList.AddForm(Game.GetFormFromFile(0x00017E35, "Hunterborn.esp"))		;elk steak
			_SNQuest._SNFood_HeavyList.AddForm(Game.GetFormFromFile(0x00017E37, "Hunterborn.esp"))	;goat haunch
			_SNQuest._SNFood_HeavyList.AddForm(Game.GetFormFromFile(0x00017E39, "Hunterborn.esp"))	;wolf haunch
			Utility.Wait(1.0)
			_SNQuest._SNFood_HeavyList.AddForm(Game.GetFormFromFile(0x00017E3B, "Hunterborn.esp"))	;smoked elf roast
			_SNQuest._SNFood_HeavyList.AddForm(Game.GetFormFromFile(0x00017E3D, "Hunterborn.esp"))	;honey mammoth roast
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
			_SNQuest._SNFood_HeavyList.AddForm(Game.GetFormFromFile(0x00029DBA, "Hunterborn.esp"))	;charred troll
			_SNQuest._SNFood_HeavyList.AddForm(Game.GetFormFromFile(0x00029DBC, "Hunterborn.esp"))	;dragon steak
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x000314C4, "Hunterborn.esp"))		;spider fry
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x000314C5, "Hunterborn.esp"))		;boiled spider paste
			_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x000314C9, "Hunterborn.esp"))		;poisoners soup
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x000314CC, "Hunterborn.esp"))	;chaurus chops
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x000314CD, "Hunterborn.esp"))		;troll jerky
			_SNQuest._SNFood_NoSpoilList.AddForm(Game.GetFormFromFile(0x000314CD, "Hunterborn.esp"))		;troll jerky
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

	Form RawMeat = Game.GetFormFromFile(0x00030CE7, "Requiem.esp")
	If RawMeat
		If !RequiemInstalled
			_SNQuest._SNFood_RawList.AddForm(RawMeat)
			_SNQuest._SNFood_HeavyList.AddForm(Game.GetFormFromFile(0x00030CFB, "Requiem.esp"))	;cooked meat
			_SNQuest._SNFood_RawList.AddForm(Game.GetFormFromFile(0x00030D05, "Requiem.esp"))	;skeever meat
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x000368F7, "Requiem.esp"))	;mudcrab meat
			_SNQuest._SNFood_DrinkNoAlcList.AddForm(Game.GetFormFromFile(0x00036E7E, "Requiem.esp"))	;milk
			_SNQuest._SNFood_DrinkNoAlcList.AddForm(Game.GetFormFromFile(0x0003DFE8, "Requiem.esp"))	;water
			_SNQuest._SNFood_RawList.AddForm(Game.GetFormFromFile(0x00284894, "Requiem.esp"))	;strange meat
			_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x002897D4, "Requiem.esp"))	;bestial stew
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

	Form Cookie = Game.GetFormFromFile(0x000048B6, "ETaC - RESOURCES.esm")
	If Cookie
		If !ETACISInstalled
			_SNQuest._SNFood_LightList.AddForm(Cookie)
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x000048B8, "ETaC - RESOURCES.esm"))		;cinnamon bun
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x000048BA, "ETaC - RESOURCES.esm"))		;juniper pie
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x000048BE, "ETaC - RESOURCES.esm"))		;muffin
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x000048C0, "ETaC - RESOURCES.esm"))		;strawpie
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x00004E24, "ETaC - RESOURCES.esm"))		;pumppie
			_SNQuest._SNFood_DrinkList.AddForm(Game.GetFormFromFile(0x00007965, "ETaC - RESOURCES.esm"))		;cyro spiced
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x0000842B, "ETaC - RESOURCES.esm"))		;bluemuffin
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x0000842C, "ETaC - RESOURCES.esm"))		;cranmuffin
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x0000842E, "ETaC - RESOURCES.esm"))		;figmuffin
			_SNQuest._SNFood_RawList.AddForm(Game.GetFormFromFile(0x00011681, "ETaC - RESOURCES.esm"))		;ribs
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x0001317E, "ETaC - RESOURCES.esm"))		;kabob
			_SNQuest._SNFood_DrinkList.AddForm(Game.GetFormFromFile(0x0003684C, "ETaC - RESOURCES.esm"))		;hippo
			_SNQuest._SNFood_DrinkList.AddForm(Game.GetFormFromFile(0x00038347, "ETaC - RESOURCES.esm"))		;acerglin
			_SNQuest._SNFood_DrinkList.AddForm(Game.GetFormFromFile(0x00038348, "ETaC - RESOURCES.esm"))		;tej
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x0003D48B, "ETaC - RESOURCES.esm"))		;jazbaypie
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x0003D48F, "ETaC - RESOURCES.esm"))		;snowpie
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x0003D492, "ETaC - RESOURCES.esm"))		;snowpie
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x0003D493, "ETaC - RESOURCES.esm"))		;pumpkin
			_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x00043043, "ETaC - RESOURCES.esm"))		;carrsoup
			_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x00043044, "ETaC - RESOURCES.esm"))		;chicsoup
			_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x00043046, "ETaC - RESOURCES.esm"))		;fishsoup
			_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x00043048, "ETaC - RESOURCES.esm"))		;leeksoup
			_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x0004304A, "ETaC - RESOURCES.esm"))		;mushsoup
			_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x0004304C, "ETaC - RESOURCES.esm"))		;pheassoup
			Utility.Wait(1.0)
			_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x0004304E, "ETaC - RESOURCES.esm"))		;slaughsoup
			_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x00043050, "ETaC - RESOURCES.esm"))		;begstew
			_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x00043052, "ETaC - RESOURCES.esm"))		;rabbstew
			_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x00043054, "ETaC - RESOURCES.esm"))		;seastew
			_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x00043056, "ETaC - RESOURCES.esm"))		;squashstew
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x00053F2A, "ETaC - RESOURCES.esm"))		;cookie
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x00053F2B, "ETaC - RESOURCES.esm"))		;cookie
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x00053F2D, "ETaC - RESOURCES.esm"))		;cookie
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x00053F2F, "ETaC - RESOURCES.esm"))		;cookie
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x00053F31, "ETaC - RESOURCES.esm"))		;cookie
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x00053F33, "ETaC - RESOURCES.esm"))		;cookie
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x00053F35, "ETaC - RESOURCES.esm"))		;cookie
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x00053F37, "ETaC - RESOURCES.esm"))		;cookie
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x00053F39, "ETaC - RESOURCES.esm"))		;cookie
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x00053F3B, "ETaC - RESOURCES.esm"))		;cookie
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x00053F3D, "ETaC - RESOURCES.esm"))		;cookie
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x00053F3F, "ETaC - RESOURCES.esm"))		;cookie
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x00053F41, "ETaC - RESOURCES.esm"))		;cookie
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x00053F43, "ETaC - RESOURCES.esm"))		;cookie
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x00053F45, "ETaC - RESOURCES.esm"))		;cookie
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x00055FE8, "ETaC - RESOURCES.esm"))		;snoberrytart
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x00055FE9, "ETaC - RESOURCES.esm"))		;jazbaytart
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x00055FEB, "ETaC - RESOURCES.esm"))		;appletart
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x00055FED, "ETaC - RESOURCES.esm"))		;buttertart
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x00055FEF, "ETaC - RESOURCES.esm"))		;carameltart
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x00055FF1, "ETaC - RESOURCES.esm"))		;lemontart
			_SNQuest._SNFood_DrinkList.AddForm(Game.GetFormFromFile(0x00068437, "ETaC - RESOURCES.esm"))		;hammerfellrum
			_SNQuest._SNFood_DrinkList.AddForm(Game.GetFormFromFile(0x00068439, "ETaC - RESOURCES.esm"))		;daggerfallwine
			Utility.Wait(1.0)
		EndIf
		ETACISInstalled = True
	Else
		ETACISInstalled = False
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
			_SNQuest._SNFood_HeavyList.AddForm(Game.GetFormFromFile(0x0005596C, "HarvestOverhaulCreatures.esp"))		;basted chaurus
			_SNQuest._SNFood_HeavyList.AddForm(Game.GetFormFromFile(0x0005596E, "HarvestOverhaulCreatures.esp"))		;pie chaurus
			_SNQuest._SNFood_HeavyList.AddForm(Game.GetFormFromFile(0x00055972, "HarvestOverhaulCreatures.esp"))		;chaurus
			_SNQuest._SNFood_HeavyList.AddForm(Game.GetFormFromFile(0x0007E18A, "HarvestOverhaulCreatures.esp"))		;ash hopper
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

	Form GooseBreast = Game.GetFormFromFile(0x00030132, "skyBirds - Airborne Perching Birds.esp")
	If GooseBreast
		If !sky_BirdsInstalled
			_SNQuest._SNFood_RawList.AddForm(GooseBreast)
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x000316C7, "skyBirds - Airborne Perching Birds.esp"))
		EndIf
		sky_BirdsInstalled = True
	Else
		sky_BirdsInstalled = False
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

	Form BakedTomato = Game.GetFormFromFile(0x000012C4, "BonAppetitBase.esm")
	If BakedTomato
		If !Bon_AppetitInstalled
			_SNQuest._SNFood_LightList.AddForm(BakedTomato)
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x000038A8, "BonAppetitBase.esm"))		;beetroot
			_SNQuest._SNFood_DrinkNoAlcList.AddForm(Game.GetFormFromFile(0x000038AE, "BonAppetitBase.esm"))		;coffee
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x00005E88, "BonAppetitBase.esm"))		;icecream
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x00006EB5, "BonAppetitBase.esm"))		;icecreamjazbay
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x00006EB6, "BonAppetitBase.esm"))		;icecreamorange
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x00006EB8, "BonAppetitBase.esm"))		;icecreamsnoberry
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x000012C5, "BonAppetitBase.esm"))		;jamapple
			_SNQuest._SNFood_DrinkNoAlcList.AddForm(Game.GetFormFromFile(0x00003E1C, "BonAppetitBase.esm"))		;juiceapple
			_SNQuest._SNFood_DrinkNoAlcList.AddForm(Game.GetFormFromFile(0x00003E20, "BonAppetitBase.esm"))		;juicebeet
			_SNQuest._SNFood_DrinkNoAlcList.AddForm(Game.GetFormFromFile(0x00003E1E, "BonAppetitBase.esm"))		;juicecarrot
			_SNQuest._SNFood_DrinkNoAlcList.AddForm(Game.GetFormFromFile(0x00003E22, "BonAppetitBase.esm"))		;juiceorange
			_SNQuest._SNFood_DrinkNoAlcList.AddForm(Game.GetFormFromFile(0x00003E24, "BonAppetitBase.esm"))		;juicesnoberry
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x000012C7, "BonAppetitBase.esm"))		;kulebyaka1
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x000012C9, "BonAppetitBase.esm"))		;kulebyaka2
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x000038A6, "BonAppetitBase.esm"))		;orange
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x00004389, "BonAppetitBase.esm"))		;orange slices
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x000022FC, "BonAppetitBase.esm"))		;pancakes
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x00002301, "BonAppetitBase.esm"))		;pancakeshoney
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x00002300, "BonAppetitBase.esm"))		;pancakesapple
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x000012CB, "BonAppetitBase.esm"))		;pelmeni
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x00003E1B, "BonAppetitBase.esm"))		;pieacron
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x00004388, "BonAppetitBase.esm"))		;pieorange
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x00002DCD, "BonAppetitBase.esm"))		;sausage1
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x00002DCE, "BonAppetitBase.esm"))		;sausage2
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x00002DD0, "BonAppetitBase.esm"))		;sausage3
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x00002DD2, "BonAppetitBase.esm"))		;sausage4
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x00002DD4, "BonAppetitBase.esm"))		;sausage5
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x00002DD6, "BonAppetitBase.esm"))		;sausaget1
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x00002DD8, "BonAppetitBase.esm"))		;sausaget2
			_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x000048ED, "BonAppetitBase.esm"))		;beetsoup1
			_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x000048EE, "BonAppetitBase.esm"))		;beetsoup2
		EndIf
		Bon_AppetitInstalled = True
	Else
		Bon_AppetitInstalled = False
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

	Form HighlandMilk = Game.GetFormFromFile(0x00000D62, "HighlandFarmMilk.esp")
	If HighlandMilk
		If !HighlandFarmInstalled
			_SNQuest._SNFood_DrinkNoAlcList.AddForm(HighlandMilk)
			_SNQuest._SNFood_DrinkNoAlcList.AddForm(Game.GetFormFromFile(0x00003580, "HighlandFarmMilk.esp"))	;milkbottle
			_SNQuest._SNFood_DrinkNoAlcList.AddForm(Game.GetFormFromFile(0x00003581, "HighlandFarmMilk.esp"))	;milkbarrel
			_SNQuest._SNFood_DrinkNoAlcList.AddForm(Game.GetFormFromFile(0x00007DFF, "HighlandFarmMilk.esp"))	;thiefmilk
			_SNQuest._SNFood_DrinkNoAlcList.AddForm(Game.GetFormFromFile(0x00007E00, "HighlandFarmMilk.esp"))	;magemilk
			_SNQuest._SNFood_DrinkNoAlcList.AddForm(Game.GetFormFromFile(0x00007E02, "HighlandFarmMilk.esp"))	;warriormilk
			_SNQuest._SNFood_HeavyList.AddForm(Game.GetFormFromFile(0x0000A9E7, "HighlandFarmMilk.esp"))		;cheesewheel
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x0000AF53, "HighlandFarmMilk.esp"))			;omelette
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x0000AF54, "HighlandFarmMilk.esp"))			;pancakes
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x0000AF56, "HighlandFarmMilk.esp"))			;skeever
			_SNQuest._SNFood_DrinkNoAlcList.AddForm(Game.GetFormFromFile(0x0000AF58, "HighlandFarmMilk.esp"))	;water bottle
			Utility.Wait(1.0)
		EndIf
		HighlandFarmInstalled = True
	Else
		HighlandFarmInstalled = False
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

	Form AshYamSoup = Game.GetFormFromFile(0x0004D50E, "SpecialFlora.esp")
	If AshYamSoup
		If !SpecialFloraInstalled
			_SNQuest._SNFood_SoupList.AddForm(AshYamSoup)
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x0004D50F, "SpecialFlora.esp"))		;warbread
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x0004D511, "SpecialFlora.esp"))		;ryeflour
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x0004D513, "SpecialFlora.esp"))		;ryebread
			_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x0004D51B, "SpecialFlora.esp"))		;chickstew
			_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x0004D51C, "SpecialFlora.esp"))		;vegstew
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x0004D51E, "SpecialFlora.esp"))		;parsnip
			_SNQuest._SNFood_HorseList.AddForm(Game.GetFormFromFile(0x0004D51E, "SpecialFlora.esp"))		;parsnip
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x0004D527, "SpecialFlora.esp"))		;comberry
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x00075D68, "SpecialFlora.esp"))		;scribcabbage
			_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x0007FF71, "SpecialFlora.esp"))		;hopperstew
		EndIf
		SpecialFloraInstalled = True
	Else
		SpecialFloraInstalled = False
	EndIf

	Form NordicJerky = Game.GetFormFromFile(0x00000D62, "NordicCooking.esp")
	If NordicJerky
		If !NordicCookingInstalled
			_SNQuest._SNFood_LightList.AddForm(NordicJerky)
			_SNQuest._SNFood_NoSpoilList.AddForm(NordicJerky)
			_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x00000D63, "NordicCooking.esp"))		;beefstew
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x00000D65, "NordicCooking.esp"))		;mammothcheesesteak
			_SNQuest._SNFood_DrinkList.AddForm(Game.GetFormFromFile(0x00000D67, "NordicCooking.esp"))		;redapplecider
			_SNQuest._SNFood_DrinkNoAlcList.AddForm(Game.GetFormFromFile(0x00000D69, "NordicCooking.esp"))		;carrotjuice
			_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x000012EF, "NordicCooking.esp"))		;horkerstew
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x00001856, "NordicCooking.esp"))		;hash
			_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x00002322, "NordicCooking.esp"))		;cheesesoup
			_SNQuest._SNFood_DrinkList.AddForm(Game.GetFormFromFile(0x00003349, "NordicCooking.esp"))		;greenappleale
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x000038B0, "NordicCooking.esp"))		;salmonsalad
			_SNQuest._SNFood_HeavyList.AddForm(Game.GetFormFromFile(0x000038B3, "NordicCooking.esp"))		;roastedgoat
			_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x000038B6, "NordicCooking.esp"))		;clamchowder
			_SNQuest._SNFood_HeavyList.AddForm(Game.GetFormFromFile(0x000038B9, "NordicCooking.esp"))		;roastedgourd
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x000038BC, "NordicCooking.esp"))		;roastedchicken
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x00003E24, "NordicCooking.esp"))		;smokedsalmon
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x000048EB, "NordicCooking.esp"))		;cheesehero
			_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x00004E51, "NordicCooking.esp"))		;venisonstew
			_SNQuest._SNFood_DrinkNoAlcList.AddForm(Game.GetFormFromFile(0x000053B9, "NordicCooking.esp"))		;coffee
			_SNQuest._SNFood_DrinkNoAlcList.AddForm(Game.GetFormFromFile(0x000053BF, "NordicCooking.esp"))		;tea
			_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x00005924, "NordicCooking.esp"))		;chickensoup
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x00005E8A, "NordicCooking.esp"))		;veggiehero
			_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x00005E8D, "NordicCooking.esp"))		;veggiestew
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x00005E91, "NordicCooking.esp"))		;salad
			_SNQuest._SNFood_DrinkList.AddForm(Game.GetFormFromFile(0x00009478, "NordicCooking.esp"))		;redapplewine
			_SNQuest._SNFood_DrinkList.AddForm(Game.GetFormFromFile(0x00009479, "NordicCooking.esp"))		;greenapplewine
		EndIf
		NordicCookingInstalled = True
	Else
		NordicCookingInstalled = False
	EndIf

	Form EveningStar = Game.GetFormFromFile(0x0000230A, "CRX.esp")
	If EveningStar
		If !DovahCookInstalled
			_SNQuest._SNFood_HeavyList.AddForm(EveningStar)
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x000038A5, "CRX.esp"))		;flour pile
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x000038A9, "CRX.esp"))		;grilledwhitecap
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x000038AD, "CRX.esp"))		;marinatedpholiota
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x000038B1, "CRX.esp"))		;smokedblisterwort
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x000038B4, "CRX.esp"))		;sauteedamanita
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x000038B7, "CRX.esp"))		;rawglassmeal
			_SNQuest._SNFood_DrinkList.AddForm(Game.GetFormFromFile(0x00003E1C, "CRX.esp"))		;distilledchaurus
			_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x00003E21, "CRX.esp"))		;skeeverlapskaus
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x00003E24, "CRX.esp"))		;northpointpoutine
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x00003E27, "CRX.esp"))		;wayrestcheese
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x00003E2A, "CRX.esp"))		;nibenesenoodles
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x00003E2D, "CRX.esp"))		;crimsonspices
			_SNQuest._SNFood_DrinkNoAlcList.AddForm(Game.GetFormFromFile(0x00003E30, "CRX.esp"))		;taprootextract
			_SNQuest._SNFood_DrinkList.AddForm(Game.GetFormFromFile(0x00004397, "CRX.esp"))		;snowblindliquor
			_SNQuest._SNFood_DrinkList.AddForm(Game.GetFormFromFile(0x0000439C, "CRX.esp"))		;nightcaller
			_SNQuest._SNFood_HeavyList.AddForm(Game.GetFormFromFile(0x0000439F, "CRX.esp"))		;infusedleg
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x000043A2, "CRX.esp"))		;falmeromelette
			_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x000043A5, "CRX.esp"))		;jallenheim
			_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x0000490A, "CRX.esp"))		;meadcoleslaw
			_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x0000490D, "CRX.esp"))		;shellfish
			_SNQuest._SNFood_DrinkList.AddForm(Game.GetFormFromFile(0x00004910, "CRX.esp"))		;redmountain
			_SNQuest._SNFood_DrinkList.AddForm(Game.GetFormFromFile(0x00004917, "CRX.esp"))		;sahloknir
			_SNQuest._SNFood_DrinkList.AddForm(Game.GetFormFromFile(0x0000491B, "CRX.esp"))		;galerion
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x000053E4, "CRX.esp"))		;humanpie
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x000053E8, "CRX.esp"))		;humanheart
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x000053EB, "CRX.esp"))		;daedraheart
			_SNQuest._SNFood_DrinkList.AddForm(Game.GetFormFromFile(0x000053EF, "CRX.esp"))		;molagamur
			_SNQuest._SNFood_DrinkList.AddForm(Game.GetFormFromFile(0x000053F4, "CRX.esp"))		;obliviondark
			_SNQuest._SNFood_DrinkList.AddForm(Game.GetFormFromFile(0x000053F7, "CRX.esp"))		;apocrypha
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x00009F5B, "CRX.esp"))		;iceflowsweet
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x0000AF8A, "CRX.esp"))		;haraldfrestelse
			_SNQuest._SNFood_DrinkList.AddForm(Game.GetFormFromFile(0x0000AF8D, "CRX.esp"))		;augururstonic
			_SNQuest._SNFood_DrinkList.AddForm(Game.GetFormFromFile(0x0000B4F3, "CRX.esp"))		;nirnscoria
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x0000B4F5, "CRX.esp"))		;bakedskeever
			_SNQuest._SNFood_DrinkList.AddForm(Game.GetFormFromFile(0x0000C521, "CRX.esp"))		;liquescentvoid
			_SNQuest._SNFood_DrinkList.AddForm(Game.GetFormFromFile(0x0000C523, "CRX.esp"))		;fermentedaqu
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x0000CA8C, "CRX.esp"))		;bakedmora
			_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x0000CA8D, "CRX.esp"))		;viridiansyr
		EndIf
		DovahCookInstalled = True
	Else
		DovahCookInstalled = False
	EndIf

	Form Onion = Game.GetFormFromFile(0x000036C9, "Another Recipe Mod.esp")
	If Onion
		If !AnotherRecipeInstalled
			_SNQuest._SNFood_LightList.AddForm(Onion)
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x000036CC, "Another Recipe Mod.esp"))		;pear
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x000036CD, "Another Recipe Mod.esp"))		;marshmerrow
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x000036CF, "Another Recipe Mod.esp"))		;saltrice
			_SNQuest._SNFood_DrinkNoAlcList.AddForm(Game.GetFormFromFile(0x000036D4, "Another Recipe Mod.esp"))		;tramatea
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x000036D5, "Another Recipe Mod.esp"))		;friedegg
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x000036D7, "Another Recipe Mod.esp"))		;grilledfish
			_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x000036D9, "Another Recipe Mod.esp"))		;fishsoup
			_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x000036DB, "Another Recipe Mod.esp"))		;honeypudding
			_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x000036DD, "Another Recipe Mod.esp"))		;pheasantstew
			_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x000036DF, "Another Recipe Mod.esp"))		;rabbitstew
			_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x000036E1, "Another Recipe Mod.esp"))		;potatoleekstew
			_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x000036E3, "Another Recipe Mod.esp"))		;mushroomsoup
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x000036E5, "Another Recipe Mod.esp"))		;hopperriceballs
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x000036E7, "Another Recipe Mod.esp"))		;steamsaltrice
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x000036E9, "Another Recipe Mod.esp"))		;salmonplatter
			_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x000036EB, "Another Recipe Mod.esp"))		;chickensoup
			_SNQuest._SNFood_HeavyList.AddForm(Game.GetFormFromFile(0x000036ED, "Another Recipe Mod.esp"))		;meatpie
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x00009485, "Another Recipe Mod.esp"))		;herbbread
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x00009489, "Another Recipe Mod.esp"))		;cookedmudcrab
			_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x0000948D, "Another Recipe Mod.esp"))		;crabchowder
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x000094A9, "Another Recipe Mod.esp"))		;porkdumpling
			_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x000187AF, "Another Recipe Mod.esp"))		;mammothstew
			_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x000187B2, "Another Recipe Mod.esp"))		;banditstew
			_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x000187B5, "Another Recipe Mod.esp"))		;orcstew
			_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x0001D8C8, "Another Recipe Mod.esp"))		;ashyamstew
		EndIf
		AnotherRecipeInstalled = True
	Else
		AnotherRecipeInstalled = False
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
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x00001D9E, "SL00CookingIngredient.esp"))		;chauruspie
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x00002DC6, "SL00CookingIngredient.esp"))		;chaurusegg
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x00002DC8, "SL00CookingIngredient.esp"))		;slaughterfishegg
			_SNQuest._SNFood_DrinkNoAlcList.AddForm(Game.GetFormFromFile(0x0000332E, "SL00CookingIngredient.esp"))		;canisroottea
			_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x00003899, "SL00CookingIngredient.esp"))		;potage1
			_SNQuest._SNFood_SoupList.AddForm(Game.GetFormFromFile(0x0000389B, "SL00CookingIngredient.esp"))		;potage2
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x00003DFF, "SL00CookingIngredient.esp"))		;glowingmushroom
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x0000538D, "SL00CookingIngredient.esp"))		;scalypholiota
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x00005E53, "SL00CookingIngredient.esp"))		;jamsnoberry
			_SNQuest._SNFood_LightList.AddForm(Game.GetFormFromFile(0x000063B8, "SL00CookingIngredient.esp"))		;jamjazbay
			_SNQuest._SNFood_HeavyList.AddForm(Game.GetFormFromFile(0x0000691E, "SL00CookingIngredient.esp"))		;slaughterfish
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x00006E83, "SL00CookingIngredient.esp"))		;chaurusmeat
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
			_SNQuest._SNFood_MedList.AddForm(Game.GetFormFromFile(0x00008431, "SL00CookingIngredient.esp"))		;beefcooked
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

	Form ChickenSoup_1 = Game.GetFormFromFile(0x00001002, "GM-CookingRebalanceFinal.esp")
	Form ChickenSoup_2 = Game.GetFormFromFile(0x00001002, "GM-CookingRebalanceFinalHearthfire.esp")
	If ChickenSoup_1
		SetFarmAnimals(ChickenSoup_1, "GM-CookingRebalanceFinal.esp")
	ElseIf ChickenSoup_2
		SetFarmAnimals(ChickenSoup_2, "GM-CookingRebalanceFinalHearthfire.esp")
	Else
		GromitInstalled = False
	EndIf

	Form PotatoCarrot_1 = Game.GetFormFromFile(0x00023F2F, "ZFO-TS10.esp")
	Form PotatoCarrot_2 = Game.GetFormFromFile(0x00023F2F, "ZFO-TS6.esp")
	Form PotatoCarrot_3 = Game.GetFormFromFile(0x00023F2F, "ZFO-TS8.esp")
	Form PotatoCarrot_4 = Game.GetFormFromFile(0x00023F2F, "ZFO-TS10-Labeled.esp")
	Form PotatoCarrot_5 = Game.GetFormFromFile(0x00023F2F, "ZFO-TS6-Labeled.esp")
	Form PotatoCarrot_6 = Game.GetFormFromFile(0x00023F2F, "ZFO-TS8-Labeled.esp")
	If PotatoCarrot_1
		SetZFO(PotatoCarrot_1, "ZFO-TS10.esp")
	ElseIf PotatoCarrot_2
		SetZFO(PotatoCarrot_2, "ZFO-TS6.esp")
	ElseIf PotatoCarrot_3
		SetZFO(PotatoCarrot_3, "ZFO-TS8.esp")
	ElseIf PotatoCarrot_4
		SetZFO(PotatoCarrot_4, "ZFO-TS10-Labeled.esp")
	ElseIf PotatoCarrot_5
		SetZFO(PotatoCarrot_5, "ZFO-TS6-Labeled.esp")
	ElseIf PotatoCarrot_6
		SetZFO(PotatoCarrot_6, "ZFO-TS8-Labeled.esp")
	Else
		ZFOInstalled = False
	EndIf

	Form WhiteBread_1 = Game.GetFormFromFile(0x00001B30, "NerniesCityandVillageExpansion.esp")
	Form WhiteBread_2 = Game.GetFormFromFile(0x00001B30, "REGS - Resources.esm")
	If WhiteBread_1
		SetNern(WhiteBread_1, "NerniesCityandVillageExpansion.esp")
	ElseIf WhiteBread_2
		SetNern(WhiteBread_2, "REGS - Resources.esm")
	Else
		NernieCityInstalled = False
	EndIf

	Form Wayrest_1 = Game.GetFormFromFile(0x00001000, "Babettes Feast Balanced.esp")
	Form Wayrest_2 = Game.GetFormFromFile(0x00001000, "Babettes Feast Weaker Effects.esp")
	Form Wayrest_3 = Game.GetFormFromFile(0x00001000, "Babettes Feast Overpowered.esp")
	If Wayrest_1
		SetBF(Wayrest_1, "Babettes Feast Balanced.esp")
	ElseIf Wayrest_2
		SetBF(Wayrest_2, "Babettes Feast Weaker Effects.esp")
	ElseIf Wayrest_3
		SetBF(Wayrest_3, "Babettes Feast Overpowered.esp")
	Else
		BabetteInstalled = False
	EndIf

	Milk_1 = Game.GetFormFromFile(0x00000D62, "MilkHearthfire.esp")
	Milk_2 = Game.GetFormFromFile(0x00000D62, "Milk.esp")
	If Milk_1
		SetMilk(Milk_1, "MilkHearthfire.esp")
	ElseIf Milk_2
		SetMilk(Milk_2, "Milk.esp")
	Else
		MilkDrinkerInstalled = False
	EndIf

	Form ClamStew_1 = Game.GetFormFromFile(0x0001051E, "PTAlchemyFoodOverhaul.esp")
	Form ClamStew_2 = Game.GetFormFromFile(0x0001051E, "PTAlchemyFoodOverhaul_BetterSorting.esp")
	Form ClamStew_3 = Game.GetFormFromFile(0x0001051E, "PTFoodOverhaul_ONLY.esp")
	If ClamStew_1
		SetClam(ClamStew_1, "PTAlchemyFoodOverhaul.esp")
	ElseIf ClamStew_2
		SetClam(ClamStew_2, "PTAlchemyFoodOverhaul_BetterSorting.esp")
	ElseIf ClamStew_3
		SetClam(ClamStew_3, "PTFoodOverhaul_ONLY.esp")
	Else
		PhittOverhaulInstalled = False
	EndIf

	Form ElfEar_1 = Game.GetFormFromFile(0x00000D62, "DftT.esp")
	Form ElfEar_2 = Game.GetFormFromFile(0x00000D62, "DftT-NGP-WTLS.esp")
	Form ElfEar_3 = Game.GetFormFromFile(0x00000D62, "DftT-NoGreenPact.esp")
	Form ElfEar_4 = Game.GetFormFromFile(0x00000D62, "DftT-WTLS.esp")
	If ElfEar_1
		SetElfEar(ElfEar_1, "DftT.esp")
	ElseIf ElfEar_2
		SetElfEar(ElfEar_2, "DftT-NGP-WTLS.esp")
	ElseIf ElfEar_3
		SetElfEar(ElfEar_3, "DftT-NoGreenPact.esp")
	ElseIf ElfEar_4
		SetElfEar(ElfEar_4, "DftT-WTLS.esp")
	Else
		DrinksThirstyInstalled = False
	EndIf

	_SNQuest._SNMagicEffect_CureList.AddForm(Game.GetFormFromFile(0x000389BB, "PerkusMaximus_Master.esp"))

EndFunction