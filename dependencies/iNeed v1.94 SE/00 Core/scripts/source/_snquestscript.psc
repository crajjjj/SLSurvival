Scriptname _SNQuestScript extends Quest

;====================================================================================

Spell Property _SNPlayerSpell Auto
Spell Property _SNFatiguePenaltySpell_1 Auto
Spell Property _SNFatiguePenaltySpell_2 Auto
Spell Property _SNFatiguePenaltySpell_3 Auto
Spell Property _SNHungerPenaltySpell_1 Auto
Spell Property _SNHungerPenaltySpell_2 Auto
Spell Property _SNHungerPenaltySpell_3 Auto
Spell Property _SNHungerBuffSpell Auto
Spell Property _SNThirstPenaltySpell_1 Auto
Spell Property _SNThirstPenaltySpell_2 Auto
Spell Property _SNThirstPenaltySpell_3 Auto
Spell Property _SNThirstBuffSpell Auto
Spell Property _SNDrunkSpell Auto
Spell Property _SNSkoomaSpell Auto
Spell Property _SNFeverPenaltySpell_1 Auto
Spell Property _SNVariedDietSpell Auto

Spell Property _SNDisAtaxiaSpell_1 Auto
Spell Property _SNDisAtaxiaSpell_2 Auto
Spell Property _SNDisAtaxiaSpell_3 Auto
Spell Property _SNDisAtaxiaSpell_4 Auto
Spell Property _SNDisBBFSpell_1 Auto
Spell Property _SNDisBBFSpell_2 Auto
Spell Property _SNDisBBFSpell_3 Auto
Spell Property _SNDisBBFSpell_4 Auto
Spell Property _SNDisBHBSpell_1 Auto
Spell Property _SNDisBHBSpell_2 Auto
Spell Property _SNDisBHBSpell_3 Auto
Spell Property _SNDisBHBSpell_4 Auto
Spell Property _SNDisBrainRotSpell_1 Auto
Spell Property _SNDisBrainRotSpell_2 Auto
Spell Property _SNDisBrainRotSpell_3 Auto
Spell Property _SNDisBrainRotSpell_4 Auto
Spell Property _SNDisDroopsSpell_1 Auto
Spell Property _SNDisDroopsSpell_2 Auto
Spell Property _SNDisDroopsSpell_3 Auto
Spell Property _SNDisDroopsSpell_4 Auto
Spell Property _SNDisRattlesSpell_1 Auto
Spell Property _SNDisRattlesSpell_2 Auto
Spell Property _SNDisRattlesSpell_3 Auto
Spell Property _SNDisRattlesSpell_4 Auto
Spell Property _SNDisRockjointSpell_1 Auto
Spell Property _SNDisRockjointSpell_2 Auto
Spell Property _SNDisRockjointSpell_3 Auto
Spell Property _SNDisRockjointSpell_4 Auto
Spell Property _SNDisSalmonVanillaSpell Auto
Spell Property _SNDisSalmonSpell_1 Auto
Spell Property _SNDisSalmonSpell_2 Auto
Spell Property _SNDisSalmonSpell_3 Auto
Spell Property _SNDisSalmonSpell_4 Auto
Spell Property _SNDisWitbaneSpell_1 Auto
Spell Property _SNDisWitbaneSpell_2 Auto
Spell Property _SNDisWitbaneSpell_3 Auto
Spell Property _SNDisWitbaneSpell_4 Auto

Spell Property _SNAdrenalineSpell Auto
Spell Property _SNWearySpell Auto
Spell Property _SNWellnessSpell Auto
Spell Property _SNOldConfigSpell Auto

Message Property _SNHarvestMsg Auto
Message Property _SNWaterSaltMsg Auto

Idle Property IdleStop_Loose Auto
Idle Property idlepickup_ground Auto

Keyword Property Vampire Auto
Keyword Property VendorItemFood Auto
Keyword Property CraftingCookPot Auto
Keyword Property CraftOven Auto
Keyword Property FurnitureBedRoll Auto
Keyword Property LocTypeHouse Auto
Keyword Property TGWealthyHome Auto
Keyword Property LocTypeInn Auto
Keyword Property LocTypeStore Auto
Keyword Property LocTypeMilitaryFort Auto
Keyword Property LocTypeMilitaryCamp Auto
Keyword Property LocTypeBarracks Auto
Keyword Property LocTypeBanditCamp Auto
Keyword Property LocTypeForswornCamp Auto
Keyword Property LocTypeWarlockLair Auto
Keyword Property LocTypeTemple Auto
Keyword Property LocTypeDwelling Auto
Keyword Property LocTypeHabitation Auto
Keyword Property LocTypeDungeon Auto
Keyword Property LocTypeClearable Auto
Keyword Property LocTypeVampireLair Auto
Keyword Property LocTypeSprigganGrove Auto

MagicEffect Property DiseaseBHB Auto
MagicEffect Property DiseaseDroops Auto

ConstructibleObject Property RecipeFoodBeefCooked Auto
ConstructibleObject Property RecipeFoodChickenCooked Auto
ConstructibleObject Property RecipeFoodGoatCooked Auto
ConstructibleObject Property RecipeFoodHorkerCooked Auto
ConstructibleObject Property RecipeFoodHorseCooked Auto
ConstructibleObject Property RecipeFoodMammothCooked Auto
ConstructibleObject Property RecipeFoodPheasantCooked Auto
ConstructibleObject Property RecipeFoodRabbitCooked Auto
ConstructibleObject Property RecipeFoodSalmonCooked Auto
ConstructibleObject Property RecipeFoodVenisonCooked Auto

Armor Property DA11RingofNamira Auto

MiscObject Property _SNWaterskin_0 Auto
MiscObject Property _SNWaterskin_Salt Auto
MiscObject Property LeatherStrips Auto
MiscObject Property Gold001 Auto

Perk Property DA11Cannibalism Auto

Activator Property DFSFountain Auto
Activator Property _SNWaterBarrel Auto

Ingredient Property SaltPile Auto
Ingredient Property Garlic Auto

Potion Property _SNCureDisease Auto
Potion Property _SNWaterskin_1 Auto
Potion Property _SNWaterskin_2 Auto
Potion Property _SNWaterskin_3 Auto
Potion Property _SNWaterskin_1_Unknown Auto
Potion Property _SNWaterskin_2_Unknown Auto
Potion Property _SNWaterskin_3_Unknown Auto
Potion Property _SNEmptyFood Auto
Potion Property FoodCheeseWheel01A Auto
Potion Property FoodCheeseWheel01B Auto
Potion Property FoodCheeseWheel02A Auto
Potion Property FoodCheeseWheel02B Auto
Potion Property FoodCheeseWedge01 Auto
Potion Property FoodCheeseWedge02 Auto
Potion Property _SNSnowPile Auto

Sound Property _SNHungerLP Auto
Sound Property _SNHungerFullLP_M Auto
Sound Property _SNHungerFullLP_F Auto
Sound Property _SNFatigueLP_M Auto
Sound Property _SNFatigueLP_F Auto
Sound Property _SNThirstLP_M Auto
Sound Property _SNThirstLP_F Auto
Sound Property _SNWaterskinWaterBodyRefillLP Auto
Sound Property _SNWaterskinRefillLP Auto
Sound Property _SNSaltMeatLP Auto
Sound Property _SNSnowGatherLP Auto
Sound Property _SNWaterskinEmptyLP Auto

Faction Property BanditFaction Auto
Faction Property ForswornFaction Auto
Faction Property WarlockFaction Auto

FormList Property _SNFood_BloodList Auto
FormList Property _SNFood_WaterList Auto
FormList Property _SNFood_DrinkList Auto
FormList Property _SNFood_DrinkSnowList Auto
FormList Property _SNFood_DrinkNoAlcList Auto
FormList Property _SNFood_HeavyList Auto
FormList Property _SNFood_LightList Auto
FormList Property _SNFood_MedList Auto
FormList Property _SNFood_SoupList Auto
FormList Property _SNFood_RawList Auto
FormList Property _SNFood_HorseList Auto
FormList Property _SNFood_SkoomaList Auto
FormList Property _SNFood_NoSpoilList Auto
FormList Property _SNFood_IgnoreList Auto
FormList Property _SNPotion_CureList Auto
FormList Property _SNMagicEffect_CureList Auto
FormList Property _SNSnowStatList Auto
FormList Property _SNScannedCellsList Auto
FormList Property _SNHarvest_CropList Auto
FormList Property _SNHarvest_CropIngredientList Auto
FormList Property _SNHarvestableCellsList Auto
FormList Property _SNHabitationList Auto
FormList Property _SNFollowerIgnoreList Auto
FormList Property _SNFireList Auto
FormList Property _SNTentList Auto

GlobalVariable Property _SNHungerRate Auto
GlobalVariable Property _SNThirstRate Auto
GlobalVariable Property _SNFatigueRate Auto
GlobalVariable Property _SNAutoHungerToggle Auto
GlobalVariable Property _SNAutoThirstToggle Auto
GlobalVariable Property _SNHungerPenalty Auto
GlobalVariable Property _SNFatiguePenalty Auto
GlobalVariable Property _SNThirstPenalty Auto
GlobalVariable Property _SNFollowerNeedsToggle Auto
GlobalVariable Property _SNCannibalToggle Auto
GlobalVariable Property _SNDiseaseStage Auto
GlobalVariable Property _SNDiseaseToggle Auto
GlobalVariable Property _SNPriestCureCost Auto
GlobalVariable Property _SNFollowerToggle Auto
GlobalVariable Property _SNFollowerPurchaseToggle Auto
GlobalVariable Property _SNFoodRemovalChance Auto
GlobalVariable Property _SNFoodRemovalToggle Auto
GlobalVariable Property _SNValuedHarvestsToggle Auto
GlobalVariable Property _SNValuedHarvestsDialogueToggle Auto
GlobalVariable Property _SNVampWereToggle Auto
GlobalVariable Property _SNAdrenalineToggle Auto
GlobalVariable Property _SNWaterskinEquipToggle Auto
GlobalVariable Property _SNUnknownAllToggle Auto
GlobalVariable Property _SNHorseNeedsToggle Auto
GlobalVariable Property _SNCarryWeightMag Auto
GlobalVariable Property _SNPriestFreeCure Auto
GlobalVariable Property _SNWellnessLevel Auto
GlobalVariable Property _SNVariedDietLevel Auto
GlobalVariable Property IsHoliday Auto
GlobalVariable Property Timescale Auto
GlobalVariable Property InTheCold Auto
GlobalVariable Property InTheColdTimed Auto

Worldspace Property Tamriel Auto
Worldspace Property Solstheim Auto

Location Property RiftenRaggedFlagonLocation Auto
Location Property HighHrothgarLocation Auto
Location Property DLC1HunterHQLocationInterior Auto

Race Property WoodelfRace Auto
Race Property WoodelfRaceVampire Auto

Quest Property _SNApplyFoodQuest_1 Auto
Quest Property _SNApplyFoodQuest_2 Auto

_SNSkyUIConfig Property _SNSKConfigQuest Auto
_SNDLCQuestScript Property _SNDLCQuest Auto
_SNDialogueScript Property _SNDialogueQuest Auto
PlayerSleepQuestScript Property PlayerSleepQuest Auto

LeveledItem Property _SNEmptyFoodList Auto
LeveledItem Property LItemBarrelFoodRawMeatSame Auto
LeveledItem Property LItemBarrelFoodSame70 Auto
LeveledItem Property LItemBarrelFoodSame75 Auto
LeveledItem Property LItemBarrelFoodSameSmall Auto
LeveledItem Property LItemMiscVendorPotion50 Auto
LeveledItem Property LItemFoodInnCommon Auto
LeveledItem Property LItemFoodInnCommon10 Auto
LeveledItem Property LItemLootIMineralsProcessed Auto
LeveledItem Property LItemFurnitureMiscItems75 Auto
LeveledItem Property LItemMiscHunterAnimalParts75 Auto
LeveledItem Property LItemApothecaryPotionCureHMS75 Auto
LeveledItem Property LItemPotionCureHMS Auto
LeveledItem Property DLC2LItemIngredientNewRR75 Auto
LeveledItem Property _SNWaterskinList Auto
LeveledItem Property _SNMerchantVendorList Auto
LeveledItem Property _SNSoupFoodList Auto
LeveledItem Property _SNDLCFoodList Auto

Form[] Property FoodInventoryList Auto
Form[] Property FoodRecentList Auto
Form[] Property FoodFollowerList Auto
Float[] Property SatiationList Auto

Float Property fModVersion Auto
Float Property SKSEVersion Auto
Float Property TimeUpdate Auto
Float Property HungerRate = 10.5 Auto
Float Property FatigueRate = 5.0 Auto
Float Property ThirstRate = 13.0 Auto
Float Property HungerState = 75.0 Auto
Float Property FatigueState = 100.0 Auto
Float Property ThirstState = 75.0 Auto
Float Property TempHungerState = 100.0 Auto
Float Property TempFatigueState = 100.0 Auto
Float Property TempThirstState = 100.0 Auto
Float Property HungerVol = 0.5 Auto
Float Property FatigueVol = 0.5 Auto
Float Property ThirstVol = 0.5 Auto
Float Property FoodMult = 1.0 Auto
Float Property DrinkMult = 1.0 Auto
Float Property WidgetAlpha = 100.0 Auto
Float Property FollowerHungerRate = 3.5 Auto
Float Property FollowerThirstRate = 3.0 Auto
Float Property CombatIncreaseNeeds = 0.0 Auto
Float Property RawFreshness = 0.6 Auto
Float Property LightFreshness = 5.0 Auto
Float Property MedFreshness = 1.1 Auto
Float Property HeavyFreshness = 1.0 Auto
Float Property AdrenalineStart Auto
Float Property AdrenalineFinish Auto
Float Property TimeInAdrenaline Auto

Int Property WidgetOrient = 0 Auto
Int Property WidgetPos = 0 Auto
Int Property NotifHUD = 2 Auto
Int Property WidgetXOffset = 0 Auto
Int Property WidgetYOffset = 0 Auto
Int Property WellnessNeeds = 5 Auto
Int Property VariedDietCount = 5 Auto
Int Property HungerLevel Auto
Int Property FatigueLevel Auto
Int Property ThirstLevel Auto
Int Property TimePassed Auto
Int Property RefillableSkins_Total Auto
Int Property DefaultColor Auto
Int Property Animations Auto
Int Property FoodPriority Auto
Int Property BreakableWaterskins Auto
Int Property HasSalmonella Auto
Int Property DrunkAlcohol Auto
Int Property DiseaseType Auto
Int PenaltyHungerIncrement
Int PenaltyFatigueIncrement
Int PenaltyThirstIncrement
Int NotifHungerIncrement = 10
Int NotifFatigueIncrement = 10
Int NotifThirstIncrement = 10
Int DrunkCount

Bool Property SkyInstalled Auto
Bool Property ModUpdated Auto
Bool Property ModRestarted Auto
Bool Property ForceFollowerConsume Auto
Bool Property FoodWeight = True Auto
Bool Property FoodNoEffect Auto
Bool Property FoodPrice Auto
Bool Property NotifAutoText = True Auto
Bool Property UnderShelter = True Auto
Bool Property AnimationsFollowers = True Auto
Bool Property RefillAnimate = True Auto
Bool Property EnableMod = True Auto
Bool Property EnableAlcohol = True Auto
Bool Property EnableSkooma = True Auto
Bool Property ForceThird = True Auto
Bool Property AlcoholDehydrates Auto
Bool Property AutoRefill Auto
Bool Property CarriageFastTravel Auto
Bool Property Recategorize Auto
Bool Property NotifText Auto
Bool Property IsMale = True Auto
Bool Property IsSitting Auto
Bool Property IsBedRoll Auto
Bool Property IsWerewolf Auto
Bool Property IsWerewolfHuman Auto
Bool Property PlayerIsWoodelf Auto
Bool Property Death Auto
Bool Property SetLeveledLists Auto
Bool Property SetPotionLists Auto
Bool Property SetPotionListsRevert Auto
Bool Property HarmfulRaw = True Auto
Bool Property NoSalt Auto
Bool Property IsInWater
	Bool Function Get()
		Return PO3_SKSEFunctions.IsActorInWater(PlayerRef)
	EndFunction
EndProperty
Bool Property IsInWarmWater Auto
Bool Property FoodSpoilage Auto
Bool Property JustSlept Auto
Bool Property DisplayPercent = True Auto
Bool Property WidgetHide Auto
Bool Property DiseaseCuring Auto
Bool Property IsVanillaDiseased Auto
Bool Property ConsumptionNotif Auto
Bool Property DiseaseNotif Auto
Bool Property WidgetDisease Auto
Bool Property IsCooking Auto
Bool Property NoAnimate Auto
Bool Property Weary Auto
Bool Property Restore Auto
Bool Property EnableActionsSpell Auto
Bool Property iNeedDDInstalled Auto
Bool Property DFSInstalled Auto
Bool Property EFFInstalled Auto
Bool AutoDrinking
Bool WellnessBuffer

Bool SkoomaFX
Bool DrunkNotice
Bool SetMerchantList

String Property Tip01Text = "Prepared food tends to be more filling while water is most effective at quenching your Thirst. Eating raw meat will still lower Hunger but may make you sick. If fast traveling via carriage or sitting and Waiting for at least 2 hours, you will rest for the time spent sitting. However, that type of resting along with sleeping in bedrolls/hay piles is not as effective as sleeping in a bed/tent. Sleeping in unsafe interiors such as dungeons is also less effective than sleeping in a safe interior such as a home." Auto
String Property Tip02Text = "You will receive buffs for maintaining each of your needs. Debuffs will progress through three stages (mild, moderate, severe) after your needs haven't been met for some time. Thirst penalties progress the fastest, followed by Fatigue, and then Hunger. The Wellness buff gives you a bonus to Health dependent on your overall well-being. Stay healthy and over time this bonus will increase. Neglect your needs and this bonus will eventually decrease. Maintaining a Varied Diet gives you a bonus to Stamina and Magicka, which can also increase/decrease over time depending on your diet." Auto
String Property Tip03Text = "Adrenaline/Weariness is a mechanic that helps make your needs feel less irksome and encourages preparation before dungeon diving. In unsafe interiors you will have the Adrenaline buff, which slows down the rate of your needs by 50%. However, after exiting, you will be afflicted with Weariness if you've spent enough time under Adrenaline. This debuff speeds up the rate of your needs by 100% for half of the time you've spent under Adrenaline. Adrenaline/Weariness doesn't apply to hybrid vampires." Auto
String Property Tip04Text = "Alcohol has the effect of off-setting Hunger a bit due to having a higher caloric content than water but will not be as hydrating. Drinking too much alcohol within a short time span will put you in a drunken state with visual impairment effects. You can either wait out the debuff or sleep it off. Consuming Skooma will produce a quick Stamina regeneration buff but a longer lasting debuff to Magicka and spells." Auto
String Property Tip05Text = "Waterskins can be purchased from innkeepers, merchants who sell general goods and can sometimes be found on NPCs. They can also be crafted at a Leather Rack. Empty Waterskins will be listed under the 'Misc' category and filled ones will be listed under the 'Food' category in your inventory." Auto
String Property Tip06Text = "Water Barrels/Kegs are intended to serve as an easy source of water for locations where it would make sense. Barrels/kegs can be purchased from general goods merchants or crafted at a Forge. Once a location to build is chosen, simply drop the item or access it from your inventory." Auto
String Property Tip07Text = "Water Buckets are intended to serve as an in-game patching system for mod-added wells not supported by iNeed. Water buckets can be crafted at a Forge and then placed anywhere in the world by dropping or accessing them from your inventory. There are no restrictions on placement so they can be placed near unsupported wells or any other location you deem appropriate." Auto
String Property Tip08Text = "This mechanic requires the 'iNeed - Extended' addon. Snow can be collected from exterior medium to large snow drifts/mounds by activating them. It can be consumed as is to satisfy Thirst but will make you slightly hungrier. Snow can also be melted into empty Waterskins at a Cooking Pot. Don't take too long to make use of it though. Snow will eventually melt and disappear from your inventory. If 'Wet and Cold' is installed, the time it takes to melt depends on your location." Auto
String Property Tip09Text = "Refills can be... 1. Purchased from an innkeeper or any traveler with a Waterskin in their inventory 2. Requested from an NPC that you have become friendly with (done quests for) in an interior 3. Collected from any upright bucket/kettle out in the open when it's raining 4. Collected from any open wells/Water Barrels/Kegs 5. Collected by standing in bodies of fresh water and attempting to refill them or in the form of snow (see 'Snow Hydration')." Auto

String Property RecategorizeStartText = "This consumable is " Auto
String Property RecategorizeRawText = "a raw food item." Auto
String Property RecategorizeSoupText = "a soup item." Auto
String Property RecategorizeLightText = "a light food item." Auto
String Property RecategorizeMedText = "a medium food item." Auto
String Property RecategorizeHeavyText = "a heavy food item." Auto
String Property RecategorizeDrinkText = "an alcoholic drink." Auto
String Property RecategorizeDrinkNoAlcText = "a non-alcoholic drink." Auto
String Property RecategorizeUnknownText = "not recognized by iNeed yet." Auto
String Property ConfigText = "Changes saved." Auto
String Property NoWaterText = "There is no water in this container." Auto
String Property FollowerAutoConsumeText = " has consumed " Auto
String Property FollowerSharedRefillMText = " picks up his Waterskin." Auto
String Property FollowerSharedRefillFText = " picks up her Waterskin." Auto
String Property FollowerNWaterText = " complains about the lack of drinks." Auto
String Property FollowerNFoodText = " grumbles about the lack of food." Auto
String Property SpoilText = " has spoiled completely." Auto
String Property Spoil_1 = "Lightly Stale" Auto
String Property Spoil_2 = "Mildly Stale" Auto
String Property Spoil_3 = "Stale" Auto
String Property Spoil_4 = "Very Stale" Auto
String Property Spoil_5 = "Severely Stale" Auto
String Property Spoil_6 = "Salted" Auto
String Property NoSaltText = "Salt Pile (7) is needed to cure meat." Auto
String Property NoSaltDecayText = "This meat is already decaying." Auto
String Property FollowerSnowDecayText_1 = " groans about the melting snow." Auto
String Property FollowerNoGoldText = " laments over the lack of gold for supplies." Auto
String Property SpoilageReminder = "iNeed: Spoilage enabled. Remove/add all food back to your inventory." Auto
String Property FollowerStatusMText_1 = " checks his bag: " Auto
String Property FollowerStatusFText_1 = " checks her bag: " Auto
String Property FollowerStatusText_2 = " edibles and " Auto
String Property FollowerStatusText_3 = " drinks." Auto
String Property RestartText = "iNeed has been restarted." Auto
String Property NoWaterSourceText Auto
String Property RestText Auto
String Property DrinkWaterText Auto
String Property SalmonellaText Auto
String Property DiseaseCureText Auto
String Property SnowDecayText Auto
String Property UnknownWaterText Auto
String Property DiseaseNotifText Auto
String Property NoFireText Auto
String Property NoRoastItemText Auto
String AutoConsumeText = " has been consumed."
String WaterskinBreakText = "A Waterskin has been shredded to pieces."
String FollowerWaterskinBreakText_1 = " frets over the broken Waterskin."
String SatedText
String SatedNormalText
String SatedShortText = " well sated. "
String SatedNormalShortText = " sated. "
String HydratedText
String HydratedNormalText
String HydratedShortText = " well hydrated. "
String HydratedNormalShortText = " hydrated. "
String RestedText
String RestedNormalText
String RestedShortText = " well rested. "
String RestedNormalShortText = " rested. "
String DrunkText
String HungryText_1
String HungryText_2
String HungryText_3
String HungryText_4
String HungryShortText_1 = " a bit hungry. "
String HungryShortText_2 = " mildly hungry. "
String HungryShortText_3 = " moderately hungry. "
String HungryShortText_4 = " severely hungry. "
String ThirstyText_1
String ThirstyText_2
String ThirstyText_3
String ThirstyText_4
String ThirstyShortText_1 = " a bit thirsty. "
String ThirstyShortText_2 = " mildly thirsty. "
String ThirstyShortText_3 = " moderately thirsty. "
String ThirstyShortText_4 = " severely thirsty. "
String FatigueText_1
String FatigueText_2
String FatigueText_3
String FatigueText_4
String FatigueShortText_1 = " a bit fatigued. "
String FatigueShortText_2 = " mildly fatigued. "
String FatigueShortText_3 = " moderately fatigued. "
String FatigueShortText_4 = " severely fatigued. "
String DeathFatigueText
String DeathThirstText
String DiseaseNotifText_1
String DiseaseNotifText_2
String DiseaseNotifText_3
String DiseaseNotifText_4
String DiseaseNotifText_5
String StatusText
String NoGoldText
String CheckInventoryText
String AutoConsumeNoFoodText

String MCMWarnStart = "iNeed: Initializing. Do not open the MCM."
String MCMWarnEnd = "iNeed: You may open the MCM. There may be a delay before the menu registers."
String NoSKSEText = "iNeed: SKSE not detected. Some features will be disabled."
String UpdateText = "iNeed: Updated to "

Actor Property _SNDummyActor Auto
Actor Property PlayerRef Auto
Actor targ

;====================================================================================           Strings

Function SetPerspective(Bool FirstPersonText = False)
    If FirstPersonText
        RestText = "I wake up as the carriage comes to a halt."
        DrinkWaterText = "I take a drink from the nearby water."
        SalmonellaText = "I have contracted Stomach Rot."
        DiseaseCureText = "My body begins to feel the effects of the cure."
        SatedText = "I am feeling well sated."
        SatedNormalText = "I am feeling sated."
        HydratedText = "I am feeling well hydrated."
        HydratedNormalText = "I am feeling hydrated."
        RestedText = "I am feeling well rested."
        RestedNormalText = "I am feeling rested."
        DrunkText = "I am feeling drunk."
        HungryText_1 = "I am feeling a bit hungry."
        HungryText_2 = "I am feeling mildly hungry."
        HungryText_3 = "I am feeling moderately hungry."
        HungryText_4 = "I am feeling severely hungry."
        ThirstyText_1 = "I am feeling a bit thirsty."
        ThirstyText_2 = "I am feeling mildly thirsty."
        ThirstyText_3 = "I am feeling moderately thirsty."
        ThirstyText_4 = "I am feeling severely thirsty."
        FatigueText_1 = "I am feeling a bit fatigued."
        FatigueText_2 = "I am feeling mildly fatigued."
        FatigueText_3 = "I am feeling moderately fatigued."
        FatigueText_4 = "I am feeling severely fatigued."
        DeathFatigueText = "I am dying from fatigue."
        DeathThirstText = "I am dying from thirst."
        SnowDecayText = "My snow has melted."
        UnknownWaterText = "The water here looks questionable. Should I try it again?"
        DiseaseNotifText_1 = "My body aches immensely."
        DiseaseNotifText_2 = "I feel unusually weaker all of a sudden."
        DiseaseNotifText_3 = "My heart and head throb irregularly."
        DiseaseNotifText_4 = "I feel abnormally cold and clammy."
        DiseaseNotifText_5 = "Bizarre amounts of sweat continue to roll down my face."
        StatusText = "I am"
        NoGoldText = "I do not have enough gold."
        CheckInventoryText = "I check my bag: "
        NoFireText = "I am not close enough to a fire."
        NoRoastItemText = "I have nothing to roast."
        NoWaterSourceText = "I am not close enough to drinkable water."
        AutoConsumeNoFoodText = "I have no more consumables in my bag."
    Else
        RestText = "You wake up as the carriage comes to a halt."
        DrinkWaterText = "You take a drink from the nearby water."
        SalmonellaText = "You have contracted Stomach Rot."
        DiseaseCureText = "Your body begins to feel the effects of the cure."
        SatedText = "You are feeling well sated."
        SatedNormalText = "You are feeling sated."
        HydratedText = "You are feeling well hydrated."
        HydratedNormalText = "You are feeling hydrated."
        RestedText = "You are feeling well rested."
        RestedNormalText = "You are feeling rested."
        DrunkText = "You are feeling drunk."
        HungryText_1 = "You are feeling a bit hungry."
        HungryText_2 = "You are feeling mildly hungry."
        HungryText_3 = "You are feeling moderately hungry."
        HungryText_4 = "You are feeling severely hungry."
        ThirstyText_1 = "You are feeling a bit thirsty."
        ThirstyText_2 = "You are feeling mildly thirsty."
        ThirstyText_3 = "You are feeling moderately thirsty."
        ThirstyText_4 = "You are feeling severely thirsty."
        FatigueText_1 = "You are feeling a bit fatigued."
        FatigueText_2 = "You are feeling mildly fatigued."
        FatigueText_3 = "You are feeling moderately fatigued."
        FatigueText_4 = "You are feeling severely fatigued."
        DeathFatigueText = "You are dying from fatigue."
        DeathThirstText = "You are dying from thirst."
        SnowDecayText = "Your snow has melted."
        UnknownWaterText = "The water here looks questionable. Should you try it again?"
        DiseaseNotifText_1 = "Your body aches immensely."
        DiseaseNotifText_2 = "You feel unusually weaker all of a sudden."
        DiseaseNotifText_3 = "Your heart and head throb irregularly."
        DiseaseNotifText_4 = "You feel abnormally cold and clammy."
        DiseaseNotifText_5 = "Bizarre amounts of sweat continue to roll down your face."
        StatusText = "You are"
        NoGoldText = "You do not have enough gold."
        CheckInventoryText = "You check your bag: "
        NoFireText = "You are not close enough to a fire."
        NoRoastItemText = "You have nothing to roast."
        NoWaterSourceText = "You are not close enough to drinkable water."
        AutoConsumeNoFoodText = "You have no more consumables in your bag."
    EndIf
EndFunction

;====================================================================================           Food removal

Function ScanFood()
    Form CurrentCell = targ.GetParentCell()
    If !_SNScannedCellsList.HasForm(CurrentCell)
        Location CurrentLoc = targ.GetCurrentLocation()         
        If CurrentLoc.HasKeyword(LocTypeHouse)
            If CurrentLoc.HasKeyword(TGWealthyHome)
                _SNFoodRemovalChance.SetValue(16)   ;30%            int = (1 - sqrt(1 - intended decimal)) * 100
            Else
                _SNFoodRemovalChance.SetValue(29)   ;50%
            EndIf
        ElseIf CurrentLoc.HasKeyword(LocTypeInn) || CurrentLoc.HasKeyword(LocTypeStore)
            _SNFoodRemovalChance.SetValue(16)   ;30%
        ElseIf CurrentLoc.HasKeyword(LocTypeDwelling) || CurrentLoc.HasKeyword(LocTypeHabitation) || CurrentLoc.HasKeyword(LocTypeTemple) || CurrentLoc == HighHrothgarLocation
            _SNFoodRemovalChance.SetValue(29)   ;50%
        ElseIf CurrentLoc.HasKeyword(LocTypeMilitaryFort) || CurrentLoc.HasKeyword(LocTypeBarracks) || (DLC1HunterHQLocationInterior && CurrentLoc == DLC1HunterHQLocationInterior) || CurrentLoc.HasKeyword(LocTypeBanditCamp) || CurrentLoc.HasKeyword(LocTypeForswornCamp) || CurrentLoc.HasKeyword(LocTypeWarlockLair)
            _SNFoodRemovalChance.SetValue(37)   ;60%
        ElseIf CurrentLoc.HasKeyword(LocTypeDungeon)
            _SNFoodRemovalChance.SetValue(100)  ;100%
        Else
            Return
        EndIf
        _SNApplyFoodQuest_1.Start()
        Utility.Wait(0.1)
        _SNApplyFoodQuest_1.Stop()
        _SNApplyFoodQuest_2.Start()
        Utility.Wait(0.1)
        _SNApplyFoodQuest_2.Stop()
        _SNScannedCellsList.AddForm(CurrentCell)
    EndIf
EndFunction

;====================================================================================           Harvests

Function CheckLoc()
    Location CurrentLoc = targ.GetCurrentLocation()
    If !Game.FindRandomReferenceOfTypeFromRef(_SNWaterBarrel, targ, 2048.0)
        If CurrentLoc.HasKeyword(LocTypeHabitation) || CurrentLoc.HasKeyword(LocTypeMilitaryCamp)
            ShowHarvestMenu()
        Else
            Cell CurrentCell = targ.GetParentCell()
            If _SNHarvestableCellsList.HasForm(CurrentCell)
                ShowHarvestMenu()
            ElseIf !CurrentLoc.HasKeyword(LocTypeClearable) && Game.FindClosestReferenceOfAnyTypeInListFromRef(_SNHabitationList, targ, 512.0)
                ShowHarvestMenu()
            Else
                AddHarvestable(0)
            EndIf
        EndIf
    Else
        AddHarvestable(0)
    EndIf
EndFunction

Function ShowHarvestMenu()  
    Int HarvestOption = _SNHarvestMsg.Show()
    If HarvestOption == 0
        AddHarvestable(1)
    ElseIf HarvestOption == 1
        AddHarvestable(2)
    EndIf
EndFunction

Function AddHarvestable(Int Type)
    ObjectReference HarvestedRef = Game.GetCurrentCrosshairRef()
    Form HarvestedPlant = HarvestedRef.GetBaseObject()
    If HarvestedPlant
        Int iIndex = _SNHarvest_CropList.Find(HarvestedPlant)
        Int IngredientCount = 1
        Form HarvestedItem
        If iIndex < 6
            HarvestedItem = _SNHarvest_CropIngredientList.GetAt(iIndex)
        ElseIf iIndex < 8
            HarvestedItem = _SNHarvest_CropIngredientList.GetAt(6)
        ElseIf iIndex < 10
            HarvestedItem = _SNHarvest_CropIngredientList.GetAt(7)
        ElseIf iIndex < 14
            HarvestedItem = _SNHarvest_CropIngredientList.GetAt(8)
        ElseIf iIndex == 14
            HarvestedItem = _SNHarvest_CropIngredientList.GetAt(9)
            IngredientCount = 3
        ElseIf iIndex == 15
            HarvestedItem = _SNHarvest_CropIngredientList.GetAt(9)
        ElseIf iIndex == 16
            HarvestedItem = _SNHarvest_CropIngredientList.GetAt(10)
        EndIf
        If HarvestedItem
            If Type == 2
                ObjectReference AddedItem = targ.PlaceAtMe(HarvestedItem, IngredientCount, false, true)
                AddedItem.MoveTo(targ, 0.0, 0.0, -1000.0, false)
                AddedItem.Enable()
                AddedItem.SetActorOwner(_SNDummyActor.GetActorBase())
                AddedItem.SendStealAlarm(targ)
                HarvestedRef.Disable()
                HarvestedRef.SetHarvested(true)
                HarvestedRef.Enable()
                targ.AddItem(AddedItem)
            ElseIf Type == 1
                Int ItemValue = (HarvestedItem.GetGoldValue() as Int * 4 * IngredientCount)
                If ItemValue > 0 && targ.GetItemCount(Gold001) as Int >= ItemValue
                    targ.RemoveItem(Gold001, ItemValue)
                    HarvestedRef.Activate(targ)
                Else
                    Debug.Notification(NoGoldText)
                EndIf
            Else
                HarvestedRef.Activate(targ)
            EndIf
        EndIf
    EndIf
EndFunction

;====================================================================================           Cheese wheels

Function CheckCheese(Actor Target, Form Food)
    If Food == FoodCheeseWheel01A
        Target.AddItem(FoodCheeseWedge01, 11)
    ElseIf Food == FoodCheeseWheel01B
        Target.AddItem(FoodCheeseWedge01, 7)
    ElseIf Food == FoodCheeseWheel02A
        Target.AddItem(FoodCheeseWedge02, 8)
    ElseIf Food == FoodCheeseWheel02B
        Target.AddItem(FoodCheeseWedge02, 7)
    EndIf
EndFunction

;====================================================================================           Salt

Function CheckSalt(ConstructibleObject Recipe)
    Int i = 0
    While i < Recipe.GetNumIngredients()
        If Recipe.GetNthIngredient(i) == SaltPile
            Recipe.SetNthIngredientQuantity(0, i)
            Return
        Else
            i += 1
        EndIf
    EndWhile
EndFunction

Function RemoveSalt()
    CheckSalt(RecipeFoodBeefCooked)
    CheckSalt(RecipeFoodChickenCooked)
    CheckSalt(RecipeFoodGoatCooked)
    CheckSalt(RecipeFoodHorkerCooked)
    CheckSalt(RecipeFoodHorseCooked)
    CheckSalt(RecipeFoodMammothCooked)
    CheckSalt(RecipeFoodPheasantCooked)
    CheckSalt(RecipeFoodRabbitCooked)
    CheckSalt(RecipeFoodSalmonCooked)
    CheckSalt(RecipeFoodVenisonCooked)
EndFunction

Bool Function IsInSaltWater()
    Worldspace CurrentWorld = targ.GetWorldSpace()
    Int PosX = targ.GetPositionX() as Int
    Int PosY = targ.GetPositionY() as Int
    If CurrentWorld == Tamriel
        If PosY > 104000
            Return True
        ElseIf PosY > 86500 && PosX < -10800
            If PosX < -104290 && PosX > -111010 && PosY > 92490 && PosY < 98980         ;clearpine pond
                Return False
            EndIf
            Return True
        ElseIf PosY > 50250 && PosX > 109250
            Return True
        ElseIf PosY > 15500 && PosX > 120000
            Return True
        EndIf
    ElseIf Solstheim && CurrentWorld == Solstheim
        If PosX < 31070
            Return True
        ElseIf PosY < 24385
            Return True
        ElseIf PosY > 79100
            Return True
        ElseIf PosX > 76350
            Return True 
        EndIf
    EndIf
    Return False
endFunction

;====================================================================================           Breakable Waterskins

Function BreakWater(Actor Target)
    If EnableMod
        Int RandomNum = Utility.RandomInt(1, 1000)
        Int Chance =(BreakableWaterskins * 10)
        Form BrokenWaterskin
        If RandomNum < Chance
            If Target.GetItemCount(_SNWaterSkin_0) as Int > 0
                BrokenWaterskin = _SNWaterSkin_0
            ElseIf Target.GetItemCount(_SNWaterSkin_1) as Int > 0
                BrokenWaterskin = _SNWaterSkin_1
            ElseIf Target.GetItemCount(_SNWaterSkin_2) as Int > 0
                BrokenWaterskin = _SNWaterSkin_2
            ElseIf Target.GetItemCount(_SNWaterSkin_3) as Int > 0
                BrokenWaterskin = _SNWaterSkin_3
            EndIf
        ElseIf RandomNum < Chance * 2
            If Target.GetItemCount(_SNWaterSkin_1) as Int > 0
                BrokenWaterskin = _SNWaterSkin_1
            ElseIf Target.GetItemCount(_SNWaterSkin_2) as Int > 0
                BrokenWaterskin = _SNWaterSkin_2
            ElseIf Target.GetItemCount(_SNWaterSkin_3) as Int > 0
                BrokenWaterskin = _SNWaterSkin_3
            ElseIf Target.GetItemCount(_SNWaterSkin_0) as Int > 0
                BrokenWaterskin = _SNWaterSkin_0
            EndIf
        ElseIf RandomNum < Chance * 3
            If Target.GetItemCount(_SNWaterSkin_2) as Int > 0
                BrokenWaterskin = _SNWaterSkin_2
            ElseIf Target.GetItemCount(_SNWaterSkin_3) as Int > 0
                BrokenWaterskin = _SNWaterSkin_3
            ElseIf Target.GetItemCount(_SNWaterSkin_0) as Int > 0
                BrokenWaterskin = _SNWaterSkin_0
            ElseIf Target.GetItemCount(_SNWaterSkin_1) as Int > 0
                BrokenWaterskin = _SNWaterSkin_1
            EndIf
        ElseIf RandomNum < Chance * 4
            If Target.GetItemCount(_SNWaterSkin_3) as Int > 0
                BrokenWaterskin = _SNWaterSkin_3
            ElseIf Target.GetItemCount(_SNWaterSkin_0) as Int > 0
                BrokenWaterskin = _SNWaterSkin_0
            ElseIf Target.GetItemCount(_SNWaterSkin_1) as Int > 0
                BrokenWaterskin = _SNWaterSkin_1
            ElseIf Target.GetItemCount(_SNWaterSkin_2) as Int > 0
                BrokenWaterskin = _SNWaterSkin_2
            EndIf
        EndIf
        If BrokenWaterskin
            Target.RemoveItem(BrokenWaterskin, 1, true)
            If Target == PlayerRef
                Target.AddItem(LeatherStrips, 1, true)
                Debug.Notification(WaterskinBreakText)
            Else
                If EFFInstalled
                    PlayerRef.AddItem(LeatherStrips, 1, true)
                    PlayerRef.RemoveItem(LeatherStrips, 1, true, Target)
                Else    
                    Target.AddItem(LeatherStrips, 1, true)
                EndIf
                Debug.Notification(Target.GetBaseObject().GetName() + FollowerWaterskinBreakText_1)
            EndIf
        EndIf
    EndIf
EndFunction

;====================================================================================           Diseases    disable until decide what to do with it

Int Function Round(Float i) Global
    If (i - (i as Int)) < 0.5
        Return (i as Int)
    EndIf
    Return (Math.Ceiling(i) as Int)
EndFunction

Function SetPotionLeveledLists(Bool Revert)
    If !Revert
        LItemApothecaryPotionCureHMS75.SetChanceNone(85)
        LItemPotionCureHMS.SetChanceNone(85)
        If !SetPotionLists
            Int iIndex = _SNPotion_CureList.GetSize()
            While iIndex > 0
                iIndex -= 1
                Form CurePotion = _SNPotion_CureList.GetAt(iIndex)
                If iIndex == 2 || iIndex == 4
                    If DLC2LItemIngredientNewRR75
                        DLC2LItemIngredientNewRR75.AddForm(CurePotion, 1, 1)
                    EndIf
                Else
                    LItemApothecaryPotionCureHMS75.AddForm(CurePotion, 1, 1)
                    LItemPotionCureHMS.AddForm(CurePotion, 1, 1)
                EndIf
            EndWhile
            SetPotionListsRevert = True
        EndIf
        SetPotionLists = True
    ElseIf !SetPotionListsRevert
        LItemApothecaryPotionCureHMS75.Revert()
        LItemPotionCureHMS.Revert()
        LItemApothecaryPotionCureHMS75.SetChanceNone(85)
        LItemPotionCureHMS.SetChanceNone(85)
        SetPotionListsRevert = False
        SetPotionLists = False
    EndIf
EndFunction

Function DiseaseNotification()
    If DiseaseNotif
        String[] DiseaseInt = New String[5]
        DiseaseInt[0] = DiseaseNotifText_1
        DiseaseInt[1] = DiseaseNotifText_2
        DiseaseInt[2] = DiseaseNotifText_3
        DiseaseInt[3] = DiseaseNotifText_4
        DiseaseInt[4] = DiseaseNotifText_5
        DiseaseNotifText = DiseaseInt[Utility.RandomInt(0, 4)]
        Debug.Notification(DiseaseNotifText)
    EndIf
EndFunction

Function DiseaseRoll()
    If !targ.HasKeyword(Vampire) && !IsWerewolfHuman
        If _SNDiseaseToggle.GetValue() as Int == 1 && HasSalmonella == 0 && !IsVanillaDiseased && _SNDiseaseStage.GetValue() as Int == 0 && Utility.RandomInt(1, 50) == 10
            CauseStomachRot()
        ElseIf Utility.RandomInt(1, 50) == 10
            CauseStomachRot(true)
        EndIf
    EndIf
EndFunction

Function CauseStomachRot(Bool Vanilla = False)
    If Utility.RandomInt(1, 100) > targ.GetAV("DiseaseResist") as Int
        If Vanilla
            targ.AddSpell(_SNDisSalmonVanillaSpell, false)
        Else
            targ.AddSpell(_SNDisSalmonSpell_1, false)
            _SNDiseaseStage.SetValue(1)
            Game.IncrementStat("Diseases Contracted")
        EndIf
        Debug.Notification(SalmonellaText)
    EndIf
EndFunction

Function CalcCosts(Int DiseaseStageInt)
    Int SpeechSkill = targ.GetActorValue("Speechcraft") as Int
    Int DiseaseStage = DiseaseStageInt
    Int CureCost
    If SpeechSkill < 0
        SpeechSkill = 0
    ElseIf SpeechSkill > 100
        SpeechSkill = 100
    EndIf
    If DiseaseStage < 2
        CureCost = 200
    ElseIf DiseaseStage == 2
        CureCost = 400
    ElseIf DiseaseStage == 3
        CureCost = 700
    Else
        CureCost = 1100
    EndIf
    Int SpeechDiscount = Round((CureCost / 2.0) * (SpeechSkill / 100.0))
    Int SubTotal = CureCost - SpeechDiscount
    If IsHoliday
        Int Holiday = IsHoliday.GetValue() as Int
        If Holiday == 17
            SubTotal = Round(SubTotal / 2.0)
            _SNPriestFreeCure.SetValue(0)
        ElseIf Holiday == 3 || Holiday == 7 || Holiday == 9
            SubTotal = 0
            _SNPriestFreeCure.SetValue(1)
        Else
            _SNPriestFreeCure.SetValue(0)
        EndIf
    Else
        _SNPriestFreeCure.SetValue(0)
    EndIf
    _SNPriestCureCost.SetValue(SubTotal)
    _SNDialogueQuest.UpdateGlobals()
EndFunction

Function PriestCure(Actor akSpeaker)
    targ.AddItem(_SNCureDisease, 1, true)
    targ.EquipItem(_SNCureDisease, false, true)
    Int CureCost = _SNPriestCureCost.GetValue() as Int
    If CureCost > 0
        targ.RemoveItem(Gold001, CureCost, false, akSpeaker)
    EndIf
EndFunction

Function CureDisease()
    targ.RemoveSpell(_SNDisAtaxiaSpell_1)
    targ.RemoveSpell(_SNDisAtaxiaSpell_2)
    targ.RemoveSpell(_SNDisAtaxiaSpell_3)
    targ.RemoveSpell(_SNDisAtaxiaSpell_4)
    targ.RemoveSpell(_SNDisBBFSpell_1)
    targ.RemoveSpell(_SNDisBBFSpell_2)
    targ.RemoveSpell(_SNDisBBFSpell_3)
    targ.RemoveSpell(_SNDisBBFSpell_4)
    targ.RemoveSpell(_SNDisBHBSpell_1)
    targ.RemoveSpell(_SNDisBHBSpell_2)
    targ.RemoveSpell(_SNDisBHBSpell_3)
    targ.RemoveSpell(_SNDisBHBSpell_4)
    targ.RemoveSpell(_SNDisBrainRotSpell_1)
    targ.RemoveSpell(_SNDisBrainRotSpell_2)
    targ.RemoveSpell(_SNDisBrainRotSpell_3)
    targ.RemoveSpell(_SNDisBrainRotSpell_4)
    targ.RemoveSpell(_SNDisDroopsSpell_1)
    targ.RemoveSpell(_SNDisDroopsSpell_2)
    targ.RemoveSpell(_SNDisDroopsSpell_3)
    targ.RemoveSpell(_SNDisDroopsSpell_4)
    targ.RemoveSpell(_SNDisRattlesSpell_1)
    targ.RemoveSpell(_SNDisRattlesSpell_2)
    targ.RemoveSpell(_SNDisRattlesSpell_3)
    targ.RemoveSpell(_SNDisRattlesSpell_4)
    targ.RemoveSpell(_SNDisRockjointSpell_1)
    targ.RemoveSpell(_SNDisRockjointSpell_2)
    targ.RemoveSpell(_SNDisRockjointSpell_3)
    targ.RemoveSpell(_SNDisRockjointSpell_4)
    targ.RemoveSpell(_SNDisSalmonSpell_1)
    targ.RemoveSpell(_SNDisSalmonSpell_2)
    targ.RemoveSpell(_SNDisSalmonSpell_3)
    targ.RemoveSpell(_SNDisSalmonSpell_4)
    targ.RemoveSpell(_SNDisWitbaneSpell_1)
    targ.RemoveSpell(_SNDisWitbaneSpell_2)
    targ.RemoveSpell(_SNDisWitbaneSpell_3)
    targ.RemoveSpell(_SNDisWitbaneSpell_4)
    targ.RemoveSpell(_SNFeverPenaltySpell_1)
    _SNDiseaseStage.SetValue(0)
    HasSalmonella = 0
    DiseaseType = -1
    DiseaseCuring = False
    IsVanillaDiseased = False
    Utility.Wait(0.5)
    If SkyInstalled && SKSEVersion > 0.0
        SendModEvent("_SN_StatusUpdated")
    EndIf
EndFunction

Function CureDiseaseVanilla()
    IsVanillaDiseased = False
    Utility.Wait(0.5)
    If SkyInstalled && SKSEVersion > 0.0
        SendModEvent("_SN_StatusUpdated")
    EndIf
EndFunction

;====================================================================================           Refills

Bool Function AnimationStart(Bool PlaySound = False)
    If targ.GetAnimationVariableInt("i1stPerson") as Int == 1
        If ForceThird
            Game.ForceThirdPerson()
        EndIf
        targ.PlayIdle(idlepickup_ground)
        Utility.Wait(1.0)
        If PlaySound
            _SNWaterskinWaterBodyRefillLP.Play(targ)
        EndIf
        Utility.Wait(1.0)
        targ.PlayIdle(IdleStop_Loose)
        Utility.Wait(1.0)
        If !IsSitting && ForceThird
            Game.ForceFirstPerson()
        EndIf
    Else
        targ.PlayIdle(idlepickup_ground)
        If PlaySound
            Utility.Wait(1.0)
            _SNWaterskinWaterBodyRefillLP.Play(targ)
        EndIf
    EndIf
EndFunction

Bool Function PlayRefillAnim(Bool WithSound = False)
    If RefillAnimate
        If Utility.IsInMenuMode()
            Game.DisablePlayerControls(False, False, False, False, False, True)
            Utility.Wait(0.01)
            Game.EnablePlayerControls(False, False, False, False, False, True)
            Utility.Wait(0.25)
        EndIf
        If targ.IsWeaponDrawn()
            If SKSEVersion > 0.0
                targ.SheatheWeapon()
                Utility.Wait(2.0)
                AnimationStart(WithSound)
            EndIf
        Else
            AnimationStart(WithSound)
        EndIf
        Return True
    EndIf
    Return False
EndFunction

Function RefillNDrink()
    Bool Refilled
    If Refill(targ, true)
        Refilled = True
        If !RefillAnimate
            _SNWaterskinWaterBodyRefillLP.Play(targ)
        EndIf
        Utility.WaitMenuMode(1.0)
    EndIf
    If NotifAutoText
        Debug.Notification(DrinkWaterText)
    EndIf
    If !Refilled
        PlayRefillAnim()
    EndIf
    Drink(targ)
EndFunction

Bool Function RefillUnknown(Actor Target)
    Int RefillableSkins_0 = Target.GetItemCount(_SNWaterSkin_0) as Int
    If RefillableSkins_0 > 0
        PlayRefillAnim(true)
        Target.RemoveItem(_SNWaterSkin_0, 1, true)
        Target.AddItem(_SNWaterSkin_3_Unknown, 1)
        If !RefillAnimate
            _SNWaterskinWaterBodyRefillLP.Play(targ)
        EndIf
        Return True
    EndIf
    Return False
EndFunction

Bool Function Refill(Actor Target, Bool Animate = False)
    If Target == PlayerRef
        RefillableSkins_Total = 0
        If SKSEVersion > 0.0
            SendModEvent("_SN_WaterRefill")
        EndIf
    Else
        Utility.Wait(0.25)
    EndIf
    Int RefillableSkins_0 = Target.GetItemCount(_SNWaterSkin_0) as Int
    Int RefillableSkins_1 = Target.GetItemCount(_SNWaterSkin_1) as Int
    Int RefillableSkins_2 = Target.GetItemCount(_SNWaterSkin_2) as Int
    Int RefillableSkins_SubTotal = RefillableSkins_0 + RefillableSkins_1 + RefillableSkins_2
    RefillableSkins_Total += RefillableSkins_0 + RefillableSkins_1 + RefillableSkins_2
    If RefillableSkins_0 > 0
        Target.RemoveItem(_SNWaterSkin_0, RefillableSkins_0, true)
    EndIf
    If RefillableSkins_1 > 0
        Target.RemoveItem(_SNWaterSkin_1, RefillableSkins_1, true)
    EndIf
    If RefillableSkins_2 > 0
        Target.RemoveItem(_SNWaterSkin_2, RefillableSkins_2, true)
    EndIf
    Target.AddItem(_SNWaterSkin_3, RefillableSkins_SubTotal)
    If Target == PlayerRef && RefillableSkins_Total > 0
        If Animate
            PlayRefillAnim(true)
        EndIf
        Return True
    ElseIf RefillableSkins_SubTotal > 0
        Return True
    EndIf
    Return False
EndFunction

Bool Function IsSafeLocation(Location CurrentLoc)               ;water-wise
    If !IsInWarmWater
        If !targ.IsInInterior() || !CurrentLoc
            Return True
        ElseIf CurrentLoc != RiftenRaggedFlagonLocation && (!CurrentLoc.HasKeyword(LocTypeDungeon) || CurrentLoc.HasKeyword(LocTypeBanditCamp) || CurrentLoc.HasKeyword(LocTypeWarlockLair) || CurrentLoc.HasKeyword(LocTypeForswornCamp) || CurrentLoc.HasKeyword(LocTypeSprigganGrove))
            Return True
        EndIf
    EndIf
    Return False
EndFunction

Bool Function IsUnsafeLocation()
    Location CurrentLoc = targ.GetCurrentLocation()
    If CurrentLoc && !CurrentLoc.IsCleared()
        If CurrentLoc.HasKeyword(LocTypeClearable)
            If (targ.HasKeyword(Vampire) && CurrentLoc.HasKeyword(LocTypeVampireLair)) || (targ.IsInFaction(BanditFaction) && CurrentLoc.HasKeyword(LocTypeBanditCamp)) || (targ.IsInFaction(ForswornFaction) && CurrentLoc.HasKeyword(LocTypeForswornCamp)) || (targ.IsInFaction(WarlockFaction) && CurrentLoc.HasKeyword(LocTypeWarlockLair))
                Return False
            EndIf
            Return True
        EndIf
    EndIf
    Return False
EndFunction

Function RefillWithTarget(Actor Target, Actor Owner)
    If Owner.GetItemCount(_SNWaterskin_3) > 0
        Owner.RemoveItem(_SNWaterskin_3, 1, true, Target)
        Target.RemoveItem(_SNWaterskin_0, 1, true, Owner)
    ElseIf Owner.GetItemCount(_SNWaterskin_2) > 0
        Owner.RemoveItem(_SNWaterskin_2, 1, true, Target)
        Target.RemoveItem(_SNWaterskin_0, 1, true, Owner)
    ElseIf Owner.GetItemCount(_SNWaterskin_1) > 0
        Owner.RemoveItem(_SNWaterskin_1, 1, true, Target)
        Target.RemoveItem(_SNWaterskin_0, 1, true, Owner)
    EndIf
EndFunction

Function Drink(Actor Target)
    NoAnimate = True
    Target.AddItem(_SNWaterskin_2, 1, true)
    Utility.Wait(0.25)
    Target.EquipItem(_SNWaterskin_2, false, true)
    Utility.Wait(1.25)
    Target.RemoveItem(_SNWaterskin_1, 1, true)
    NoAnimate = False
EndFunction

;====================================================================================           Automation Functions

Int Function FormIndex(Form[] MyArray, Form MyForm)
    Int i = 0
    While i < MyArray.Length
        If MyArray[i] == MyForm
            Return i
        Else
            i += 1
        EndIf
    EndWhile
    Return -1
EndFunction

Function AddForm(Form[] MyArray, Form MyForm)
    Int i = 0
    While i < MyArray.Length
        If MyArray[i] == None
            MyArray[i] = MyForm
            Return
        Else
            i += 1
        EndIf
    EndWhile
EndFunction

Int Function FormCount(Form[] MyArray)
    Int i = 0
    While i < MyArray.Length
        If MyArray[i] != None
            i += 1
        Else
            Return i
        EndIf
    EndWhile
    Return i
EndFunction

Bool Function ParseAndConsume(Actor Target, FormList myFormList, Bool Remove = False, Bool Text = True)
    Int iIndex = -1
    Int ListSize = myFormList.GetSize() as Int - 1
    While iIndex < ListSize
        iIndex += 1
        Form CurrentItem = myFormList.GetAt(iIndex)
        ;Debug.Trace("Form " + iIndex + " is " + CurrentItem.GetName())
        If CurrentItem && Target.GetItemCount(CurrentItem) > 0
            If Target == PlayerRef
                Int iFood = FormIndex(FoodInventoryList, CurrentItem)
                If AutoDrinking || !FoodSpoilage || (iFood > -1 && SatiationList[iFood] > 99)
                    If !Remove
                        Target.EquipItem(CurrentItem, false, true)
                    Else
                        Target.RemoveItem(CurrentItem, 1, true)
                    EndIf
                    If NotifAutoText && Text
                        If SKSEVersion == 0.0
                            Target.AddItem(CurrentItem, 1, true)
                            Utility.Wait(0.5)
                            Target.RemoveItem(CurrentItem, 1)
                        Else
                            Debug.Notification(CurrentItem.GetName() + AutoConsumeText)
                        EndIf
                    EndIf
                    Return True
                Else
                    iIndex += 1
                EndIf
            Else
                If !Remove
                    Target.EquipItem(CurrentItem, false, true)
                Else
                    Target.RemoveItem(CurrentItem, 1, true)
                EndIf
                If (myFormList == _SNFood_HeavyList || myFormList == _SNFood_MedList || myFormList == _SNFood_SoupList || myFormList == _SNFood_LightList) && FormIndex(FoodFollowerList, CurrentItem) == -1
                    AddForm(FoodFollowerList, CurrentItem)
                EndIf
                If NotifAutoText && Text
                    If !_SNDLCQuest.CACOInstalled
                        CheckCheese(Target, CurrentItem)
                    EndIF
                    If SKSEVersion > 0.0
                        Debug.Notification(Target.GetBaseObject().GetName() + FollowerAutoConsumeText + CurrentItem.GetName() + ".")
                    EndIf
                EndIf
                Return True
            EndIf
        EndIf
    EndWhile
    Return False
EndFunction

Bool Function AutoConsume(Actor Target, Formlist Formlist1, FormList FormList2 = None, FormList FormList3 = None, FormList FormList4 = None, FormList FormList5 = None, Bool Remove = False, Bool Text = True)
    If FormList1 && ParseAndConsume(Target, FormList1, Remove, Text)
        Return True
    ElseIf FormList2 && ParseAndConsume(Target, FormList2, Remove, Text)
        Return True
    ElseIf FormList3 && ParseAndConsume(Target, FormList3, Remove, Text)
        Return True
    ElseIf FormList4 && ParseAndConsume(Target, FormList4, Remove, Text)
        Return True
    ElseIf FormList5 && ParseAndConsume(Target, FormList5, Remove, Text)
        Return True
    EndIf
    If NotifAutoText && Text && Target == PlayerRef
        Debug.Notification(AutoConsumeNoFoodText)
    EndIf
    Return False
EndFunction

Bool Function AutoEat(Actor Target, Bool Text = True, Bool Remove = False)
    If _SNCannibalToggle.GetValue() as Int == 1
        Race targRace = Target.GetRace()
        If targRace == WoodelfRace || targRace == WoodelfRaceVampire || Target.IsEquipped(DA11RingofNamira) || Target.HasPerk(DA11Cannibalism)
            If FoodPriority == 0 && AutoConsume(Target, _SNFood_RawList, _SNFood_HeavyList, _SNFood_MedList, _SNFood_SoupList, _SNFood_LightList, Remove, Text)
                Return True
            ElseIf AutoConsume(Target, _SNFood_RawList, _SNFood_LightList, _SNFood_SoupList, _SNFood_MedList, _SNFood_HeavyList, Remove, Text)
                Return True
            EndIf
        EndIf   
    Else
        If FoodPriority == 0 && AutoConsume(Target, _SNFood_HeavyList, _SNFood_MedList, _SNFood_SoupList, _SNFood_LightList, None, Remove, Text)
            Return True
        ElseIf AutoConsume(Target, _SNFood_LightList, _SNFood_SoupList, _SNFood_MedList, _SNFood_HeavyList, None, Remove, Text)
            Return True
        EndIf
    EndIf
    Return False
EndFunction

Function AutoDrink(Actor Target, Bool Text = True)
    AutoDrinking = True
    AutoConsume(Target, _SNFood_WaterList, _SNFood_DrinkNoAlcList, _SNFood_DrinkList, _SNFood_DrinkSnowList, None, false, Text)
    AutoDrinking = False
EndFunction

Function AutoDrinkNoAlc(Actor Target, Bool Text = True)
    AutoDrinking = True
    AutoConsume(Target, _SNFood_WaterList, _SNFood_DrinkNoAlcList, _SNFood_DrinkSnowList, None, None, false, Text)
    AutoDrinking = False
EndFunction

Bool Function AutoEatHorse(Actor Target, Bool Text = True)
    If AutoConsume(Target, _SNFood_HorseList, None, None, None, None, true, Text)
        Return True
    EndIf
    Return False
EndFunction

;====================================================================================           Drunk/Skooma

Function Drunk()
    Utility.Wait(0.1)
    Int DrunkMax
    If IsMale
        DrunkMax = 3
    Else
        DrunkMax = 2
    EndIf
    If DrunkCount > DrunkMax
        targ.AddSpell(_SNDrunkSpell, false)
        If !DrunkNotice
            Debug.Notification(DrunkText)
            DrunkNotice = True
        EndIf
        Int HungerSound
        If IsMale
            HungerSound = _SNHungerFullLP_M.Play(targ)
        Else
            HungerSound = _SNHungerFullLP_F.Play(targ)
        EndIf
        Sound.SetInstanceVolume(HungerSound, ThirstVol)
    Else
        DrunkCount += 1
    EndIf
    If !SkoomaFX
        RegisterForSingleUpdate(185.0)
    Else
        RegisterForSingleUpdate(305.0)
    EndIf
EndFunction

Function Skooma()
    SkoomaFX = True
    Utility.Wait(0.1)
    targ.AddSpell(_SNSkoomaSpell, false)
    targ.AddItem(_SNEmptyFood, 1, true)
    targ.EquipItem(_SNEmptyFood, false, true)
    RegisterForSingleUpdate(305.0)
EndFunction

;====================================================================================           Notification Functions

Function PlayHungerNotif(Int MaxNotif)
    If NotifHungerIncrement >= MaxNotif
        If !IsWerewolf
            Int HungerSound = _SNHungerLP.Play(targ)
            Sound.SetInstanceVolume(HungerSound, HungerVol)
        EndIf
        If NotifText
            If MaxNotif == 3
                Debug.Notification(HungryText_1)
            ElseIf MaxNotif == 2
                Debug.Notification(HungryText_2)
            ElseIf MaxNotif == 1
                Debug.Notification(HungryText_3)
            Else
                Debug.Notification(HungryText_4)
            EndIf
        EndIf
        NotifHungerIncrement = 0
    Else
        NotifHungerIncrement += TimePassed
    EndIf
EndFunction

Function PlayFatigueNotif(Int MaxNotif)
    If NotifFatigueIncrement >= MaxNotif
        If !IsWerewolf
            Int FatigueSound
            If IsMale
                FatigueSound = _SNFatigueLP_M.Play(targ)
            Else
                FatigueSound = _SNFatigueLP_F.Play(targ)
            EndIf
            Sound.SetInstanceVolume(FatigueSound, FatigueVol)
        EndIf
        If NotifText
            If MaxNotif == 3
                Debug.Notification(FatigueText_1)
            ElseIf MaxNotif == 2
                Debug.Notification(FatigueText_2)
            ElseIf MaxNotif == 1
                Debug.Notification(FatigueText_3)
            Else
                Debug.Notification(FatigueText_4)
            EndIf
        EndIf
        NotifFatigueIncrement = 0
    Else
        NotifFatigueIncrement += TimePassed
    EndIf
EndFunction

Function PlayThirstNotif(Int MaxNotif)
    If NotifThirstIncrement >= MaxNotif
        If !IsWerewolf
            Int ThirstSound
            If IsMale
                ThirstSound = _SNThirstLP_M.Play(targ)
            Else
                ThirstSound = _SNThirstLP_F.Play(targ)
            EndIf
            Sound.SetInstanceVolume(ThirstSound, ThirstVol)
        EndIf
        If NotifText
            If MaxNotif == 3
                Debug.Notification(ThirstyText_1)
            ElseIf MaxNotif == 2
                Debug.Notification(ThirstyText_2)
            ElseIf MaxNotif == 1
                Debug.Notification(ThirstyText_3)
            Else
                Debug.Notification(ThirstyText_4)
            EndIf
        EndIf
        NotifThirstIncrement = 0
    Else
        NotifThirstIncrement += TimePassed
    EndIf
EndFunction

Function CheckStatusHunger()
    Int HungerPenalty = _SNHungerPenalty.GetValue() as Int
    If HungerPenalty == -2
        Debug.Notification(SatedText)
    ElseIf HungerPenalty == -1
        Debug.Notification(SatedNormalText)
    ElseIf HungerPenalty == 0
        Debug.Notification(HungryText_1)
    ElseIf HungerPenalty == 1
        Debug.Notification(HungryText_2)
    ElseIf HungerPenalty == 2
        Debug.Notification(HungryText_3)
    ElseIf HungerPenalty == 3
        Debug.Notification(HungryText_4)
    EndIf
EndFunction

Function CheckStatusThirst()
    Int ThirstPenalty = _SNThirstPenalty.GetValue() as Int
    If ThirstPenalty == -2
        Debug.Notification(HydratedText)
    ElseIf ThirstPenalty == -1
        Debug.Notification(HydratedNormalText)
    ElseIf ThirstPenalty == 0
        Debug.Notification(ThirstyText_1)
    ElseIf ThirstPenalty == 1
        Debug.Notification(ThirstyText_2)
    ElseIf ThirstPenalty == 2
        Debug.Notification(ThirstyText_3)
    ElseIf ThirstPenalty == 3
        Debug.Notification(ThirstyText_4)
    EndIf
EndFunction

Function CheckStatus()
    String HungerText
    String ThirstText
    String FatigueText
    Int HungerPenalty = _SNHungerPenalty.GetValue() as Int
    If HungerPenalty == -2
        HungerText = SatedShortText
    ElseIf HungerPenalty == -1
        HungerText = SatedNormalShortText
    ElseIf HungerPenalty == 0
        HungerText = HungryShortText_1
    ElseIf HungerPenalty == 1
        HungerText = HungryShortText_2
    ElseIf HungerPenalty == 2
        HungerText = HungryShortText_3
    Else
        HungerText = HungryShortText_4
    EndIf
    Int ThirstPenalty = _SNThirstPenalty.GetValue() as Int
    If ThirstPenalty == -2
        ThirstText = HydratedShortText
    ElseIf ThirstPenalty == -1
        ThirstText = HydratedNormalShortText
    ElseIf ThirstPenalty == 0
        ThirstText = ThirstyShortText_1
    ElseIf ThirstPenalty == 1
        ThirstText = ThirstyShortText_2
    ElseIf ThirstPenalty == 2
        ThirstText = ThirstyShortText_3
    Else
        ThirstText = ThirstyShortText_4
    EndIf
    Int FatiguePenalty = _SNFatiguePenalty.GetValue() as Int
    If FatiguePenalty == -2
        FatigueText = RestedShortText
    ElseIf FatiguePenalty == -1
        FatigueText = RestedNormalShortText
    ElseIf FatiguePenalty == 0
        FatigueText = FatigueShortText_1
    ElseIf FatiguePenalty == 1
        FatigueText = FatigueShortText_2
    ElseIf FatiguePenalty == 2
        FatigueText = FatigueShortText_3
    Else
        FatigueText = FatigueShortText_4
    EndIf
    Debug.Notification(StatusText + HungerText + StatusText + ThirstText + StatusText + FatigueText)
    If SKSEVersion > 0.0 && _SNFollowerNeedsToggle.GetValue() as Int > 0
        SendModEvent("_SN_CheckStatus")
    EndIf
EndFunction

Function CheckInventory()
    Int FoodCount
    If _SNCannibalToggle.GetValue() as Int == 1 && PlayerIsWoodElf
        FoodCount = targ.GetItemCount(_SNFood_HeavyList) as Int +  targ.GetItemCount(_SNFood_MedList) as Int +  targ.GetItemCount(_SNFood_SoupList) as Int +  targ.GetItemCount(_SNFood_LightList) as Int +  targ.GetItemCount(_SNFood_RawList) as Int
    Else
        FoodCount = targ.GetItemCount(_SNFood_HeavyList) as Int +  targ.GetItemCount(_SNFood_MedList) as Int +  targ.GetItemCount(_SNFood_SoupList) as Int +  targ.GetItemCount(_SNFood_LightList) as Int
    EndIf
    Int DrinkCount = targ.GetItemCount(_SNWaterskin_1) as Int + (targ.GetItemCount(_SNWaterskin_2) as Int * 2) + (targ.GetItemCount(_SNWaterskin_3) as Int * 3) + targ.GetItemCount(_SNFood_DrinkList) as Int + targ.GetItemCount(_SNFood_DrinkNoAlcList) as Int
    Debug.Notification(CheckInventoryText + FoodCount + FollowerStatusText_2 + DrinkCount + FollowerStatusText_3)
EndFunction

;====================================================================================           Mod Needs Functions

Function WellnessDecrease(Int ChangeInt, Bool IsHunger = False)
    If !WellnessBuffer
        WellnessNeeds -= ChangeInt
        If IsHunger
            VariedDietCount -= (ChangeInt * 3)
        EndIf
        WellnessBuffer = True
        RegisterForSingleUpdateGameTime(0.95)
    EndIf
EndFunction

Function ModHunger(Float HungerDelta)
    Int HungerPenalty
    
    targ.RemoveSpell(_SNHungerBuffSpell)
    targ.RemoveSpell(_SNHungerPenaltySpell_1)
    targ.RemoveSpell(_SNHungerPenaltySpell_2)
    targ.RemoveSpell(_SNHungerPenaltySpell_3)
    
    If (TempHungerState + HungerDelta) > 110
        HungerState = 110.0
    ElseIf (TempHungerState + HungerDelta) < 0
        HungerState = 0.0
    Else
        HungerState = TempHungerState + HungerDelta
    EndIf

    TempHungerState = HungerState

    If HungerState == 0.0
        PenaltyHungerIncrement += TimePassed
        If PenaltyHungerIncrement < 14
            HungerPenalty = 1
            PlayHungerNotif(2)
        ElseIf PenaltyHungerIncrement < 39
            HungerPenalty = 2
            PlayHungerNotif(1)
        Else
            HungerPenalty = 3
            PlayHungerNotif(0)
        EndIf
        HungerLevel = 2
    Else
        If HungerState <= 50.0
            PlayHungerNotif(3)
            HungerPenalty = 0
            HungerLevel = 1
        ElseIf HungerState < 85.0
            HungerPenalty = -1
            NotifHungerIncrement = 10
            HungerLevel = 0
        Else
            If HungerDelta > 0
                If HungerState > 95.0
                    If HungerState >= 105.0 && HungerLevel != 0
                        Int HungerSound
                        If IsMale
                            HungerSound = _SNHungerFullLP_M.Play(targ)
                        Else
                            HungerSound = _SNHungerFullLP_F.Play(targ)
                        EndIf
                        Sound.SetInstanceVolume(HungerSound, HungerVol)
                    EndIf
                    If !ConsumptionNotif && HungerRate > 0 && _SNHungerPenalty.GetValue() as Int != -2
                        Debug.Notification(SatedText)
                    EndIf
                    HungerPenalty = -2
                Else
                    HungerPenalty = -1
                EndIf
            Else
                If !ConsumptionNotif && HungerRate > 0 && _SNHungerPenalty.GetValue() as Int != -2
                    Debug.Notification(SatedText)
                EndIf
                HungerPenalty = -2
            EndIf
            NotifHungerIncrement = 10
            HungerLevel = 0
        EndIf
        PenaltyHungerIncrement = 0
    EndIf
    If HungerPenalty == -2
        targ.AddSpell(_SNHungerBuffSpell, false)
    ElseIf HungerPenalty == 1
        targ.AddSpell(_SNHungerPenaltySpell_1, false)
    ElseIf HungerPenalty == 2
        targ.AddSpell(_SNHungerPenaltySpell_2, false)
    ElseIf HungerPenalty == 3
        targ.AddSpell(_SNHungerPenaltySpell_3, false)
        WellnessDecrease(1, true)
    EndIf
    _SNHungerPenalty.SetValue(HungerPenalty)
    If SkyInstalled && SKSEVersion >= 0.0
        SendModEvent("_SN_StatusUpdated")
    EndIf
    ;Debug.Notification(HungerState + " Hunger")                                                                ;DEBUG      0=white, 1=yellow, 2=red
EndFunction

Function ModFatigue(Float FatigueDelta)
    Int FatiguePenalty
    
    targ.RemoveSpell(_SNFatiguePenaltySpell_1)
    targ.RemoveSpell(_SNFatiguePenaltySpell_2)
    targ.RemoveSpell(_SNFatiguePenaltySpell_3)
    
    If (TempFatigueState + FatigueDelta) > 110
        FatigueState = 110.0
    ElseIf (TempFatigueState + FatigueDelta) < 0
        FatigueState = 0.0
    Else
        FatigueState = TempFatigueState + FatigueDelta
    EndIf

    TempFatigueState = FatigueState

    If FatigueState == 0.0
        PenaltyFatigueIncrement += TimePassed
        If PenaltyFatigueIncrement < 10
            FatiguePenalty = 1
            PlayFatigueNotif(2)
        ElseIf PenaltyFatigueIncrement < 26
            FatiguePenalty = 2
            PlayFatigueNotif(1)
        Else
            If Death && PenaltyFatigueIncrement > 62
                WellnessDecrease(3)
                _SNWellnessLevel.Mod(-2)
                Float CurrentHealth = PlayerRef.GetBaseActorValue("Health")
                PlayerRef.DamageActorValue("Health", Utility.RandomFloat(CurrentHealth / 3.0, CurrentHealth * 1.5))
                Float CurrentStamina = PlayerRef.GetBaseActorValue("Stamina")
                PlayerRef.DamageActorValue("Stamina", Utility.RandomFloat(CurrentStamina / 3.0, CurrentStamina))
                Float CurrentMagicka = PlayerRef.GetBaseActorValue("Magicka")
                PlayerRef.DamageActorValue("Magicka", Utility.RandomFloat(CurrentMagicka / 3.0, CurrentMagicka))
                If NotifText
                    Debug.Notification(DeathFatigueText)
                EndIf
            EndIf
            FatiguePenalty = 3
            PlayFatigueNotif(0)
        EndIf
        FatigueLevel = 2
    Else
        If FatigueState <= 50.0
            FatiguePenalty = 0
            PlayFatigueNotif(3)
            FatigueLevel = 1
        ElseIf FatigueState < 85.0
            FatiguePenalty = -1
            NotifFatigueIncrement = 10
            FatigueLevel = 0
        Else
            If FatigueDelta > 0
                If FatigueState > 95.0
                    FatiguePenalty = -2
                Else
                    FatiguePenalty = -1
                EndIf
            Else
                FatiguePenalty = -2
            EndIf
            NotifFatigueIncrement = 10
            FatigueLevel = 0
        EndIf
        PenaltyFatigueIncrement = 0
    EndIf
    If FatiguePenalty > -2
        PlayerSleepQuest.RemoveRested()
        PlayerSleepQuest.RemoveAdoptionRested()
        If FatiguePenalty == 1
            targ.AddSpell(_SNFatiguePenaltySpell_1, false)
        ElseIf FatiguePenalty == 2
            targ.AddSpell(_SNFatiguePenaltySpell_2, false)
        ElseIf FatiguePenalty == 3
            targ.AddSpell(_SNFatiguePenaltySpell_3, false)
            WellnessDecrease(1)
        EndIf
    EndIf
    _SNFatiguePenalty.SetValue(FatiguePenalty)
    ;Debug.Notification(FatigueState + " Fatigue")                                                              ;DEBUG
EndFunction

Function ModThirst(Float ThirstDelta)
    Int ThirstPenalty
    
    targ.RemoveSpell(_SNThirstBuffSpell)
    targ.RemoveSpell(_SNThirstPenaltySpell_1)
    targ.RemoveSpell(_SNThirstPenaltySpell_2)
    targ.RemoveSpell(_SNThirstPenaltySpell_3)
    
    If (TempThirstState + ThirstDelta) > 110
        ThirstState = 110.0
    ElseIf (TempThirstState + ThirstDelta) < 0
        ThirstState = 0.0
    Else
        ThirstState = TempThirstState + ThirstDelta
    EndIf

    TempThirstState = ThirstState

    If ThirstState == 0.0
        PenaltyThirstIncrement += TimePassed
        If PenaltyThirstIncrement < 6
            ThirstPenalty = 1
            PlayThirstNotif(2)
        ElseIf PenaltyThirstIncrement < 14
            ThirstPenalty = 2
            PlayThirstNotif(1)
        Else
            If Death && PenaltyThirstIncrement > 38
                WellnessDecrease(3)
                _SNWellnessLevel.Mod(-2)
                Float CurrentHealth = PlayerRef.GetBaseActorValue("Health")
                Float CurrentStamina = PlayerRef.GetBaseActorValue("Stamina")
                Float CurrentMagicka = PlayerRef.GetBaseActorValue("Magicka")
                PlayerRef.DamageActorValue("Health", Utility.RandomFloat(CurrentHealth / 3.0, CurrentHealth * 1.5))
                PlayerRef.DamageActorValue("Stamina", Utility.RandomFloat(CurrentStamina / 3.0, CurrentStamina))
                PlayerRef.DamageActorValue("Magicka", Utility.RandomFloat(CurrentMagicka / 3.0, CurrentMagicka))
                If NotifText
                    Debug.Notification(DeathThirstText)
                EndIf
            EndIf
            ThirstPenalty = 3
            PlayThirstNotif(0)
        EndIf
        ThirstLevel = 2
    Else
        If ThirstState <= 50.0
            ThirstPenalty = 0
            PlayThirstNotif(3)
            ThirstLevel = 1
        ElseIf ThirstState < 85.0
            ThirstPenalty = -1
            NotifThirstIncrement = 10
            ThirstLevel = 0
        Else
            If ThirstDelta > 0
                If ThirstState > 95.0
                    If !ConsumptionNotif && ThirstRate > 0 && _SNThirstPenalty.GetValue() as Int != -2
                        Debug.Notification(HydratedText)
                    EndIf
                    ThirstPenalty = -2
                Else
                    ThirstPenalty = -1
                EndIf
            Else
                If !ConsumptionNotif && ThirstRate > 0 && _SNThirstPenalty.GetValue() as Int != -2
                    Debug.Notification(HydratedText)
                EndIf
                ThirstPenalty = -2
            EndIf
            NotifThirstIncrement = 10
            ThirstLevel = 0
        EndIf
        PenaltyThirstIncrement = 0
    EndIf
    If ThirstPenalty == -2
        targ.AddSpell(_SNThirstBuffSpell, false)
    ElseIf ThirstPenalty == 1
        targ.AddSpell(_SNThirstPenaltySpell_1, false)
    ElseIf ThirstPenalty == 2
        targ.AddSpell(_SNThirstPenaltySpell_2, false)
    ElseIf ThirstPenalty == 3
        targ.AddSpell(_SNThirstPenaltySpell_3, false)
        WellnessDecrease(1)
    EndIf
    _SNThirstPenalty.SetValue(ThirstPenalty)
    ;Debug.Notification(ThirstState + " Thirst")                                                                ;DEBUG
EndFunction

;====================================================================================           ;Food weight and value maintenance

Function FoodMaintenance(FormList FoodList, Float ValueMult, Float WeightAdd)
    Int iIndex = FoodList.GetSize() as Int
    While iIndex > 0
        iIndex -= 1
        Form Food = FoodList.GetAt(iIndex)
        If Food
            If FoodPrice
                Food.SetGoldValue((Food.GetGoldValue() as Int * ValueMult) as Int)
            EndIf
            If FoodWeight
                Food.SetWeight(Food.GetWeight() as Int + WeightAdd)
            EndIf
            If SKSEVersion >= 0.0 && !(Food as Ingredient) && (FoodNoEffect || (FoodList == _SNFood_RawList && FoodSpoilage && HarmfulRaw))
                (Food as Potion).SetNthEffectMagnitude(0, 0.0)
                (Food as Potion).SetNthEffectMagnitude(1, 0.0)
                (Food as Potion).SetNthEffectMagnitude(2, 0.0)
                (Food as Potion).SetNthEffectMagnitude(3, 0.0)
            EndIf
        EndIf
    EndWhile
    Utility.Wait(1.0)
EndFunction

Function FoodLeveledList()
    If !SetLeveledLists
        LItemBarrelFoodRawMeatSame.AddForm(SaltPile, 1, 7)
        LItemBarrelFoodRawMeatSame.AddForm(SaltPile, 1, 10)
        LItemBarrelFoodRawMeatSame.AddForm(SaltPile, 1, 13)
        LItemBarrelFoodRawMeatSame.AddForm(_SNWaterskin_0, 1, 1)
        LItemBarrelFoodRawMeatSame.AddForm(_SNWaterskin_0, 1, 2)
        LItemBarrelFoodRawMeatSame.AddForm(_SNWaterskin_0, 1, 3)
        LItemBarrelFoodRawMeatSame.AddForm(_SNEmptyFoodList, 1, 1)
        LItemBarrelFoodRawMeatSame.AddForm(_SNEmptyFoodList, 1, 1)
        LItemBarrelFoodRawMeatSame.AddForm(_SNEmptyFoodList, 1, 1)
        LItemBarrelFoodRawMeatSame.AddForm(_SNEmptyFoodList, 1, 1)
        LItemBarrelFoodRawMeatSame.AddForm(_SNEmptyFoodList, 1, 1)
        LItemBarrelFoodRawMeatSame.AddForm(_SNEmptyFoodList, 1, 1)
        LItemBarrelFoodRawMeatSame.AddForm(_SNEmptyFoodList, 1, 1)
        LItemBarrelFoodRawMeatSame.AddForm(Garlic, 1, 3)
        LItemBarrelFoodRawMeatSame.AddForm(Garlic, 1, 4)
        LItemBarrelFoodSame70.AddForm(SaltPile, 1, 6)
        LItemBarrelFoodSame70.AddForm(SaltPile, 1, 9)
        LItemBarrelFoodSame70.AddForm(SaltPile, 1, 12)
        LItemBarrelFoodSame70.AddForm(_SNWaterskin_0, 1, 1)
        LItemBarrelFoodSame70.AddForm(_SNEmptyFoodList, 1, 1)
        LItemBarrelFoodSame70.AddForm(_SNEmptyFoodList, 1, 1)
        LItemBarrelFoodSame70.AddForm(_SNEmptyFoodList, 1, 1)
        LItemBarrelFoodSame75.AddForm(_SNEmptyFoodList, 1, 1)
        LItemBarrelFoodSame75.AddForm(_SNEmptyFoodList, 1, 1)
        LItemBarrelFoodSame75.AddForm(_SNEmptyFoodList, 1, 1)
        LItemBarrelFoodSame75.AddForm(_SNEmptyFoodList, 1, 1)
        LItemBarrelFoodSame75.AddForm(_SNEmptyFoodList, 1, 1)
        LItemBarrelFoodSame75.AddForm(Garlic, 1, 3)
        LItemBarrelFoodSame75.AddForm(Garlic, 1, 4)
        LItemBarrelFoodSameSmall.AddForm(SaltPile, 1, 5)
        LItemBarrelFoodSameSmall.AddForm(SaltPile, 1, 8)
        LItemBarrelFoodSameSmall.AddForm(SaltPile, 1, 11)
        LItemBarrelFoodSameSmall.AddForm(_SNWaterskin_0, 1, 1)
        LItemBarrelFoodSameSmall.AddForm(_SNWaterskin_0, 1, 2)
        LItemBarrelFoodSameSmall.AddForm(_SNWaterskin_0, 1, 3)
        LItemBarrelFoodSameSmall.AddForm(_SNEmptyFoodList, 1, 1)
        LItemBarrelFoodSameSmall.AddForm(_SNEmptyFoodList, 1, 1)
        LItemBarrelFoodSameSmall.AddForm(_SNEmptyFoodList, 1, 1)
        LItemBarrelFoodSameSmall.AddForm(_SNEmptyFoodList, 1, 1)
        LItemBarrelFoodSameSmall.AddForm(_SNEmptyFoodList, 1, 1)
        LItemBarrelFoodSameSmall.AddForm(Garlic, 1, 3)
        LItemBarrelFoodSameSmall.AddForm(Garlic, 1, 4)
        SetLeveledLists = True
    EndIf
EndFunction

;====================================================================================

Function Maintenance()
    targ = PlayerRef
    Debug.Trace("")
    Debug.Trace("=====iNeed (_sn) is refreshing itself and searching for addons. Any errors below are harmless.=====")
    Debug.Trace("")

    If Game.GetFormFromFile(0x00000802, "SkyUI_SE.esp")     ;SkyUI
        SkyInstalled = True
        If !fModVersion
            Debug.Notification(MCMWarnStart)
        EndIf
    Else
        SkyInstalled = False
        targ.AddSpell(_SNOldConfigSpell, false)
    EndIf

    _SNDLCQuest.DLCMaintenance()

    SKSEVersion = (SKSE.GetVersion() + SKSE.GetVersionMinor() * 0.01 + SKSE.GetVersionBeta() * 0.0001)

    If SKSEVersion > 0.0
        If (FoodWeight || FoodPrice || FoodNoEffect) && _SNEmptyFood.GetWeight() == 1.0 && _SNEmptyFood.GetGoldValue() == 1
            FoodMaintenance(_SNFood_MedList, 2.0, 0.5)
            FoodMaintenance(_SNFood_SoupList, 2.0, 0.75)
            If !_SNDLCQuest.WildLootInstalled
                FoodMaintenance(_SNFood_RawList, 2.0, 1.0)
            Else
                FoodMaintenance(_SNFood_RawList, 2.0, 0.0)
            EndIf
            FoodMaintenance(_SNFood_LightList, 2.0, 0.25)
            FoodMaintenance(_SNFood_HeavyList, 2.0, 1.0)
            FoodMaintenance(_SNFood_DrinkList, 3.0, 0.5)        ;*price, +weight
            FoodMaintenance(_SNFood_DrinkNoAlcList, 3.0, 0.5)
            FoodMaintenance(_SNFood_SkoomaList, 5.0, 0.0)
        EndIf
        If NoSalt
            RemoveSalt()
        EndIf
    ElseIf !fModVersion
        Debug.Notification(NoSKSEText)
    EndIf

    If !SetMerchantList
        LItemMiscVendorPotion50.AddForm(_SNWaterskin_0, 1, 1)
        LItemMiscVendorPotion50.AddForm(_SNWaterskin_0, 1, 2)
        LItemMiscVendorPotion50.AddForm(_SNMerchantVendorList, 1, 1)
        LItemFoodInnCommon.AddForm(_SNWaterskin_3, 1, 1)
        LItemFoodInnCommon.AddForm(_SNWaterskin_3, 1, 2)
        LItemFoodInnCommon.AddForm(_SNWaterskin_3, 1, 3)
        LItemFoodInnCommon.AddForm(SaltPile, 1, 3)
        LItemFoodInnCommon.AddForm(SaltPile, 1, 4)
        LItemFoodInnCommon.AddForm(Garlic, 1, 2)
        LItemFoodInnCommon.AddForm(Garlic, 1, 3)
        LItemLootIMineralsProcessed.AddForm(SaltPile, 1, 3)
        LItemLootIMineralsProcessed.AddForm(SaltPile, 1, 4)
        LItemLootIMineralsProcessed.AddForm(SaltPile, 1, 5)
        LItemLootIMineralsProcessed.AddForm(SaltPile, 1, 6)
        LItemFoodInnCommon10.AddForm(SaltPile, 1, 3)
        LItemFoodInnCommon10.AddForm(SaltPile, 1, 4)
        LItemFoodInnCommon10.AddForm(Garlic, 1, 2)
        LItemFoodInnCommon10.AddForm(Garlic, 1, 3)
        LItemFoodInnCommon10.AddForm(_SNWaterskinList, 1, 1)
        LItemFurnitureMiscItems75.AddForm(_SNWaterskin_0, 1, 1)
        SetMerchantList = True
    EndIf

    If _SNDiseaseToggle.GetValue() as Int == 1
        SetPotionLeveledLists()
    EndIf

    If fModVersion
        If SkyInstalled && SKSEVersion > 0.0
            _SNSKConfigQuest.OnConfigInit()
        EndIf
        If fModVersion < 1.94                           ;CHANGE VERSION NUMBER WHEN UPDATING
            ModUpdated = True
            Restart()
            Debug.Notification(UpdateText + "v1.94")    ;CHANGE VERSION NUMBER WHEN UPDATING
        EndIf
        If targ.GetActorBase().GetSex() == 0
            IsMale = True
        Else
            IsMale = False
        EndIf
    Else
        If SkyInstalled && SKSEVersion >= 0.0
            _SNSKConfigQuest.OnConfigInit()
            Debug.Notification(MCMWarnEnd)
        Else
            NotifText = True
        EndIf
        SetPerspective()
        FoodRecentList = New Form[4]
        FoodFollowerList = New Form[128]
        _SNWellnessLevel.SetValue(Utility.RandomInt(1, 3))
        _SNVariedDietLevel.SetValue(Utility.RandomInt(1, 3))
        EnableMod()
    EndIf
    fModVersion = 1.94                                  ;CHANGE VERSION NUMBER WHEN UPDATING
    Race targRace = targ.GetRace()
    If targRace == WoodelfRace || targRace == WoodelfRaceVampire
        PlayerIsWoodelf = True
    Else
        PlayerIsWoodelf = False
    EndIf
    ModUpdated = False
    Debug.Trace("")
    Debug.Trace("=====iNeed (_sn) is finished refreshing itself and searching for addons!=====")
    Debug.Trace("")
EndFunction

;====================================================================================

Function Restart()
    ModRestarted = True
    targ = PlayerRef
    DisableMod()
    If ModUpdated && SKSEVersion > 0.0 && _SNFollowerNeedsToggle.GetValue() as Int > 0
        _SNFollowerNeedsToggle.SetValue(0)
        Utility.Wait(1.0)
        _SNFollowerNeedsToggle.SetValue(_SNSKConfigQuest.FollowerNeedsType)
    Else
        Utility.Wait(0.5)
    EndIf
    EnableMod()
    Utility.Wait(1.0)
    ModRestarted = False
EndFunction

Function DisableMod()
    targ.RemoveSpell(_SNPlayerSpell)
    targ.RemoveSpell(_SNVariedDietSpell)
    targ.RemoveSpell(_SNWellnessSpell)
    targ.RemoveSpell(_SNAdrenalineSpell)
    targ.RemoveSpell(_SNWearySpell)
    targ.RemoveSpell(_SNFatiguePenaltySpell_1)
    targ.RemoveSpell(_SNFatiguePenaltySpell_2)
    targ.RemoveSpell(_SNFatiguePenaltySpell_3)
    targ.RemoveSpell(_SNHungerPenaltySpell_1)
    targ.RemoveSpell(_SNHungerPenaltySpell_2)
    targ.RemoveSpell(_SNHungerPenaltySpell_3)
    targ.RemoveSpell(_SNThirstPenaltySpell_1)
    targ.RemoveSpell(_SNThirstPenaltySpell_2)
    targ.RemoveSpell(_SNThirstPenaltySpell_3)
    targ.RemoveSpell(_SNThirstBuffSpell)
    targ.RemoveSpell(_SNHungerBuffSpell)
    targ.RemoveSpell(_SNOldConfigSpell)
    CureDisease()
EndFunction

Function EnableMod()
    targ.AddSpell(_SNPlayerSpell, false)
    targ.AddSpell(_SNWellnessSpell, false)
    targ.AddSpell(_SNVariedDietSpell, false)
    If SKSEVersion == 0.0 || EnableActionsSpell
        targ.AddSpell(_SNOldConfigSpell, false)
    EndIf
    ModThirst(0.0)
    ModFatigue(0.0)
    ModHunger(0.0)
EndFunction

;====================================================================================

Event OnInit()
    Utility.Wait(2.0)
    targ = PlayerRef
    If Utility.GetCurrentGameTime() < 0.5
        TempHungerState = Utility.RandomInt(-50, 100) as Float
        If TempHungerState < 0
            PenaltyHungerIncrement = Utility.RandomInt(1, 48)
            TempHungerState = 0
        EndIf
        TempThirstState = Utility.RandomInt(-50, 100) as Float
        If TempThirstState < 0
            PenaltyThirstIncrement = Utility.RandomInt(1, 24)
            TempThirstState = 0
        EndIf
        TempFatigueState = Utility.RandomInt(25, 100) as Float
        HungerState = TempHungerState
        ThirstState = TempThirstState
        FatigueState = TempFatigueState
        Maintenance()
    Else
        Maintenance()
    EndIf
    targ.AddItem(_SNWaterskin_0, 1, true)
EndEvent

Event OnUpdate()
    targ.RemoveSpell(_SNDrunkSpell)
    targ.RemoveSpell(_SNSkoomaSpell)
    DrunkCount = 0
    DrunkNotice = False
    SkoomaFX = False
EndEvent

Event OnUpdateGameTime()
    WellnessBuffer = False
EndEvent