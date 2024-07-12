Scriptname mndController Extends Quest Conditional

; FIXME Added a new way to remove the pee (that adds an uninvisible pee at the end of the animation, in case the pee is still equipped)
; FIXME The food should always satisfy the need at least a little
; FIXME In case the mod is in basic mode, and at least one anim is used, then all settings for the anims will be enabled (in basic mode peeing and pooping anims may have been disabled while other asnims were anabled)
; FIXME Now is possible to specify the duration of bath, only in Expert mode. The default is 30 seconds
; FIXME Changed the valid level of water for rivers to bath also when the river is deeper
; FIXME Simple mode is removed, it was creating problems for many users to switch between SkyUI modes. At mod install the config is the standard for simple mode
; FIXME Fixed a problem having PapyrusUItil not recognized (so no way to load/save options)
; FIXME Added an option to revert the widgets, so they can stay full if the need is satisfied
; FIXME Piss and Poop are now sent thru ModEvents, so the duration of the effect does not matter anymore
; FIXME Added the ability to use spell, shout, or key to start pissing and pooping together
; FIXME Altered the stamina regen to use only a static value
; FIXME Fixed the problem of havinf SexLab stripping modes gone if you open the MCM twice and SexLab is installed
; FIXME Added a page in the MCM to apply immediately a penalty
; FIXME Fixed a problem where weight variations were not applied
; FIXME 
; FIXME 
; FIXME 
; FIXME 
; FIXME 
; FIXME 
; FIXME 
; FIXME 
; FIXME 
; FIXME [FUTURE VERSION]Add soft dependency with Qostafan scaling mod
; FIXME [FUTURE VERSION] MILK: Check if we can do a specific milk need. Maybe use a soft dependency with Milk Mod economy
; FIXME [FUTURE VERSION] ZAZ: In case mouth restrains are applied make impossible to eat and drink
; FIXME [FUTURE VERSION] In case the JSON file has errors, show them and ask if the file should be removed

; ((- External Events and Global functions

Event setNeedsValues(string need, int value)
	float now = Utility.GetCurrentGameTime()
	float tsv = 20.0/TimeScale.getValue()
	if need=="Eat"
		lastTimeEat = now - (timeEat * value)/(tsv * 24.0)
	elseIf need=="Drink"
		lastTimeDrink = now - (timeDrink * value)/(tsv * 24.0)
	elseIf need=="Sleep"
		lastTimeSleep = now - (timeSleep * value)/(tsv * 24.0)
	elseIf need=="Talk"
		lastTimeTalk = now - (timeTalk * value)/(tsv * 24.0)
	elseIf need=="Bath"
		lastTimeBath = now - (timeBath * value)/(tsv * 24.0)
	elseIf need=="Pray"
		lastTimePray = now - (timePray * value)/(tsv * 24.0)
	elseIf need=="Sex"
		lastTimeSex = now - (timeSex * value)/(tsv * 24.0)
	elseIf need=="Piss"
		lastTimePiss = now - (timePiss * value)/(tsv * 24.0)
	elseIf need=="Poop"
		lastTimePoop = now - (timePoop * value)/(tsv * 24.0)
	elseIf need=="Drunk"
		lastTimeDrunk = now - (timeDrunk * value)/(tsv * 24.0)
	elseIf need=="Skooma"
		lastTimeSkooma = now - (timeSkooma * value)/(tsv * 24.0)
	elseIf need=="Alcohol"
		lastTimeAlcohol = now - (timeAlcohol * value)/(tsv * 24.0)
	elseIf need=="Weed"
		lastTimeWeed = now - (timeWeed * value)/(tsv * 24.0)
	endIf
	recalculateBuffs()
endEvent

Event getNeedsValues(string need)
	int id
	float now = Utility.GetCurrentGameTime()
	float tsv = 20.0/TimeScale.getValue()
		
	if need=="Eat" || need=="All"
		id = ModEvent.Create("MiniNeedsValue")
		ModEvent.PushString(id, "Eat")
		ModEvent.PushInt(id, ( tsv * 24.0*(now - lastTimeEat)/timeEat) as int)
		ModEvent.Send(id)
	endIf
	if need=="Drink" || need=="All"
		id = ModEvent.Create("MiniNeedsValue")
		ModEvent.PushString(id, "Drink")
		ModEvent.PushInt(id, ( tsv * 24.0*(now - lastTimeDrink)/timeDrink) as int)
		ModEvent.Send(id)
	endIf
	if need=="Sleep" || need=="All"
		id = ModEvent.Create("MiniNeedsValue")
		ModEvent.PushString(id, "Sleep")
		ModEvent.PushInt(id, ( tsv * 24.0*(now - lastTimeSleep)/timeSleep) as int)
		ModEvent.Send(id)
	endIf
	if need=="Talk" || need=="All"
		id = ModEvent.Create("MiniNeedsValue")
		ModEvent.PushString(id, "Talk")
		ModEvent.PushInt(id, ( tsv * 24.0*(now - lastTimeTalk)/timeTalk) as int)
		ModEvent.Send(id)
	endIf
	if need=="Bath" || need=="All"
		id = ModEvent.Create("MiniNeedsValue")
		ModEvent.PushString(id, "Bath")
		ModEvent.PushInt(id, ( tsv * 24.0*(now - lastTimeBath)/timeBath) as int)
		ModEvent.Send(id)
	endIf
	if need=="Pray" || need=="All"
		id = ModEvent.Create("MiniNeedsValue")
		ModEvent.PushString(id, "Pray")
		ModEvent.PushInt(id, ( tsv * 24.0*(now - lastTimePray)/timePray) as int)
		ModEvent.Send(id)
	endIf
	if need=="Sex" || need=="All"
		id = ModEvent.Create("MiniNeedsValue")
		ModEvent.PushString(id, "Sex")
		ModEvent.PushInt(id, ( tsv * 24.0*(now - lastTimeSex)/timeSex) as int)
		ModEvent.Send(id)
	endIf
	if need=="Piss" || need=="All"
		id = ModEvent.Create("MiniNeedsValue")
		ModEvent.PushString(id, "Piss")
		ModEvent.PushInt(id, ( tsv * 24.0*(now - lastTimePiss)/timePiss) as int)
		ModEvent.Send(id)
	endIf
	if need=="Poop" || need=="All"
		id = ModEvent.Create("MiniNeedsValue")
		ModEvent.PushString(id, "Poop")
		ModEvent.PushInt(id, ( tsv * 24.0*(now - lastTimePoop)/timePoop) as int)
		ModEvent.Send(id)
	endIf
	if need=="Drunk" || need=="All"
		id = ModEvent.Create("MiniNeedsValue")
		ModEvent.PushString(id, "Drunk")
		ModEvent.PushInt(id, ( tsv * 24.0*(now - lastTimeDrunk)/timeDrunk) as int)
		ModEvent.Send(id)
	endIf
	if need=="Skooma" || need=="All"
		id = ModEvent.Create("MiniNeedsValue")
		ModEvent.PushString(id, "Skooma")
		ModEvent.PushInt(id, ( tsv * 24.0*(now - lastTimeSkooma)/timeSkooma) as int)
		ModEvent.Send(id)
	endIf
	if need=="Alcohol" || need=="All"
		id = ModEvent.Create("MiniNeedsValue")
		ModEvent.PushString(id, "Alcohol")
		ModEvent.PushInt(id, ( tsv * 24.0*(now - lastTimeAlcohol)/timeAlcohol) as int)
		ModEvent.Send(id)
	endIf
	if need=="Weed" || need=="All"
		id = ModEvent.Create("MiniNeedsValue")
		ModEvent.PushString(id, "Weed")
		ModEvent.PushInt(id, ( tsv * 24.0*(now - lastTimeWeed)/timeWeed) as int)
		ModEvent.Send(id)
	endIf
endEvent

mndController function instance() global
	return Game.GetFormFromFile(0x12C4, "MiniNeeds.esp") as mndController
endFunction

int function getPecent(string need)
	float now = Utility.GetCurrentGameTime()
	float tsv = 20.0/TimeScale.getValue()
	float perc = -1.0
	if need=="Eat"
		perc = tsv * 24.0*(now - lastTimeEat)/timeEat
	elseIf need=="Drink"
		perc = tsv * 24.0*(now - lastTimeDrink)/timeDrink
	elseIf need=="Sleep"
		perc = tsv * 24.0*(now - lastTimeSleep)/timeSleep
	elseIf need=="Talk"
		perc = tsv * 24.0*(now - lastTimeTalk)/timeTalk
	elseIf need=="Piss"
		perc = tsv * 24.0*(now - lastTimePiss)/timePiss
	elseIf need=="Poop"
		perc = tsv * 24.0*(now - lastTimePoop)/timePoop
	elseIf need=="Pray"
		perc = tsv * 24.0*(now - lastTimePray)/timePray
	elseIf need=="Bath"
		perc = tsv * 24.0*(now - lastTimeBath)/timeBath
	elseIf need=="Sex"
		perc = tsv * 24.0*(now - lastTimeSex)/timeSex
	elseIf need=="Skooma"
		perc = tsv * 24.0*(now - lastTimeSkooma)/timeSkooma
	elseIf need=="Alcohol"
		perc = tsv * 24.0*(now - lastTimeAlcohol)/timeAlcohol
	elseIf need=="Weed"
		perc = tsv * 24.0*(now - lastTimeWeed)/timeWeed
	elseIf need=="Drunk"
		perc = ((timeDrunk/24.0) - now + lastTimeDrunk)/(timeDrunk/24.0)
	endIf
	if perc>100.0
		perc=100.0
	elseIf perc<0.0
		perc=0.0
	endIf

	return perc as int
endFunction

int function getStep(string need)
	float now = Utility.GetCurrentGameTime()
	float timeMultiplier = timeScale.getValue()/20.0
	int step = 0
	if need=="Eat"
		return calculateTimeStep(now - lastTimeEat, timeMultiplier*timeEat/24.0)
	elseIf need=="Drink"
		return calculateTimeStep(now - lastTimeDrink, timeMultiplier*timeDrink/24.0)
	elseIf need=="Sleep"
		return calculateTimeStep(now - lastTimeSleep, timeMultiplier*timeSleep/24.0)
	elseIf need=="Talk"
		return calculateTimeStep(now - lastTimeTalk, timeMultiplier*timeTalk/24.0)
	elseIf need=="Piss"
		return calculateTimeStep(now - lastTimePiss, timeMultiplier*timePiss/24.0)
	elseIf need=="Poop"
		return calculateTimeStep(now - lastTimePoop, timeMultiplier*timePoop/24.0)
	elseIf need=="Pray"
		return calculateTimeStep(now - lastTimePray, timeMultiplier*timePray/24.0)
	elseIf need=="Bath"
		return calculateTimeStep(now - lastTimeBath, timeMultiplier*timeBath/24.0)
	elseIf need=="Sex"
		return calculateTimeStep(now - lastTimeSex, timeMultiplier*timeSex/24.0)
	elseIf need=="Skooma"
		return calculateTimeStep(now - lastTimeSkooma, timeMultiplier*timeSkooma/24.0)
	elseIf need=="Alcohol"
		return calculateTimeStep(now - lastTimeAlcohol, timeMultiplier*timeAlcohol/24.0)
	elseIf need=="Weed"
		return calculateTimeStep(now - lastTimeWeed, timeMultiplier*timeWeed/24.0)
	elseIf need=="Drunk"
		return calculateTimeStep(now - lastTimeDrunk, timeMultiplier*timeDrunk/24.0, ((timeDrunk/24.0) - now + lastTimeDrunk)/(timeDrunk/24.0))
	endIf

	return 0
endFunction

int Function getVersion() global
	return 3200
endFunction

; -))

; ((- Config properties

bool Property enableStaticShowers Auto
bool Property reverseWidgets Auto
int Property useNutritionValues Auto

bool Property enableEat Auto
Float Property timeEat Auto
Float Property lastTimeEat Auto
Float Property maxEatDamage Auto
bool Property useAnimForEating auto

bool Property enableDrink Auto
Float Property timeDrink Auto
Float Property lastTimeDrink Auto
Float Property maxDrinkDamage Auto
bool Property useAnimForDrinking auto

bool Property enableSleep Auto
Float Property timeSleep Auto
Float Property lastTimeSleep Auto
Float Property maxSleepDamage Auto

bool Property enableTalk Auto
Float Property timeTalk Auto
Float Property lastTimeTalk Auto
Float Property maxTalkDamage Auto

bool Property enablePiss Auto
Float Property timePiss Auto
Float Property lastTimePiss Auto
Float Property maxPissDamage Auto
bool Property useAnimForPissing auto
int Property howToPiss Auto
int Property keyToPiss Auto
bool Property noPissInPublic Auto
int Property addPissPuddle Auto

bool Property enablePoop Auto
Float Property timePoop Auto
Float Property lastTimePoop Auto
Float Property maxPoopDamage Auto
bool Property useAnimForPooping auto
int Property howToPoop Auto
int Property keyToPoop Auto
bool Property noPoopInPublic Auto
int Property addVisiblePoop Auto

bool Property pissAndPoopTogether Auto
int Property howToPissPoop Auto
int Property keyToPissPoop Auto

bool Property enableSex Auto
Float Property timeSex Auto
Float Property lastTimeSex Auto
Float Property maxSexDamage Auto
bool Property noSexInPublic Auto
int Property keyToMasturbate Auto

bool Property enableDrunk Auto
Float Property timeDrunk Auto
Float Property lastTimeDrunk Auto
Float Property maxDrunkDamage Auto
	
bool Property enableBath Auto
Float Property timeBath Auto
Float Property lastTimeBath Auto
Float Property maxBathDamage Auto
bool Property noDirtShaderWhileCum Auto
int Property howToBathInRivers Auto
int Property keyToBathInRivers Auto
Float Property bathDuration Auto

bool Property enablePray Auto
Float Property timePray Auto
Float Property lastTimePray Auto
Float Property maxPrayDamage Auto

bool Property enableSkooma Auto
Float Property timeSkooma Auto
Float Property lastTimeSkooma Auto
Float Property maxSkoomaDamage Auto
	
bool Property enableAlcohol Auto
Float Property timeAlcohol Auto
Float Property lastTimeAlcohol Auto
Float Property maxAlcoholDamage Auto
	
bool Property enableWeed Auto
Float Property timeWeed Auto
Float Property lastTimeWeed Auto
Float Property maxWeedDamage Auto
	
int Property stripMode Auto

int Property grabRandomWeapon Auto ; 0=disabled, >0 do it (higer = more probable), -1 being done (used when equipping)
int Property drinkAnotherAlcohol Auto ; 0=disabled, >0 do it (higer = more probable), -1 being done (used when drinking)

bool Property enableWidgets Auto
int Property widgetsKey Auto
int Property oldWidgetsKey Auto
int Property widgetsOpacities Auto ; 0=Always visible, 1=Barely visible, 2=Progressive (linear), 3=Progressive (late), 4=Progressive (soon)
int Property widgetsPositions Auto ; 0=top, 1=bottom, 2=left, 3=right
int Property widgetsArrangements Auto ; 0=begin, 1=center, 2=end
int Property widgetsSize Auto ; 0=no, 1=minimal (50px), 2=quarter space (1280/num/4), 3=half space (1280/num/2), 4=full space (1280/num)
int Property widgetsSpace Auto ; space between widgets
int Property widgetsMarginH Auto ; margin from the horizontal border
int Property widgetsMarginV Auto ; margin from the vertical border
int Property widgetsGrouped Auto ; organization: 0=one after the other horizontal, 1=squared, 2=one after other vertical

bool Property useTimeScale Auto
int Property notificationsTime Auto

bool Property disableTheMod Auto


bool Property enableWidgetEat Auto
bool Property enableWidgetDrink Auto
bool Property enableWidgetSleep Auto
bool Property enableWidgetTalk Auto
bool Property enableWidgetBath Auto
bool Property enableWidgetPray Auto
bool Property enableWidgetPiss Auto
bool Property enableWidgetPoop Auto
bool Property enableWidgetSex Auto
bool Property enableWidgetSkooma Auto
bool Property enableWidgetAlcohol Auto
bool Property enableWidgetWeed Auto
bool Property enableWidgetDrunk Auto

int Property widColSEat Auto
int Property widColEEat Auto
int Property widColSDrink Auto
int Property widColEDrink Auto
int Property widColSSleep Auto
int Property widColESleep Auto
int Property widColSTalk Auto
int Property widColETalk Auto
int Property widColSBath Auto
int Property widColEBath Auto
int Property widColSPray Auto
int Property widColEPray Auto
int Property widColSPiss Auto
int Property widColEPiss Auto
int Property widColSPoop Auto
int Property widColEPoop Auto
int Property widColSSex Auto
int Property widColESex Auto
int Property widColSDrunk Auto
int Property widColEDrunk Auto
int Property widColSSkooma Auto
int Property widColESkooma Auto
int Property widColSAlcohol Auto
int Property widColEAlcohol Auto
int Property widColSWeed Auto
int Property widColEWeed Auto

; Needs: 0=Eat, 1=Drink, 2=Sleep, 3=Talk, 4=Bath, 5=Pray, 6=Piss, 7=Poop, 8=Sex, 9=Skooma, 10=Alcohol, 11=Weed, 12=Drunk
int[] Property penalties0 Auto
int[] Property penalties1 Auto
int[] Property penalties2 Auto
int[] Property penalties3 Auto
int[] Property penalties4 Auto

; -))

; ((- Game properties
bool Property weHaveSexLab Auto
bool Property weHavePapyrusUtils Auto
Faction SexLabAnimatingFaction

bool Property weHaveWeed Auto
Potion Property mndInvisibleWeight Auto
int property mndSetDoNothing auto conditional
GlobalVariable Property TimeScale Auto
Potion Property mndWaterBottleFull Auto
Potion Property mndWaterBottleEmpty Auto
FormList Property mndFoods Auto
FormList Property mndDrinks Auto
Keyword Property mndVendorItemWater Auto
FormList Property VendorItemsInnkeeper Auto
FormList Property MQ201DrinkList Auto
FormList Property AlcoholicDrinksList Auto
FormList Property WineList Auto
FormList Property mndAlcohol Auto
FormList Property mndLiquidFoods Auto
FormList Property mndSkooma Auto
FormList Property mndWeed Auto
FormList Property mndBlood Auto
FormList Property mndVampireRaces Auto
FormList Property mndToBeIgnored Auto
FormList Property mndUnidentified Auto
FormList Property mndMilk Auto
FormList Property mndPreviouslyUnidentified Auto
Actor Property PlayerRef Auto

MagicEffect Property mndTakeALeakME Auto
MagicEffect Property mndDoYourBusinessME Auto
MagicEffect Property mndDoFullBusinessME Auto
Spell Property mndTakeALeak Auto
Shout Property mndTakeALeakShout Auto
Spell Property mndDoYourBusiness Auto
Shout Property mndDoYourBusinessShout Auto
Spell Property mndDoFullBusiness Auto
Shout Property mndDoFullBusinessShout Auto
Spell Property mndBathInRivers Auto
Shout Property mndBathInRiversShout Auto

ImageSpaceModifier[] Property mndISMs Auto

Sound Property mndPissingSound Auto
Sound Property mndEatSound Auto
Sound Property mndDrinkSound Auto
Sound Property mndPoopingSound Auto
Sound Property mndDiarrheaSound Auto
mndMCM Property mcm Auto
Activator Property mndPissPuddle Auto
Activator Property mndPoopPuddle Auto
ObjectReference[] Property pisses Auto
Float[] Property pissesTimes Auto
ObjectReference[] Property poops Auto
Float[] Property poopsTimes Auto

EffectShader Property mndDirtShader1 Auto
EffectShader Property mndDirtShader2 Auto
EffectShader Property mndDirtShader3 Auto
EffectShader Property mndDirtShader4 Auto

LeveledItem Property LItemFoodInnCommon Auto
LeveledItem Property LItemHonningbrewWhiterunRuralInnDrink Auto
LeveledItem Property LItemInnRuralDrink Auto
LeveledItem Property LItemMiscVendorMiscItems75 Auto
Book Property mndBuildShowerBook Auto
Book Property mndBuildBathtubBook Auto
LeveledItem Property LItemBookClutter Auto
LeveledItem Property LItemBook0All Auto
Book Property mndShowerLocationsBook Auto
EffectShader Property mndWetShader Auto

ObjectReference[] Property allStaticShowers Auto

Armor[] Property mndPees Auto
Armor Property mndPeeNone Auto


mndSLDelegateScript Property mndSLDelegate Auto

; -))

; ((- Widgets

mndWidget[] Property mndWidgets Auto ; Needs: 0=Eat, 1=Drink, 2=Sleep, 3=Talk, 4=Bath, 5=Pray, 6=Piss, 7=Poop, 8=Sex, 9=Skooma, 10=Alcohol, 11=Weed, 12=Drunk

mndWidgetManager[] wds

Function initWidgets()
	if !wds || wds.length!=13
		wds = new mndWidgetManager[13]
	endIf
	; Needs: 0=Eat, 1=Drink, 2=Sleep, 3=Talk, 4=Bath, 5=Pray, 6=Piss, 7=Poop, 8=Sex, 9=Skooma, 10=Alcohol, 11=Weed, 12=Drunk
	
	int i=mndWidgets.length
	while i
		i-=1
		mndWidgets[i].Alpha = 0.0
		mndWidgets[i].HAnchor = "left"
		mndWidgets[i].VAnchor = "bottom"
		mndWidgets[i].Width = 100
		mndWidgets[i].SetPercent(0.0)
		mndWidgets[i].FillDirection = "right"
	endWhile

	if widColSEat==-1
		widColSEat=0xEF6F12
	endIf
	if widColEEat==-1
		widColEEat=0xFF2211
	endIf
	if widColSDrink==-1
		widColSDrink=0x82FF82
	endIf
	if widColEDrink==-1
		widColEDrink=0x11AF22
	endIf
	if widColSSleep==-1
		widColSSleep=0x6666FF
	endIf
	if widColESleep==-1
		widColESleep=0x1122A1
	endIf
	if widColSTalk==-1
		widColSTalk=0xb7b4b4
	endIf
	if widColETalk==-1
		widColETalk=0x999997
	endIf
	if widColSBath==-1
		widColSBath=0xa7e4f4
	endIf
	if widColEBath==-1
		widColEBath=0xa9d9e7
	endIf
	if widColSPray==-1
		widColSPray=0xf884b4
	endIf
	if widColEPray==-1
		widColEPray=0xe98997
	endIf
	if widColSPiss==-1
		widColSPiss=0xFFDA22
	endIf
	if widColEPiss==-1
		widColEPiss=0xBABA11
	endIf
	if widColSPoop==-1
		widColSPoop=0x834a07
	endIf
	if widColEPoop==-1
		widColEPoop=0xd4801d
	endIf
	if widColSSex==-1
		widColSSex=0xe0efef
	endIf
	if widColESex==-1
		widColESex=0xf0f4f5
	endIf
	if widColSDrunk==-1
		widColSDrunk=0x91acd4
	endIf
	if widColEDrunk==-1
		widColEDrunk=0x9a1dd4
	endIf
	if widColSSkooma==-1
		widColSSkooma=0x68c6d5
	endIf
	if widColESkooma==-1
		widColESkooma=0x22d0eb
	endIf
	if widColSAlcohol==-1
		widColSAlcohol=0xdb90f4
	endIf
	if widColEAlcohol==-1
		widColEAlcohol=0xf434c0
	endIf
	if widColSWeed==-1
		widColSWeed=0x9ae1ac
	endIf
	if widColEWeed==-1
		widColEWeed=0x2d8b2c
	endIf

	mndWidgets[0].SetColors(widColSEat, widColEEat)
	mndWidgets[1].SetColors(widColSDrink, widColEDrink)
	mndWidgets[2].SetColors(widColSSleep, widColESleep)
	mndWidgets[3].SetColors(widColSTalk, widColETalk)
	mndWidgets[4].SetColors(widColSBath, widColEBath)
	mndWidgets[5].SetColors(widColSPray, widColEPray)
	mndWidgets[6].SetColors(widColSPiss, widColEPiss)
	mndWidgets[7].SetColors(widColSPoop, widColEPoop)
	mndWidgets[8].SetColors(widColSSex, widColESex)
	mndWidgets[9].SetColors(widColSSkooma, widColESkooma)
	mndWidgets[10].SetColors(widColSAlcohol, widColEAlcohol)
	mndWidgets[11].SetColors(widColSWeed, widColEWeed)
	mndWidgets[12].SetColors(widColSDrunk, widColEDrunk)
endFunction

Function calculateWidgets()
	if !enableWidgets || !(enableEat || enableDrink || enableSleep || enableTalk || enableBath || enablePray || enablePiss || enablePoop || enableSex || enableDrunk || enableSkooma || enableAlcohol || enableWeed)
		int w = mndWidgets.length
		while w
			w-=1
			mndWidgets[w].Alpha = 0.0
		endWhile
		return
	endIf
	
	float now = Utility.GetCurrentGameTime()
	if reverseWidgets
		if useTimeScale
			float tsv = 20.0/TimeScale.getValue()
			mndWidgets[0].SetPercent( 1.0 - tsv * 24.0*(now - lastTimeEat)/timeEat)
			mndWidgets[1].SetPercent( 1.0 - tsv * 24.0*(now - lastTimeDrink)/timeDrink)
			mndWidgets[2].SetPercent( 1.0 - tsv * 24.0*(now - lastTimeSleep)/timeSleep)
			mndWidgets[3].SetPercent( 1.0 - tsv * 24.0*(now - lastTimeTalk)/timeTalk)
			mndWidgets[4].SetPercent( 1.0 - tsv * 24.0*(now - lastTimeBath)/timeBath)
			mndWidgets[5].SetPercent( 1.0 - tsv * 24.0*(now - lastTimePray)/timePray)
			mndWidgets[6].SetPercent( 1.0 - tsv * 24.0*(now - lastTimePiss)/timePiss)
			mndWidgets[7].SetPercent( 1.0 - tsv * 24.0*(now - lastTimePoop)/timePoop)
			mndWidgets[8].SetPercent( 1.0 - tsv * 24.0*(now - lastTimeSex)/timeSex)
			mndWidgets[9].SetPercent( 1.0 - tsv * 24.0*(now - lastTimeSkooma)/timeSkooma)
			mndWidgets[10].SetPercent( 1.0 - tsv * 24.0*(now - lastTimeAlcohol)/timeAlcohol)
			mndWidgets[11].SetPercent( 1.0 - tsv * 24.0*(now - lastTimeWeed)/timeWeed)
			mndWidgets[12].SetPercent((timeDrunk - now + lastTimeDrunk)/timeDrunk)
		else
			mndWidgets[0].SetPercent(1.0 - 24.0*(now - lastTimeEat)/timeEat)
			mndWidgets[1].SetPercent(1.0 - 24.0*(now - lastTimeDrink)/timeDrink)
			mndWidgets[2].SetPercent(1.0 - 24.0*(now - lastTimeSleep)/timeSleep)
			mndWidgets[3].SetPercent(1.0 - 24.0*(now - lastTimeTalk)/timeTalk)
			mndWidgets[4].SetPercent(1.0 - 24.0*(now - lastTimeBath)/timeBath)
			mndWidgets[5].SetPercent(1.0 - 24.0*(now - lastTimePray)/timePray)
			mndWidgets[6].SetPercent(1.0 - 24.0*(now - lastTimePiss)/timePiss)
			mndWidgets[7].SetPercent(1.0 - 24.0*(now - lastTimePoop)/timePoop)
			mndWidgets[8].SetPercent(1.0 - 24.0*(now - lastTimeSex)/timeSex)
			mndWidgets[9].SetPercent(1.0 - 24.0*(now - lastTimeSkooma)/timeSkooma)
			mndWidgets[10].SetPercent(1.0 - 24.0*(now - lastTimeAlcohol)/timeAlcohol)
			mndWidgets[11].SetPercent(1.0 - 24.0*(now - lastTimeWeed)/timeWeed)
			mndWidgets[12].SetPercent((timeDrunk/24.0 - now + lastTimeDrunk)/(timeDrunk/24.0))
		endIf
	else
		if useTimeScale
			float tsv = 20.0/TimeScale.getValue()
			mndWidgets[0].SetPercent( tsv * 24.0*(now - lastTimeEat)/timeEat)
			mndWidgets[1].SetPercent( tsv * 24.0*(now - lastTimeDrink)/timeDrink)
			mndWidgets[2].SetPercent( tsv * 24.0*(now - lastTimeSleep)/timeSleep)
			mndWidgets[3].SetPercent( tsv * 24.0*(now - lastTimeTalk)/timeTalk)
			mndWidgets[4].SetPercent( tsv * 24.0*(now - lastTimeBath)/timeBath)
			mndWidgets[5].SetPercent( tsv * 24.0*(now - lastTimePray)/timePray)
			mndWidgets[6].SetPercent( tsv * 24.0*(now - lastTimePiss)/timePiss)
			mndWidgets[7].SetPercent( tsv * 24.0*(now - lastTimePoop)/timePoop)
			mndWidgets[8].SetPercent( tsv * 24.0*(now - lastTimeSex)/timeSex)
			mndWidgets[9].SetPercent( tsv * 24.0*(now - lastTimeSkooma)/timeSkooma)
			mndWidgets[10].SetPercent( tsv * 24.0*(now - lastTimeAlcohol)/timeAlcohol)
			mndWidgets[11].SetPercent( tsv * 24.0*(now - lastTimeWeed)/timeWeed)
			mndWidgets[12].SetPercent((timeDrunk - now + lastTimeDrunk)/timeDrunk)
		else
			mndWidgets[0].SetPercent(24.0*(now - lastTimeEat)/timeEat)
			mndWidgets[1].SetPercent(24.0*(now - lastTimeDrink)/timeDrink)
			mndWidgets[2].SetPercent(24.0*(now - lastTimeSleep)/timeSleep)
			mndWidgets[3].SetPercent(24.0*(now - lastTimeTalk)/timeTalk)
			mndWidgets[4].SetPercent(24.0*(now - lastTimeBath)/timeBath)
			mndWidgets[5].SetPercent(24.0*(now - lastTimePray)/timePray)
			mndWidgets[6].SetPercent(24.0*(now - lastTimePiss)/timePiss)
			mndWidgets[7].SetPercent(24.0*(now - lastTimePoop)/timePoop)
			mndWidgets[8].SetPercent(24.0*(now - lastTimeSex)/timeSex)
			mndWidgets[9].SetPercent(24.0*(now - lastTimeSkooma)/timeSkooma)
			mndWidgets[10].SetPercent(24.0*(now - lastTimeAlcohol)/timeAlcohol)
			mndWidgets[11].SetPercent(24.0*(now - lastTimeWeed)/timeWeed)
			mndWidgets[12].SetPercent((timeDrunk/24.0 - now + lastTimeDrunk)/(timeDrunk/24.0))
		endIf
	endIf

	; Fit the actual widgets
	i = wds.length
	while i
		i-=1
		wds[i]=None
	endWhile

	int numWidgets=0
	if enableEat && enableWidgetEat
		wds[numWidgets] = mndWidgets[0]
		numWidgets+=1
	else
		mndWidgets[0].alpha=0.0
	endIf
	if enableDrink && enableWidgetDrink
		wds[numWidgets] = mndWidgets[1]
		numWidgets+=1
	else
		mndWidgets[1].alpha=0.0
	endIf
	if enableSleep && enableWidgetSleep
		wds[numWidgets] = mndWidgets[2]
		numWidgets+=1
	else
		mndWidgets[2].alpha=0.0
	endIf
	if enableTalk && enableWidgetTalk
		wds[numWidgets] = mndWidgets[3]
		numWidgets+=1
	else
		mndWidgets[3].alpha=0.0
	endIf
	if enableBath && enableWidgetBath
		wds[numWidgets] = mndWidgets[4]
		numWidgets+=1
	else
		mndWidgets[4].alpha=0.0
	endIf
	if enablePray && enableWidgetPray
		wds[numWidgets] = mndWidgets[5]
		numWidgets+=1
	else
		mndWidgets[5].alpha=0.0
	endIf
	if enablePiss && enableWidgetPiss
		wds[numWidgets] = mndWidgets[6]
		numWidgets+=1
	else
		mndWidgets[6].alpha=0.0
	endIf
	if enablePoop && enableWidgetPoop
		wds[numWidgets] = mndWidgets[7]
		numWidgets+=1
	else
		mndWidgets[7].alpha=0.0
	endIf
	if enableSex && enableWidgetSex
		wds[numWidgets] = mndWidgets[8]
		numWidgets+=1
	else
		mndWidgets[8].alpha=0.0
	endIf
	if enableSkooma && enableWidgetSkooma
		wds[numWidgets] = mndWidgets[9]
		numWidgets+=1
	else
		mndWidgets[9].alpha=0.0
	endIf
	if enableAlcohol && enableWidgetAlcohol
		wds[numWidgets] = mndWidgets[10]
		numWidgets+=1
	else
		mndWidgets[10].alpha=0.0
	endIf
	if enableWeed && enableWidgetWeed
		wds[numWidgets] = mndWidgets[11]
		numWidgets+=1
	else
		mndWidgets[11].alpha=0.0
	endIf
	if enableDrunk && enableWidgetDrunk
		wds[numWidgets] = mndWidgets[12]
		numWidgets+=1
	else
		mndWidgets[12].alpha=0.0
	endIf
	
	int wSpace = widgetsSpace
	if (widgetsPositions==0 || widgetsPositions==1) && widgetsGrouped==0
		wSpace -= 23 ; Correction for horizontal widgets
	endIf
	float size = 100.0
	i = 0
	if widgetsGrouped==0 ; Arranged horizontally one after the other
		if widgetsPositions==0 ; Top ----------------------------------------------------------------------------------
			if widgetsSize==0 ; small
				size = 100.0
			elseIf widgetsSize==1 ; medium
				size = 105.0 + (13 - numWidgets)*15.0
			elseIf widgetsSize==2 ; big
				size = 1.01 *((1280.0 - 2.0*widgetsMarginH) - (numWidgets - 1.0)*widgetsSpace) / numWidgets
			endIf
			if widgetsArrangements==0 ; Top Left
				while i<numWidgets
					wds[i].y = 20 + widgetsMarginV
					wds[i].x = widgetsMarginH + (size+wSpace)*i
					wds[i].alpha=size
					i+=1
				endWhile
			elseIf widgetsArrangements==1 ; Top Center
				while i<numWidgets
					wds[i].y = 20 + widgetsMarginV
					wds[i].x = ((1293 - 2*widgetsMarginH) - ((size+wSpace)*numWidgets - wSpace))/2.0 + (size+wSpace)*i
					wds[i].alpha=size
					i+=1
				endWhile
			elseIf widgetsArrangements==2 ; Top Right
				while i<numWidgets
					wds[i].y = 20 + widgetsMarginV
					wds[i].x = (1274 - widgetsMarginH) - (size+wSpace)*(numWidgets - i)
					wds[i].alpha=size
					i+=1
				endWhile
			endIf
		

		elseIf widgetsPositions==1 ; Bottom ----------------------------------------------------------------------------------
			if widgetsSize==0 ; small
				size = 100.0
			elseIf widgetsSize==1 ; medium
				size = 105.0 + (13 - numWidgets)*15.0
			elseIf widgetsSize==2 ; big
				size = 1.01 *((1280.0 - 2.0*widgetsMarginH) - (numWidgets - 1.0)*widgetsSpace) / numWidgets
			endIf
			if widgetsArrangements==0 ; Bottom Left
				while i<numWidgets
					wds[i].y = 723 - widgetsMarginV
					wds[i].x = widgetsMarginH + (size+wSpace)*i
					wds[i].alpha=size
					i+=1
				endWhile
			elseIf widgetsArrangements==1 ; Bottom Center
				while i<numWidgets
					wds[i].y = 723 - widgetsMarginV
					wds[i].x = ((1293 - 2*widgetsMarginH) - ((size+wSpace)*numWidgets - wSpace))/2.0 + (size+wSpace)*i
					wds[i].alpha=size
					i+=1
				endWhile
			elseIf widgetsArrangements==2 ; Bottom Right
				while i<numWidgets
					wds[i].y = 723 - widgetsMarginV
					wds[i].x = (1274 - widgetsMarginH) - (size+wSpace)*(numWidgets - i)
					wds[i].alpha=size
					i+=1
				endWhile
			endIf
			

		elseIf widgetsPositions==2 ; Left ----------------------------------------------------------------------------------
			if widgetsSize==0 ; small
				size = 100.0
			elseIf widgetsSize==1 ; medium
				size = 130.0
			elseIf widgetsSize==2 ; big
				size = 160.0
			endIf
			if widgetsArrangements==0 ; Left Top
				while i<numWidgets
					wds[i].y = 20.0 + widgetsMarginV + (16.0+wSpace)*i
					wds[i].x = widgetsMarginH
					wds[i].alpha=size
					i+=1
				endWhile
			elseIf widgetsArrangements==1 ; Left Middle
				while i<numWidgets
					wds[i].y = ((703 - 2*widgetsMarginV) - ((16.0+wSpace)*numWidgets - wSpace))/2.0 + (16.0+wSpace)*i
					wds[i].x = widgetsMarginH
					wds[i].alpha=size
					i+=1
				endWhile
			elseIf widgetsArrangements==2 ; Left Bottom
				while i<numWidgets
					wds[i].y = 723 - widgetsMarginV - (16.0+wSpace)*(numWidgets - i - 1)
					wds[i].x = widgetsMarginH
					wds[i].alpha=size
					i+=1
				endWhile
			endIf
		
		elseIf widgetsPositions==3 ; Right ----------------------------------------------------------------------------------
			if widgetsSize==0 ; small
				size = 100.0
			elseIf widgetsSize==1 ; medium
				size = 130.0
			elseIf widgetsSize==2 ; big
				size = 160.0
			endIf
			if widgetsArrangements==0 ; Right Top
				while i<numWidgets
					wds[i].y = 20.0 + widgetsMarginV + (16.0+wSpace)*i
					wds[i].x = 1298 - widgetsMarginH - size
					wds[i].alpha=size
					i+=1
				endWhile
			elseIf widgetsArrangements==1 ; Right Middle
				while i<numWidgets
					wds[i].y = ((703 - 2*widgetsMarginV) - ((16.0+wSpace)*numWidgets - wSpace))/2.0 + (16.0+wSpace)*i
					wds[i].x = 1298 - widgetsMarginH - size
					wds[i].alpha=size
					i+=1
				endWhile
			elseIf widgetsArrangements==2 ; Right Bottom
				while i<numWidgets
					wds[i].y = 723 - widgetsMarginV - (16.0+wSpace)*(numWidgets - i - 1)
					wds[i].x = 1298 - widgetsMarginH - size
					wds[i].alpha=size
					i+=1
				endWhile
			endIf
		
		endIf

	elseIf widgetsGrouped==1 ; Arranged in a square box (x/2,2)
		int halfW=0
		if numWidgets%2 == 0
			halfW=numWidgets/2
		else
			halfW=(1+numWidgets)/2
		endIf
		if widgetsPositions==0 ; Top ----------------------------------------------------------------------------------
			if widgetsSize==0 ; small
				size = 100.0
			elseIf widgetsSize==1 ; medium
				size = 110.25 + (13 - numWidgets)*15.0
			elseIf widgetsSize==2 ; big
				size = 1.01 *((1280.0 - 2.0*widgetsMarginH) - (numWidgets - 1.0)*widgetsSpace) / numWidgets
			endIf
			if widgetsArrangements==0 ; Top Left
				while i<halfW
					wds[i].y = 20 + widgetsMarginV
					wds[i].x = widgetsMarginH + (size+wSpace - 23)*i
					wds[i].alpha=size
					i+=1
				endWhile
				i=halfW
				while i<numWidgets
					wds[i].y = 20 + widgetsMarginV + 16.0 + wSpace
					wds[i].x = widgetsMarginH + (size+wSpace - 23)*(i - halfW)
					wds[i].alpha=size
					i+=1
				endWhile
				
			elseIf widgetsArrangements==1 ; Top Center
				while i<halfW
					wds[i].y = 20 + widgetsMarginV
					wds[i].x = ((1293 - 2*widgetsMarginH) - ((size+wSpace)*halfW - wSpace - 23))/2.0 + (size+wSpace - 23)*i
					wds[i].alpha=size
					i+=1
				endWhile
				i=halfW
				while i<numWidgets
					wds[i].y = 20 + widgetsMarginV + 16.0 + wSpace
					wds[i].x = ((1293 - 2*widgetsMarginH) - ((size+wSpace)*halfW - wSpace - 23))/2.0 + (size+wSpace - 23)*(i - halfW)
					wds[i].alpha=size
					i+=1
				endWhile
				
			elseIf widgetsArrangements==2 ; Top Right
				while i<halfW
					wds[i].y = 20 + widgetsMarginV
					wds[i].x = (1274 - widgetsMarginH) - (size+wSpace - 23)*(halfW - i)
					wds[i].alpha=size
					i+=1
				endWhile
				i=halfW
				while i<numWidgets
					wds[i].y = 20 + widgetsMarginV + 16.0 + wSpace
					wds[i].x = (1274 - widgetsMarginH) - (size+wSpace - 23)*(numWidgets - i)
					wds[i].alpha=size
					i+=1
				endWhile
			endIf

		elseIf widgetsPositions==1 ; Bottom ----------------------------------------------------------------------------------
			if widgetsSize==0 ; small
				size = 100.0
			elseIf widgetsSize==1 ; medium
				size = 110.25 + (13 - numWidgets)*15.0
			elseIf widgetsSize==2 ; big
				size = 1.01 *((1280.0 - 2.0*widgetsMarginH) - (numWidgets - 1.0)*widgetsSpace) / numWidgets
			endIf
			if widgetsArrangements==0 ; Bottom Left
				while i<halfW
					wds[i].y = 723 - widgetsMarginV - 16.0 - wSpace
					wds[i].x = widgetsMarginH + (size+wSpace - 23)*i
					wds[i].alpha=size
					i+=1
				endWhile
				i=halfW
				while i<numWidgets
					wds[i].y = 723 - widgetsMarginV
					wds[i].x = widgetsMarginH + (size+wSpace - 23)*(i - halfW)
					wds[i].alpha=size
					i+=1
				endWhile
			elseIf widgetsArrangements==1 ; Bottom Center
				while i<halfW
					wds[i].y = 723 - widgetsMarginV - 16.0 - wSpace
					wds[i].x = ((1293 - 2*widgetsMarginH) - ((size+wSpace)*halfW - wSpace - 23))/2.0 + (size+wSpace - 23)*i
					wds[i].alpha=size
					i+=1
				endWhile
				i=halfW
				while i<numWidgets
					wds[i].y = 723 - widgetsMarginV
					wds[i].x = ((1293 - 2*widgetsMarginH) - ((size+wSpace)*halfW - wSpace - 23))/2.0 + (size+wSpace - 23)*(i - halfW)
					wds[i].alpha=size
					i+=1
				endWhile
			elseIf widgetsArrangements==2 ; Bottom Right
				while i<halfW
					wds[i].y = 723 - widgetsMarginV - 16.0 - wSpace
					wds[i].x = (1274 - widgetsMarginH) - (size+wSpace - 23)*(halfW - i)
					wds[i].alpha=size
					i+=1
				endWhile
				i=halfW
				while i<numWidgets
					wds[i].y = 723 - widgetsMarginV
					wds[i].x = (1274 - widgetsMarginH) - (size+wSpace - 23)*(numWidgets - i)
					wds[i].alpha=size
					i+=1
				endWhile
			endIf
			

		elseIf widgetsPositions==2 ; Left ----------------------------------------------------------------------------------
			if widgetsSize==0 ; small
				size = 100.0
			elseIf widgetsSize==1 ; medium
				size = 130.0
			elseIf widgetsSize==2 ; big
				size = 160.0
			endIf
			if widgetsArrangements==0 ; Left Top
				while i<halfW
					wds[i].y = 20 + widgetsMarginV
					wds[i].x = widgetsMarginH + (size+wSpace - 23)*i
					wds[i].alpha=size
					i+=1
				endWhile
				i=halfW
				while i<numWidgets
					wds[i].y = 20 + widgetsMarginV + 16.0 + wSpace
					wds[i].x = widgetsMarginH + (size+wSpace - 23)*(i - halfW)
					wds[i].alpha=size
					i+=1
				endWhile
			elseIf widgetsArrangements==1 ; Left Middle
				while i<halfW
					wds[i].y = (703 - 2*widgetsMarginV - 32.0 - wSpace)/2.0
					wds[i].x = widgetsMarginH + (size+wSpace - 23)*i
					wds[i].alpha=size
					i+=1
				endWhile
				i=halfW
				while i<numWidgets
					wds[i].y = (703 - 2*widgetsMarginV - 32.0 - wSpace)/2.0 + 16.0 + wSpace
					wds[i].x = widgetsMarginH + (size+wSpace - 23)*(i - halfW)
					wds[i].alpha=size
					i+=1
				endWhile
			elseIf widgetsArrangements==2 ; Left Bottom
				while i<halfW
					wds[i].y = 723 - widgetsMarginV - 16.0 - wSpace
					wds[i].x = widgetsMarginH + (size+wSpace - 23)*i
					wds[i].alpha=size
					i+=1
				endWhile
				i=halfW
				while i<numWidgets
					wds[i].y = 723 - widgetsMarginV
					wds[i].x = widgetsMarginH + (size+wSpace - 23)*(i - halfW)
					wds[i].alpha=size
					i+=1
				endWhile
			endIf
		
		elseIf widgetsPositions==3 ; Right ----------------------------------------------------------------------------------
			if widgetsSize==0 ; small
				size = 100.0
			elseIf widgetsSize==1 ; medium
				size = 130.0
			elseIf widgetsSize==2 ; big
				size = 160.0
			endIf
			if widgetsArrangements==0 ; Right Top
				while i<halfW
					wds[i].y = 20 + widgetsMarginV
					wds[i].x = (1274 - widgetsMarginH) - (size+wSpace - 23)*(halfW - i)
					wds[i].alpha=size
					i+=1
				endWhile
				i=halfW
				while i<numWidgets
					wds[i].y = 20 + widgetsMarginV + 16.0 + wSpace
					wds[i].x = (1274 - widgetsMarginH) - (size+wSpace - 23)*(numWidgets - i)
					wds[i].alpha=size
					i+=1
				endWhile
			elseIf widgetsArrangements==1 ; Right Middle
				while i<halfW
					wds[i].y = (703 - 2*widgetsMarginV - 32.0 - wSpace)/2.0
					wds[i].x = (1274 - widgetsMarginH) - (size+wSpace - 23)*(halfW - i)
					wds[i].alpha=size
					i+=1
				endWhile
				i=halfW
				while i<numWidgets
					wds[i].y = (703 - 2*widgetsMarginV - 32.0 - wSpace)/2.0 + 16.0 + wSpace
					wds[i].x = (1274 - widgetsMarginH) - (size+wSpace - 23)*(numWidgets - i)
					wds[i].alpha=size
					i+=1
				endWhile
			elseIf widgetsArrangements==2 ; Right Bottom
				while i<halfW
					wds[i].y = 723 - widgetsMarginV - 16.0 - wSpace
					wds[i].x = (1274 - widgetsMarginH) - (size+wSpace - 23)*(halfW - i)
					wds[i].alpha=size
					i+=1
				endWhile
				i=halfW
				while i<numWidgets
					wds[i].y = 723 - widgetsMarginV
					wds[i].x = (1274 - widgetsMarginH) - (size+wSpace - 23)*(numWidgets - i)
					wds[i].alpha=size
					i+=1
				endWhile
			endIf
		
		endIf

	elseIf widgetsGrouped==2 ; Arranged in a square box (2,x/2)
		if widgetsPositions==0 ; Top ----------------------------------------------------------------------------------
			if widgetsSize==0 ; small
				size = 100.0
			elseIf widgetsSize==1 ; medium
				size = 110.25 + (13 - numWidgets)*15.0
			elseIf widgetsSize==2 ; big
				size = 1.01 *((1280.0 - 2.0*widgetsMarginH) - (numWidgets - 1.0)*widgetsSpace) / numWidgets
			endIf
			if widgetsArrangements==0 ; Top Left
				while i<numWidgets
					wds[i].y = 20 + widgetsMarginV + (16.0 + wSpace) * (i/2)
					wds[i].x = widgetsMarginH
					wds[i].alpha=size
					if i+1<numWidgets
						wds[i+1].y = 20 + widgetsMarginV + (16.0 + wSpace) * (i/2)
						wds[i+1].x = widgetsMarginH + size + wSpace - 23
						wds[i+1].alpha=size
					endIf
					i+=2
				endWhile
				
			elseIf widgetsArrangements==1 ; Top Center
				while i<numWidgets
					wds[i].y = 20 + widgetsMarginV + (16.0 + wSpace) * (i/2)
					wds[i].x = ((1293 - 2*widgetsMarginH) - (2*size + wSpace - 23))/2.0
					wds[i].alpha=size
					if i+1<numWidgets
						wds[i+1].y = 20 + widgetsMarginV + (16.0 + wSpace) * (i/2)
						wds[i+1].x = ((1293 - 2*widgetsMarginH) - (2*size + wSpace - 23))/2.0 + (size+wSpace - 23)
						wds[i+1].alpha=size
					endIf
					i+=2
				endWhile
				
			elseIf widgetsArrangements==2 ; Top Right
				while i<numWidgets
					wds[i].y = 20 + widgetsMarginV + (16.0 + wSpace) * (i/2)
					wds[i].x = 1274 - widgetsMarginH - 2*size - wSpace + 46
					wds[i].alpha=size
					if i+1<numWidgets
						wds[i+1].y = 20 + widgetsMarginV + (16.0 + wSpace) * (i/2)
						wds[i+1].x = 1274 - widgetsMarginH - size - wSpace + 23
						wds[i+1].alpha=size
					endIf
					i+=2
				endWhile
			endIf

		elseIf widgetsPositions==1 ; Bottom ----------------------------------------------------------------------------------
			if widgetsSize==0 ; small
				size = 100.0
			elseIf widgetsSize==1 ; medium
				size = 110.25 + (13 - numWidgets)*15.0
			elseIf widgetsSize==2 ; big
				size = 1.01 *((1280.0 - 2.0*widgetsMarginH) - (numWidgets - 1.0)*widgetsSpace) / numWidgets
			endIf
			if widgetsArrangements==0 ; Bottom Left
				while i<numWidgets
					wds[i].y = 723 - widgetsMarginV - (16.0 + wSpace) * Math.floor((numWidgets - i)/2)
					wds[i].x = widgetsMarginH
					wds[i].alpha=size
					if i+1<numWidgets
						wds[i+1].y = 723 - widgetsMarginV - (16.0 + wSpace) * Math.floor((numWidgets - i)/2)
						wds[i+1].x = widgetsMarginH + size + wSpace - 23
						wds[i+1].alpha=size
					endIf
					i+=2
				endWhile

			elseIf widgetsArrangements==1 ; Bottom Center
				while i<numWidgets
					wds[i].y = 723 - widgetsMarginV - (16.0 + wSpace) * Math.floor((numWidgets - i)/2)
					wds[i].x = ((1293 - 2*widgetsMarginH) - (2*size + wSpace - 23))/2.0
					wds[i].alpha=size
					if i+1<numWidgets
						wds[i+1].y = 723 - widgetsMarginV - (16.0 + wSpace) * Math.floor((numWidgets - i)/2)
						wds[i+1].x = ((1293 - 2*widgetsMarginH) - (2*size + wSpace - 23))/2.0 + (size+wSpace - 23)
						wds[i+1].alpha=size
					endIf
					i+=2
				endWhile
				
			elseIf widgetsArrangements==2 ; Bottom Right
				while i<numWidgets
					wds[i].y = 723 - widgetsMarginV - (16.0 + wSpace) * Math.floor((numWidgets - i)/2)
					wds[i].x = 1274 - widgetsMarginH - 2*size - wSpace + 46
					wds[i].alpha=size
					if i+1<numWidgets
						wds[i+1].y = 723 - widgetsMarginV - (16.0 + wSpace) * Math.floor((numWidgets - i)/2)
						wds[i+1].x = 1274 - widgetsMarginH - size - wSpace + 23
						wds[i+1].alpha=size
					endIf
					i+=2
				endWhile
			endIf
			

		elseIf widgetsPositions==2 ; Left ----------------------------------------------------------------------------------
			if widgetsSize==0 ; small
				size = 100.0
			elseIf widgetsSize==1 ; medium
				size = 130.0
			elseIf widgetsSize==2 ; big
				size = 160.0
			endIf
			if widgetsArrangements==0 ; Left Top
				while i<numWidgets
					wds[i].y = 20 + widgetsMarginV + (16.0 + wSpace) * (i/2)
					wds[i].x = widgetsMarginH
					wds[i].alpha=size
					if i+1<numWidgets
						wds[i+1].y = 20 + widgetsMarginV + (16.0 + wSpace) * (i/2)
						wds[i+1].x = widgetsMarginH + size + wSpace - 23
						wds[i+1].alpha=size
					endIf
					i+=2
				endWhile
			elseIf widgetsArrangements==1 ; Left Middle
				while i<numWidgets
					wds[i].y = ((703 - 2*widgetsMarginV) - (16.0 + wSpace) * (numWidgets/2))/2.0 + (16.0 + wSpace) * (i/2)
					wds[i].x = widgetsMarginH
					wds[i].alpha=size
					if i+1<numWidgets
						wds[i+1].y = ((703 - 2*widgetsMarginV) - (16.0 + wSpace) * (numWidgets/2))/2.0 + (16.0 + wSpace) * (i/2)
						wds[i+1].x = widgetsMarginH + size + wSpace - 23
						wds[i+1].alpha=size
					endIf
					i+=2
				endWhile
			elseIf widgetsArrangements==2 ; Left Bottom
				while i<numWidgets
					wds[i].y = 723 - widgetsMarginV - (16.0 + wSpace) * Math.floor((numWidgets - i)/2)
					wds[i].x = widgetsMarginH
					wds[i].alpha=size
					if i+1<numWidgets
						wds[i+1].y = 723 - widgetsMarginV - (16.0 + wSpace) * Math.floor((numWidgets - i)/2)
						wds[i+1].x = widgetsMarginH + size + wSpace - 23
						wds[i+1].alpha=size
					endIf
					i+=2
				endWhile
			endIf
		
		elseIf widgetsPositions==3 ; Right ----------------------------------------------------------------------------------
			if widgetsSize==0 ; small
				size = 100.0
			elseIf widgetsSize==1 ; medium
				size = 130.0
			elseIf widgetsSize==2 ; big
				size = 160.0
			endIf
			if widgetsArrangements==0 ; Right Top
				while i<numWidgets
					wds[i].y = 20 + widgetsMarginV + (16.0 + wSpace) * (i/2)
					wds[i].x = 1274 - widgetsMarginH - 2*size - wSpace + 46
					wds[i].alpha=size
					if i+1<numWidgets
						wds[i+1].y = 20 + widgetsMarginV + (16.0 + wSpace) * (i/2)
						wds[i+1].x = 1274 - widgetsMarginH - size - wSpace + 23
						wds[i+1].alpha=size
					endIf
					i+=2
				endWhile
			elseIf widgetsArrangements==1 ; Right Middle
				while i<numWidgets
					wds[i].y = ((703 - 2*widgetsMarginV) - (16.0 + wSpace) * (numWidgets/2))/2.0 + (16.0 + wSpace) * (i/2)
					wds[i].x = 1274 - widgetsMarginH - 2*size - wSpace + 46
					wds[i].alpha=size
					if i+1<numWidgets
						wds[i+1].y = ((703 - 2*widgetsMarginV) - (16.0 + wSpace) * (numWidgets/2))/2.0 + (16.0 + wSpace) * (i/2)
						wds[i+1].x = 1274 - widgetsMarginH - size - wSpace + 23
						wds[i+1].alpha=size
					endIf
					i+=2
				endWhile

			elseIf widgetsArrangements==2 ; Right Bottom
				while i<numWidgets
					wds[i].y = 723 - widgetsMarginV - (16.0 + wSpace) * Math.floor((numWidgets - i)/2)
					wds[i].x = 1274 - widgetsMarginH - 2*size - wSpace + 46
					wds[i].alpha=size
					if i+1<numWidgets
						wds[i+1].y = 723 - widgetsMarginV - (16.0 + wSpace) * Math.floor((numWidgets - i)/2)
						wds[i+1].x = 1274 - widgetsMarginH - size - wSpace + 23
						wds[i+1].alpha=size
					endIf
					i+=2
				endWhile
			endIf
		endIf	
	
	elseIf widgetsGrouped==3 ; Arranged vertically one over the other
		if widgetsPositions==0 ; Top ----------------------------------------------------------------------------------
			if widgetsSize==0 ; small
				size = 100.0
			elseIf widgetsSize==1 ; medium
				size = 110.25 + (13 - numWidgets)*15.0
			elseIf widgetsSize==2 ; big
				size = 1.01 *((1280.0 - 2.0*widgetsMarginH) - (numWidgets - 1.0)*widgetsSpace) / numWidgets
			endIf
			if widgetsArrangements==0 ; Top Left
				while i<numWidgets
					wds[i].y = 20 + widgetsMarginV + (16.0+wSpace)*i
					wds[i].x = widgetsMarginH
					wds[i].alpha=size
					i+=1
				endWhile
			elseIf widgetsArrangements==1 ; Top Center
				while i<numWidgets
					wds[i].y = 20 + widgetsMarginV + (16.0+wSpace)*i
					wds[i].x = (1293 - 2*widgetsMarginH - size)/2.0
					wds[i].alpha=size
					i+=1
				endWhile
			elseIf widgetsArrangements==2 ; Top Right
				while i<numWidgets
					wds[i].y = 20 + widgetsMarginV + (16.0+wSpace)*i
					wds[i].x = 1298 - widgetsMarginH - size
					wds[i].alpha=size
					i+=1
				endWhile
			endIf

		elseIf widgetsPositions==1 ; Bottom ----------------------------------------------------------------------------------
			if widgetsSize==0 ; small
				size = 100.0
			elseIf widgetsSize==1 ; medium
				size = 110.25 + (13 - numWidgets)*15.0
			elseIf widgetsSize==2 ; big
				size = 1.01 *((1280.0 - 2.0*widgetsMarginH) - (numWidgets - 1.0)*widgetsSpace) / numWidgets
			endIf
			if widgetsArrangements==0 ; Bottom Left
				while i<numWidgets
					wds[i].y = 723 - widgetsMarginV - (16.0+wSpace)*(numWidgets - i - 1)
					wds[i].x = widgetsMarginH
					wds[i].alpha=size
					i+=1
				endWhile
			elseIf widgetsArrangements==1 ; Bottom Center
				while i<numWidgets
					wds[i].y = 723 - widgetsMarginV - (16.0+wSpace)*(numWidgets - i - 1)
					wds[i].x = (1293 - 2*widgetsMarginH - size)/2.0
					wds[i].alpha=size
					i+=1
				endWhile
			elseIf widgetsArrangements==2 ; Bottom Right
				while i<numWidgets
					wds[i].y = 723 - widgetsMarginV - (16.0+wSpace)*(numWidgets - i - 1)
					wds[i].x = 1298 - widgetsMarginH - size
					wds[i].alpha=size
					i+=1
				endWhile
			endIf
			
		elseIf widgetsPositions==2 ; Left ----------------------------------------------------------------------------------
			if widgetsSize==0 ; small
				size = 100.0
			elseIf widgetsSize==1 ; medium
				size = 130.0
			elseIf widgetsSize==2 ; big
				size = 160.0
			endIf
			if widgetsArrangements==0 ; Left Top
				while i<numWidgets
					wds[i].y = 20 + widgetsMarginV + (16.0+wSpace)*i
					wds[i].x = widgetsMarginH
					wds[i].alpha=size
					i+=1
				endWhile
			elseIf widgetsArrangements==1 ; Left Middle
				while i<numWidgets
					wds[i].y = ((703 - 2*widgetsMarginV) - ((16.0+wSpace)*numWidgets - wSpace))/2.0 + (16.0+wSpace)*i
					wds[i].x = widgetsMarginH
					wds[i].alpha=size
					i+=1
				endWhile
			elseIf widgetsArrangements==2 ; Left Bottom
				while i<numWidgets
					wds[i].y = 723 - widgetsMarginV - (16.0+wSpace)*(numWidgets - i - 1)
					wds[i].x = widgetsMarginH
					wds[i].alpha=size
					i+=1
				endWhile
			endIf
		
		elseIf widgetsPositions==3 ; Right ----------------------------------------------------------------------------------
			if widgetsSize==0 ; small
				size = 100.0
			elseIf widgetsSize==1 ; medium
				size = 130.0
			elseIf widgetsSize==2 ; big
				size = 160.0
			endIf
			if widgetsArrangements==0 ; Right Top
				while i<numWidgets
					wds[i].y = 20 + widgetsMarginV + (16.0+wSpace)*i
					wds[i].x = 1298 - widgetsMarginH - size
					wds[i].alpha=size
					i+=1
				endWhile
			elseIf widgetsArrangements==1 ; Right Middle
				while i<numWidgets
					wds[i].y = ((703 - 2*widgetsMarginV) - ((16.0+wSpace)*numWidgets - wSpace))/2.0 + (16.0+wSpace)*i
					wds[i].x = 1298 - widgetsMarginH - size
					wds[i].alpha=size
					i+=1
				endWhile
			elseIf widgetsArrangements==2 ; Right Bottom
				while i<numWidgets
					wds[i].y = 723 - widgetsMarginV - (16.0+wSpace)*(numWidgets - i - 1)
					wds[i].x = 1298 - widgetsMarginH - size
					wds[i].alpha=size
					i+=1
				endWhile
			endIf	
		endIf	
	endIf
	
	int i = mndWidgets.length
	while i
		i-=1
		mndWidgets[i].Width = size
	endWhile
	
	; Min Y = 20
	; Min X = -15
	; Max X = 1793 (size = 100)
	; Max Y = 723
	; Min acceptable size is 100
	; Max width 1298
	; 120.5 is max width for 13 widgets
	
	
	; Calculation of opacity
	; 0=Always visible, 1=Barely visible, 2=Progressive (linear), 3=Progressive (late), 4=Progressive (soon)
	float percent = 0.0
	if widgetsOpacities==0 ; Always
		i = numWidgets
		while i
			i-=1
			wds[i].alpha=100.0
		endWhile

	elseIf widgetsOpacities==1 ; Barely
		i = numWidgets
		while i
			i-=1
			wds[i].alpha=20.0
		endWhile

	elseIf widgetsOpacities==2 ; Linear
		percent = 24.0*(now - lastTimeEat)/timeEat
		if percent> 1.0
			percent = 1.0
		endIf
		mndWidgets[0].Alpha = 100.0 * percent
		percent = 24.0*(now - lastTimeDrink)/timeDrink
		if percent> 1.0
			percent = 1.0
		endIf
		mndWidgets[1].Alpha = 100.0 * percent
		percent = 24.0*(now - lastTimeSleep)/timeSleep
		if percent> 1.0
			percent = 1.0
		endIf
		mndWidgets[2].Alpha = 100.0 * percent
		percent = 24.0*(now - lastTimeTalk)/timeTalk
		if percent> 1.0
			percent = 1.0
		endIf
		mndWidgets[3].Alpha = 100.0 * percent
		percent = 24.0*(now - lastTimeBath)/timeBath
		if percent> 1.0
			percent = 1.0
		endIf
		mndWidgets[4].Alpha = 100.0 * percent
		percent = 24.0*(now - lastTimePray)/timePray
		if percent> 1.0
			percent = 1.0
		endIf
		mndWidgets[5].Alpha = 100.0 * percent
		percent = 24.0*(now - lastTimePiss)/timePiss
		if percent> 1.0
			percent = 1.0
		endIf
		mndWidgets[6].Alpha = 100.0 * percent
		percent = 24.0*(now - lastTimePoop)/timePoop
		if percent> 1.0
			percent = 1.0
		endIf
		mndWidgets[7].Alpha = 100.0 * percent
		percent = 24.0*(now - lastTimeSex)/timeSex
		if percent> 1.0
			percent = 1.0
		endIf
		mndWidgets[8].Alpha = 100.0 * percent
		percent = (timeDrunk/24.0 - now + lastTimeDrunk)/(timeDrunk/24.0)
		if percent> 1.0
			percent = 1.0
		endIf
		mndWidgets[12].Alpha = 100.0 * percent
		percent = 24.0*(now - lastTimeSkooma)/timeSkooma
		if percent> 1.0
			percent = 1.0
		endIf
		mndWidgets[9].Alpha = 100.0 * percent
		percent = 24.0*(now - lastTimeAlcohol)/timeAlcohol
		if percent> 1.0
			percent = 1.0
		endIf
		mndWidgets[10].Alpha = 100.0 * percent
		percent = 24.0*(now - lastTimeWeed)/timeWeed
		if percent> 1.0
			percent = 1.0
		endIf
		mndWidgets[11].Alpha = 100.0 * percent
		
	elseIf widgetsOpacities==3 ; Begin
		percent = 24.0*(now - lastTimeEat)/timeEat
		if percent> 1.0
			percent = 1.0
		endIf
		if percent < 0.5
			mndWidgets[0].Alpha = 100.0 * percent * percent
		else
			mndWidgets[0].Alpha = 100.0 * Math.sqrt(percent)
		endIf
		percent = 24.0*(now - lastTimeDrink)/timeDrink
		if percent> 1.0
			percent = 1.0
		endIf
		mndWidgets[1].Alpha = percent
		percent = 24.0*(now - lastTimeSleep)/timeSleep
		if percent> 1.0
			percent = 1.0
		endIf
		if percent < 0.5
			mndWidgets[2].Alpha = 100.0 * percent * percent
		else
			mndWidgets[2].Alpha = 100.0 * Math.sqrt(percent)
		endIf
		percent = 24.0*(now - lastTimeTalk)/timeTalk
		if percent> 1.0
			percent = 1.0
		endIf
		if percent < 0.5
			mndWidgets[3].Alpha = 100.0 * percent * percent
		else
			mndWidgets[3].Alpha = 100.0 * Math.sqrt(percent)
		endIf
		percent = 24.0*(now - lastTimeBath)/timeBath
		if percent> 1.0
			percent = 1.0
		endIf
		if percent < 0.5
			mndWidgets[4].Alpha = 100.0 * percent * percent
		else
			mndWidgets[4].Alpha = 100.0 * Math.sqrt(percent)
		endIf
		percent = 24.0*(now - lastTimePray)/timePray
		if percent> 1.0
			percent = 1.0
		endIf
		if percent < 0.5
			mndWidgets[5].Alpha = 100.0 * percent * percent
		else
			mndWidgets[5].Alpha = 100.0 * Math.sqrt(percent)
		endIf
		percent = 24.0*(now - lastTimePiss)/timePiss
		if percent> 1.0
			percent = 1.0
		endIf
		if percent < 0.5
			mndWidgets[6].Alpha = 100.0 * percent * percent
		else
			mndWidgets[6].Alpha = 100.0 * Math.sqrt(percent)
		endIf
		percent = 24.0*(now - lastTimePoop)/timePoop
		if percent> 1.0
			percent = 1.0
		endIf
		if percent < 0.5
			mndWidgets[7].Alpha = 100.0 * percent * percent
		else
			mndWidgets[7].Alpha = 100.0 * Math.sqrt(percent)
		endIf
		percent = 24.0*(now - lastTimeSex)/timeSex
		if percent> 1.0
			percent = 1.0
		endIf
		if percent < 0.5
			mndWidgets[8].Alpha = 100.0 * percent * percent
		else
			mndWidgets[8].Alpha = 100.0 * Math.sqrt(percent)
		endIf
		percent = (timeDrunk/24.0 - now + lastTimeDrunk)/(timeDrunk/24.0)
		if percent> 1.0
			percent = 1.0
		endIf
		if percent < 0.5
			mndWidgets[12].Alpha = 100.0 * percent * percent
		else
			mndWidgets[12].Alpha = 100.0 * Math.sqrt(percent)
		endIf
		percent = 24.0*(now - lastTimeSkooma)/timeSkooma
		if percent> 1.0
			percent = 1.0
		endIf
		if percent < 0.5
			mndWidgets[9].Alpha = 100.0 * percent * percent
		else
			mndWidgets[9].Alpha = 100.0 * Math.sqrt(percent)
		endIf
		percent = 24.0*(now - lastTimeAlcohol)/timeAlcohol
		if percent> 1.0
			percent = 1.0
		endIf
		if percent < 0.5
			mndWidgets[10].Alpha = 100.0 * percent * percent
		else
			mndWidgets[10].Alpha = 100.0 * Math.sqrt(percent)
		endIf
		percent = 24.0*(now - lastTimeWeed)/timeWeed
		if percent> 1.0
			percent = 1.0
		endIf
		if percent < 0.5
			mndWidgets[11].Alpha = 100.0 * percent * percent
		else
			mndWidgets[11].Alpha = 100.0 * Math.sqrt(percent)
		endIf
	elseIf widgetsOpacities==4 ; end
		percent = 24.0*(now - lastTimeEat)/timeEat
		if percent> 1.0
			percent = 1.0
		endIf
		if percent < 0.5
			mndWidgets[0].Alpha = 100.0 * Math.sqrt(percent)
		else
			mndWidgets[0].Alpha = 100.0 * percent * percent
		endIf
		percent = 24.0*(now - lastTimeDrink)/timeDrink
		if percent> 1.0
			percent = 1.0
		endIf
		if percent < 0.5
			mndWidgets[1].Alpha = 100.0 * Math.sqrt(percent)
		else
			mndWidgets[1].Alpha = 100.0 * percent * percent
		endIf
		percent = 24.0*(now - lastTimeSleep)/timeSleep
		if percent> 1.0
			percent = 1.0
		endIf
		if percent < 0.5
			mndWidgets[2].Alpha = 100.0 * Math.sqrt(percent)
		else
			mndWidgets[2].Alpha = 100.0 * percent * percent
		endIf
		percent = 24.0*(now - lastTimeTalk)/timeTalk
		if percent> 1.0
			percent = 1.0
		endIf
		if percent < 0.5
			mndWidgets[3].Alpha = 100.0 * Math.sqrt(percent)
		else
			mndWidgets[3].Alpha = 100.0 * percent * percent
		endIf
		percent = 24.0*(now - lastTimeBath)/timeBath
		if percent> 1.0
			percent = 1.0
		endIf
		if percent < 0.5
			mndWidgets[4].Alpha = 100.0 * Math.sqrt(percent)
		else
			mndWidgets[4].Alpha = 100.0 * percent * percent
		endIf
		percent = 24.0*(now - lastTimePray)/timePray
		if percent> 1.0
			percent = 1.0
		endIf
		if percent < 0.5
			mndWidgets[5].Alpha = 100.0 * Math.sqrt(percent)
		else
			mndWidgets[5].Alpha = 100.0 * percent * percent
		endIf
		percent = 24.0*(now - lastTimePiss)/timePiss
		if percent> 1.0
			percent = 1.0
		endIf
		if percent < 0.5
			mndWidgets[6].Alpha = 100.0 * Math.sqrt(percent)
		else
			mndWidgets[6].Alpha = 100.0 * percent * percent
		endIf
		percent = 24.0*(now - lastTimePoop)/timePoop
		if percent> 1.0
			percent = 1.0
		endIf
		if percent < 0.5
			mndWidgets[7].Alpha = 100.0 * Math.sqrt(percent)
		else
			mndWidgets[7].Alpha = 100.0 * percent * percent
		endIf
		percent = 24.0*(now - lastTimeSex)/timeSex
		if percent> 1.0
			percent = 1.0
		endIf
		if percent < 0.5
			mndWidgets[8].Alpha = 100.0 * Math.sqrt(percent)
		else
			mndWidgets[8].Alpha = 100.0 * percent * percent
		endIf
		percent = (timeDrunk/24.0 - now + lastTimeDrunk)/(timeDrunk/24.0)
		if percent> 1.0
			percent = 1.0
		endIf
		if percent < 0.5
			mndWidgets[12].Alpha = 100.0 * Math.sqrt(percent)
		else
			mndWidgets[12].Alpha = 100.0 * percent * percent
		endIf
		percent = 24.0*(now - lastTimeSkooma)/timeSkooma
		if percent> 1.0
			percent = 1.0
		endIf
		if percent < 0.5
			mndWidgets[9].Alpha = 100.0 * Math.sqrt(percent)
		else
			mndWidgets[9].Alpha = 100.0 * percent * percent
		endIf
		percent = 24.0*(now - lastTimeAlcohol)/timeAlcohol
		if percent> 1.0
			percent = 1.0
		endIf
		if percent < 0.5
			mndWidgets[10].Alpha = 100.0 * Math.sqrt(percent)
		else
			mndWidgets[10].Alpha = 100.0 * percent * percent
		endIf
		percent = 24.0*(now - lastTimeWeed)/timeWeed
		if percent> 1.0
			percent = 1.0
		endIf
		if percent < 0.5
			mndWidgets[11].Alpha = 100.0 * Math.sqrt(percent)
		else
			mndWidgets[11].Alpha = 100.0 * percent * percent
		endIf
	endIf
endFunction

; -))

; ((- Special effects

int dsound
bool diarrheaAdded
Armor Property mndDiarrhea Auto

function applyDiarrhea()
	float oldMovementNoiseMult = PlayerRef.getActorValue("MovementNoiseMult")
	PlayerRef.setActorValue("MovementNoiseMult", 2.0)
	int diarrSound = mndDiarrheaSound.play(PlayerRef)
	PlayerRef.SheatheWeapon()
	int oldCameraState = Game.getCameraState()
	if oldCameraState==0
		Game.forceThirdPerson()
	endIf
	Debug.sendAnimationEvent(PlayerRef, "IdleForceDefaultState")
	Form prev61Item = PlayerRef.GetWornForm(Armor.GetMaskForSlot(61))
	if prev61Item
		PlayerRef.unEquipItem(prev61Item, false, true)
	endIf
	PlayerRef.EquipItem(mndDiarrhea, false, true)
	Utility.wait(Utility.randomFloat(1.0, 5.0))
	Sound.StopInstance(diarrSound)
	PlayerRef.unEquipItem(mndDiarrhea, false, true)
	if prev61Item
		PlayerRef.EquipItem(prev61Item, false, true)
	endIf
	if oldCameraState==0
		Game.forceFirstPerson()
	endIf
	PlayerRef.setActorValue("MovementNoiseMult", oldMovementNoiseMult)
endFunction

function collapse()
	int oldCameraState = Game.getCameraState()
	if oldCameraState==0
		Game.forceThirdPerson()
	endIf
	Game.SetPlayerAIDriven(true)
	Debug.sendAnimationEvent(PlayerRef, "BleedOutStart")
	Utility.wait(Utility.randomFloat(2.0, 3.0))
	Debug.sendAnimationEvent(PlayerRef, "BleedOutStop")
	Game.SetPlayerAIDriven(false)
	Utility.wait(1.5)
	if oldCameraState==0
		Game.forceFirstPerson()
	endIf
endFunction

Event hookSexLabAnim(int tid, bool hasPlayer)
	if hasPlayer
		mndSLDelegate.hookSexLabAnim(tid)
	endIf
endEvent

function doMasturbation()
	if !weHaveSexLab
		return
	endIf
	mndSLDelegate.doMasturbation()
	lastTimeSex = Utility.GetCurrentGameTime()	
endFunction

function removeCum()
	if !weHaveSexLab
		return
	endIf
	mndSLDelegate.removeCum()
endFunction

ObjectReference function addPiss(int pissNum)
	int pos = -1
	float oldest = Utility.GetCurrentGameTime()
	int i = pisses.length
	while i
		i-=1
		if oldest >= pissesTimes[i]
			pos = i
			oldest = pissesTimes[i]
		endIf
	endWhile
	if pisses[pos]
		pisses[pos].delete()
	endIf
	pisses[pos] = PlayerRef.placeAtMe(mndPissPuddle, 1)
	float az = PlayerRef.getAngleZ()
	float dist = 0.0
	if PlayerRef.getLeveledActorbase().getSex()==0
		if pissNum==0 ; Normal piss with piss 0
			dist = 104.0
		elseIf pissNum==1 ; Normal piss with piss 1
			dist = 160.0
		elseIf pissNum==2 ; Defecation piss with piss 0
			dist = 84.0
		elseIf pissNum==3 ; Defecation piss with piss 1
			dist = 106.0
		else
			dist = 100.0
		endIf
	else
		if pissNum==0
			dist = -15.0
		elseIf pissNum==1
			dist = 27.0
		elseIf pissNum==2 ; Defecation piss with piss 0
			dist = -32.0
		elseIf pissNum==3 ; Defecation piss with piss 1
			dist = -15.0
		else
			dist = 10.0
		endIf
	endIf
	pisses[pos].setPosition(PlayerRef.X + math.sin(az - 2.0)*dist, PlayerRef.Y + math.cos(az - 2.0)*dist, PlayerRef.Z+0.25)
	pisses[pos].setAngle(0.0, 0.0, az)
	pissesTimes[pos] = Utility.GetCurrentGameTime()
	return pisses[pos]
endFunction

ObjectReference function addPoop()
	int pos = -1
	float oldest = Utility.GetCurrentGameTime()
	int i = poops.length
	while i
		i-=1
		if oldest >= poopsTimes[i]
			pos = i
			oldest = poopsTimes[i]
		endIf
	endWhile
	if poops[pos]
		poops[pos].delete()
	endIf
	poops[pos] = PlayerRef.placeAtMe(mndPoopPuddle, 1)
	float az = PlayerRef.getAngleZ()
	float dist = 0.0
	poops[pos].setPosition(PlayerRef.X + math.sin(az+0.0)*dist, PlayerRef.Y + math.cos(az+0.0)*dist, PlayerRef.Z+0.15)
	poops[pos].setAngle(0.0, 0.0, az)
	poopsTimes[pos] = Utility.GetCurrentGameTime()
	return poops[pos]
endFunction

event removePissPoop(Form refFromEvent)
	ObjectReference ref = refFromEvent as ObjectReference
	PlayerRef.evaluatePackage()
	PlayerRef.stopCombat()
	PlayerRef.SheatheWeapon()
	Game.setPlayerAIDriven(true)
	int oldCameraState = Game.getCameraState()
	; 3D camera if player
	if oldCameraState==0
		Game.forceThirdPerson()
	endIf
	PlayerRef.evaluatePackage()
	Utility.wait(0.1)
	Game.DisablePlayerControls(true, true, false, false, false, false, false, false, 0)
	PlayerRef.TranslateTo(PlayerRef.X, PlayerRef.Y, PlayerRef.Z, PlayerRef.getAngleX(), PlayerRef.getAngleY(), PlayerRef.getAngleZ()+45.0, 50.0, 55.0)

	Debug.SendAnimationEvent(PlayerRef, "IdleLooseSweepingStart")
	
	Utility.wait(Utility.RandomFloat(7.0, 10.0))
	; Delete the actual object
	int i = pisses.length
	while i
		i-=1
		if pisses[i]==ref
			pissesTimes[i] = Utility.GetCurrentGameTime()
			pisses[i].delete()
			pisses[i] = none
		endIf
	endWhile
	i = poops.length
	while i
		i-=1
		if poops[i]==ref
			poopsTimes[i] = Utility.GetCurrentGameTime()
			poops[i].delete()
			poops[i] = none
		endIf
	endWhile
	PlayerRef.StopTranslation()
	Utility.wait(Utility.RandomFloat(1.0, 2.0))
	Debug.SendAnimationEvent(PlayerRef, "IdleLooseSweepingEnd")
	Utility.wait(Utility.RandomFloat(2.0, 3.0))
	
	; Regain controls
	PlayerRef.evaluatePackage()
	PlayerRef.SheatheWeapon()
	Utility.wait(0.1)
	Game.EnablePlayerControls(true, true, false, false, false, false, false, false, 0)
	Game.setPlayerAIDriven(false)
	Debug.SendAnimationEvent(PlayerRef, "IdleForceDefaultState")
	if oldCameraState==0
		Game.forceFirstPerson()
	endIf
endEvent

function bathInRivers()
	; If we not are in a river, or the water is too deep, or we are swimming, then just show a message
	Cell c = PlayerRef.getParentCell()
	float waterLevel = c.GetWaterLevel() - PlayerRef.Z
	if waterLevel < 2.0
		showTranslatedString("YouAreNotInWaterToBath")
		return
	elseIf waterLevel > 45.0 || PlayerRef.isSwimming()
		showTranslatedString("TooDeepWaterToBath")
		return	
	endIf
	; If we are already animating do nothing
	if PlayerIsAnimating()
		return
	endIf
	
	; Play a bath animation (that should be created)
	alreadyPlayingAnim = true
	int oldCameraState = 0
	; Stop the actor (lock AI if player)
	PlayerRef.evaluatePackage()
	PlayerRef.stopCombat()
	PlayerRef.SheatheWeapon()
	Form leftHand = PlayerRef.GetEquippedObject(0)
	if leftHand
		PlayerRef.UnequipItemEX(leftHand, 2, false)
	endIf
	Form rightHand = PlayerRef.GetEquippedObject(1)
	if rightHand
		PlayerRef.UnequipItemEX(rightHand, 1, false)
	endIf
	Utility.wait(0.1)
	Game.setPlayerAIDriven(true)
	oldCameraState = Game.getCameraState()
	; 3D camera if player
	if oldCameraState==0
		Game.forceThirdPerson()
	endIf
	PlayerRef.evaluatePackage()
	Utility.wait(0.1)
	Game.DisablePlayerControls(true, true, false, false, false, false, false, false, 0)

	; ((- Stripping
	clothes[2] = PlayerRef.GetWornForm(Armor.GetMaskForSlot(32))
	Form[] items
	
	if clothes[2] && (stripMode==0 || stripMode==1) ; Not animated
		int i = 44
		while i>30
			i-=1
			clothes[i - 30] = PlayerRef.GetWornForm(Armor.GetMaskForSlot(i))
			if clothes[i - 30]
				PlayerRef.UnequipItem(clothes[i - 30], false, true)
			endIf
		endWhile
	elseIf clothes[2] && (stripMode==2 || stripMode==3) ; Animated
		Debug.SendAnimationEvent(PlayerRef, "mndUndress")
		Utility.wait(2.5)
		int i = 44
		while i>30
			i-=1
			clothes[i - 30] = PlayerRef.GetWornForm(Armor.GetMaskForSlot(i))
			if clothes[i - 30]
				PlayerRef.UnequipItem(clothes[i - 30], false, true)
			endIf
		endWhile
	elseIf stripMode==4 || stripMode==5 ; SexLab not animated
		items = mndSLDelegate.StripActor(false, true)
	elseIf stripMode==6 || stripMode==7 ; SexLab animated
		items = mndSLDelegate.StripActor(true, true)
	endIf
	; -))
	
	lastTimeBath = Utility.getCurrentGameTime()

	; Play bath in river anims
	Utility.wait(0.3)
	PlayerRef.stopTranslation()
	Debug.SendAnimationEvent(PlayerRef, "mndShowerLegs")
	float elapsed = Utility.randomFloat(5.0, 7.5)
	if bathDuration<10.0
		elapsed=1.0
	endIf
	Utility.wait(elapsed)
	Debug.SendAnimationEvent(PlayerRef, "mndBathInRiverEnter")
	Utility.wait(6.0)
	elapsed+=6.0
	int anims = 4
	int anim = Utility.randomInt(0, 2)
	mndDirtShader4.Stop(PlayerRef)
	while elapsed<bathDuration
		if anim==0
			Debug.SendAnimationEvent(PlayerRef, "mndBathInRiverFace")
			elapsed += 8.0
			Utility.wait(8.0)
			anim=Utility.randomInt(0, 1)+1
		elseIf anim==1
			Debug.SendAnimationEvent(PlayerRef, "mndBathInRiverArms")
			elapsed += 6.0
			Utility.wait(6.0)
			anim=Utility.randomInt(0, 1)*2
		else
			Debug.SendAnimationEvent(PlayerRef, "mndBathInRiverLegs")
			elapsed += 8.0
			Utility.wait(8.0)
			anim=Utility.randomInt(0, 1)
		endIf
		Utility.wait(0.5)
		mndWetShader.Play(PlayerRef)
		removeCum()
		mndDirtShader3.Stop(PlayerRef)
		mndDirtShader2.Stop(PlayerRef)
		mndDirtShader1.Stop(PlayerRef)
	endWhile
	Utility.wait(1.0)
	Debug.SendAnimationEvent(PlayerRef, "mndBathInRiverExit")
	Utility.wait(4.0)
	mndWetShader.Stop(PlayerRef)
	Utility.wait(1.0)
	
	PlayerRef.stopTranslation()
	Debug.SendAnimationEvent(PlayerRef, "IdleForceDefaultState")
	Utility.wait(0.1)
	
	; ((- Redressing
	if clothes[2] && (stripMode==0 || stripMode==1) ; No anim
		int i = 44
		while i>30
			i-=1
			if clothes[i - 30]
				PlayerRef.equipItem(clothes[i - 30], false, true)
			endIf
		endWhile
	elseIf clothes[2] && (stripMode==2 || stripMode==3) ; Animated
		Debug.SendAnimationEvent(PlayerRef, "mndUndress")
		Utility.wait(2.5)
		int i = 44
		while i>30
			i-=1
			if clothes[i - 30]
				PlayerRef.equipItem(clothes[i - 30], false, true)
			endIf
		endWhile
	elseIf stripMode==4 || stripMode==5 ; SexLab no anim
		mndSLDelegate.UnStripActor(items)
	elseIf stripMode==6 || stripMode==7 ; SexLab animated
		Debug.SendAnimationEvent(PlayerRef, "mndUndress")
		Utility.wait(2.5)
		mndSLDelegate.UnStripActor(items)
	endIf
	; -))
	
	mndWetShader.Stop(PlayerRef)
	
	; Regain controls
	Utility.wait(0.5)
	if leftHand
		PlayerRef.EquipItemEX(leftHand, 2, false)
	endIf
	if rightHand
		PlayerRef.EquipItemEX(rightHand, 1, false)
	endIf
	PlayerRef.evaluatePackage()
	PlayerRef.SheatheWeapon()
	Utility.wait(0.1)
	Game.EnablePlayerControls(true, true, false, false, false, false, false, false, 0)
	Game.setPlayerAIDriven(false)
	Debug.SendAnimationEvent(PlayerRef, "IdleForceDefaultState")
	if oldCameraState==0
		Game.forceFirstPerson()
	endIf
	alreadyPlayingAnim = false
endFunction

float lastPlayedAnim
bool alreadyPlayingAnim

Function playingAnim(bool playing)
	alreadyPlayingAnim = playing
endFunction

bool function PlayerIsAnimating()
	if !weHaveSexLab
		return alreadyPlayingAnim
	endIf
	return PlayerRef.isInFaction(SexLabAnimatingFaction) || alreadyPlayingAnim
endFunction

Event mndPlayAnim(string anim, int openMouth)
	if PlayerRef.getSitState()!=0 || alreadyPlayingAnim
		return
	endIf
	alreadyPlayingAnim=true
	while UI.IsMenuOpen("InventoryMenu")
		Utility.wait(0.5)
	endWhile
	if Utility.GetCurrentGameTime() - lastPlayedAnim < 0.0000405
		alreadyPlayingAnim = false
		return
	endIf
	lastPlayedAnim = Utility.GetCurrentGameTime()
	Utility.wait(0.1)
	PlayerRef.SheatheWeapon()
	Form leftHandI = PlayerRef.GetEquippedObject(0)
	if leftHandI
		PlayerRef.UnequipItemEX(leftHandI, 2, false)
	endIf
	Form rightHandI = PlayerRef.GetEquippedObject(1)
	if rightHandI
		PlayerRef.UnequipItemEX(rightHandI, 1, false)
	endIf
	int oldCameraState = Game.getCameraState()
	if oldCameraState==0
		Game.forceThirdPerson()
	endIf
	Debug.SendAnimationEvent(PlayerRef, anim)
	
	if openMouth ; For eating
		; 1 close
		Utility.wait(1.00)
		; 1 small open
		PlayerRef.SetExpressionPhoneme(1, 0.35)
		PlayerRef.SetExpressionPhoneme(11, 0.10)
		Utility.wait(0.75)
		; 0.5 open
		PlayerRef.SetExpressionPhoneme(1, 0.55)
		PlayerRef.SetExpressionPhoneme(11, 0.50)
		int esound1 = mndEatSound.play(PlayerRef)
		Utility.wait(0.50)
		; 0.5 small open
		PlayerRef.SetExpressionPhoneme(1, 0.25)
		PlayerRef.SetExpressionPhoneme(11, 0.20)
		int esound2 = mndEatSound.play(PlayerRef)
		Utility.wait(0.50)
		; 0.25 open
		PlayerRef.SetExpressionPhoneme(1, 0.65)
		PlayerRef.SetExpressionPhoneme(11, 0.35)
		int esound3 = mndEatSound.play(PlayerRef)
		Utility.wait(0.50)
		; 0.25 small open
		PlayerRef.SetExpressionPhoneme(1, 0.25)
		PlayerRef.SetExpressionPhoneme(11, 0.10)
		Utility.wait(0.25)
		; 0.15 open
		PlayerRef.SetExpressionPhoneme(1, 0.50)
		PlayerRef.SetExpressionPhoneme(11, 0.27)
		int esound4 = mndEatSound.play(PlayerRef)
		Utility.wait(0.15)
		; 0.10 semi-open
		PlayerRef.SetExpressionPhoneme(1, 0.30)
		PlayerRef.SetExpressionPhoneme(11, 0.20)
		Utility.wait(0.10)
		Sound.StopInstance(esound1)
		Sound.StopInstance(esound2)
		Sound.StopInstance(esound3)
		Sound.StopInstance(esound4)
		; 0.25 small open
		PlayerRef.SetExpressionPhoneme(1, 0.15)
		PlayerRef.SetExpressionPhoneme(11, 0.30)
		Utility.wait(0.25)
		; 1.25 close
		PlayerRef.ResetExpressionOverrides()
		PlayerRef.SetExpressionPhoneme(1, 0.01)
		PlayerRef.SetExpressionPhoneme(11, 0.01)
		PlayerRef.ResetExpressionOverrides()
		Utility.wait(1.25)
	else ; For drinking
		Utility.wait(1.30)
		PlayerRef.SetExpressionPhoneme(1, 0.35)
		PlayerRef.SetExpressionPhoneme(11, 0.10)
		int dsound1 = mndDrinkSound.play(PlayerRef)
		Utility.wait(0.25)
		PlayerRef.SetExpressionPhoneme(11, 0.20)
		Utility.wait(0.25)
		PlayerRef.SetExpressionPhoneme(11, 0.30)
		int dsound2 = mndDrinkSound.play(PlayerRef)
		Utility.wait(0.25)
		PlayerRef.SetExpressionPhoneme(11, 0.40)
		Utility.wait(0.25)
		PlayerRef.SetExpressionPhoneme(11, 0.30)
		int dsound3 = mndDrinkSound.play(PlayerRef)
		Utility.wait(0.15)
		PlayerRef.SetExpressionPhoneme(11, 0.20)
		Utility.wait(0.15)
		PlayerRef.SetExpressionPhoneme(1, 0.25)
		PlayerRef.SetExpressionPhoneme(11, 0.10)
		Sound.StopInstance(dsound1)
		Sound.StopInstance(dsound2)
		Sound.StopInstance(dsound3)
		Utility.wait(0.15)
		PlayerRef.SetExpressionPhoneme(1, 0.10)
		PlayerRef.SetExpressionPhoneme(11, 0.10)
		Utility.wait(0.15)
		PlayerRef.ResetExpressionOverrides()
		PlayerRef.SetExpressionPhoneme(1, 0.01)
		PlayerRef.SetExpressionPhoneme(11, 0.01)
		PlayerRef.ResetExpressionOverrides()
		Utility.wait(0.95)
	endIf
	if leftHandI
		PlayerRef.EquipItemEX(leftHandI, 2, false)
	endIf
	if rightHandI
		PlayerRef.EquipItemEX(rightHandI, 1, false)
	endIf
	PlayerRef.ResetExpressionOverrides()
	Debug.SendAnimationEvent(PlayerRef, "IdleForceDefaultState")
	if oldCameraState==0
		Game.forceFirstPerson()
	endIf
	
	alreadyPlayingAnim=false
endEvent

Form[] Function StripActor(bool animated, bool full)
	return mndSLDelegate.StripActor(animated, full)
endFunction

Function UnStripActor(form[] items)
	mndSLDelegate.UnStripActor(items)
endFunction

; -))

;((- Piss and Poop


event DoPissAndPoop(int mode)
	if PlayerIsAnimating()
		return
	endIf
	if mode==0
		piss()
	elseIf mode==1
		poop()
	elseIf mode==2
		pissAndPoop()
	endIf
endEvent

Form[] Property clothes Auto ; 0-13
Armor[] Property pees Auto

function piss()
	if noPissInPublic
		Actor looking = None
		if weHavePapyrusUtils
			Actor[] around = MiscUtil.ScanCellNPCs(PlayerRef)
			int num=around.length
			while num
				num-=1
				Actor a=around[num]
				if a && a!=PlayerRef && !a.isDisabled() && !a.isDead() && a.HasLOS(PlayerRef)
					looking = a
					num=0
				endIf
			endWhile

		else
			Cell c = PlayerRef.getParentCell()
			int num=c.GetNumRefs(43)
			while num
				num-=1
				Actor a=c.getNthRef(num, 43) as Actor
				if a && a!=PlayerRef && !a.isDisabled() && !a.isDead() && a.HasLOS(PlayerRef)
					looking = a
					num=0
				endIf
			endWhile
		endIf
		
		if looking
			showTranslatedString("CantUrinate")
			return
		endIf
	endIf
	
	alreadyPlayingAnim = 1
	mndSetDoNothing = 1
	PlayerRef.evaluatePackage()
	PlayerRef.stopCombat()
	PlayerRef.SheatheWeapon()
	Form leftHand = PlayerRef.GetEquippedObject(0)
	if leftHand
		PlayerRef.UnequipItemEX(leftHand, 2, false)
	endIf
	Form rightHand = PlayerRef.GetEquippedObject(1)
	if rightHand
		PlayerRef.UnequipItemEX(rightHand, 1, false)
	endIf
	Utility.wait(0.3)
	Game.setPlayerAIDriven(true)
	int oldCameraState = Game.getCameraState()
	if oldCameraState==0
		Game.forceThirdPerson()
	endIf
	PlayerRef.evaluatePackage()
	Utility.wait(0.3)
	Game.DisablePlayerControls(true, true, false, false, false, false, false, false, 0)
	Game.SetPlayerAIDriven()
	Debug.SendAnimationEvent(PlayerRef, "SOSBend5")
	
	; ((- Stripping
	clothes[2] = PlayerRef.GetWornForm(Armor.GetMaskForSlot(32))
	Form[] items
	
	if clothes[2] && stripMode==0 ; Partial not animated
		PlayerRef.UnequipItem(clothes[2], false, true)
	elseIf stripMode==1 ; Full not animated
		int i = 44
		while i>30
			i-=1
			clothes[i - 30] = PlayerRef.GetWornForm(Armor.GetMaskForSlot(i))
			if clothes[i - 30]
				PlayerRef.UnequipItem(clothes[i - 30], false, true)
			endIf
		endWhile
	elseIf clothes[2] && stripMode==2 ; Partial animated
		Debug.SendAnimationEvent(PlayerRef, "mndUndress")
		Utility.wait(2.5)
		PlayerRef.UnequipItem(clothes[2], false, true)
	elseIf stripMode==3 ; Full animated
		Debug.SendAnimationEvent(PlayerRef, "mndUndress")
		Utility.wait(2.5)
		int i = 44
		while i>30
			i-=1
			clothes[i - 30] = PlayerRef.GetWornForm(Armor.GetMaskForSlot(i))
			if clothes[i - 30]
				PlayerRef.UnequipItem(clothes[i - 30], false, true)
			endIf
		endWhile
	elseIf stripMode==4 ; SexLab partial not animated
		items = StripActor(false, false)
	elseIf stripMode==5 ; SexLab full not animated
		items = StripActor(false, true)
	elseIf stripMode==6 ; SexLab partial animated
		items = StripActor(true, false)
	elseIf stripMode==7 ; SexLab full animated
		items = StripActor(true, true)
	endIf
	; -))
	
	Debug.SendAnimationEvent(PlayerRef, "SOSBend5")
	Form previous = PlayerRef.GetWornForm(Armor.GetMaskForSlot(61))
	int peeNum = Utility.randomInt(0, 1)
	Form pee = pees[peeNum]
	PlayerRef.equipItem(pee, false, true)
	int psound = mndPissingSound.play(PlayerRef)
	
	float pissTime = 24.0*(Utility.getCurrentGameTime() - lastTimePiss)/timePiss
	if pissTime<0.05
		pissTime = 0.05
	elseIf pissTime>2.0
		pissTime = 2.0
	endIf
	Utility.wait(0.5)
	Debug.SendAnimationEvent(PlayerRef, "SOSBend5")
	
	if useAnimForPissing
		if PlayerRef.getLeveledActorBase().getSex()==0
			Debug.SendAnimationEvent(PlayerRef, "mndPissM" + Utility.randomInt(0, 1))
		else
			Debug.SendAnimationEvent(PlayerRef, "mndPissF" + Utility.randomInt(0, 1))
		endIf
	endIf

	Utility.wait(pissTime * 2.5)
	if addPissPuddle
		pissPuddle = addPiss(peeNum)
		pissPuddle.setScale(0.95)
	endIf
	Utility.wait(pissTime * 2.0)
	if addPissPuddle
		pissPuddle.setScale(1.0)
	endIf
	Utility.wait(pissTime * 0.5)
	if pissPuddle && pissTime>0.3
		pissPuddle.setScale(1.05)
	endIf
	ObjectReference pissPuddle = none
	Utility.wait(pissTime * 2.5)
	if pissPuddle && pissTime>0.3
		pissPuddle.setScale(1.1)
	endIf
	Utility.wait(pissTime * 2.5)
	if pissPuddle && pissTime>0.4
		pissPuddle.setScale(1.15)
	endIf
	Utility.wait(pissTime * 2.5)
	if pissPuddle && pissTime>0.5
		pissPuddle.setScale(1.2)
	endIf
	Utility.wait(pissTime * 2.5)
	if pissPuddle && pissTime>0.5
		pissPuddle.setScale(1.25)
	endIf
	PlayerRef.unEquipItem(pee, false, true)
	Sound.StopInstance(psound)
	Utility.wait(0.5)
	
	; ((- Redressing 
	if clothes[2] && stripMode==0 ; Partial no anim
		PlayerRef.equipItem(clothes[2], false, true)
	elseIf stripMode==1 ; Full no anim
		int i = 44
		while i>30
			i-=1
			if clothes[i - 30]
				PlayerRef.equipItem(clothes[i - 30], false, true)
			endIf
		endWhile
	elseIf clothes[2] && stripMode==2 ; Partial animated
		Debug.SendAnimationEvent(PlayerRef, "mndUndress")
		Utility.wait(2.5)
		PlayerRef.equipItem(clothes[2], false, true)
	elseIf stripMode==3 ; Full animated
		Debug.SendAnimationEvent(PlayerRef, "mndUndress")
		Utility.wait(2.5)
		int i = 44
		while i>30
			i-=1
			if clothes[i - 30]
				PlayerRef.equipItem(clothes[i - 30], false, true)
			endIf
		endWhile
	elseIf stripMode==4 ; SexLab partial no anim
		UnStripActor(items)
	elseIf stripMode==5 ; SexLab full no anim
		UnStripActor(items)
	elseIf stripMode==6 ; SexLab partial animated
		Debug.SendAnimationEvent(PlayerRef, "mndUndress")
		Utility.wait(2.5)
		UnStripActor(items)
	elseIf stripMode==7 ; SexLab full animated
		Debug.SendAnimationEvent(PlayerRef, "mndUndress")
		Utility.wait(2.5)
		UnStripActor(items)
	endIf	
	; -))
	
	PlayerRef.unEquipItem(pee, false, true)
	PlayerRef.UnequipItemSlot(61)
	if previous
		PlayerRef.EquipItemEx(previous, 61, false, false)
	else
		PlayerRef.EquipItem(mndPeeNone, false, true)
	endIf
	PlayerRef.unEquipItem(pee, false, true)
	
	Utility.wait(0.5)
	if leftHand
		PlayerRef.EquipItemEX(leftHand, 2, false)
	endIf
	if rightHand
		PlayerRef.EquipItemEX(rightHand, 1, false)
	endIf
	mndSetDoNothing = 0
	PlayerRef.evaluatePackage()
	PlayerRef.SheatheWeapon()
	PlayerRef.unEquipItem(pee, false, true)
	if previous
		PlayerRef.EquipItemEx(previous, 61, false, false)
	else
		PlayerRef.EquipItem(mndPeeNone, false, true)
	endIf
	Utility.wait(0.3)
	Game.EnablePlayerControls(true, true, false, false, false, false, false, false, 0)
	Game.setPlayerAIDriven(false)
	lastTimePiss = Utility.GetCurrentGameTime()
	Debug.SendAnimationEvent(PlayerRef, "IdleForceDefaultState")
	if oldCameraState==0
		Game.forceFirstPerson()
	endIf
	alreadyPlayingAnim = 0
endFunction


function poop()
	if noPoopInPublic
		Actor looking = None
		if weHaveSexLab
			Actor[] around = MiscUtil.ScanCellNPCs(PlayerRef)
			int num=around.length
			while num
				num-=1
				Actor a=around[num]
				if a && a!=PlayerRef && !a.isDisabled() && !a.isDead() && a.HasLOS(PlayerRef)
					looking = a
					num=0
				endIf
			endWhile

		else
			Cell c = PlayerRef.getParentCell()
			int num=c.GetNumRefs(43)
			while num
				num-=1
				Actor a=c.getNthRef(num, 43) as Actor
				if a && a!=PlayerRef && !a.isDisabled() && !a.isDead() && a.HasLOS(PlayerRef)
					looking = a
					num=0
				endIf
			endWhile
		endIf
		
		if looking
			showTranslatedString("CantDefecate")
			return
		endIf
	endIf
	
	alreadyPlayingAnim=1
	mndSetDoNothing = 1
	PlayerRef.evaluatePackage()
	PlayerRef.stopCombat()
	PlayerRef.SheatheWeapon()
	Form leftHand = PlayerRef.GetEquippedObject(0)
	if leftHand
		PlayerRef.UnequipItemEX(leftHand, 2, false)
	endIf
	Form rightHand = PlayerRef.GetEquippedObject(1)
	if rightHand
		PlayerRef.UnequipItemEX(rightHand, 1, false)
	endIf
	Utility.wait(0.3)
	Game.setPlayerAIDriven(true)
	int oldCameraState = Game.getCameraState()
	if oldCameraState==0
		Game.forceThirdPerson()
	endIf
	PlayerRef.evaluatePackage()
	Utility.wait(0.3)
	Game.DisablePlayerControls(true, true, false, false, false, false, false, false, 0)
	Game.SetPlayerAIDriven()

	; ((- Stripping
	clothes[2] = PlayerRef.GetWornForm(Armor.GetMaskForSlot(32))
	Form[] items
	
	if clothes[2] && stripMode==0 ; Partial not animated
		PlayerRef.UnequipItem(clothes[2], false, true)
	elseIf stripMode==1 ; Full not animated
		int i = 44
		while i>30
			i-=1
			clothes[i - 30] = PlayerRef.GetWornForm(Armor.GetMaskForSlot(i))
			if clothes[i - 30]
				PlayerRef.UnequipItem(clothes[i - 30], false, true)
			endIf
		endWhile
	elseIf clothes[2] && stripMode==2 ; Partial animated
		Debug.SendAnimationEvent(PlayerRef, "mndUndress")
		Utility.wait(2.5)
		PlayerRef.UnequipItem(clothes[2], false, true)
	elseIf stripMode==3 ; Full animated
		Debug.SendAnimationEvent(PlayerRef, "mndUndress")
		Utility.wait(2.5)
		int i = 44
		while i>30
			i-=1
			clothes[i - 30] = PlayerRef.GetWornForm(Armor.GetMaskForSlot(i))
			if clothes[i - 30]
				PlayerRef.UnequipItem(clothes[i - 30], false, true)
			endIf
		endWhile
	elseIf stripMode==4 ; SexLab partial not animated
		items = StripActor(false, false)
	elseIf stripMode==5 ; SexLab full not animated
		items = StripActor(false, true)
	elseIf stripMode==6 ; SexLab partial animated
		items = StripActor(true, false)
	elseIf stripMode==7 ; SexLab full animated
		items = StripActor(true, true)
	endIf
	; -))
	
	if useAnimForPooping
		Debug.SendAnimationEvent(PlayerRef, "mndPoop")
	endIf

	int psound = mndPoopingSound.play(PlayerRef)
	Utility.wait(13.0)
	if addVisiblePoop
		addPoop()
	endIf
	Sound.StopInstance(psound)
	Utility.wait(1.5)
	
	; ((- Redressing 
	if clothes[2] && stripMode==0 ; Partial no anim
		PlayerRef.equipItem(clothes[2], false, true)
	elseIf stripMode==1 ; Full no anim
		int i = 44
		while i>30
			i-=1
			if clothes[i - 30]
				PlayerRef.equipItem(clothes[i - 30], false, true)
			endIf
		endWhile
	elseIf clothes[2] && stripMode==2 ; Partial animated
		Debug.SendAnimationEvent(PlayerRef, "mndUndress")
		Utility.wait(2.5)
		PlayerRef.equipItem(clothes[2], false, true)
	elseIf stripMode==3 ; Full animated
		Debug.SendAnimationEvent(PlayerRef, "mndUndress")
		Utility.wait(2.5)
		int i = 44
		while i>30
			i-=1
			if clothes[i - 30]
				PlayerRef.equipItem(clothes[i - 30], false, true)
			endIf
		endWhile
	elseIf stripMode==4 ; SexLab partial no anim
		UnStripActor(items)
	elseIf stripMode==5 ; SexLab full no anim
		UnStripActor(items)
	elseIf stripMode==6 ; SexLab partial animated
		Debug.SendAnimationEvent(PlayerRef, "mndUndress")
		Utility.wait(2.5)
		UnStripActor(items)
	elseIf stripMode==7 ; SexLab full animated
		Debug.SendAnimationEvent(PlayerRef, "mndUndress")
		Utility.wait(2.5)
		UnStripActor(items)
	endIf	
	; -))
	
	Utility.wait(0.5)
	if leftHand
		PlayerRef.EquipItemEX(leftHand, 2, false)
	endIf
	if rightHand
		PlayerRef.EquipItemEX(rightHand, 1, false)
	endIf
	mndSetDoNothing = 0
	PlayerRef.evaluatePackage()
	PlayerRef.SheatheWeapon()
	Utility.wait(0.3)
	Game.EnablePlayerControls(true, true, false, false, false, false, false, false, 0)
	Game.setPlayerAIDriven(false)
	lastTimePoop = Utility.GetCurrentGameTime()
	Debug.SendAnimationEvent(PlayerRef, "IdleForceDefaultState")
	if oldCameraState==0
		Game.forceFirstPerson()
	endIf
	alreadyPlayingAnim=0
endFunction

function pissAndPoop()
	if noPoopInPublic || noPissInPublic
		Actor looking = None
		if weHaveSexLab
			Actor[] around = MiscUtil.ScanCellNPCs(PlayerRef)
			int num=around.length
			while num
				num-=1
				Actor a=around[num]
				if a && a!=PlayerRef && !a.isDisabled() && !a.isDead() && a.HasLOS(PlayerRef)
					looking = a
					num=0
				endIf
			endWhile

		else
			Cell c = PlayerRef.getParentCell()
			int num=c.GetNumRefs(43)
			while num
				num-=1
				Actor a=c.getNthRef(num, 43) as Actor
				if a && a!=PlayerRef && !a.isDisabled() && !a.isDead() && a.HasLOS(PlayerRef)
					looking = a
					num=0
				endIf
			endWhile
		endIf
		
		if looking
			if noPoopInPublic
				showTranslatedString("CantDefecate")
			else
				showTranslatedString("CantUrinate")
			endIf
			return
		endIf
	endIf
	
	mndSetDoNothing = 1
	alreadyPlayingAnim=1
	PlayerRef.evaluatePackage()
	PlayerRef.stopCombat()
	PlayerRef.SheatheWeapon()
	Form leftHand = PlayerRef.GetEquippedObject(0)
	if leftHand
		PlayerRef.UnequipItemEX(leftHand, 2, false)
	endIf
	Form rightHand = PlayerRef.GetEquippedObject(1)
	if rightHand
		PlayerRef.UnequipItemEX(rightHand, 1, false)
	endIf
	Utility.wait(0.3)
	Game.setPlayerAIDriven(true)
	int oldCameraState = Game.getCameraState()
	if oldCameraState==0
		Game.forceThirdPerson()
	endIf
	PlayerRef.evaluatePackage()
	Utility.wait(0.3)
	Game.DisablePlayerControls(true, true, false, false, false, false, false, false, 0)
	Game.SetPlayerAIDriven()
	Debug.SendAnimationEvent(PlayerRef, "SOSBend5")
	; ((- Stripping
	clothes[2] = PlayerRef.GetWornForm(Armor.GetMaskForSlot(32))
	Form[] items
	
	if clothes[2] && stripMode==0 ; Partial not animated
		PlayerRef.UnequipItem(clothes[2], false, true)
	elseIf stripMode==1 ; Full not animated
		int i = 44
		while i>30
			i-=1
			clothes[i - 30] = PlayerRef.GetWornForm(Armor.GetMaskForSlot(i))
			if clothes[i - 30]
				PlayerRef.UnequipItem(clothes[i - 30], false, true)
			endIf
		endWhile
	elseIf clothes[2] && stripMode==2 ; Partial animated
		Debug.SendAnimationEvent(PlayerRef, "mndUndress")
		Utility.wait(2.5)
		PlayerRef.UnequipItem(clothes[2], false, true)
	elseIf stripMode==3 ; Full animated
		Debug.SendAnimationEvent(PlayerRef, "mndUndress")
		Utility.wait(2.5)
		int i = 44
		while i>30
			i-=1
			clothes[i - 30] = PlayerRef.GetWornForm(Armor.GetMaskForSlot(i))
			if clothes[i - 30]
				PlayerRef.UnequipItem(clothes[i - 30], false, true)
			endIf
		endWhile
	elseIf stripMode==4 ; SexLab partial not animated
		items = StripActor(false, false)
	elseIf stripMode==5 ; SexLab full not animated
		items = StripActor(false, true)
	elseIf stripMode==6 ; SexLab partial animated
		items = StripActor(true, false)
	elseIf stripMode==7 ; SexLab full animated
		items = StripActor(true, true)
	endIf
	
	; -))
	
	Debug.SendAnimationEvent(PlayerRef, "SOSBend5")
	if useAnimForPooping || useAnimForPissing
		Debug.SendAnimationEvent(PlayerRef, "mndPoop")
	endIf
	Debug.SendAnimationEvent(PlayerRef, "SOSBend5")
	Form previous = PlayerRef.GetWornForm(Armor.GetMaskForSlot(61))
	int peeNum = Utility.randomInt(0, 1)
	Form pee = pees[peeNum]
	PlayerRef.equipItem(pee, false, true)
	int pisound = mndPissingSound.play(PlayerRef)
	int posound = mndPoopingSound.play(PlayerRef)
	Utility.wait(1.0)
	Debug.SendAnimationEvent(PlayerRef, "SOSBend5")
	
	ObjectReference pissPuddle
	Utility.wait(2.0)
	if addPissPuddle
		pissPuddle = addPiss(2 + peeNum)
		pissPuddle.setScale(0.95)
	endIf
	Utility.wait(2.0)
	if addPissPuddle
		pissPuddle.setScale(1)
	endIf
	Utility.wait(2.0)
	if addPissPuddle
		pissPuddle.setScale(1.05)
	endIf
	Utility.wait(2.0)
	if addPissPuddle
		pissPuddle.setScale(1.1)
	endIf
	PlayerRef.unEquipItem(pee, false, true)
	PlayerRef.UnequipItemSlot(61)
	Sound.StopInstance(pisound)
	Utility.wait(4.0)
	
	if addVisiblePoop
		addPoop()
	endIf
	Sound.StopInstance(posound)
	Utility.wait(1.5)
	
	; ((- Redressing 
	if clothes[2] && stripMode==0 ; Partial no anim
		PlayerRef.equipItem(clothes[2], false, true)
	elseIf stripMode==1 ; Full no anim
		int i = 44
		while i>30
			i-=1
			if clothes[i - 30]
				PlayerRef.equipItem(clothes[i - 30], false, true)
			endIf
		endWhile
	elseIf clothes[2] && stripMode==2 ; Partial animated
		Debug.SendAnimationEvent(PlayerRef, "mndUndress")
		Utility.wait(2.5)
		PlayerRef.equipItem(clothes[2], false, true)
	elseIf stripMode==3 ; Full animated
		Debug.SendAnimationEvent(PlayerRef, "mndUndress")
		Utility.wait(2.5)
		int i = 44
		while i>30
			i-=1
			if clothes[i - 30]
				PlayerRef.equipItem(clothes[i - 30], false, true)
			endIf
		endWhile
	elseIf stripMode==4 ; SexLab partial no anim
		UnStripActor(items)
	elseIf stripMode==5 ; SexLab full no anim
		UnStripActor(items)
	elseIf stripMode==6 ; SexLab partial animated
		Debug.SendAnimationEvent(PlayerRef, "mndUndress")
		Utility.wait(2.5)
		UnStripActor(items)
	elseIf stripMode==7 ; SexLab full animated
		Debug.SendAnimationEvent(PlayerRef, "mndUndress")
		Utility.wait(2.5)
		UnStripActor(items)
	endIf	
	; -))
	
	
	PlayerRef.unEquipItem(pee, false, true)
	PlayerRef.UnequipItemSlot(61)
	if previous
		PlayerRef.EquipItemEx(previous, 61, false, false)
	else
		PlayerRef.EquipItem(mndPeeNone, false, true)
	endIf
	PlayerRef.unEquipItem(pee, false, true)
	Utility.wait(0.5)
	if leftHand
		PlayerRef.EquipItemEX(leftHand, 2, false)
	endIf
	if rightHand
		PlayerRef.EquipItemEX(rightHand, 1, false)
	endIf
	mndSetDoNothing = 0
	PlayerRef.evaluatePackage()
	PlayerRef.SheatheWeapon()
	PlayerRef.unEquipItem(pee, false, true)
	if previous
		PlayerRef.EquipItemEx(previous, 61, false, false)
	else
		PlayerRef.EquipItem(mndPeeNone, false, true)
	endIf
	Utility.wait(0.3)
	Game.EnablePlayerControls(true, true, false, false, false, false, false, false, 0)
	Game.setPlayerAIDriven(false)
	lastTimePoop = Utility.GetCurrentGameTime()
	lastTimePiss = Utility.GetCurrentGameTime()
	Debug.SendAnimationEvent(PlayerRef, "IdleForceDefaultState")
	if oldCameraState==0
		Game.forceFirstPerson()
	endIf
	alreadyPlayingAnim=0
endFunction

;-))


function applyConfig()
	mndMiniNeedsPlayerScript pla = GetAliasByName("PlayerRef") as mndMiniNeedsPlayerScript
	if weHaveSexLab && mndSLDelegate
		mndSLDelegate.doInit()
	endIf
	
	removeAllDiseases()
	pla.UnregisterForAllKeys()
	
	
	if enablePiss && enablePoop && pissAndPoopTogether
		howToPiss=howToPoop
		keyToPiss=0
		if PlayerRef.HasSpell(mndTakeALeak)
			PlayerRef.removeSpell(mndTakeALeak)
		endIf
		PlayerRef.removeShout(mndTakeALeakShout)
		if PlayerRef.HasSpell(mndDoYourBusiness)
			PlayerRef.removeSpell(mndDoYourBusiness)
		endIf
		PlayerRef.removeShout(mndDoYourBusinessShout)
		if howToPoop==0
			if !PlayerRef.HasSpell(mndDoFullBusiness)
				PlayerRef.addSpell(mndDoFullBusiness, false)
			endIf
		elseIf howToPoop==1
			PlayerRef.AddShout(mndDoFullBusinessShout)
		else
			pla.RegisterForKey(keyToPoop)
		endIf
	else
		if enablePiss
			if howToPiss==0
				if !PlayerRef.HasSpell(mndTakeALeak)
					PlayerRef.addSpell(mndTakeALeak, false)
				endIf
				PlayerRef.RemoveShout(mndTakeALeakShout)
			elseIf howToPiss==1
				if PlayerRef.HasSpell(mndTakeALeak)
					PlayerRef.removeSpell(mndTakeALeak)
				endIf
				PlayerRef.AddShout(mndTakeALeakShout)
			elseIf howToPiss==2
				if PlayerRef.HasSpell(mndTakeALeak)
					PlayerRef.removeSpell(mndTakeALeak)
				endIf
				PlayerRef.removeShout(mndTakeALeakShout)
				pla.RegisterForKey(keyToPiss)
			endIf
		else
			addRemoveDiseases(4, 0)
			if PlayerRef.HasSpell(mndTakeALeak)
				PlayerRef.removeSpell(mndTakeALeak)
			endIf
			PlayerRef.RemoveShout(mndTakeALeakShout)
			if PlayerRef.HasSpell(mndDoFullBusiness)
				PlayerRef.removeSpell(mndDoFullBusiness)
			endIf
			PlayerRef.removeShout(mndDoFullBusinessShout)
		endIf
		if enablePoop
			if howToPoop==0
				if !PlayerRef.HasSpell(mndDoYourBusiness)
					PlayerRef.addSpell(mndDoYourBusiness, false)
				endIf
				PlayerRef.RemoveShout(mndDoYourBusinessShout)
			elseIf howToPoop==1
				if PlayerRef.HasSpell(mndDoYourBusiness)
					PlayerRef.removeSpell(mndDoYourBusiness)
				endIf
				PlayerRef.AddShout(mndDoYourBusinessShout)
			elseIf howToPoop==2
				if PlayerRef.HasSpell(mndDoYourBusiness)
					PlayerRef.removeSpell(mndDoYourBusiness)
				endIf
				PlayerRef.removeShout(mndDoYourBusinessShout)
				pla.RegisterForKey(keyToPoop)
			endIf
		else
			addRemoveDiseases(5, 0)
			if PlayerRef.HasSpell(mndDoYourBusiness)
				PlayerRef.removeSpell(mndDoYourBusiness)
			endIf
			PlayerRef.RemoveShout(mndDoYourBusinessShout)
			if PlayerRef.HasSpell(mndDoFullBusiness)
				PlayerRef.removeSpell(mndDoFullBusiness)
			endIf
			PlayerRef.removeShout(mndDoFullBusinessShout)
		endIf
		if enablePiss && enablePoop && !pissAndPoopTogether
			if howToPissPoop==0
				if !PlayerRef.HasSpell(mndDoFullBusiness)
					PlayerRef.addSpell(mndDoFullBusiness, false)
				endIf
				PlayerRef.RemoveShout(mndDoFullBusinessShout)
			elseIf howToPissPoop==1
				if PlayerRef.HasSpell(mndDoFullBusiness)
					PlayerRef.removeSpell(mndDoFullBusiness)
				endIf
				PlayerRef.AddShout(mndDoFullBusinessShout)
			elseIf howToPissPoop==2
				if PlayerRef.HasSpell(mndDoFullBusiness)
					PlayerRef.removeSpell(mndDoFullBusiness)
				endIf
				PlayerRef.removeShout(mndDoFullBusinessShout)
				pla.RegisterForKey(keyToPissPoop)
			endIf
		else
			addRemoveDiseases(4, 0)
			addRemoveDiseases(5, 0)
			if PlayerRef.HasSpell(mndDoFullBusiness)
				PlayerRef.removeSpell(mndDoFullBusiness)
			endIf
			PlayerRef.RemoveShout(mndDoFullBusinessShout)
		endIf
	endIf

	if disableTheMod
		pla.UnRegisterForKey(widgetsKey)
		pla.UnRegisterForKey(oldWidgetsKey)
	elseIf widgetsKey!=0
		pla.RegisterForKey(widgetsKey)
	elseIf oldWidgetsKey!=0
		pla.UnRegisterForKey(oldWidgetsKey)
		oldWidgetsKey=0
	endIf
	
	if enableSleep
		pla.RegisterForSleep()
	else
		pla.UnregisterForSleep()
	endIf
	
	if enableTalk
		pla.RegisterForMenu("Dialogue Menu")
	else
		pla.UnregisterForMenu("Dialogue Menu")
	endIf

	if enableEat || enableDrink || enableSleep || enableTalk || enableBath || enablePray || enablePiss || enablePoop || enableSex || enableSkooma || enableAlcohol || enableWeed || enableDrunk
		pla.RegisterForUpdateGameTime(0.05)
		if enableWidgets && !enableWidgetEat && !enableWidgetDrink && !enableWidgetSleep && !enableWidgetTalk && !enableWidgetBath && !enableWidgetPray && !enableWidgetPiss && !enableWidgetPoop && !enableWidgetSex && !enableWidgetSkooma && !enableWidgetAlcohol && !enableWidgetWeed && !enableWidgetDrunk
			enableWidgetEat=true
			enableWidgetDrink=true
			enableWidgetSleep=true
			enableWidgetTalk=true
			enableWidgetSex=true
			enableWidgetPiss=true
			enableWidgetPoop=true
			enableWidgetSkooma=true
			enableWidgetAlcohol=true
			enableWidgetWeed=true
			enableWidgetDrunk=true
		endIf
	else
		pla.UnregisterForUpdateGameTime()
		pla.UnRegisterForKey(widgetsKey)
		pla.UnRegisterForKey(oldWidgetsKey)
	endIf
	
	RegisterForModEvent("MiniNeedsCleanPissPoop", "removePissPoop")
	RegisterForModEvent("MiniNeedsDoPissAndPoop", "DoPissAndPoop")
	RegisterForModEvent("MiniNeedsApplyPenalty", "ApplyPenalty")
	
	if enableBath
		if howToBathInRivers==0
			if !PlayerRef.HasSpell(mndBathInRivers)
				PlayerRef.addSpell(mndBathInRivers, false)
			endIf
			PlayerRef.RemoveShout(mndBathInRiversShout)
		elseIf howToBathInRivers==1
			if PlayerRef.HasSpell(mndBathInRivers)
				PlayerRef.removeSpell(mndBathInRivers)
			endIf
			PlayerRef.AddShout(mndBathInRiversShout)
		elseIf howToBathInRivers==2
			if PlayerRef.HasSpell(mndBathInRivers)
				PlayerRef.removeSpell(mndBathInRivers)
			endIf
			PlayerRef.removeShout(mndBathInRiversShout)
			pla.RegisterForKey(keyToBathInRivers)
		endIf
	else
		if PlayerRef.HasSpell(mndBathInRivers)
			PlayerRef.removeSpell(mndBathInRivers)
		endIf
		PlayerRef.RemoveShout(mndBathInRiversShout)
	endIf
		
	
	weHaveSexLab = Game.GetModByName("SexLab.esm")!=-1 && Game.GetModByName("SexLab.esm")!=255
	if weHaveSexLab
		SexLabAnimatingFaction = Game.GetFormFromFile(0xE50F, "SexLab.esm") as Faction
	else
		SexLabAnimatingFaction = none
	endIf
	if enableSex && weHaveSexLab
		RegisterForModEvent("HookAnimationEnding", "hookSexLabAnim")
		if keyToMasturbate
			pla.RegisterForKey(keyToMasturbate)
		endIf
	else
		UnRegisterForModEvent("HookAnimationEnding")
	endIf
	if !weHaveSexLab && stripMode>1
		stripMode-=2
	endIf
	
	weHaveWeed = (Game.GetModByName("Cannabis.esp")!=-1 && Game.GetModByName("Cannabis.esp")!=255) || (Game.GetModByName("CannabisSkyrimLite.esp")!=-1 && Game.GetModByName("CannabisSkyrimLite.esp")!=255)
	
	if disableTheMod
		unRegisterForModEvent("mndPlayAnim")
		unRegisterForModEvent("MiniNeedsSetValue")
		unRegisterForModEvent("MiniNeedsGetValue")
	else
		RegisterForModEvent("mndPlayAnim", "mndPlayAnim")
		RegisterForModEvent("MiniNeedsSetValue", "setNeedsValues")
		RegisterForModEvent("MiniNeedsGetValue", "getNeedsValues")
	endIf
	lastPlayedAnim = Utility.GetCurrentGameTime()
	alreadyPlayingAnim = false
	appliedISM = 0
	dirtShaderApplied = 0
	dirtShaderToApply = 0

	bool foundWater = false
	int i=LItemFoodInnCommon.GetNumForms()
	while i
		i-=1
		if LItemFoodInnCommon.GetNthForm(i)==mndWaterBottleFull
			foundWater=true
			i=0
		endIf
	endWhile
	if !foundWater
		LItemFoodInnCommon.AddForm(mndWaterBottleFull, 1, 1)
	endIf
	foundWater = false
	i=LItemHonningbrewWhiterunRuralInnDrink.GetNumForms()
	while i
		i-=1
		if LItemHonningbrewWhiterunRuralInnDrink.GetNthForm(i)==mndWaterBottleFull
			foundWater=true
			i=0
		endIf
	endWhile
	if !foundWater
		LItemHonningbrewWhiterunRuralInnDrink.AddForm(mndWaterBottleFull, 1, 1)
	endIf
	foundWater = false
	i=LItemInnRuralDrink.GetNumForms()
	while i
		i-=1
		if LItemInnRuralDrink.GetNthForm(i)==mndWaterBottleFull
			foundWater=true
			i=0
		endIf
	endWhile
	if !foundWater
		LItemInnRuralDrink.AddForm(mndWaterBottleFull, 1, 1)
	endIf
	
	bool foundBookS = false
	bool foundBookB = false
	i=LItemMiscVendorMiscItems75.GetNumForms()
	while i
		i-=1
		if LItemMiscVendorMiscItems75.GetNthForm(i)==mndBuildShowerBook
			foundBookS=true
		endIf
		if LItemMiscVendorMiscItems75.GetNthForm(i)==mndBuildBathtubBook
			foundBookB=true
		endIf
	endWhile
	if !foundBookS
		LItemMiscVendorMiscItems75.AddForm(mndBuildShowerBook, 1, 1)
	endIf
	if !foundBookB
		LItemMiscVendorMiscItems75.AddForm(mndBuildBathtubBook, 1, 1)
	endIf
	foundBookS = false
	i=LItemBookClutter.GetNumForms()
	while i
		i-=1
		if LItemBookClutter.GetNthForm(i)==mndShowerLocationsBook
			foundBookS=true
			i=0
		endIf
	endWhile
	if !foundBookS
		LItemBookClutter.AddForm(mndShowerLocationsBook, 1, 1)
	endIf
	foundBookS = false
	i=LItemBook0All.GetNumForms()
	while i
		i-=1
		if LItemBook0All.GetNthForm(i)==mndShowerLocationsBook
			foundBookS=true
			i=0
		endIf
	endWhile
	if !foundBookS
		LItemBook0All.AddForm(mndShowerLocationsBook, 1, 1)
	endIf

	if !weapons || weapons.length!=32
		weapons = new Weapon[32]
	endIf

	i=allStaticShowers.length
	while i
		i-=1
		if allStaticShowers[i]
			if enableStaticShowers
				allStaticShowers[i].Enable()
			else
				allStaticShowers[i].Disable()
			endIf
		endIf
	endWhile
	
	calculateWidgets()
endFunction

function removeISMs()
	if currentISM
		currentISM.remove()
	endIf
	appliedISM=0
endFunction

function showTranslatedString(string toGet)
	mcm.showTranslatedString(toGet)
endFunction

bool function isPlayerVampire()
	return mndVampireRaces.hasForm(PlayerRef.getRace())
endFunction



; ((- External mods and JSON config

Function loadExternalMods()
	if PapyrusUtil.GetVersion()>31
		weHavePapyrusUtils = true
	else
		weHavePapyrusUtils = false
	endIf

	; Pre-load forms from mods

	; Check if we have Requiem
	if Game.GetModByName("Requiem.esp")!=-1 && Game.GetModByName("Requiem.esp")!=255
		mndLiquidFoods.addForm(Game.GetFormFromFile(0x2897D4, "Requiem.esp"))
		mndBlood.addForm(Game.GetFormFromFile(0x318ADC, "Requiem.esp"))
		mndDrinks.addForm(Game.GetFormFromFile(0x3DFE8, "Requiem.esp"))
		mndLiquidFoods.addForm(Game.GetFormFromFile(0x36E7E, "Requiem.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x30CFB, "Requiem.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x284894, "Requiem.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x368F7, "Requiem.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x30D05, "Requiem.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x30CE7, "Requiem.esp"))
	endIf
	
	; Check if we have CACO
	if Game.GetModByName("Complete Alchemy & Cooking Overhaul.esp")!=-1 && Game.GetModByName("Complete Alchemy & Cooking Overhaul.esp")!=255
		mndDrinks.addForm(Game.GetFormFromFile(0xCCA111, "Complete Alchemy & Cooking Overhaul.esp"))
		mndLiquidFoods.addForm(Game.GetFormFromFile(0xCCA121, "Complete Alchemy & Cooking Overhaul.esp"))
		mndLiquidFoods.addForm(Game.GetFormFromFile(0xCCA124, "Complete Alchemy & Cooking Overhaul.esp"))
		mndDrinks.addForm(Game.GetFormFromFile(0xCCA125, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0xCCA119, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0xCCA120, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0xCCA122, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0xCCA123, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0xCCA126, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0xCCA127, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0xCCA128, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0xCCA129, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0xCCA130, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0xCCA145, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0xCCA146, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0xCCA147, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0xCCA148, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0xCCA150, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0xCCA151, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0xCCA152, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0xCCA153, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x190B50, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x190B53, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x190B54, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x190B55, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x190B56, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x190B57, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x190B58, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x190B5B, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x190B5D, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x190B5E, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x190B5F, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x190B62, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x190B63, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x195C73, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x195C75, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x1FB15C, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x1FB15E, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x1FB165, "Complete Alchemy & Cooking Overhaul.esp"))
		mndDrinks.addForm(Game.GetFormFromFile(0x1FB16B, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x1FB16D, "Complete Alchemy & Cooking Overhaul.esp"))
		mndDrinks.addForm(Game.GetFormFromFile(0x1FB171, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x1FB173, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x1FB175, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x1FB177, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x1FB179, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x1FB17B, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x1FB17D, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x1FB17F, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x1FB181, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x1FB183, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x1FB185, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x1FB187, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x1FB18D, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x1FB18F, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x1FB191, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x1FB193, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x1FB195, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x1FB199, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x1FB19B, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x1FB19D, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x1FB19F, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x1FB1A1, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x2002AD, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x2002B1, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x2002B3, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x2002B5, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x2002B7, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x2002B9, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x2002BD, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x2002BF, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x2002C1, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x2002C3, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x2002C5, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x2002C9, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x2002CB, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x2002CD, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x2002CF, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x2002D1, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x2002D3, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x2002D5, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x2002D7, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x2002D9, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x2002DB, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x2002DD, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x2002DF, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x2002E1, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x2002E5, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x2002E7, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x2002E9, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x2002EB, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x2002ED, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x2002EF, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x2002F1, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x2002F3, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x2002F5, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x2002F7, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x2002F9, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x2002FB, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x2002FD, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x2002FF, "Complete Alchemy & Cooking Overhaul.esp"))
		
		mndFoods.addForm(Game.GetFormFromFile(0x200301, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x200303, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x200305, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x200307, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x200308, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x20540E, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x205411, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x20A518, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x20A519, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x20A51D, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x20F620, "Complete Alchemy & Cooking Overhaul.esp"))
		mndLiquidFoods.addForm(Game.GetFormFromFile(0x220000, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x220001, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x220002, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x220003, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x220004, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x220005, "Complete Alchemy & Cooking Overhaul.esp"))
		mndLiquidFoods.addForm(Game.GetFormFromFile(0x220006, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x220008, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x220009, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x22000B, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x22000C, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x22001F, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x220020, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x220025, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x220026, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x220027, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x220028, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x220029, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x22002B, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x22002C, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x22002F, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x220030, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x220042, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x220043, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x220044, "Complete Alchemy & Cooking Overhaul.esp"))
		mndLiquidFoods.addForm(Game.GetFormFromFile(0x220045, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x220046, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x220047, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x220048, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x220049, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x22004A, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x22004B, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x22004C, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x22004E, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x22004F, "Complete Alchemy & Cooking Overhaul.esp"))
		mndAlcohol.addForm(Game.GetFormFromFile(0x220050, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x220051, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x220052, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x220053, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x220067, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x220068, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x22006F, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x220070, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x220071, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x220072, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x220073, "Complete Alchemy & Cooking Overhaul.esp"))
		mndLiquidFoods.addForm(Game.GetFormFromFile(0x220074, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x220075, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x220097, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x220098, "Complete Alchemy & Cooking Overhaul.esp"))
		mndLiquidFoods.addForm(Game.GetFormFromFile(0x220099, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x22009A, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x22009B, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x22009C, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x22009D, "Complete Alchemy & Cooking Overhaul.esp"))
		mndLiquidFoods.addForm(Game.GetFormFromFile(0x22009E, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x22009F, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x2200A0, "Complete Alchemy & Cooking Overhaul.esp"))
		mndLiquidFoods.addForm(Game.GetFormFromFile(0x2200A1, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x2200A2, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x2200A3, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x2200A4, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x2200A5, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x2200A6, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x2200A8, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x2200C8, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x2200C9, "Complete Alchemy & Cooking Overhaul.esp"))
		mndLiquidFoods.addForm(Game.GetFormFromFile(0x2200CA, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x2200CB, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x2200CC, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x2200CD, "Complete Alchemy & Cooking Overhaul.esp"))
		mndLiquidFoods.addForm(Game.GetFormFromFile(0x2200DA, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x2200DB, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x2200DC, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x2200DD, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x2200DE, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x2200E0, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x2200E1, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x2200E2, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x2200E3, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x2200E4, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x2200E5, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x2200E6, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x2200F2, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x2200F4, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x2200F6, "Complete Alchemy & Cooking Overhaul.esp"))
		mndDrinks.addForm(Game.GetFormFromFile(0x2200F8, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x2200FA, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x2200FC, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x2200FD, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x2200FE, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x2200FF, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x220101, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x220106, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x220108, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x22010B, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x22010C, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x22010D, "Complete Alchemy & Cooking Overhaul.esp"))
		mndDrinks.addForm(Game.GetFormFromFile(0x220110, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x220118, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x220119, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x22011E, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x220120, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x220122, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x220125, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x220127, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x220129, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x22012A, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x22012B, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x22012F, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x220131, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x220132, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x220133, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x220136, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x22013D, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x22013E, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x220142, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x220143, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x220146, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x220147, "Complete Alchemy & Cooking Overhaul.esp"))

		mndFoods.addForm(Game.GetFormFromFile(0x2B18A4, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x2B18CA, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x2B18CB, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x2B18CC, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x2B18CD, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x2B18CE, "Complete Alchemy & Cooking Overhaul.esp"))
		mndLiquidFoods.addForm(Game.GetFormFromFile(0x2B18CF, "Complete Alchemy & Cooking Overhaul.esp"))
		mndLiquidFoods.addForm(Game.GetFormFromFile(0x2B18D0, "Complete Alchemy & Cooking Overhaul.esp"))
		mndLiquidFoods.addForm(Game.GetFormFromFile(0x2B18D1, "Complete Alchemy & Cooking Overhaul.esp"))
		mndLiquidFoods.addForm(Game.GetFormFromFile(0x2B18D2, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x2B18D3, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x2B18D4, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x2B18D5, "Complete Alchemy & Cooking Overhaul.esp"))
		mndLiquidFoods.addForm(Game.GetFormFromFile(0x2B18D6, "Complete Alchemy & Cooking Overhaul.esp"))
		mndLiquidFoods.addForm(Game.GetFormFromFile(0x2B18D7, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x2B18D8, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x2B18D9, "Complete Alchemy & Cooking Overhaul.esp"))
		mndLiquidFoods.addForm(Game.GetFormFromFile(0x2B18DA, "Complete Alchemy & Cooking Overhaul.esp"))
		mndLiquidFoods.addForm(Game.GetFormFromFile(0x2B18DB, "Complete Alchemy & Cooking Overhaul.esp"))
		mndLiquidFoods.addForm(Game.GetFormFromFile(0x2B18DC, "Complete Alchemy & Cooking Overhaul.esp"))
		mndLiquidFoods.addForm(Game.GetFormFromFile(0x2B18DD, "Complete Alchemy & Cooking Overhaul.esp"))
		mndLiquidFoods.addForm(Game.GetFormFromFile(0x2B18DE, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x2B18DF, "Complete Alchemy & Cooking Overhaul.esp"))
		mndLiquidFoods.addForm(Game.GetFormFromFile(0x2B18E0, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x2B18E1, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x2B18E2, "Complete Alchemy & Cooking Overhaul.esp"))

		mndAlcohol.addForm(Game.GetFormFromFile(0x2BBAC6, "Complete Alchemy & Cooking Overhaul.esp"))
		mndAlcohol.addForm(Game.GetFormFromFile(0x2BBAC7, "Complete Alchemy & Cooking Overhaul.esp"))
		mndAlcohol.addForm(Game.GetFormFromFile(0x2BBAC9, "Complete Alchemy & Cooking Overhaul.esp"))
		mndAlcohol.addForm(Game.GetFormFromFile(0x2EE520, "Complete Alchemy & Cooking Overhaul.esp"))
		mndAlcohol.addForm(Game.GetFormFromFile(0x2EE522, "Complete Alchemy & Cooking Overhaul.esp"))
		mndAlcohol.addForm(Game.GetFormFromFile(0x2EE524, "Complete Alchemy & Cooking Overhaul.esp"))
		mndAlcohol.addForm(Game.GetFormFromFile(0x2EE529, "Complete Alchemy & Cooking Overhaul.esp"))
		mndAlcohol.addForm(Game.GetFormFromFile(0x2EE52B, "Complete Alchemy & Cooking Overhaul.esp"))
		mndAlcohol.addForm(Game.GetFormFromFile(0x2EE52D, "Complete Alchemy & Cooking Overhaul.esp"))
		mndAlcohol.addForm(Game.GetFormFromFile(0x2EE52F, "Complete Alchemy & Cooking Overhaul.esp"))
		mndAlcohol.addForm(Game.GetFormFromFile(0x2EE531, "Complete Alchemy & Cooking Overhaul.esp"))
		mndAlcohol.addForm(Game.GetFormFromFile(0x2EE533, "Complete Alchemy & Cooking Overhaul.esp"))
		mndDrinks.addForm(Game.GetFormFromFile(0x2EE53D, "Complete Alchemy & Cooking Overhaul.esp"))
		mndAlcohol.addForm(Game.GetFormFromFile(0x2F8755, "Complete Alchemy & Cooking Overhaul.esp"))
		mndAlcohol.addForm(Game.GetFormFromFile(0x2F8757, "Complete Alchemy & Cooking Overhaul.esp"))
		mndAlcohol.addForm(Game.GetFormFromFile(0x2F8758, "Complete Alchemy & Cooking Overhaul.esp"))
		mndAlcohol.addForm(Game.GetFormFromFile(0x2F875B, "Complete Alchemy & Cooking Overhaul.esp"))
		mndAlcohol.addForm(Game.GetFormFromFile(0x2F875D, "Complete Alchemy & Cooking Overhaul.esp"))
		mndAlcohol.addForm(Game.GetFormFromFile(0x2F875F, "Complete Alchemy & Cooking Overhaul.esp"))
		mndAlcohol.addForm(Game.GetFormFromFile(0x2F8761, "Complete Alchemy & Cooking Overhaul.esp"))
		mndAlcohol.addForm(Game.GetFormFromFile(0x2F8763, "Complete Alchemy & Cooking Overhaul.esp"))
		mndAlcohol.addForm(Game.GetFormFromFile(0x2F8765, "Complete Alchemy & Cooking Overhaul.esp"))
		mndAlcohol.addForm(Game.GetFormFromFile(0x2F8767, "Complete Alchemy & Cooking Overhaul.esp"))
		mndAlcohol.addForm(Game.GetFormFromFile(0x2F8769, "Complete Alchemy & Cooking Overhaul.esp"))
		mndAlcohol.addForm(Game.GetFormFromFile(0x2F876B, "Complete Alchemy & Cooking Overhaul.esp"))
		mndAlcohol.addForm(Game.GetFormFromFile(0x2F876D, "Complete Alchemy & Cooking Overhaul.esp"))
		mndAlcohol.addForm(Game.GetFormFromFile(0x2F876F, "Complete Alchemy & Cooking Overhaul.esp"))
		mndAlcohol.addForm(Game.GetFormFromFile(0x2F8771, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x37C247, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x37C248, "Complete Alchemy & Cooking Overhaul.esp"))
		mndAlcohol.addForm(Game.GetFormFromFile(0x44BCA1, "Complete Alchemy & Cooking Overhaul.esp"))
		mndAlcohol.addForm(Game.GetFormFromFile(0x44BCA2, "Complete Alchemy & Cooking Overhaul.esp"))
		mndAlcohol.addForm(Game.GetFormFromFile(0x44BCB2, "Complete Alchemy & Cooking Overhaul.esp"))
		mndAlcohol.addForm(Game.GetFormFromFile(0x44BCB4, "Complete Alchemy & Cooking Overhaul.esp"))
		mndAlcohol.addForm(Game.GetFormFromFile(0x44BCB6, "Complete Alchemy & Cooking Overhaul.esp"))
		mndAlcohol.addForm(Game.GetFormFromFile(0x44BCB9, "Complete Alchemy & Cooking Overhaul.esp"))
		mndAlcohol.addForm(Game.GetFormFromFile(0x44BCBB, "Complete Alchemy & Cooking Overhaul.esp"))
		mndAlcohol.addForm(Game.GetFormFromFile(0x44BCBD, "Complete Alchemy & Cooking Overhaul.esp"))
		mndAlcohol.addForm(Game.GetFormFromFile(0x44BCBF, "Complete Alchemy & Cooking Overhaul.esp"))
		mndAlcohol.addForm(Game.GetFormFromFile(0x44BCC1, "Complete Alchemy & Cooking Overhaul.esp"))
		mndAlcohol.addForm(Game.GetFormFromFile(0x44BCC3, "Complete Alchemy & Cooking Overhaul.esp"))
		mndAlcohol.addForm(Game.GetFormFromFile(0x44BCC5, "Complete Alchemy & Cooking Overhaul.esp"))
		mndAlcohol.addForm(Game.GetFormFromFile(0x44BCC7, "Complete Alchemy & Cooking Overhaul.esp"))
		mndAlcohol.addForm(Game.GetFormFromFile(0x44BCC9, "Complete Alchemy & Cooking Overhaul.esp"))
		mndAlcohol.addForm(Game.GetFormFromFile(0x44BCCB, "Complete Alchemy & Cooking Overhaul.esp"))
		mndAlcohol.addForm(Game.GetFormFromFile(0x450DD2, "Complete Alchemy & Cooking Overhaul.esp"))
		mndAlcohol.addForm(Game.GetFormFromFile(0x450DD4, "Complete Alchemy & Cooking Overhaul.esp"))
		mndAlcohol.addForm(Game.GetFormFromFile(0x450DD6, "Complete Alchemy & Cooking Overhaul.esp"))
		mndAlcohol.addForm(Game.GetFormFromFile(0x450DDB, "Complete Alchemy & Cooking Overhaul.esp"))
		mndAlcohol.addForm(Game.GetFormFromFile(0x450DDD, "Complete Alchemy & Cooking Overhaul.esp"))
		mndAlcohol.addForm(Game.GetFormFromFile(0x450DDF, "Complete Alchemy & Cooking Overhaul.esp"))
		mndAlcohol.addForm(Game.GetFormFromFile(0x450DE4, "Complete Alchemy & Cooking Overhaul.esp"))
		mndAlcohol.addForm(Game.GetFormFromFile(0x450DE6, "Complete Alchemy & Cooking Overhaul.esp"))
		mndAlcohol.addForm(Game.GetFormFromFile(0x450DE8, "Complete Alchemy & Cooking Overhaul.esp"))
		mndAlcohol.addForm(Game.GetFormFromFile(0x45AFF2, "Complete Alchemy & Cooking Overhaul.esp"))
		mndAlcohol.addForm(Game.GetFormFromFile(0x45AFF3, "Complete Alchemy & Cooking Overhaul.esp"))
		mndAlcohol.addForm(Game.GetFormFromFile(0x45AFF6, "Complete Alchemy & Cooking Overhaul.esp"))
		mndAlcohol.addForm(Game.GetFormFromFile(0x45AFF8, "Complete Alchemy & Cooking Overhaul.esp"))
		mndAlcohol.addForm(Game.GetFormFromFile(0x45AFF9, "Complete Alchemy & Cooking Overhaul.esp"))
		mndAlcohol.addForm(Game.GetFormFromFile(0x45AFFC, "Complete Alchemy & Cooking Overhaul.esp"))
		mndAlcohol.addForm(Game.GetFormFromFile(0x45AFFE, "Complete Alchemy & Cooking Overhaul.esp"))
		mndAlcohol.addForm(Game.GetFormFromFile(0x45B003, "Complete Alchemy & Cooking Overhaul.esp"))
		mndDrinks.addForm(Game.GetFormFromFile(0x45B005, "Complete Alchemy & Cooking Overhaul.esp"))
		mndAlcohol.addForm(Game.GetFormFromFile(0x45B00A, "Complete Alchemy & Cooking Overhaul.esp"))
		mndAlcohol.addForm(Game.GetFormFromFile(0x45B00C, "Complete Alchemy & Cooking Overhaul.esp"))
		mndAlcohol.addForm(Game.GetFormFromFile(0x45B00E, "Complete Alchemy & Cooking Overhaul.esp"))
		mndDrinks.addForm(Game.GetFormFromFile(0x460116, "Complete Alchemy & Cooking Overhaul.esp"))
		mndDrinks.addForm(Game.GetFormFromFile(0x460117, "Complete Alchemy & Cooking Overhaul.esp"))
		mndDrinks.addForm(Game.GetFormFromFile(0x46011A, "Complete Alchemy & Cooking Overhaul.esp"))
		mndDrinks.addForm(Game.GetFormFromFile(0x460124, "Complete Alchemy & Cooking Overhaul.esp"))
		mndDrinks.addForm(Game.GetFormFromFile(0x460126, "Complete Alchemy & Cooking Overhaul.esp"))
		mndDrinks.addForm(Game.GetFormFromFile(0x460128, "Complete Alchemy & Cooking Overhaul.esp"))
		mndDrinks.addForm(Game.GetFormFromFile(0x46012A, "Complete Alchemy & Cooking Overhaul.esp"))
		mndDrinks.addForm(Game.GetFormFromFile(0x46012B, "Complete Alchemy & Cooking Overhaul.esp"))
		mndDrinks.addForm(Game.GetFormFromFile(0x46012E, "Complete Alchemy & Cooking Overhaul.esp"))
		mndDrinks.addForm(Game.GetFormFromFile(0x46013A, "Complete Alchemy & Cooking Overhaul.esp"))
		mndDrinks.addForm(Game.GetFormFromFile(0x46013C, "Complete Alchemy & Cooking Overhaul.esp"))
		mndDrinks.addForm(Game.GetFormFromFile(0x46013E, "Complete Alchemy & Cooking Overhaul.esp"))
		mndDrinks.addForm(Game.GetFormFromFile(0x460140, "Complete Alchemy & Cooking Overhaul.esp"))
		mndDrinks.addForm(Game.GetFormFromFile(0x460142, "Complete Alchemy & Cooking Overhaul.esp"))
		mndDrinks.addForm(Game.GetFormFromFile(0x460144, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x48DA5A, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x48DA60, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x48DA62, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x48DA65, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x48DA6D, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x492B79, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x492B7A, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x492B7C, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x492B83, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x497C91, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x497C94, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x49CDA3, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x49CDAC, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x49CDB1, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x49CDB5, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x49CDBC, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x49CDC5, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x49CDC7, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x4A1ED3, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x4A6FE8, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x4A6FF8, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x4A6FFD, "Complete Alchemy & Cooking Overhaul.esp"))
		
		mndFoods.addForm(Game.GetFormFromFile(0x4B1215, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x4B631F, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x4B6322, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x4B6325, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x4B6328, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x4C0572, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x4C0579, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x4C057D, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x4C0583, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x4C0584, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x4C569B, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x4C569D, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x4CF8C1, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x4D9AE6, "Complete Alchemy & Cooking Overhaul.esp"))
		mndDrinks.addForm(Game.GetFormFromFile(0x4E3D21, "Complete Alchemy & Cooking Overhaul.esp"))
		mndDrinks.addForm(Game.GetFormFromFile(0x4E3D23, "Complete Alchemy & Cooking Overhaul.esp"))
		mndDrinks.addForm(Game.GetFormFromFile(0x4E3D25, "Complete Alchemy & Cooking Overhaul.esp"))
		mndDrinks.addForm(Game.GetFormFromFile(0x4E3D27, "Complete Alchemy & Cooking Overhaul.esp"))
		mndDrinks.addForm(Game.GetFormFromFile(0x4E3D29, "Complete Alchemy & Cooking Overhaul.esp"))
		mndDrinks.addForm(Game.GetFormFromFile(0x4E3D2B, "Complete Alchemy & Cooking Overhaul.esp"))
		mndDrinks.addForm(Game.GetFormFromFile(0x4E3D2D, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x4E3D30, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x50C65D, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x511764, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x51686D, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x516870, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x516872, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x516874, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x516876, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x516878, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x516879, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x51687B, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x51687D, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x516880, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x516881, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x516883, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x516886, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x52AD03, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x534F1A, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x534F1D, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x534F20, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x534F23, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x54425D, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x54426C, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x54E48A, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x54E497, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x54E4A3, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x54E4A4, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x54E4A6, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x54E4A8, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x54E4AA, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x54E4AC, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x54E4AE, "Complete Alchemy & Cooking Overhaul.esp"))
		
		mndBlood.addForm(Game.GetFormFromFile(0x55D7EB, "Complete Alchemy & Cooking Overhaul.esp"))
		mndBlood.addForm(Game.GetFormFromFile(0x55D7EE, "Complete Alchemy & Cooking Overhaul.esp"))
		mndBlood.addForm(Game.GetFormFromFile(0x55D7F2, "Complete Alchemy & Cooking Overhaul.esp"))
		mndBlood.addForm(Game.GetFormFromFile(0x55D7F3, "Complete Alchemy & Cooking Overhaul.esp"))
		mndBlood.addForm(Game.GetFormFromFile(0x55D7F6, "Complete Alchemy & Cooking Overhaul.esp"))
		mndBlood.addForm(Game.GetFormFromFile(0x55D7F7, "Complete Alchemy & Cooking Overhaul.esp"))
		mndBlood.addForm(Game.GetFormFromFile(0x55D7F8, "Complete Alchemy & Cooking Overhaul.esp"))
		mndBlood.addForm(Game.GetFormFromFile(0x55D7F9, "Complete Alchemy & Cooking Overhaul.esp"))
		mndBlood.addForm(Game.GetFormFromFile(0x55D7FA, "Complete Alchemy & Cooking Overhaul.esp"))
		mndBlood.addForm(Game.GetFormFromFile(0x55D7FB, "Complete Alchemy & Cooking Overhaul.esp"))
		
		mndFoods.addForm(Game.GetFormFromFile(0x5B8C29, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x5B8C2C, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x5C2E48, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x5C7F6E, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x5C7F73, "Complete Alchemy & Cooking Overhaul.esp"))
		mndDrinks.addForm(Game.GetFormFromFile(0x5E65D3, "Complete Alchemy & Cooking Overhaul.esp"))
		mndDrinks.addForm(Game.GetFormFromFile(0x5E65D6, "Complete Alchemy & Cooking Overhaul.esp"))
		mndDrinks.addForm(Game.GetFormFromFile(0x6FCE69, "Complete Alchemy & Cooking Overhaul.esp"))
		mndDrinks.addForm(Game.GetFormFromFile(0x6FCE6A, "Complete Alchemy & Cooking Overhaul.esp"))
		mndDrinks.addForm(Game.GetFormFromFile(0x701F71, "Complete Alchemy & Cooking Overhaul.esp"))
		mndDrinks.addForm(Game.GetFormFromFile(0x701F72, "Complete Alchemy & Cooking Overhaul.esp"))
		mndDrinks.addForm(Game.GetFormFromFile(0x701F74, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x725695, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x725696, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x99E776, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x99E778, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x99E784, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x99E786, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x99E788, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x99E78A, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x99E78C, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x99E78E, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x99E796, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x9A89CE, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x9FEC40, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0xA10114, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0xA10115, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0xA10116, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0xA10117, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0xA1011C, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0xA1011D, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0xA1011E, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0xA10125, "Complete Alchemy & Cooking Overhaul.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0xA1014A, "Complete Alchemy & Cooking Overhaul.esp"))
	endIf
	
	; Check if we have Cutting Room Floor
	if Game.GetModByName("Cutting Room Floor.esp")!=-1 && Game.GetModByName("Cutting Room Floor.esp")!=255
		mndAlcohol.addForm(Game.GetFormFromFile(0x37108, "Cutting Room Floor.esp"))
	endIf
	
	; Check if we have Skooma Whore
	if Game.GetModByName("SexLabSkoomaWhore.esp")!=-1 && Game.GetModByName("SexLabSkoomaWhore.esp")!=255
		mndSkooma.addForm(Game.GetFormFromFile(0x14980, "SexLabSkoomaWhore.esp"))
		mndSkooma.addForm(Game.GetFormFromFile(0x169EA, "SexLabSkoomaWhore.esp"))
		mndSkooma.addForm(Game.GetFormFromFile(0x174BD, "SexLabSkoomaWhore.esp"))
		mndSkooma.addForm(Game.GetFormFromFile(0x17A2F, "SexLabSkoomaWhore.esp"))
		mndSkooma.addForm(Game.GetFormFromFile(0x17A3E, "SexLabSkoomaWhore.esp"))
		mndSkooma.addForm(Game.GetFormFromFile(0x17FB0, "SexLabSkoomaWhore.esp"))
		mndSkooma.addForm(Game.GetFormFromFile(0x18521, "SexLabSkoomaWhore.esp"))
		mndSkooma.addForm(Game.GetFormFromFile(0x18A94, "SexLabSkoomaWhore.esp"))
		mndSkooma.addForm(Game.GetFormFromFile(0x19003, "SexLabSkoomaWhore.esp"))
		mndSkooma.addForm(Game.GetFormFromFile(0x19011, "SexLabSkoomaWhore.esp"))
		mndSkooma.addForm(Game.GetFormFromFile(0x19022, "SexLabSkoomaWhore.esp"))
		mndSkooma.addForm(Game.GetFormFromFile(0x19AEA, "SexLabSkoomaWhore.esp"))
		mndSkooma.addForm(Game.GetFormFromFile(0x1A05F, "SexLabSkoomaWhore.esp"))
		mndSkooma.addForm(Game.GetFormFromFile(0x1A064, "SexLabSkoomaWhore.esp"))
	endIf
	
	; Check if we have Cannabis and/or Cannabis Lite
	if Game.GetModByName("Cannabis.esp")!=-1 && Game.GetModByName("Cannabis.esp")!=255
		weHaveWeed = true
		mndWeed.addForm(Game.GetFormFromFile(0x1918, "Cannabis.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x1919, "Cannabis.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x191B, "Cannabis.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x191D, "Cannabis.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x191F, "Cannabis.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x2071, "Cannabis.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x2072, "Cannabis.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x2074, "Cannabis.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x2076, "Cannabis.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x2078, "Cannabis.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0xB841, "Cannabis.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x19656, "Cannabis.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x1CC43, "Cannabis.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x1CC44, "Cannabis.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x1CC46, "Cannabis.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x1CC48, "Cannabis.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x1CC4A, "Cannabis.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x1CC4C, "Cannabis.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x1CC4E, "Cannabis.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x1CC50, "Cannabis.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x1CC52, "Cannabis.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x1CC54, "Cannabis.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x1CC56, "Cannabis.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x1CC58, "Cannabis.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x1CC5A, "Cannabis.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x1CC5C, "Cannabis.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x1CC5E, "Cannabis.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x1CC60, "Cannabis.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x1CC62, "Cannabis.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x4AF1, "Cannabis.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x4AF1, "Cannabis.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x58728, "Cannabis.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x58729, "Cannabis.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x5872B, "Cannabis.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x5872D, "Cannabis.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x5872F, "Cannabis.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x58731, "Cannabis.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x7FA4C, "Cannabis.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x7FA50, "Cannabis.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x7FAC1, "Cannabis.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x80526, "Cannabis.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x80527, "Cannabis.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x80529, "Cannabis.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x8052B, "Cannabis.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x8052D, "Cannabis.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x8052F, "Cannabis.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x80531, "Cannabis.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x80533, "Cannabis.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x80535, "Cannabis.esp"))
		mndDrinks.addForm(Game.GetFormFromFile(0x8307A, "Cannabis.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x8A74A, "Cannabis.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x8D27A, "Cannabis.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x8D27B, "Cannabis.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x8D27D, "Cannabis.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x8D27F, "Cannabis.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x8D281, "Cannabis.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x976DB, "Cannabis.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x976DC, "Cannabis.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x976DE, "Cannabis.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x976E0, "Cannabis.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x976E2, "Cannabis.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x976E4, "Cannabis.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x976E6, "Cannabis.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x976E8, "Cannabis.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x976EA, "Cannabis.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x976EC, "Cannabis.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x976EE, "Cannabis.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x976F0, "Cannabis.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x97C58, "Cannabis.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x97C59, "Cannabis.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x97C5B, "Cannabis.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x97C5D, "Cannabis.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x97C5F, "Cannabis.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x981C3, "Cannabis.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0xA1E22, "Cannabis.esp"))
	endIf

	if Game.GetModByName("CannabisSkyrimLite.esp")!=-1 && Game.GetModByName("CannabisSkyrimLite.esp")!=255
		weHaveWeed = true
		mndWeed.addForm(Game.GetFormFromFile(0x1918, "CannabisSkyrimLite.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x1919, "CannabisSkyrimLite.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x191B, "CannabisSkyrimLite.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x191D, "CannabisSkyrimLite.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x191F, "CannabisSkyrimLite.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x2071, "CannabisSkyrimLite.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x2072, "CannabisSkyrimLite.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x2074, "CannabisSkyrimLite.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x2076, "CannabisSkyrimLite.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x2078, "CannabisSkyrimLite.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0xB841, "CannabisSkyrimLite.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x19656, "CannabisSkyrimLite.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x1CC43, "CannabisSkyrimLite.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x1CC44, "CannabisSkyrimLite.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x1CC46, "CannabisSkyrimLite.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x1CC48, "CannabisSkyrimLite.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x1CC4A, "CannabisSkyrimLite.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x1CC4C, "CannabisSkyrimLite.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x1CC4E, "CannabisSkyrimLite.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x1CC50, "CannabisSkyrimLite.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x1CC52, "CannabisSkyrimLite.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x1CC54, "CannabisSkyrimLite.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x1CC56, "CannabisSkyrimLite.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x1CC58, "CannabisSkyrimLite.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x1CC5A, "CannabisSkyrimLite.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x1CC5C, "CannabisSkyrimLite.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x1CC5E, "CannabisSkyrimLite.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x1CC60, "CannabisSkyrimLite.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x1CC62, "CannabisSkyrimLite.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x4AF1, "CannabisSkyrimLite.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x4AF1, "CannabisSkyrimLite.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x58728, "CannabisSkyrimLite.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x58729, "CannabisSkyrimLite.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x5872B, "CannabisSkyrimLite.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x5872D, "CannabisSkyrimLite.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x5872F, "CannabisSkyrimLite.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x58731, "CannabisSkyrimLite.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x7FA4C, "CannabisSkyrimLite.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x7FA50, "CannabisSkyrimLite.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x7FAC1, "CannabisSkyrimLite.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x80526, "CannabisSkyrimLite.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x80527, "CannabisSkyrimLite.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x80529, "CannabisSkyrimLite.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x8052B, "CannabisSkyrimLite.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x8052D, "CannabisSkyrimLite.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x8052F, "CannabisSkyrimLite.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x80531, "CannabisSkyrimLite.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x80533, "CannabisSkyrimLite.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x80535, "CannabisSkyrimLite.esp"))
		mndDrinks.addForm(Game.GetFormFromFile(0x8307A, "CannabisSkyrimLite.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x8A74A, "CannabisSkyrimLite.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x8D27A, "CannabisSkyrimLite.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x8D27B, "CannabisSkyrimLite.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x8D27D, "CannabisSkyrimLite.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x8D27F, "CannabisSkyrimLite.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x8D281, "CannabisSkyrimLite.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x976DB, "CannabisSkyrimLite.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x976DC, "CannabisSkyrimLite.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x976DE, "CannabisSkyrimLite.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x976E0, "CannabisSkyrimLite.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x976E2, "CannabisSkyrimLite.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x976E4, "CannabisSkyrimLite.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x976E6, "CannabisSkyrimLite.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x976E8, "CannabisSkyrimLite.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x976EA, "CannabisSkyrimLite.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x976EC, "CannabisSkyrimLite.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x976EE, "CannabisSkyrimLite.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x976F0, "CannabisSkyrimLite.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x97C58, "CannabisSkyrimLite.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x97C59, "CannabisSkyrimLite.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x97C5B, "CannabisSkyrimLite.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x97C5D, "CannabisSkyrimLite.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x97C5F, "CannabisSkyrimLite.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0x981C3, "CannabisSkyrimLite.esp"))
		mndWeed.addForm(Game.GetFormFromFile(0xA1E22, "CannabisSkyrimLite.esp"))
	endIf
	
	if (Game.GetModByName("Cannabis.esp")==-1 || Game.GetModByName("Cannabis.esp")==255) && (Game.GetModByName("CannabisSkyrimLite.esp")==-1 || Game.GetModByName("CannabisSkyrimLite.esp")==255)
		weHaveWeed = false
	endIf
	
	; Check if we have MilkLegendary
	if Game.GetModByName("MilkLegendary.esp")!=-1 && Game.GetModByName("MilkLegendary.esp")!=255
		mndLiquidFoods.addForm(Game.GetFormFromFile(0xD62, "MilkLegendary.esp"))
		mndDrinks.addForm(Game.GetFormFromFile(0x8466, "MilkLegendary.esp"))
		mndDrinks.addForm(Game.GetFormFromFile(0x8467, "MilkLegendary.esp"))
		mndDrinks.addForm(Game.GetFormFromFile(0x8469, "MilkLegendary.esp"))
		mndDrinks.addForm(Game.GetFormFromFile(0x846B, "MilkLegendary.esp"))
		mndDrinks.addForm(Game.GetFormFromFile(0x846D, "MilkLegendary.esp"))
		mndDrinks.addForm(Game.GetFormFromFile(0xAF81, "MilkLegendary.esp"))
		mndLiquidFoods.addForm(Game.GetFormFromFile(0xAF8C, "MilkLegendary.esp"))
		mndDrinks.addForm(Game.GetFormFromFile(0xBA53, "MilkLegendary.esp"))
		mndDrinks.addForm(Game.GetFormFromFile(0xFAFE, "MilkLegendary.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0xE006, "MilkLegendary.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0xE007, "MilkLegendary.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0xE009, "MilkLegendary.esp"))
	endIf

	; Check if we have Hunterborn
	if Game.GetModByName("Hunterborn.esp")!=-1 && Game.GetModByName("Hunterborn.esp")!=255
		mndBlood.addForm(Game.GetFormFromFile(0x0400B500, "Hunterborn.esp"))
		mndAlcohol.addForm(Game.GetFormFromFile(0x0400B504, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x04012C6B, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x04012C6C, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x04014226, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x04014228, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x0401422A, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x0401422C, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x0401422E, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x04014795, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x04014796, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x04014798, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x0401479A, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x0401479C, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x0401479E, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x040147A0, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x040147A2, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x04014D21, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x04014D22, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x04014D24, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x04017E08, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x04017E09, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x04017E0B, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x04017E0D, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x04017E0F, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x04017E11, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x04017E13, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x04017E15, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x04017E17, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x04017E19, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x04017E1B, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x04017E1D, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x04017E1F, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x04017E21, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x04017E23, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x04017E25, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x04017E27, "Hunterborn.esp"))
		mndAlcohol.addForm(Game.GetFormFromFile(0x04017E29, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x04017E2B, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x04017E2D, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x04017E2F, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x04017E31, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x04017E33, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x04017E35, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x04017E37, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x04017E39, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x04017E3B, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x04017E3D, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x04017E3F, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x04017E41, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x04017E43, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x04017E45, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x04017E47, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x04017E49, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x04017E4B, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x04017E4D, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x04017E4F, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x04017E51, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x04017E53, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x04017E55, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x04027783, "Hunterborn.esp"))
		mndBlood.addForm(Game.GetFormFromFile(0x040292C1, "Hunterborn.esp"))
		mndBlood.addForm(Game.GetFormFromFile(0x040292C2, "Hunterborn.esp"))
		mndBlood.addForm(Game.GetFormFromFile(0x040292C4, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x04029846, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x04029847, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x04029849, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x04029854, "Hunterborn.esp"))
		mndLiquidFoods.addForm(Game.GetFormFromFile(0x04029DB9, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x04029DBA, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x04029DBC, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x040314C4, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x040314C5, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x040314C9, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x040314CC, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x040314CD, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x040314D1, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x040314D4, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x040314D7, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x04031A49, "Hunterborn.esp"))
		mndDrinks.addForm(Game.GetFormFromFile(0x0403FD68, "Hunterborn.esp"))
		mndDrinks.addForm(Game.GetFormFromFile(0x040402D7, "Hunterborn.esp"))
		mndDrinks.addForm(Game.GetFormFromFile(0x040402DA, "Hunterborn.esp"))
		mndDrinks.addForm(Game.GetFormFromFile(0x040402DC, "Hunterborn.esp"))
		mndDrinks.addForm(Game.GetFormFromFile(0x040402DE, "Hunterborn.esp"))
		mndDrinks.addForm(Game.GetFormFromFile(0x040402E0, "Hunterborn.esp"))
		mndDrinks.addForm(Game.GetFormFromFile(0x040402E2, "Hunterborn.esp"))
		mndDrinks.addForm(Game.GetFormFromFile(0x040402E4, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x04055772, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x04078EA9, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x04078EAB, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x04078EAD, "Hunterborn.esp"))
		mndLiquidFoods.addForm(Game.GetFormFromFile(0x0407DFB3, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x0409C5C9, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x0409C5CF, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x0409C5D7, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x040C4E31, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x040E8564, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x040ED667, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x040ED66A, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x040ED66C, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x040ED66E, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x040ED670, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x040ED672, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x040ED674, "Hunterborn.esp"))
		mndDrinks.addForm(Game.GetFormFromFile(0x040ED676, "Hunterborn.esp"))
		mndDrinks.addForm(Game.GetFormFromFile(0x040ED678, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x040ED67A, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x040ED67C, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x040ED67E, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x040ED680, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x040F2783, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x040F2785, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x040F2787, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x040F2789, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x040F278B, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x040F278D, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x040F278F, "Hunterborn.esp"))
		mndLiquidFoods.addForm(Game.GetFormFromFile(0x040F2791, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x040F2794, "Hunterborn.esp"))
		mndLiquidFoods.addForm(Game.GetFormFromFile(0x041344E6, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x04152B41, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x04152B46, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x04152B48, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x04152B4A, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x04152B4C, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x04152B4E, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x04152B50, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x04152B52, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x04152B54, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x04152B56, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x04152B58, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x04152B5A, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x04152B5C, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x04152B5E, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x04152B60, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x04152B62, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x04152B64, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x04152B66, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x04152B68, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x04152B6A, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x04152B6C, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x04152B6E, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x04152B70, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x04152B72, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x04152B74, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x04152B76, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x04152B78, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x04152B7A, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x04199A0C, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x04199A0D, "Hunterborn.esp"))
		mndFoods.addForm(Game.GetFormFromFile(0x04199A0E, "Hunterborn.esp"))
	endIf

	; Check if we have Drinking Fountains of Skyrim
	if Game.GetModByName("Drinking Fountains of Skyrim.esp")!=-1 && Game.GetModByName("Drinking Fountains of Skyrim.esp")!=255
		mndDrinks.addForm(Game.GetFormFromFile(0x2E6F, "Drinking Fountains of Skyrim.esp"))
	endIf
	
	; Check if we have the JSON file, in case load it.
	if !weHavePapyrusUtils
		return
	endIf
	if !JsonUtil.IsGood("../MiniNeeds/currentMiniNeedsConfig.json")
		debug.messagebox("MiniNeeds\nThe JSON config file has errors inside:\n" + JsonUtil.GetErrors("../MiniNeeds/foodDrinkConfig.json"))
		return
	endIf
	JsonUtil.load("../MiniNeeds/currentMiniNeedsConfig.json")
	string[] mods = JsonUtil.PathMembers("../MiniNeeds/currentMiniNeedsConfig.json", ".FoodAndDrinks.")
	int i=mods.length
	while i
		i-=1
		string mod = mods[i]
		int pos = StringUtil.find(mod, "@")
		while pos!=-1
			mod = StringUtil.substring(mod, 0, pos - 1) + "." + StringUtil.substring(mod, pos + 1)
			pos = StringUtil.find(mod, "@")
		endWhile
		; Do we have the mod?
		if Game.GetModByName(mod)!=-1 && Game.GetModByName(mod)!=255
			; Get all IDs and grab the form, and put it in the correct spot
			String[] ids = JsonUtil.PathMembers("../MiniNeeds/currentMiniNeedsConfig.json", ".FoodAndDrinks." + mod)
			int j=ids.length
			while j
				j-=1
				int id = convertFromHex(ids[j])
				if id
					Form f = Game.GetFormFromFile(id, mod)
					if f
						int type = JsonUtil.GetPathIntValue("../MiniNeeds/currentMiniNeedsConfig.json", ".FoodAndDrinks." + mod + "." + ids[j], 0)
						setFormAs(f, type)
					endIf
				endIf
			endWhile
		endIf
	endWhile
endFunction

function setFormAs(form f, int type)
	if mndDrinks.hasForm(f)
		mndDrinks.RemoveAddedForm(f)
	endIf
	if mndFoods.hasForm(f)
		mndFoods.RemoveAddedForm(f)
	endIf
	if mndLiquidFoods.hasForm(f)
		mndLiquidFoods.RemoveAddedForm(f)
	endIf
	if mndSkooma.hasForm(f)
		mndSkooma.RemoveAddedForm(f)
	endIf
	if mndAlcohol.hasForm(f)
		mndAlcohol.RemoveAddedForm(f)
	endIf
	if mndWeed.hasForm(f)
		mndWeed.RemoveAddedForm(f)
	endIf
	if mndBlood.hasForm(f)
		mndBlood.RemoveAddedForm(f)
	endIf
	if mndToBeIgnored.hasForm(f)
		mndToBeIgnored.RemoveAddedForm(f)
	endIf
	if type==1
		mndDrinks.addForm(f)
	elseIf type==2
		mndFoods.addForm(f)
	elseIf type==3
		mndLiquidFoods.addForm(f)
	elseIf type==4
		mndSkooma.addForm(f)
	elseIf type==5
		mndAlcohol.addForm(f)
	elseIf type==6
		mndWeed.addForm(f)
	elseIf type==7
		mndBlood.addForm(f)
	else
		mndToBeIgnored.addForm(f)
	endIf
endFunction

string function getHex(int id)
	string res = ""
	while id
		int part = Math.logicalAnd(id, 0xF)
		id = Math.RightShift(Math.logicalAnd(id, 0xFFFFF0), 4)
		if part<10
			res = part + res
		elseIf part==10
			res = "A" + res
		elseIf part==11
			res = "B" + res
		elseIf part==12
			res = "C" + res
		elseIf part==13
			res = "D" + res
		elseIf part==14
			res = "E" + res
		elseIf part==15
			res = "F" + res
		endIf
	endWhile
	return "0x"+res
endFunction

int function convertFromHex(string id)
	int res = 0
	int len = StringUtil.getLength(id)
	int pos = 2
	while pos<len
		string char = StringUtil.GetNthChar(id, pos)
		pos *= 16
		if StringUtil.isDigit(char)
			res += (char as int)
		elseIf char=="A"
			res += 10
		elseIf char=="B"
			res += 11
		elseIf char=="C"
			res += 12
		elseIf char=="D"
			res += 13
		elseIf char=="E"
			res += 14
		elseIf char=="F"
			res += 15
		endIf
		pos+=1
	endWhile
	return res
endFunction

string function useSafeModName(int modId)
	string res = Game.GetModName(modId)
	int pos = StringUtil.find(res, ".")
	while pos!=-1
		res = StringUtil.substring(res, 0, pos - 1) + "@" + StringUtil.substring(res, pos+1)
		pos = StringUtil.find(res, ".")
	endWhile
	return res
endFunction

function saveFoodJson(string file)
	if !weHavePapyrusUtils
		return
	endIf

	
	if !file
		file = "../MiniNeeds/currentMiniNeedsConfig.json"
	endIf
	JsonUtil.load(file)
	int i = mndFoods.getSize()
	while i
		i-=1
		Form f = mndFoods.GetAt(i)
		int modId = Math.RightShift(Math.logicalAnd(f.getFormId(), 0xFF000000), 24)
		string mod = useSafeModName(modId)
		JsonUtil.SetPathIntValue(file, ".FoodAndDrinks."+mod+"."+getHex(Math.logicalAnd(f.getFormId(), 0xFFFFFF)), 1)
	endWhile
	i = mndDrinks.getSize()
	while i
		i-=1
		Form f = mndDrinks.GetAt(i)
		int modId = Math.RightShift(Math.logicalAnd(f.getFormId(), 0xFF000000), 24)
		string mod = useSafeModName(modId)
		JsonUtil.SetPathIntValue(file, ".FoodAndDrinks."+mod+"."+getHex(Math.logicalAnd(f.getFormId(), 0xFFFFFF)), 2)
	endWhile	
	i = mndLiquidFoods.getSize()
	while i
		i-=1
		Form f = mndLiquidFoods.GetAt(i)
		int modId = Math.RightShift(Math.logicalAnd(f.getFormId(), 0xFF000000), 24)
		string mod = useSafeModName(modId)
		JsonUtil.SetPathIntValue(file, ".FoodAndDrinks."+mod+"."+getHex(Math.logicalAnd(f.getFormId(), 0xFFFFFF)), 3)
	endWhile	
	i = mndAlcohol.getSize()
	while i
		i-=1
		Form f = mndAlcohol.GetAt(i)
		int modId = Math.RightShift(Math.logicalAnd(f.getFormId(), 0xFF000000), 24)
		string mod = useSafeModName(modId)
		JsonUtil.SetPathIntValue(file, ".FoodAndDrinks."+mod+"."+getHex(Math.logicalAnd(f.getFormId(), 0xFFFFFF)), 4)
	endWhile	
	i = mndSkooma.getSize()
	while i
		i-=1
		Form f = mndSkooma.GetAt(i)
		int modId = Math.RightShift(Math.logicalAnd(f.getFormId(), 0xFF000000), 24)
		string mod = useSafeModName(modId)
		JsonUtil.SetPathIntValue(file, ".FoodAndDrinks."+mod+"."+getHex(Math.logicalAnd(f.getFormId(), 0xFFFFFF)), 5)
	endWhile	
	i = mndWeed.getSize()
	while i
		i-=1
		Form f = mndWeed.GetAt(i)
		int modId = Math.RightShift(Math.logicalAnd(f.getFormId(), 0xFF000000), 24)
		string mod = useSafeModName(modId)
		JsonUtil.SetPathIntValue(file, ".FoodAndDrinks."+mod+"."+getHex(Math.logicalAnd(f.getFormId(), 0xFFFFFF)), 6)
	endWhile	
	i = mndBlood.getSize()
	while i
		i-=1
		Form f = mndBlood.GetAt(i)
		int modId = Math.RightShift(Math.logicalAnd(f.getFormId(), 0xFF000000), 24)
		string mod = useSafeModName(modId)
		JsonUtil.SetPathIntValue(file, ".FoodAndDrinks."+mod+"."+getHex(Math.logicalAnd(f.getFormId(), 0xFFFFFF)), 7)
	endWhile	
	i = mndToBeIgnored.getSize()
	while i
		i-=1
		Form f = mndToBeIgnored.GetAt(i)
		int modId = Math.RightShift(Math.logicalAnd(f.getFormId(), 0xFF000000), 24)
		string mod = useSafeModName(modId)
		JsonUtil.SetPathIntValue(file, ".FoodAndDrinks."+mod+"."+getHex(Math.logicalAnd(f.getFormId(), 0xFFFFFF)), 0)
	endWhile
	JsonUtil.save(file)
endFunction

; -))

; ((- Damages and penalties


; Needs: 0=Eat, 1=Drink, 2=Sleep, 3=Talk, 4=Bath, 5=Pray, 6=Piss, 7=Poop, 8=Sex, 9=Skooma, 10=Alcohol, 11=Weed, 12=Drunk
bool calculatingBuffs = false
int dirtShaderApplied = 0
int dirtShaderToApply = 0
ImageSpaceModifier currentISM
int appliedISM
bool lastAlterSpeedPositive
float lastNotificationTime
Weapon[] weapons
float originalWeight=-1.0
int damageW = 0
int damageRndW = 0
int damageAlch = 0
int damageT = 0
int damageB = 0
bool titsModified = false
float origWbm = 1.0
float origWpu = 1.0
float origWvo = 1.0
float origWbv = 1.0
float origWro = 1.0
float origWpe = 1.0
float origWpf = 1.0
bool bellyModified = false
float origWbelly = 1.0


; ((- Spells andMagic effects for Diseases

Spell Property mndDamageHealth Auto
MagicEffect Property mndDamageHealthME Auto
Spell Property mndDamageHealthRate Auto
MagicEffect Property mndDamageHealthRateME Auto
Spell Property mndDamageStamina Auto
MagicEffect Property mndDamageStaminaME Auto
Spell Property mndDamageStaminaRate Auto
MagicEffect Property mndDamageStaminaRateME Auto
Spell Property mndDamageMagicka Auto
MagicEffect Property mndDamageMagickaME Auto
Spell Property mndDamageMagickaRate Auto
MagicEffect Property mndDamageMagickaRateME Auto
Spell Property mndDamageSpeed Auto
MagicEffect Property mndDamageSpeedME Auto
Spell Property mndDamageCarryWeight Auto
MagicEffect Property mndDamageCarryWeightME Auto
Spell Property mndDamageLightArmors Auto
MagicEffect Property mndDamageLightArmorsME Auto
Spell Property mndDamageHeavyArmors Auto
MagicEffect Property mndDamageHeavyArmorsME Auto
Spell Property mndDamageSpeech Auto
MagicEffect Property mndDamageSpeechME Auto
Spell Property mndDamageSneak Auto
MagicEffect Property mndDamageSneakME Auto
Spell Property mndDamagePickPocket Auto
MagicEffect Property mndDamagePickPocketME Auto
Spell Property mndDamageLockPicking Auto
MagicEffect Property mndDamageLockPickingME Auto
Spell Property mndDamageEnchanting Auto
MagicEffect Property mndDamageEnchantingME Auto
Spell Property mndDamageAlchemy Auto
MagicEffect Property mndDamageAlchemyME Auto
Spell Property mndDamageSpellsAlteration Auto
MagicEffect Property mndDamageSpellsAlterationME Auto
Spell Property mndDamageSpellsConjuration Auto
MagicEffect Property mndDamageSpellsConjurationME Auto
Spell Property mndDamageSpellsDestruction Auto
MagicEffect Property mndDamageSpellsDestructionME Auto
Spell Property mndDamageSpellsIllusion Auto
MagicEffect Property mndDamageSpellsIllusionME Auto
Spell Property mndDamageSpellsRestoration Auto
MagicEffect Property mndDamageSpellsRestorationME Auto
Spell Property mndDamageWeaponsSpeed Auto
MagicEffect Property mndDamageWeaponsSpeedME Auto
Spell Property mndDamageWeaponsDamage Auto
MagicEffect Property mndDamageWeaponsDamageME Auto
Spell Property mndDamageAttackDamage Auto
MagicEffect Property mndDamageAttackDamageME Auto
Spell Property mndDamageBlocking Auto
MagicEffect Property mndDamageBlockingME Auto
Spell Property mndDamageIncreaseSpeed Auto
MagicEffect Property mndDamageIncreaseSpeedME Auto
Spell Property mndDamageIncreaseSneak Auto
MagicEffect Property mndDamageIncreaseSneakME Auto
Spell Property mndDamageIncreaseLockPicking Auto
MagicEffect Property mndDamageIncreaseLockPickingME Auto
Spell Property mndDamageIncreasePickPocket Auto
MagicEffect Property mndDamageIncreasePickPocketME Auto

; -))

Function recalculateBuffs()

	if calculatingBuffs
		return ; We are already calculating
	endIf
	calculatingBuffs = true


	float now = Utility.GetCurrentGameTime()
	float timeMultiplier = 1.0
	if useTimeScale
		timeMultiplier = timeScale.getValue()/20.0
	endIf
	int step
	
	; Needs: 0=Eat, 1=Drink, 2=Sleep, 3=Talk, 4=Bath, 5=Pray, 6=Piss, 7=Poop, 8=Sex, 9=Skooma, 10=Alcohol, 11=Weed, 12=Drunk
	appliedISM = 0
	damageW = 0
	damageRndW = 0
	damageAlch = 0
	damageT = 0
	damageB = 0

	; Eat 0
	bool needEat = calculateNeed(0, enableEat, timeEat, lastTimeEat, now, timeMultiplier, maxEatDamage)
	
	; Drink 1
	bool needDrink = calculateNeed(1, enableDrink, timeDrink, lastTimeDrink, now, timeMultiplier, maxDrinkDamage)

	; Sleep 2
	bool needSleep = calculateNeed(2, enableSleep, timeSleep, lastTimeSleep, now, timeMultiplier, maxSleepDamage)

	; Talk 3
	bool needTalk = calculateNeed(3, enableTalk, timeTalk, lastTimeTalk, now, timeMultiplier, maxTalkDamage)

	; Bath 4
	bool needBath = calculateNeed(4, enableBath, timeBath, lastTimeBath, now, timeMultiplier, maxBathDamage)

	; Pray 5
	bool needPray = calculateNeed(5, enablePray, timePray, lastTimePray, now, timeMultiplier, maxPrayDamage)

	; Piss 6
	bool needPiss = calculateNeed(6, enablePiss, timePiss, lastTimePiss, now, timeMultiplier, maxPissDamage)
	
	; Poop 7
	bool needPoop = calculateNeed(7, enablePoop, timePoop, lastTimePoop, now, timeMultiplier, maxPoopDamage)
	
	; Sex 8
	bool needSex = calculateNeed(8, enableSex && weHaveSexLab, timeSex, lastTimeSex, now, timeMultiplier, maxSexDamage)

	; Skooma 9
	bool needSkooma = calculateNeed(9, enableSkooma, timeSkooma, lastTimeSkooma, now, timeMultiplier, maxSkoomaDamage)
	
	; Alcohol 10
	bool needAlcohol = calculateNeed(10, enableAlcohol, timeAlcohol, lastTimeAlcohol, now, timeMultiplier, maxAlcoholDamage)
	
	; Weed 11
	bool needWeed = calculateNeed(11, weHaveWeed && enableWeed, timeWeed, lastTimeWeed, now, timeMultiplier, maxWeedDamage)

	; Drunk 12
	bool weAreDrunk = calculateNeedReverse(12, enableDrunk, timeDrunk, lastTimeDrunk, now, timeMultiplier, maxDrunkDamage)

	; Do a global variation for weight
	if damageW!=0
		applyWeightVariation()
	endIf
	
	; Do a global variation for Random weapon when equipping
	grabRandomWeapon = damageRndW

	; Drink another alcohol
	drinkAnotherAlcohol = damageAlch
	
	; Increase/Decrease Tits
	if damageT>10
		damageT=10
	elseIf damageT<-10
		damageT=-10
	endIf
	resizeTits(damageT)
	
	; Increase/Decrease Belly
	if damageB>10
		damageB=10
	elseIf damageB<-10
		damageB=-10
	endIf
	resizeBelly(damageB)
	
	; Needs: 0=Eat, 1=Drink, 2=Sleep, 3=Talk, 4=Bath, 5=Pray, 6=Piss, 7=Poop, 8=Sex, 9=Skooma, 10=Alcohol, 11=Weed, 12=Drunk

	bool showNotifications = (notificationsTime==1 && (now - lastNotificationTime)>1.0) || (notificationsTime==2 && (now - lastNotificationTime)>0.041666666) || (notificationsTime==3 && (now - lastNotificationTime)>0.020833333) || (notificationsTime==4 && (now - lastNotificationTime)>0.006944444) || (notificationsTime==5)
	if showNotifications
	
		if needEat && needDrink && needSleep
			showTranslatedString("NeedsB_EDS")
		elseIf needEat && needDrink && !needSleep
			showTranslatedString("NeedsB_ED!")
		elseIf needEat && !needDrink && needSleep
			showTranslatedString("NeedsB_E!S")
		elseIf needEat && !needDrink && !needSleep
			showTranslatedString("NeedsB_E!!")
		elseIf !needEat && needDrink && needSleep
			showTranslatedString("NeedsB_!DS")
		elseIf !needEat && needDrink && !needSleep
			showTranslatedString("NeedsB_!D!")
		elseIf !needEat && !needDrink && needSleep
			showTranslatedString("NeedsB_!!S")
		elseIf !needEat && !needDrink && !needSleep
			; showTranslatedString("NeedsB_!!!")
		endIf	
	
		if needTalk && needBath && needPray
			showTranslatedString("NeedsS_TBP")
		elseIf needTalk && needBath && !needPray
			showTranslatedString("NeedsS_TB!")
		elseIf needTalk && !needBath && needPray
			showTranslatedString("NeedsS_T!P")
		elseIf needTalk && !needBath && !needPray
			showTranslatedString("NeedsS_T!!")
		elseIf !needTalk && needBath && needPray
			showTranslatedString("NeedsS_!BP")
		elseIf !needTalk && needBath && !needPray
			showTranslatedString("NeedsS_!B!")
		elseIf !needTalk && !needBath && needPray
			showTranslatedString("NeedsS_!!P")
		elseIf !needTalk && !needBath && !needPray
			; showTranslatedString("NeedsS_!!!")
		endIf
		
		if needPiss && needPoop
			showTranslatedString("NeedsP_PP")
		elseIf needPiss && !needPoop
			showTranslatedString("NeedsP_P!")
		elseIf !needPiss && needPoop
			showTranslatedString("NeedsP_!P")
		endIf

		if needSex && needSkooma && needAlcohol && needWeed
			showTranslatedString("NeedsA_SSWW")
		elseIf needSex && needSkooma && needAlcohol && !needWeed
			showTranslatedString("NeedsA_SSW!")
		elseIf needSex && needSkooma && !needAlcohol && needWeed
			showTranslatedString("NeedsA_SS!W")
		elseIf needSex && needSkooma && !needAlcohol && !needWeed
			showTranslatedString("NeedsA_SS!!")
		elseIf needSex && !needSkooma && needAlcohol && needWeed
			showTranslatedString("NeedsA_S!WW")
		elseIf needSex && !needSkooma && needAlcohol && !needWeed
			showTranslatedString("NeedsA_S!W!")
		elseIf needSex && !needSkooma && !needAlcohol && needWeed
			showTranslatedString("NeedsA_S!!W")
		elseIf needSex && !needSkooma && !needAlcohol && !needWeed
			showTranslatedString("NeedsA_S!!!")
		elseIf !needSex && needSkooma && needAlcohol && needWeed
			showTranslatedString("NeedsA_!SWW")
		elseIf !needSex && needSkooma && needAlcohol && !needWeed
			showTranslatedString("NeedsA_!SW!")
		elseIf !needSex && needSkooma && !needAlcohol && needWeed
			showTranslatedString("NeedsA_!S!W")
		elseIf !needSex && needSkooma && !needAlcohol && !needWeed
			showTranslatedString("NeedsA_!S!!")
		elseIf !needSex && !needSkooma && needAlcohol && needWeed
			showTranslatedString("NeedsA_!!WW")
		elseIf !needSex && !needSkooma && needAlcohol && !needWeed
			showTranslatedString("NeedsA_!!W!")
		elseIf !needSex && !needSkooma && !needAlcohol && needWeed
			showTranslatedString("NeedsA_!!!W")
		endIf
	endIf
	
	lastNotificationTime = now
	calculateWidgets()
	
	; Check if we can remove old pee and poo
	if addPissPuddle<2
		int i = pissesTimes.length
		while i
			i-=1
			if pisses[i] && (now - pissesTimes[i]) > 0.99
				pisses[i].delete()
				pissesTimes[i] = 0.0
			endIf
		endWhile
	endIf
	if addVisiblePoop<2
		int i = poopsTimes.length
		while i
			i-=1
			if poops[i] && (now - poopsTimes[i]) > 0.99
				poops[i].delete()
				poopsTimes[i] = 0.0
			endIf
		endWhile
	endIf

	calculatingBuffs = false
endFunction

bool function calculateNeed(int need, bool enableIt, float timeNeed, float lastTimeNeed, float now, float timeMultiplier, float maxDamage)
	bool needIt=false
	if enableIt
		float lastTime = timeMultiplier*timeNeed/24.0
		float nowTime = now - lastTimeNeed
		int step = calculateTimeStep(nowTime, lastTime)
		needit=step!=0
		if step
			addRemoveDiseases(need, step)
			; Weight increase and decrease
			int decrV = getDamageValue(need, 38) ; Weight decrease and increase
			int incrV = getDamageValue(need, 39)
			if decrV && decrV<=step
				damageW -= ((1 + step - decrV) * maxDamage) as Int
			endIf
			if incrV && incrV<=step
				damageW += ((1 + step - incrV) * maxDamage) as Int
			endIf
			; Random weapon when equipping
			incrV = getDamageValue(need, 12)
			if incrV && incrV<=step
				if damageRndW < ((1 + step - incrV) * maxDamage/100.0) as Int
					damageRndW = ((1 + step - incrV) * maxDamage/100.0) as Int
				endIf
			endIf
			
			; Drink another alcohol
			incrV = getDamageValue(need, 40)
			if incrV && incrV<=step
				if damageAlch < ((1 + step - incrV) * maxDamage) as Int
					damageAlch = ((1 + step - incrV) * maxDamage) as Int
				endIf
			endIf
			; Increase/Decrease tits
			decrV = getDamageValue(need, 34)
			incrV = getDamageValue(need, 35)
			if decrV && decrV<=step
				damageT -= ((1 + step - decrV) * maxDamage) as Int
			endIf
			if incrV && incrV<=step
				damageT += ((1 + step - incrV) * maxDamage) as Int
			endIf
			; Increase/Decrease belly
			decrV = getDamageValue(need, 36)
			incrV = getDamageValue(need, 37)
			if decrV && decrV<=step
				damageB -= ((1 + step - decrV) * maxDamage) as Int
			endIf
			if incrV && incrV<=step
				damageB += ((1 + step - incrV) * maxDamage) as Int
			endIf
		else
			addRemoveDiseases(need, 0)
		endIf
	else
		addRemoveDiseases(need, 0)
	endIf
	return needIt
endFunction

; Used for Drunk only at the moment, but in future other needs can use the same approach
bool function calculateNeedReverse(int need, bool enableIt, float timeNeed, float lastTimeNeed, float now, float timeMultiplier, float maxDamage)
	bool needIt=false
	
	if enableIt
		float lastTime = timeMultiplier*timeNeed/24.0
		float nowTime = now - lastTimeNeed
		int step = calculateTimeStep(nowTime, lastTime, ((timeNeed/24.0) - now + lastTimeNeed)/(timeNeed/24.0))
		needit=step!=0
		if step
			addRemoveDiseases(need, step)
			; Weight increase and decrease
			int decrV = getDamageValue(need, 38) ; Weight decrease and increase
			int incrV = getDamageValue(need, 39)
			if decrV && decrV<=step
				damageW -= ((1 + step - decrV) * maxDamage) as Int
			endIf
			if incrV && incrV<=step
				damageW += ((1 + step - incrV) * maxDamage) as Int
			endIf
			; Random weapon when equipping
			incrV = getDamageValue(need, 12)
			if incrV && incrV<=step
				if damageRndW < ((1 + step - incrV) * maxDamage) as Int
					damageRndW = ((1 + step - incrV) * maxDamage) as Int
				endIf
			endIf
			; Drink another alcohol
			incrV = getDamageValue(need, 40)
			if incrV && incrV<=step
				if damageAlch < ((1 + step - incrV) * maxDamage) as Int
					damageAlch = ((1 + step - incrV) * maxDamage) as Int
				endIf
			endIf
			; Increase/Decrease tits
			decrV = getDamageValue(need, 34)
			incrV = getDamageValue(need, 35)
			if decrV && decrV<=step
				damageT -= ((1 + step - decrV) * maxDamage) as Int
			endIf
			if incrV && incrV<=step
				damageT += ((1 + step - incrV) * maxDamage) as Int
			endIf
			; Increase/Decrease belly
			decrV = getDamageValue(need, 36)
			incrV = getDamageValue(need, 37)
			if decrV && decrV<=step
				damageB -= ((1 + step - decrV) * maxDamage) as Int
			endIf
			if incrV && incrV<=step
				damageB += ((1 + step - incrV) * maxDamage) as Int
			endIf
		else
			addRemoveDiseases(need, 0)
		endIf
	else
		addRemoveDiseases(need, 0)
	endIf
	return needIt
endFunction


int function calculateTimeStep(float nowTime, float lastTime, float reversePerc=-1.0)
	if reversePerc==-1.0
		if nowTime > lastTime*2.0 ; [---][--I]
			return 6
		elseIf nowTime > lastTime*1.4 ; [---][-I-]
			return 5
		elseIf nowTime > lastTime ; [---][I--]
			return 4
		elseIf nowTime > lastTime*0.8 ; [--I]
			return 3
		elseIf nowTime > lastTime*0.4 ; [-I-]
			return 2
		elseIf nowTime > lastTime*0.01 ; [I--]
			return 1
		endIf
	else
		if nowTime < lastTime
			if reversePerc > 0.9 ; [---][--I]
				return 6
			elseIf reversePerc > 0.7 ; [---][-I-]
				return 5
			elseIf reversePerc > 0.5 ; [---][I--]
				return 4
			elseIf reversePerc > 0.3 ; [--I]
				return 3
			elseIf reversePerc > 0.1 ; [-I-]
				return 2
			elseIf reversePerc > 0.01 ; [I--]
				return 1
			endIf
		endIf
	endIf
	return 0
endFunction

function addRemoveDiseases(int need, int applyStep)
	; Grab the max penalty percent for the need
	; applyStep: 0=don't apply/remove, 1=[I--], 2=[-I-], ..., 6=[---][--I]
	; Needs: 0=Eat, 1=Drink, 2=Sleep, 3=Talk, 4=Bath, 5=Pray, 6=Piss, 7=Poop, 8=Sex, 9=Skooma, 10=Alcohol, 11=Weed, 12=Drunk
	
	float maxPercent = 50.0
	if need==0 ; Eat
		maxPercent = 1.0 - maxEatDamage/100.0
	elseIf need==1 ; Drink
		maxPercent = 1.0 - maxDrinkDamage/100.0
	elseIf need==2 ; Sleep
		maxPercent = 1.0 - maxSleepDamage/100.0
	elseIf need==3 ; Talk
		maxPercent = 1.0 - maxTalkDamage/100.0
	elseIf need==4 ; Bath
		maxPercent = 1.0 - maxBathDamage/100.0
	elseIf need==5 ; Pray
		maxPercent = 1.0 - maxPrayDamage/100.0
	elseIf need==6 ; Piss
		maxPercent = 1.0 - maxPissDamage/100.0
	elseIf need==7 ; Poop
		maxPercent = 1.0 - maxPoopDamage/100.0
	elseIf need==8 ; Sex
		maxPercent = 1.0 - maxSexDamage/100.0
	elseIf need==9 ; Skooma
		maxPercent = 1.0 - maxSkoomaDamage/100.0
	elseIf need==10 ; Alcohol
		maxPercent = 1.0 - maxAlcoholDamage/100.0
	elseIf need==11 ; Weed
		maxPercent = 1.0 - maxWeedDamage/100.0
	elseIf need==12 ; Drunk
		maxPercent = 1.0 - maxDrunkDamage/100.0
	endIf

	int damage = getDamageValue(need, 0) ; Magicka OK
	if damage
		addRemoveEffect(applyStep!=0 && damage<=applyStep, "Magicka", maxPercent, mndDamageMagicka, mndDamageMagickaME, 1, 0)
	endIf
	damage = getDamageValue(need, 1) ; Magicka rate OK
	if damage
		addRemoveEffect(applyStep!=0 && damage<=applyStep, "MagickaRateMult", maxPercent, mndDamageMagickaRate, mndDamageMagickaRateME, 2, 5, true)
	endIf
	damage = getDamageValue(need, 2) ; Health OK
	if damage
		addRemoveEffect(applyStep!=0 && damage<=applyStep, "Health", maxPercent, mndDamageHealth, mndDamageHealthME, 1, 0)
	endIf
	damage = getDamageValue(need, 3) ; Health rate OK
	if damage
		addRemoveEffect(applyStep!=0 && damage<=applyStep, "HealRateMult", maxPercent, mndDamageHealthRate, mndDamageHealthRateME, 2, 5, true)
	endIf
	damage = getDamageValue(need, 4) ; Stamina OK
	if damage
		addRemoveEffect(applyStep!=0 && damage<=applyStep, "Stamina", maxPercent, mndDamageStamina, mndDamageStaminaME, 1, 0)
	endIf
	damage = getDamageValue(need, 5) ; Stamina rate OK
	if damage
		addRemoveEffect(applyStep!=0 && damage<=applyStep, "StaminaRateMult", maxPercent, mndDamageStaminaRate, mndDamageStaminaRateME, 2, 5, true)
	endIf
	damage = getDamageValue(need, 6) ; Reduce Speed OK
	if damage
		if addRemoveEffect(applyStep!=0 && damage<=applyStep, "SpeedMult", maxPercent, mndDamageSpeed, mndDamageSpeedME, 2, 1, true)
			PlayerRef.AddItem(mndInvisibleWeight, 1, true)
			PlayerRef.removeItem(mndInvisibleWeight, 1, true)
		endIf
	endIf
	damage = getDamageValue(need, 7) ; Random Speed OK
	if damage
		float alteredSpeedAmount = Utility.randomFloat(3, 200)
		lastAlterSpeedPositive = !lastAlterSpeedPositive
		if lastAlterSpeedPositive
			alteredSpeedAmount = -alteredSpeedAmount
		endIf
		increaseDecreaseSpeed(applyStep!=0, alteredSpeedAmount)
	endIf
	damage = getDamageValue(need, 8) ; Weapons Speed OK
	if damage
		addRemoveEffect(applyStep!=0 && damage<=applyStep, "WeaponSpeedMult", maxPercent, mndDamageWeaponsSpeed, mndDamageWeaponsSpeedME, 1, 1, true)
	endIf
	damage = getDamageValue(need, 9) ; Weapons Damage
	if damage
		addRemoveEffect(applyStep!=0 && damage<=applyStep, "MeleeDamage", maxPercent, mndDamageWeaponsDamage, mndDamageWeaponsDamageME, 1, 1, true)
	endIf
	damage = getDamageValue(need, 10) ; Remove Weapons OK
	if damage && damage<=applyStep
		if Utility.randomInt(0, 6) < 1 + applyStep - damage
			form item = PlayerRef.GetEquippedObject(1) ; Right hand
			if item
				PlayerRef.UnequipItemEX(item, 1, false)
			endIf
			item = PlayerRef.GetEquippedObject(0) ; Left hand
			if item
				PlayerRef.UnequipItemEX(item, 2, false)
			endIf
			PlayerRef.sheatheWeapon()
		endIf
	endIf
	damage = getDamageValue(need, 11) ; Random Weapons OK
	if damage && damage<=applyStep
		; Have a random probability, higher the step higher the probability
		if Utility.randomInt(0, 10)<applyStep-damage
			equipRandomWeapon(Utility.randomInt(0,1), None) ; Randomly left orright
		endIf
	endIf
	; Random weapon when equipping (12) is done globally
	damage = getDamageValue(need, 13) ; Attack Damage OK
	if damage
		addRemoveEffect(applyStep!=0 && damage<=applyStep, "AttackDamageMult", maxPercent, mndDamageAttackDamage, mndDamageAttackDamageME, 1, 0.01, true)
	endIf
	damage = getDamageValue(need, 14) ; Carry Weight OK
	if damage
		if addRemoveEffect(applyStep!=0 && damage<=applyStep, "CarryWeight", maxPercent, mndDamageCarryWeight, mndDamageCarryWeightME, 1, 5, true)
			PlayerRef.AddItem(mndInvisibleWeight, 1, true)
			PlayerRef.removeItem(mndInvisibleWeight, 1, true)
		endIf
	endIf
	damage = getDamageValue(need, 15) ; Alchemy OK
	if damage
		addRemoveEffect(applyStep!=0 && damage<=applyStep, "AlchemyPowerMod", maxPercent, mndDamageAlchemy, mndDamageAlchemyME, 0, 0.01, true)
	endIf
	damage = getDamageValue(need, 16) ; Spell Illusion OK
	if damage
		addRemoveEffect(applyStep!=0 && damage<=applyStep, "IllusionPowerMod", maxPercent, mndDamageSpellsIllusion, mndDamageSpellsIllusionME, 4, 5, true)
	endIf
	damage = getDamageValue(need, 17) ; Spell Conjuration OK
	if damage
		addRemoveEffect(applyStep!=0 && damage<=applyStep, "ConjurationPowerMod", maxPercent, mndDamageSpellsConjuration, mndDamageSpellsConjurationME, 4, 5, true)
	endIf
	damage = getDamageValue(need, 18) ; Spell Destruction OK
	if damage
		addRemoveEffect(applyStep!=0 && damage<=applyStep, "DestructionPowerMod", maxPercent, mndDamageSpellsDestruction, mndDamageSpellsDestructionME, 4, 5, true)
	endIf
	damage = getDamageValue(need, 19) ; Spell Restoration OK
	if damage
		addRemoveEffect(applyStep!=0 && damage<=applyStep, "RestorationPowerMod", maxPercent, mndDamageSpellsRestoration, mndDamageSpellsRestorationME, 4, 5, true)
	endIf
	damage = getDamageValue(need, 20) ; Spell Alteration OK
	if damage
		addRemoveEffect(applyStep!=0 && damage<=applyStep, "AlterationPowerMod", maxPercent, mndDamageSpellsAlteration, mndDamageSpellsAlterationME, 4, 5, true)
	endIf
	damage = getDamageValue(need, 21) ; Enchanting OK
	if damage
		addRemoveEffect(applyStep!=0 && damage<=applyStep, "EnchantingPowerMod", maxPercent, mndDamageEnchanting, mndDamageEnchantingME, 0, 0.01, true)
	endIf
	damage = getDamageValue(need, 22) ; Light Armor OK
	if damage
		addRemoveEffect(applyStep!=0 && damage<=applyStep, "LightArmor", maxPercent, mndDamageLightArmors, mndDamageLightArmorsME, 1, 0.5, true)
	endIf
	damage = getDamageValue(need, 23) ; Heavy Armor OK
	if damage
		addRemoveEffect(applyStep!=0 && damage<=applyStep, "HeavyArmor", maxPercent, mndDamageHeavyArmors, mndDamageHeavyArmorsME, 1, 2.0, true)
	endIf
	damage = getDamageValue(need, 24) ; Sneak OK
	if damage
		addRemoveEffect(applyStep!=0 && damage<=applyStep, "SneakPowerMod", maxPercent, mndDamageSneak, mndDamageSneakME, 0, 0.01, true)
	endIf
	damage = getDamageValue(need, 25) ; Increase Sneak
	if damage
		addRemoveEffect(applyStep!=0 && damage<=applyStep, "SneakPowerMod", maxPercent, mndDamageIncreaseSneak, mndDamageIncreaseSneakME, 0, 0.01, true)
	endIf
	damage = getDamageValue(need, 26) ; LockPicking OK
	if damage
		addRemoveEffect(applyStep!=0 && damage<=applyStep, "LockPickingPowerMod", maxPercent, mndDamageLockPicking, mndDamageLockPickingME, 0, 0.01, true)
	endIf
	damage = getDamageValue(need, 27) ; Increase LockPicking
	if damage
		addRemoveEffect(applyStep!=0 && damage<=applyStep, "LockPickingPowerMod", maxPercent, mndDamageIncreaseLockPicking, mndDamageIncreaseLockPickingME, 0, 0.01, true)
	endIf
	damage = getDamageValue(need, 28) ; PickPocket OK
	if damage
		addRemoveEffect(applyStep!=0 && damage<=applyStep, "PickPocketPowerMod", maxPercent, mndDamagePickPocket, mndDamagePickPocketME, 0, 0.01, true)
	endIf
	damage = getDamageValue(need, 29) ; Increase PickPocket
	if damage
		addRemoveEffect(applyStep!=0 && damage<=applyStep, "PickPocketPowerMod", maxPercent, mndDamageIncreasePickPocket, mndDamageIncreasePickPocketME, 0, 0.01, true)
	endIf
	damage = getDamageValue(need, 30) ; Speech craft OK
	if damage
		addRemoveEffect(applyStep!=0 && damage<=applyStep, "SpeechcraftPowerMod", maxPercent, mndDamageSpeech, mndDamageSpeechME, 0, 0.01, true)
	endIf
	damage = getDamageValue(need, 31) ; Blocking OK
	if damage
		addRemoveEffect(applyStep!=0 && damage<=applyStep, "BlockPowerMod", maxPercent, mndDamageBlocking, mndDamageBlockingME, 0, 0.01, true)
	endIf

	; Dirt ----------------------------------------------------------------------------- 32 33
	; Check if we have SexLab, the option is checked and the actor has cum
	bool doIt = true
	if weHaveSexLab && noDirtShaderWhileCum && mndSLDelegate.CountCum()>0
		doIt = false
	endIf
	damage = getDamageValue(need, 32) ; Dirt OK
	if damage && damage<=applyStep
		if doIt && damage==applyStep && dirtShaderApplied<2
			dirtShaderToApply=1
		elseIf doIt && damage<applyStep && dirtShaderApplied<3
			dirtShaderToApply=2
		else
			dirtShaderToApply=0
		endIf
	endIf
	damage = getDamageValue(need, 33) ; More Dirt OK
	if damage && damage<=applyStep
		if doIt && damage==applyStep && dirtShaderApplied<4
			dirtShaderToApply=3
		elseIf doIt && damage<applyStep
			dirtShaderToApply=4
		elseIf dirtShaderToApply>2
			dirtShaderToApply=0
		endIf
	endIf
	if dirtShaderToApply!=dirtShaderApplied
		if dirtShaderToApply==1
			mndDirtShader1.Play(PlayerRef)
		endIf
		if dirtShaderToApply==2
			mndDirtShader2.Play(PlayerRef)
		endIf
		if dirtShaderToApply==3
			mndDirtShader3.Play(PlayerRef)
		endIf
		if dirtShaderToApply==4
			mndDirtShader4.Play(PlayerRef)
		endIf
		if dirtShaderApplied==1
			mndDirtShader1.Stop(PlayerRef)
		endIf
		if dirtShaderApplied==2
			mndDirtShader2.Stop(PlayerRef)
		endIf
		if dirtShaderApplied==3
			mndDirtShader3.Stop(PlayerRef)
		endIf
		if dirtShaderApplied==4
			mndDirtShader4.Stop(PlayerRef)
		endIf
		dirtShaderApplied = dirtShaderToApply
	endIf

	; Reduce and Increase Tits (34 and 35) are done globally
	; Reduce and Increase Belly (36 and 37) are done globally
	; Reduce and Increase Weight (38 and 39) are done globally
	; Pick another alcohol (40) is done globally

	damage = getDamageValue(need, 41) ; Diarrhea OK
	if damage && damage<=applyStep
		if Utility.randomInt(0,3)==0
			applyDiarrhea()
		endIf
	endIf
	damage = getDamageValue(need, 42) ; Horny pose OK
	if damage && damage<=applyStep
		if Utility.randomInt(0, 5)<applyStep-damage && !PlayerIsAnimating()
			debug.SendAnimationEvent(PlayerRef, "mndHorny")
		endIf
	endIf
	damage = getDamageValue(need, 43) ; Masturbate OK
	if damage && damage<=applyStep && weHaveSexLab && !PlayerIsAnimating()
		doMasturbation()
	endIf
	damage = getDamageValue(need, 44) ; Collapse OK
	if damage && damage<=applyStep
		if Utility.randomInt(0,3)==0
			collapse()
		endIf
	endIf

	; ImageSpaceModifiers ---------------------------------------------------------------- 45, 46, 47, 48, 49
	int ismIndex = appliedISM
	damage = getDamageValue(need, 45) ; LowContrast1 OK
	if damage && damage<=applyStep
		ismIndex = Math.logicalOr(ismIndex, 1)
	endIf
	damage = getDamageValue(need, 46) ; ismBlurry1 OK
	if damage && damage<=applyStep
		ismIndex = Math.logicalOr(ismIndex, 16)
	endIf
	damage = getDamageValue(need, 47) ; ismBlurry2 OK
	if damage && damage<=applyStep
		ismIndex = Math.logicalOr(ismIndex, 8)
	endIf
	damage = getDamageValue(need, 48) ; ismDistorted1 OK
	if damage && damage<=applyStep
		ismIndex = Math.logicalOr(ismIndex, 4)
	endIf
	damage = getDamageValue(need, 49) ; ismDistorted2 OK
	if damage && damage<=applyStep
		ismIndex = Math.logicalOr(ismIndex, 2)
	endIf
	if ismIndex==0
		if currentISM
			currentISM.Remove()
			currentISM = none
		endIf
	else
		if currentISM!=mndISMs[ismIndex]
			mndISMs[ismIndex].ApplyCrossFade(2.0)
			currentISM = mndISMs[ismIndex]
		endIf
		appliedISM = ismIndex
	endIf

endFunction

; ((- List of Penalties 
; 0	Magicka
; 1	Magicka Restoration
; 2	Health
; 3	Health Restoration
; 4	Stamina
; 5	Stamina Restoration
; 6	Reduce Speed
; 7	Random Speed
; 8	Weapons Speed
; 9	Weapons Damage
; 10	Remove Weapon
; 11	Random Weapon
; 12	Random Weapon Equipping
; 13	AttackDamage
; 14	Carry Weight
; 15	Reduce Alchemy
; 16	Spells Illusion
; 17	Spells Conjuration
; 18	Spells Destruction
; 19	SpellsRestoration
; 20	Spell sAlteration
; 21	Enchanting
; 22	Light Armors
; 23	Heavy Armors
; 24	Reduce Sneak
; 25	Increase Sneak
; 26	Reduce LockPicking
; 27	Increase LockPicking
; 28	Reduce PickPocket
; 29	Increase PickPocket
; 30	Reduce Speech
; 31	Reduce Blocking
; 32	Apply Dirt
; 33	Apply more Dirt
; 34	Reduce Tits
; 35	Increase Tits
; 36	Reduce Belly
; 37	Increase Belly
; 38	Reduce Weight
; 39	Increase Weight
; 40	Drink again Alcohol
; 41	Diarrhea
; 42	Horny Pose
; 43	Masturbate
; 44	Collapse
; 45	Vision LowContrast1
; 46	Vision Blurry1
; 47	Vision Blurry2
; 48	Vision Distorted1
; 49	Vision Distorted2
; -))

; returns: 0="No", 1="[I--]", 2="[-I-]", 3="[--I]", 4="[---][I--]", 5="[---][-I-]", 6="[---][--I]", 7=not used
int function getDamageValue(int need, int penalty)
	if penalty<10
		return Math.LogicalAnd(Math.RightShift(penalties0[need], penalty*3), 0x7)
	elseIf penalty<20
		return Math.LogicalAnd(Math.RightShift(penalties1[need], (penalty - 10)*3), 0x7)
	elseIf penalty<30
		return Math.LogicalAnd(Math.RightShift(penalties2[need], (penalty - 20)*3), 0x7)
	elseIf penalty<40
		return Math.LogicalAnd(Math.RightShift(penalties3[need], (penalty - 30)*3), 0x7)
	elseIf penalty<50
		return Math.LogicalAnd(Math.RightShift(penalties4[need], (penalty - 40)*3), 0x7)
	endIf
	return 0
endFunction

function setDamageValue(int need, int penalty, int value)
	if penalty<10
		int mask = 0xffffffff - Math.LeftShift(0x7, penalty*3)
		penalties0[need] = Math.LogicalAnd(penalties0[need], mask)
		penalties0[need] = Math.LogicalOr(penalties0[need], Math.LeftShift(value, penalty*3))
	elseIf penalty<20
		int mask = 0xffffffff - Math.LeftShift(0x7, (penalty - 10)*3)
		penalties1[need] = Math.LogicalAnd(penalties1[need], mask)
		penalties1[need] = Math.LogicalOr(penalties1[need], Math.LeftShift(value, (penalty - 10)*3))
	elseIf penalty<30
		int mask = 0xffffffff - Math.LeftShift(0x7, (penalty - 20)*3)
		penalties2[need] = Math.LogicalAnd(penalties2[need], mask)
		penalties2[need] = Math.LogicalOr(penalties2[need], Math.LeftShift(value, (penalty - 20)*3))
	elseIf penalty<40
		int mask = 0xffffffff - Math.LeftShift(0x7, (penalty - 30)*3)
		penalties3[need] = Math.LogicalAnd(penalties3[need], mask)
		penalties3[need] = Math.LogicalOr(penalties3[need], Math.LeftShift(value, (penalty - 30)*3))
	elseIf penalty<50
		int mask = 0xffffffff - Math.LeftShift(0x7, (penalty - 40)*3)
		penalties4[need] = Math.LogicalAnd(penalties4[need], mask)
		penalties4[need] = Math.LogicalOr(penalties4[need], Math.LeftShift(value, (penalty - 40)*3))
	endIf
endFunction

; usePercent: 0=direct value; 1=use percent, 2=direct*100, 3=percent*100
; modifyMagnitude: 0=no, other values are the number to be added to the effect magnitude
bool function addRemoveEffect(bool applyIt, string value, float maxPercent, Spell sp, MagicEffect me, int usePercent, float modifyMagnitude, bool dontRemove=false)
	float av = 1.0
	if usePercent==0
		av = PlayerRef.GetActorValue(value)
	elseIf usePercent==1
		av = PlayerRef.GetActorValuePercentage(value)
	elseIf usePercent==2
		av = PlayerRef.GetActorValue(value)/100.0
	elseIf usePercent==3
		av = PlayerRef.GetActorValuePercentage(value)/100.0
	elseIf usePercent==4 ; The AV cannot be get from the game, calculate it using the actual effect magnitude
		av = 1.0 - sp.GetNthEffectMagnitude(0)/100.0
		if av==1.0
			PlayerRef.SetActorValue(value, 1.0)
		endIf
	endIf
	
	if av==0.0 && applyIt
		PlayerRef.SetActorValue(value, 1.0)
		av=1.0
	endIf
	if !applyIt
		if PlayerRef.hasMagicEffect(me)
			PlayerRef.removeSpell(sp)
			if modifyMagnitude!=0.0
				sp.SetNthEffectMagnitude(0, 0.0)
				if usePercent==5
					sp.SetNthEffectArea(0, 0)
				endIf
			endIf
			return true
		endIf
	elseIf av <= maxPercent && !dontRemove
		if PlayerRef.hasMagicEffect(me)
			PlayerRef.removeSpell(sp)
			if modifyMagnitude!=0.0
				sp.SetNthEffectMagnitude(0, 0.0)
				if usePercent==5
					sp.SetNthEffectArea(0, 0)
				endIf
			endIf
			return true
		endIf
	elseIf applyIt && av > maxPercent
		bool modified = false
		if modifyMagnitude!=0.0
			sp.SetNthEffectMagnitude(0, sp.GetNthEffectMagnitude(0) + modifyMagnitude)
			PlayerRef.removeSpell(sp)
			PlayerRef.addSpell(sp, false)
			modified = true
		elseIf !PlayerRef.hasMagicEffect(me)
			PlayerRef.addSpell(sp, false)
			modified = true
		endIf
		return modified
	endIf
	return false
endFunction


; -))

; ((- Application of penalties

function removeAllDiseases()
	PlayerRef.removeSpell(mndDamageHealth)
	PlayerRef.removeSpell(mndDamageHealthRate)
	PlayerRef.removeSpell(mndDamageStamina)
	PlayerRef.removeSpell(mndDamageStaminaRate)
	PlayerRef.removeSpell(mndDamageMagicka)
	PlayerRef.removeSpell(mndDamageMagickaRate)
	PlayerRef.removeSpell(mndDamageSpeed)
	PlayerRef.removeSpell(mndDamageCarryWeight)
	PlayerRef.removeSpell(mndDamageLightArmors)
	PlayerRef.removeSpell(mndDamageHeavyArmors)
	PlayerRef.removeSpell(mndDamageSpeech)
	PlayerRef.removeSpell(mndDamageSneak)
	PlayerRef.removeSpell(mndDamagePickPocket)
	PlayerRef.removeSpell(mndDamageLockPicking)
	PlayerRef.removeSpell(mndDamageEnchanting)
	PlayerRef.removeSpell(mndDamageAlchemy)
	PlayerRef.removeSpell(mndDamageSpellsAlteration)
	PlayerRef.removeSpell(mndDamageSpellsConjuration)
	PlayerRef.removeSpell(mndDamageSpellsDestruction)
	PlayerRef.removeSpell(mndDamageSpellsIllusion)
	PlayerRef.removeSpell(mndDamageSpellsRestoration)
	PlayerRef.removeSpell(mndDamageWeaponsSpeed)
	PlayerRef.removeSpell(mndDamageWeaponsDamage)
	PlayerRef.removeSpell(mndDamageAttackDamage)
	PlayerRef.removeSpell(mndDamageBlocking)
	PlayerRef.removeSpell(mndDamageIncreaseSpeed)
	PlayerRef.removeSpell(mndDamageIncreaseSneak)
	PlayerRef.removeSpell(mndDamageIncreaseLockPicking)
	PlayerRef.removeSpell(mndDamageIncreasePickPocket)
	
	damageW = 0
	damageRndW = 0
	damageAlch = 0
	damageT = 0
	damageB = 0
	removeISMs()
	resizeTits(0)
	resizeBelly(0)
	PlayerRef.addItem(mndInvisibleWeight, 1, true)
	PlayerRef.removeItem(mndInvisibleWeight, 1, true)
endFunction

function increaseDecreaseSpeed(bool applyIt, float amount)
	if !applyIt
		bool changed = false
		if PlayerRef.hasMagicEffect(mndDamageIncreaseSpeedME)
			PlayerRef.removeSpell(mndDamageIncreaseSpeed)
			changed=true
		endIf
		if PlayerRef.hasMagicEffect(mndDamageSpeedME)
			PlayerRef.removeSpell(mndDamageSpeed)
			changed=true
		endIf
		if changed
			PlayerRef.AddItem(mndInvisibleWeight, 1, true)
			PlayerRef.removeItem(mndInvisibleWeight, 1, true)
		endIf
	else
		if amount<0
			mndDamageSpeed.SetNthEffectMagnitude(0, -amount)
			PlayerRef.removeSpell(mndDamageSpeed)
			PlayerRef.addSpell(mndDamageSpeed, false)
			PlayerRef.AddItem(mndInvisibleWeight, 1, true)
			PlayerRef.removeItem(mndInvisibleWeight, 1, true)
		else
			mndDamageIncreaseSpeed.SetNthEffectMagnitude(0, amount)
			PlayerRef.removeSpell(mndDamageIncreaseSpeed)
			PlayerRef.addSpell(mndDamageIncreaseSpeed, false)
			PlayerRef.AddItem(mndInvisibleWeight, 1, true)
			PlayerRef.removeItem(mndInvisibleWeight, 1, true)
		endIf
	endIf
endFunction

; 0=left, 1=right
function equipRandomWeapon(int hand, Form akBaseObject)
	int equipType = PlayerRef.GetEquippedItemType(hand)
	bool good = equipType>0 && equipType<9
	if akBaseObject as Weapon
		good = true
	endIf
	
	if good ; is a weapon
		form item = PlayerRef.GetEquippedObject(hand)
		Weapon w
		int numWeapons = 0
		int num = PlayerRef.GetNumItems()
		while num
			num-=1
			w = PlayerRef.GetNthForm(num) as Weapon
			if w && w!=item
				weapons[numWeapons] = w
				numWeapons+=1
			endIf
			if numWeapons==weapons.length
				num=0
			endIf
		endWhile
		if numWeapons>0
			PlayerRef.UnequipItemEX(item, 2 - hand, false)
			PlayerRef.EquipItemEx(weapons[Utility.randomInt(0, numWeapons - 1)], 2 - hand, false, false)
		endIf
	endIf
	if grabRandomWeapon<0
		grabRandomWeapon = - grabRandomWeapon
	endIf
endFunction

function resizeTits(float amount)
	if amount!=0
		if !titsModified
			; Save the original values
			titsModified = true
			origWbm = NetImmerse.GetNodeScale(PlayerRef, "Breast", false)
			origWpu = NetImmerse.GetNodeScale(PlayerRef, "CME L PreBreastRoot", false)
			origWvo = NetImmerse.GetNodeScale(PlayerRef, "NPC L PreBreast", false)
			origWbv = NetImmerse.GetNodeScale(PlayerRef, "CME L PreBreast", false)
			origWro = NetImmerse.GetNodeScale(PlayerRef, "NPC L Breast", false)
			origWpe = NetImmerse.GetNodeScale(PlayerRef, "CME L Breast", false)
			origWpf = NetImmerse.GetNodeScale(PlayerRef, "NPC L Breast01", false)
		endIf
		if amount<0.0
			amount = - amount
			doNodeUpdate( "Breast", "", calculateScaleValue(origWbm, 0.7, amount))
			doNodeUpdate( "CME R PreBreastRoot", "CME L PreBreastRoot", calculateScaleValue(origWpu, 0.5, amount))
			doNodeUpdate( "NPC R PreBreast", "NPC L PreBreast", calculateScaleValue(origWvo, 0.6, amount))
			doNodeUpdate( "CME R PreBreast", "CME L PreBreast", calculateScaleValue(origWbv, 0.7, amount))
			doNodeUpdate( "NPC R Breast", "NPC L Breast", calculateScaleValue(origWro, 0.6, amount))
			doNodeUpdate( "CME R Breast", "CME L Breast", calculateScaleValue(origWpe, 0.5, amount))
			doNodeUpdate( "NPC R Breast01", "NPC L Breast01", calculateScaleValue(origWpf, 0.4, amount))
		else
			doNodeUpdate( "Breast", "", calculateScaleValue(origWbm, 1.1, amount))
			doNodeUpdate( "CME R PreBreastRoot", "CME L PreBreastRoot", calculateScaleValue(origWpu, 1.3, amount))
			doNodeUpdate( "NPC R PreBreast", "NPC L PreBreast", calculateScaleValue(origWvo, 1.2, amount))
			doNodeUpdate( "CME R PreBreast", "CME L PreBreast", calculateScaleValue(origWbv, 1.1, amount))
			doNodeUpdate( "NPC R Breast", "NPC L Breast", calculateScaleValue(origWro, 1.2, amount))
			doNodeUpdate( "CME R Breast", "CME L Breast", calculateScaleValue(origWpe, 1.3, amount))
			doNodeUpdate( "NPC R Breast01", "NPC L Breast01", calculateScaleValue(origWpf, 1.4, amount))
		endIf
	else
		if titsModified
			titsModified=false
			doNodeUpdate( "Breast", "", origWbm)
			doNodeUpdate( "CME R PreBreastRoot", "CME L PreBreastRoot", origWpu)
			doNodeUpdate( "NPC R PreBreast", "NPC L PreBreast", origWvo)
			doNodeUpdate( "CME R PreBreast", "CME L PreBreast", origWbv)
			doNodeUpdate( "NPC R Breast", "NPC L Breast", origWro)
			doNodeUpdate( "CME R Breast", "CME L Breast", origWpe)
			doNodeUpdate( "NPC R Breast01", "NPC L Breast01", origWpf)
		endIf
	endIf
endFunction

function resizeBelly(float amount)
	if amount!=0
		if !bellyModified
			; Save the original values
			bellyModified = true
			origWbelly = NetImmerse.GetNodeScale(PlayerRef, "NPC Belly", false)
		endIf
		if amount<0.0
			amount = - amount
			doNodeUpdate( "NPC Belly", "", calculateScaleValue(origWbelly, 0.9, amount))
		else
			doNodeUpdate( "NPC Belly", "", calculateScaleValue(origWbelly, 7.5, amount))
		endIf
	else
		if bellyModified
			bellyModified=false
			doNodeUpdate( "NPC Belly", "", origWbelly)
		endIf
	endIf
endFunction

Float Function calculateScaleValue(Float orig, Float destScale, Float perc)
	return (orig*destScale - orig)/10.0 * perc + orig
EndFunction

function doNodeUpdate(string node1, string node2, float val)
	NetImmerse.SetNodeScale(PlayerRef, node1, val, false)
	NetImmerse.SetNodeScale(PlayerRef, node1, val, true)
	if node2
		NetImmerse.SetNodeScale(PlayerRef, node2, val, false)
		NetImmerse.SetNodeScale(PlayerRef, node2, val, true)
	endIf
EndFunction

function applyWeightVariation()
	if damageW!=0
		float weight = PlayerRef.getActorBase().getWeight()
		if originalWeight==-1.0
			originalWeight = weight
		endIf
		if weight + damageW < 2
			damageW = -1
		elseIf weight + damageW > 99
			damageW = 1
		endIf
		if !PlayerRef.isSwimming() && !PlayerRef.isOnMount()
			float neckDelta = (originalWeight / 100.0) - (damageW/ 100.0) ;Work out the neckdelta.
			PlayerRef.getActorBase().SetWeight(weight + damageW)
			PlayerRef.UpdateWeight(neckDelta) ;Apply the changes.
		endIf
	else
		float weight = PlayerRef.getActorBase().getWeight()
		if originalWeight!=-1.0 && originalWeight!=weight
			if !PlayerRef.isSwimming() && !PlayerRef.isOnMount()
				float neckDelta = (weight / 100.0) - (originalWeight / 100.0) ;Work out the neckdelta.
				PlayerRef.getActorBase().SetWeight(weight)
				PlayerRef.UpdateWeight(neckDelta) ;Apply the changes.
				originalWeight = -1.0
			endIf
		endIf
	endIf
endFunction

event ApplyPenalty(int id)
	Utility.wait(1.0)
	; 0	Magicka
	if id==0
		addRemoveEffect(true, "Magicka", 90.0, mndDamageMagicka, mndDamageMagickaME, 1, 0)
	endIf
	; 1	Magicka Restoration
	if id==1
		addRemoveEffect(true, "MagickaRateMult", 90.0, mndDamageMagickaRate, mndDamageMagickaRateME, 2, 5, true)
	endIf
	; 2	Health
	if id==2
		addRemoveEffect(true, "Health", 90.0, mndDamageHealth, mndDamageHealthME, 1, 0)
	endIf
	; 3	Health Restoration
	if id==3
		addRemoveEffect(true, "HealRateMult", 90.0, mndDamageHealthRate, mndDamageHealthRateME, 2, 5, true)
	endIf
	; 4	Stamina
	if id==4
		addRemoveEffect(true, "Stamina", 90.0, mndDamageStamina, mndDamageStaminaME, 1, 0)
	endIf
	; 5	Stamina Restoration
	if id==5
		addRemoveEffect(true, "StaminaRateMult", 90.0, mndDamageStaminaRate, mndDamageStaminaRateME, 2, 5, true)
	endIf
	; 6	Reduce Speed
	if id==6
		addRemoveEffect(true, "SpeedMult", 90.0, mndDamageSpeed, mndDamageSpeedME, 2, 1, true)
		PlayerRef.AddItem(mndInvisibleWeight, 1, true)
		PlayerRef.removeItem(mndInvisibleWeight, 1, true)
	endIf
	; 7	Random Speed
	if id==7
		float alteredSpeedAmount = Utility.randomFloat(3, 200)
		lastAlterSpeedPositive = !lastAlterSpeedPositive
		if lastAlterSpeedPositive
			alteredSpeedAmount = -alteredSpeedAmount
		endIf
		increaseDecreaseSpeed(true, alteredSpeedAmount)
	endIf
	; 8	Weapons Speed
	if id==8
		addRemoveEffect(true, "WeaponSpeedMult", 90.0, mndDamageWeaponsSpeed, mndDamageWeaponsSpeedME, 1, 1, true)
	endIf
	; 9	Weapons Damage
	if id==9
		addRemoveEffect(true, "MeleeDamage", 90.0, mndDamageWeaponsDamage, mndDamageWeaponsDamageME, 1, 1, true)
	endIf
	; 10	Remove Weapon
	if id==10
		form item = PlayerRef.GetEquippedObject(1) ; Right hand
		if item
			PlayerRef.UnequipItemEX(item, 1, false)
		endIf
		item = PlayerRef.GetEquippedObject(0) ; Left hand
		if item
			PlayerRef.UnequipItemEX(item, 2, false)
		endIf
		PlayerRef.sheatheWeapon()
	endIf
	; 11	Random Weapon
	if id==11
		equipRandomWeapon(Utility.randomInt(0,1), None) ; Randomly left orright
	endIf
	; 12	Random Weapon Equipping
	if id==12
		damageRndW+=2
	endIf
	; 13	AttackDamage
	if id==13
		addRemoveEffect(true, "AttackDamageMult", 90.0, mndDamageAttackDamage, mndDamageAttackDamageME, 1, 0.01, true)
	endIf
	; 14	Carry Weight
	if id==14
		addRemoveEffect(true, "CarryWeight", 90.0, mndDamageCarryWeight, mndDamageCarryWeightME, 1, 5, true)
		PlayerRef.AddItem(mndInvisibleWeight, 1, true)
		PlayerRef.removeItem(mndInvisibleWeight, 1, true)
	endIf
	; 15	Reduce Alchemy
	if id==15
		addRemoveEffect(true, "AlchemyPowerMod", 90.0, mndDamageAlchemy, mndDamageAlchemyME, 0, 0.01, true)
	endIf
	; 16	Spells Illusion
	if id==16
		addRemoveEffect(true, "IllusionPowerMod", 90.0, mndDamageSpellsIllusion, mndDamageSpellsIllusionME, 4, 5, true)
	endIf
	; 17	Spells Conjuration
	if id==17
		addRemoveEffect(true, "ConjurationPowerMod", 90.0, mndDamageSpellsConjuration, mndDamageSpellsConjurationME, 4, 5, true)
	endIf
	; 18	Spells Destruction
	if id==18
		addRemoveEffect(true, "DestructionPowerMod", 90.0, mndDamageSpellsDestruction, mndDamageSpellsDestructionME, 4, 5, true)
	endIf
	; 19	SpellsRestoration
	if id==19
		addRemoveEffect(true, "RestorationPowerMod", 90.0, mndDamageSpellsRestoration, mndDamageSpellsRestorationME, 4, 5, true)
	endIf
	; 20	Spell sAlteration
	if id==20
		addRemoveEffect(true, "AlterationPowerMod", 90.0, mndDamageSpellsAlteration, mndDamageSpellsAlterationME, 4, 5, true)
	endIf
	; 21	Enchanting
	if id==21
		addRemoveEffect(true, "EnchantingPowerMod", 90.0, mndDamageEnchanting, mndDamageEnchantingME, 0, 0.01, true)
	endIf
	; 22	Light Armors
	if id==22
		addRemoveEffect(true, "LightArmor", 90.0, mndDamageLightArmors, mndDamageLightArmorsME, 1, 0.5, true)
	endIf
	; 23	Heavy Armors
	if id==23
		addRemoveEffect(true, "HeavyArmor", 90.0, mndDamageHeavyArmors, mndDamageHeavyArmorsME, 1, 2.0, true)
	endIf
	; 24	Reduce Sneak
	if id==24
		addRemoveEffect(true, "SneakPowerMod", 90.0, mndDamageSneak, mndDamageSneakME, 0, 0.01, true)
	endIf
	; 25	Increase Sneak
	if id==25
		addRemoveEffect(true, "SneakPowerMod", 90.0, mndDamageIncreaseSneak, mndDamageIncreaseSneakME, 0, 0.01, true)
	endIf
	; 26	Reduce LockPicking
	if id==26
		addRemoveEffect(true, "LockPickingPowerMod", 90.0, mndDamageLockPicking, mndDamageLockPickingME, 0, 0.01, true)
	endIf
	; 27	Increase LockPicking
	if id==27
		addRemoveEffect(true, "LockPickingPowerMod", 90.0, mndDamageIncreaseLockPicking, mndDamageIncreaseLockPickingME, 0, 0.01, true)
	endIf
	; 28	Reduce PickPocket
	if id==28
		addRemoveEffect(true, "PickPocketPowerMod", 90.0, mndDamagePickPocket, mndDamagePickPocketME, 0, 0.01, true)
	endIf
	; 29	Increase PickPocket
	if id==29
		addRemoveEffect(true, "PickPocketPowerMod", 90.0, mndDamageIncreasePickPocket, mndDamageIncreasePickPocketME, 0, 0.01, true)
	endIf
	; 30	Reduce Speech
	if id==30
		addRemoveEffect(true, "SpeechcraftPowerMod", 90.0, mndDamageSpeech, mndDamageSpeechME, 0, 0.01, true)
	endIf
	; 31	Reduce Blocking
	if id==31
		addRemoveEffect(true, "BlockPowerMod", 90.0, mndDamageBlocking, mndDamageBlockingME, 0, 0.01, true)
	endIf
	; 32	Apply Dirt
	if id==32
		dirtShaderToApply=dirtShaderApplied+1
		if dirtShaderToApply>2
			dirtShaderToApply=2
		endIf
		if dirtShaderToApply==1
			mndDirtShader1.Play(PlayerRef)
		endIf
		if dirtShaderToApply==2
			mndDirtShader2.Play(PlayerRef)
		endIf
		dirtShaderApplied = dirtShaderToApply
	endIf
	; 33	Apply more Dirt
	if id==33
		dirtShaderToApply=dirtShaderApplied+1
		if dirtShaderToApply>4
			dirtShaderToApply=4
		endIf
		if dirtShaderToApply==1
			mndDirtShader1.Play(PlayerRef)
		endIf
		if dirtShaderToApply==2
			mndDirtShader2.Play(PlayerRef)
		endIf
		if dirtShaderToApply==3
			mndDirtShader3.Play(PlayerRef)
		endIf
		if dirtShaderToApply==4
			mndDirtShader4.Play(PlayerRef)
		endIf
		dirtShaderApplied = dirtShaderToApply
	endIf
	; 34	Reduce Tits
	if id==34
		damageT==2
		resizeTits(-2.0)
	endIf
	; 35	Increase Tits
	if id==35
		damageT+=2
		resizeTits(2.0)
	endIf
	; 36	Reduce Belly
	if id==36
		damageB-=2
		resizeBelly(-2.0)
	endIf
	; 37	Increase Belly
	if id==37
		damageB+=2
		resizeBelly(2.0)
	endIf
	; 38	Reduce Weight
	if id==38
		damageW-=2
		applyWeightVariation()
	endIf
	; 39	Increase Weight
	if id==39
		damageW+=2
		applyWeightVariation()
	endIf
	; 40	Drink again Alcohol
	if id==40
		damageAlch+=2
	endIf
	; 41	Diarrhea
	if id==41
		applyDiarrhea()
	endIf
	; 42	Horny Pose
	if id==42
		debug.SendAnimationEvent(PlayerRef, "mndHorny")
	endIf
	; 43	Masturbate
	if id==43
		doMasturbation()
	endIf
	; 44	Collapse
	if id==44
		collapse()
	endIf
	
	
	int ismIndex = appliedISM
	; 45	Vision LowContrast1
	if id==45
		ismIndex = Math.logicalOr(ismIndex, 1)
	endIf
	; 46	Vision Blurry1
	if id==46
		ismIndex = Math.logicalOr(ismIndex, 16)
	endIf
	; 47	Vision Blurry2
	if id==47
		ismIndex = Math.logicalOr(ismIndex, 8)
	endIf
	; 48	Vision Distorted1
	if id==48
		ismIndex = Math.logicalOr(ismIndex, 4)
	endIf
	; 49	Vision Distorted2	
	if id==49
		ismIndex = Math.logicalOr(ismIndex, 2)
	endIf
	if ismIndex==0
		if currentISM
			currentISM.Remove()
			currentISM = none
		endIf
	else
		if currentISM!=mndISMs[ismIndex]
			mndISMs[ismIndex].ApplyCrossFade(2.0)
			currentISM = mndISMs[ismIndex]
		endIf
		appliedISM = ismIndex
	endIf
	


	; Reduce and Increase Tits (34 and 35) are done globally
	; Reduce and Increase Belly (36 and 37) are done globally
	; Reduce and Increase Weight (38 and 39) are done globally
	; Pick another alcohol (40) is done globally


endEvent

; -))
