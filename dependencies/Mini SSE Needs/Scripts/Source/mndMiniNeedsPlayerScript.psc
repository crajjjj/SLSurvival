Scriptname mndMiniNeedsPlayerScript extends ReferenceAlias  


mndController Property mnd Auto

bool ism1 = false
bool ism2 = false
bool initDone = false
Weapon[] weapons
bool removingItemForAlcohol = false


Event OnInit()
	if initDone
		return
	endIf
	initDone = true
	doInit()
endEvent

Event OnPlayerLoadGame()
	Utility.waitMenuMode(3.0)
	if initDone
		return
	endIf
	initDone = true
	doInit()
endEvent



Function doInit()
	if !mnd.VendorItemsInnkeeper.hasForm(mnd.mndVendorItemWater)
		mnd.VendorItemsInnkeeper.addForm(mnd.mndVendorItemWater)
	endIf
	if !mnd.MQ201DrinkList.hasForm(mnd.mndWaterBottleFull)
		mnd.MQ201DrinkList.addForm(mnd.mndWaterBottleFull)
	endIf
	if !mnd.AlcoholicDrinksList.hasForm(mnd.mndWaterBottleFull)
		mnd.AlcoholicDrinksList.addForm(mnd.mndWaterBottleFull)
	endIf
	if !mnd.WineList.hasForm(mnd.mndWaterBottleFull)
		mnd.WineList.addForm(mnd.mndWaterBottleFull)
	endIf
	
	mnd.loadExternalMods()
	
	if mnd.lastTimeEat==0.0
		mnd.lastTimeEat = Math.floor(Utility.GetCurrentGameTime())
	endIf
	if mnd.lastTimeDrink==0.0
		mnd.lastTimeDrink = Math.floor(Utility.GetCurrentGameTime())
	endIf
	if mnd.lastTimeSleep==0.0
		mnd.lastTimeSleep = Math.floor(Utility.GetCurrentGameTime())
	endIf
	if mnd.lastTimeTalk==0.0
		mnd.lastTimeTalk = Math.floor(Utility.GetCurrentGameTime())
	endIf
	if mnd.lastTimePiss==0.0
		mnd.lastTimePiss = Math.floor(Utility.GetCurrentGameTime())
	endIf
	if mnd.lastTimePoop==0.0
		mnd.lastTimePoop = Math.floor(Utility.GetCurrentGameTime())
	endIf
	if mnd.lastTimeSex==0.0 && mnd.weHaveSexLab
		mnd.lastTimeSex = Math.floor(Utility.GetCurrentGameTime())
	endIf
	if mnd.enableDrunk==0.0
		if ((mnd.timeDrunk - Utility.GetCurrentGameTime() + mnd.lastTimeDrunk)/mnd.timeDrunk)<0.01
			mnd.lastTimeDrunk = 0.0
		endIf
	endIf
	if mnd.lastTimeSkooma==0.0
		mnd.lastTimeSkooma = Math.floor(Utility.GetCurrentGameTime())
	endIf
	if mnd.lastTimeAlcohol==0.0
		mnd.lastTimeAlcohol = Math.floor(Utility.GetCurrentGameTime())
	endIf
	if mnd.lastTimeWeed==0.0 && mnd.weHaveWeed
		mnd.lastTimeWeed = Math.floor(Utility.GetCurrentGameTime())
	endIf
	
	if !weapons
		weapons = new Weapon[16]
	endIf
	removingItemForAlcohol = false

	
	if mnd.bathDuration==0.0
		mnd.bathDuration = 30.0
	endIf
	
	mnd.initWidgets()
	mnd.calculateWidgets()
	mnd.applyConfig()
	mnd.Start()
endFunction

Form prevItem = none
int prevCount = 0
float prevTime = 0.0
Event OnItemRemoved(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akDestContainer)
	if UI.IsMenuOpen("Crafting Menu") || (akBaseItem==prevItem && aiItemCount==prevCount && Utility.getCurrentRealTime() - prevTime < 500.0)
		prevItem = none
		prevCount = 0
		return
	endIf
	prevItem = akBaseItem
	prevCount = aiItemCount
	prevTime = Utility.getCurrentRealTime()

	if mnd.disableTheMod
		if !akItemReference && !akDestContainer && akBaseItem==mnd.mndWaterBottleEmpty
			reAddWaterBottleLater()
		endIf
		return
	endIf
	if UI.IsMenuOpen("Crafting Menu") || removingItemForAlcohol
		return
	endIf
	
	if !akItemReference && !akDestContainer
		Potion food = akBaseItem as Potion
		if !food || akBaseItem==mnd.mndInvisibleWeight
			return
		endIf

		if food==mnd.mndWaterBottleFull
			setDrink(akBaseItem)
			reAddWaterBottleLater()
			if mnd.useAnimForDrinking
				SendPlayAnimEvent("mndDrinkW", false)
			endIf
			
		elseIf food==mnd.mndWaterBottleEmpty
			; Check if we have water around, in case fill the bottle
			Cell c = mnd.PlayerRef.getParentCell()
			if c.GetWaterLevel() > mnd.PlayerRef.Z
				mnd.PlayerRef.addItem(mnd.mndWaterBottleFull, 1, false)
			else
				reAddWaterBottleLater()
			endIf

		elseIf mnd.mndBlood.hasForm(food)
			; Add both Eat and Drink but only if player is vampire. If not just drink
			if mnd.isPlayerVampire()
				setEat(akBaseItem)
			endIf
			setDrink(akBaseItem)
			
		elseIf mnd.mndLiquidFoods.hasForm(food)
			; Add both Eat and Drink
			setEat(akBaseItem)
			setDrink(akBaseItem)
			
		elseIf mnd.mndSkooma.hasForm(food)
			setSkooma(akBaseItem)
			
		elseIf mnd.weHaveWeed && mnd.mndWeed.hasForm(food)
			; Add weed
			setWeed(akBaseItem)
		
		elseIf mnd.mndAlcohol.hasForm(food)
			; Add both Drink and Wine and Drunk
			setWine(akBaseItem)
			setDrunk(akBaseItem)
			setDrink(akBaseItem)
			removeAnotherAlcohol()
			
		elseIf mnd.mndDrinks.hasForm(food)
			; Add Drink
			setDrink(akBaseItem)
			
		elseIf mnd.mndFoods.hasForm(food)
			; Add Eat
			setEat(akBaseItem)
		
		elseIf !mnd.mndPreviouslyUnidentified.hasForm(food) && food.isFood() ; Unrecognized
			mnd.mndUnidentified.addForm(food)
			mnd.mndPreviouslyUnidentified.addForm(food)
		endIf
	endIf
	mnd.recalculateBuffs()
endEvent

bool weAreAdding = false
int toBeAdded = 0
function reAddWaterBottleLater()
	if toBeAdded==0
		RegisterForSingleUpdate(1.0)
	endIf
	toBeAdded+=1
endFunction

event OnUpdate()
	int times=0
	while weAreAdding && times<10
		Utility.wait(0.5)
		times+=1
	endWhile
	weAreAdding = true
	mnd.PlayerRef.addItem(mnd.mndWaterBottleEmpty, toBeAdded, true)
	toBeAdded=0
	weAreAdding = false
endEvent

function setEat(Form akBaseItem)
	if mnd.useNutritionValues
		mnd.lastTimeEat += calculateRestorePercentage(akBaseItem)
debug.trace(">> SSX check eat = " + (24.0 * (Utility.GetCurrentGameTime() - mnd.lastTimeEat)/mnd.timeEat))
		if 24.0 * (Utility.GetCurrentGameTime() - mnd.lastTimeEat)/mnd.timeEat > 1.0
			mnd.lastTimeEat = 1/24.0 + Utility.GetCurrentGameTime() - mnd.timeEat/24.0
debug.trace(">> SSX set eat to " + mnd.lastTimeEat)
		endIf
	else
		mnd.lastTimeEat = Utility.GetCurrentGameTime()
	endIf

	if mnd.useAnimForEating
		bool isBread = StringUtil.find(akBaseItem.getName(), "bread")!=-1 || StringUtil.find(akBaseItem.getName(), "flour")!=-1
		bool isMeat = StringUtil.find(akBaseItem.getName(), "meat")!=-1 || StringUtil.find(akBaseItem.getName(), "steak")!=-1 || StringUtil.find(akBaseItem.getName(), "raw")!=-1
		if isBread
			SendPlayAnimEvent("mndEatB", true)
		elseIf isMeat
			SendPlayAnimEvent("mndEatM", true)
		else
			SendPlayAnimEvent("mndEatS", true)
		endIf
	endIf
endFunction

function setDrink(Form akBaseItem)
	if mnd.useNutritionValues
		mnd.lastTimeDrink += calculateRestorePercentage(akBaseItem)
		if 24.0 * (Utility.GetCurrentGameTime() - mnd.lastTimeDrink)/mnd.timeDrink > 1.0
			mnd.lastTimeDrink = 1/24.0 + Utility.GetCurrentGameTime() - mnd.timeDrink/24.0
		endIf
	else
		mnd.lastTimeDrink = Utility.GetCurrentGameTime()
	endIf
	
	if mnd.useAnimForDrinking
		bool isWater = StringUtil.find(akBaseItem.getName(), "water")!=-1 || StringUtil.find(akBaseItem.getName(), "milk")!=-1
		bool isAle = StringUtil.find(akBaseItem.getName(), "ale")!=-1 || StringUtil.find(akBaseItem.getName(), "beer")!=-1
		if isWater
			SendPlayAnimEvent("mndDrinkW", false)
		elseIf isAle
			SendPlayAnimEvent("mndDrinkT", false)
		else
			SendPlayAnimEvent("mndDrinkV", false)
		endIf
	endIf
endFunction

function setSkooma(Form akBaseItem)
	if mnd.useNutritionValues
		float val = calculateRestorePercentage(akBaseItem)
		mnd.lastTimeSkooma += val
	else
		mnd.lastTimeSkooma = Utility.GetCurrentGameTime()
	endIf
	
	if mnd.enableSkooma
		if mnd.useAnimForDrinking
			SendPlayAnimEvent("mndDrinkW", false)
		endIf
	elseIf mnd.enableAlcohol
		setWine(akBaseItem)
	else
		setDrink(akBaseItem)
	endIf
endFunction

function setDrunk(Form akBaseItem)
	if mnd.useNutritionValues
		float val = calculateRestorePercentage(akBaseItem)
		mnd.lastTimeDrunk += val
	else
		mnd.lastTimeDrunk = Utility.GetCurrentGameTime()
	endIf
	
	if mnd.useAnimForDrinking
		SendPlayAnimEvent("mndDrinkV", false)
	endIf
	; No fix of penalties here, when you are drunk you start having penalties. They will be removed by the normal recalculateBuffs()
endFunction

function setWine(Form akBaseItem)
	if mnd.useNutritionValues
		float val = calculateRestorePercentage(akBaseItem)
		mnd.lastTimeAlcohol += val
		mnd.lastTimeDrink += val
	else
		mnd.lastTimeAlcohol = Utility.GetCurrentGameTime()
		mnd.lastTimeDrink = Utility.GetCurrentGameTime()
	endIf
	
	if mnd.useAnimForDrinking
		SendPlayAnimEvent("mndDrinkV", false)
	endIf
endFunction

function removeAnotherAlcohol()
	if mnd.drinkAnotherAlcohol>0
		mnd.drinkAnotherAlcohol=-1
		if Utility.randomInt(0, 6) > mnd.drinkAnotherAlcohol
			; get an item that is in the formList for alcohol and remove it after a second
			int rnd = Utility.randomInt(0, mnd.PlayerRef.GetNumItems())
			int num = rnd
			while num
				num-=1
				Form item = mnd.PlayerRef.GetNthForm(num)
				if mnd.mndAlcohol.hasForm(item)
					; drink it
					Utility.wait(Utility.randomFloat(1.0, 3.0))
					removingItemForAlcohol = true
					mnd.PlayerRef.removeItem(item, 1, true)
					Utility.wait(0.5)
					removingItemForAlcohol = true
					return
				endIf
			endWhile
			num = mnd.PlayerRef.GetNumItems()
			while num>=rnd
				num-=1
				Form item = mnd.PlayerRef.GetNthForm(num)
				if mnd.mndAlcohol.hasForm(item)
					; drink it
					Utility.wait(Utility.randomFloat(1.0, 3.0))
					removingItemForAlcohol = true
					mnd.PlayerRef.removeItem(item, 1, true)
					Utility.wait(0.5)
					removingItemForAlcohol = true
					return
				endIf
			endWhile
		endIf
	endIf
endFunction

function setWeed(Form akBaseItem)
	if mnd.useNutritionValues
		mnd.lastTimeWeed += calculateRestorePercentage(akBaseItem)
	else
		mnd.lastTimeWeed = Utility.GetCurrentGameTime()
	endIf
endFunction


float function calculateRestorePercentage(Form akBaseItem)
	Potion p = akBaseItem as Potion
	if !p
		return 0.0
	endIf

	float now = Utility.GetCurrentGameTime()
	float maxM = 0.0
	float maxD = 0.0
	float val
	int i = p.GetNumEffects()
	while i
		i-=1
		val = p.GetNthEffectMagnitude(i)
		if maxM<val
			maxM=val
		endIf
		val = p.GetNthEffectDuration(i)
		if maxD<val
			maxD=val
		endIf
	endWhile
	if maxM<1 && maxD>0
		maxM = maxD
	endIf
	if maxM > 20.0
		maxM = 20.0
	endIf
	if maxM < 3.0
		maxM = 3.0
	endIf
	
	return (1.0 + Math.sqrt(maxM))/(12.0*mnd.useNutritionValues)
endFunction


Event OnSleepStop(bool abInterrupted)
	if mnd.disableTheMod
		return
	endIf
	mnd.lastTimeSleep = Utility.GetCurrentGameTime()
	mnd.recalculateBuffs()
endEvent

Event OnUpdateGameTime()
	if mnd.disableTheMod
		return
	endIf
	mnd.recalculateBuffs()
	RegisterForSingleUpdateGameTime(0.05)
EndEvent

Event OnKeyUp(int k, float time)
	if UI.IsTextInputEnabled() || UI.IsMenuOpen("InventoryMenu") || UI.IsMenuOpen("Console") || UI.IsMenuOpen("Dialogue Menu") || UI.IsMenuOpen("Main Menu") || UI.IsMenuOpen("MessageBoxMenu") || UI.IsMenuOpen("Cursor Menu") || UI.IsMenuOpen("Fader Menu") || UI.IsMenuOpen("MagicMenu") || UI.IsMenuOpen("Top Menu") || UI.IsMenuOpen("Overlay Menu") || UI.IsMenuOpen("Overlay Interaction Menu") || UI.IsMenuOpen("Loading Menu") || UI.IsMenuOpen("TweenMenu") || UI.IsMenuOpen("BarterMenu") || UI.IsMenuOpen("GiftMenu") || UI.IsMenuOpen("Debug Text Menu") || UI.IsMenuOpen("MapMenu") || UI.IsMenuOpen("Lockpicking Menu") || UI.IsMenuOpen("Quantity Menu") || UI.IsMenuOpen("StatsMenu") || UI.IsMenuOpen("ContainerMenu") || UI.IsMenuOpen("Sleep/Wait Menu") || UI.IsMenuOpen("LevelUp Menu") || UI.IsMenuOpen("Journal Menu") || UI.IsMenuOpen("Book Menu") || UI.IsMenuOpen("FavoritesMenu") || UI.IsMenuOpen("RaceSex Menu") || UI.IsMenuOpen("Crafting Menu") || UI.IsMenuOpen("Training Menu") || UI.IsMenuOpen("Mist Menu") || UI.IsMenuOpen("Tutorial Menu") || UI.IsMenuOpen("Credits Menu") || UI.IsMenuOpen("TitleSequence Menu") || UI.IsMenuOpen("Console Native UI Menu")
		return
	endIf

	int modeventid
	if mnd.howToPoop==2 && k==mnd.keyToPoop && mnd.pissAndPoopTogether
		if mnd.PlayerRef.hasMagicEffect(mnd.mndTakeALeakME) || mnd.PlayerRef.hasMagicEffect(mnd.mndDoYourBusinessME) || mnd.PlayerRef.hasMagicEffect(mnd.mndDoFullBusinessME) || mnd.PlayerIsAnimating()
			mnd.showTranslatedString("YouAreAlreadyDoingYourBusiness")
			return
		endIf
		modeventid = ModEvent.Create("MiniNeedsDoPissAndPoop")
		ModEvent.PushInt(modeventid, 2)
		ModEvent.Send(modeventid)
	elseIf mnd.howToPiss==2 && k==mnd.keyToPiss
		if mnd.PlayerRef.hasMagicEffect(mnd.mndTakeALeakME) || mnd.PlayerRef.hasMagicEffect(mnd.mndDoYourBusinessME) || mnd.PlayerRef.hasMagicEffect(mnd.mndDoFullBusinessME) || mnd.PlayerIsAnimating()
			mnd.showTranslatedString("YouAreAlreadyDoingYourBusiness")
			return
		endIf
		modeventid = ModEvent.Create("MiniNeedsDoPissAndPoop")
		ModEvent.PushInt(modeventid, 0)
		ModEvent.Send(modeventid)
	elseIf mnd.howToPoop==2 && k==mnd.keyToPoop
		if mnd.PlayerRef.hasMagicEffect(mnd.mndTakeALeakME) || mnd.PlayerRef.hasMagicEffect(mnd.mndDoYourBusinessME) || mnd.PlayerRef.hasMagicEffect(mnd.mndDoFullBusinessME) || mnd.PlayerIsAnimating()
			mnd.showTranslatedString("YouAreAlreadyDoingYourBusiness")
			return
		endIf
		modeventid = ModEvent.Create("MiniNeedsDoPissAndPoop")
		ModEvent.PushInt(modeventid, 1)
		ModEvent.Send(modeventid)
	elseIf mnd.howToPissPoop==2 && k==mnd.keyToPissPoop
		if mnd.PlayerRef.hasMagicEffect(mnd.mndTakeALeakME) || mnd.PlayerRef.hasMagicEffect(mnd.mndDoYourBusinessME) || mnd.PlayerRef.hasMagicEffect(mnd.mndDoFullBusinessME) || mnd.PlayerIsAnimating()
			mnd.showTranslatedString("YouAreAlreadyDoingYourBusiness")
			return
		endIf
		modeventid = ModEvent.Create("MiniNeedsDoPissAndPoop")
		ModEvent.PushInt(modeventid, 2)
		ModEvent.Send(modeventid)
	elseIf k==mnd.widgetsKey && mnd.widgetsKey!=0
		mnd.enableWidgets = !mnd.enableWidgets
		mnd.calculateWidgets()
	elseIf k==mnd.keyToMasturbate && mnd.keyToMasturbate!=0
		if mnd.PlayerRef.hasMagicEffect(mnd.mndTakeALeakME) || mnd.PlayerRef.hasMagicEffect(mnd.mndDoYourBusinessME) || mnd.PlayerRef.hasMagicEffect(mnd.mndDoFullBusinessME) || mnd.PlayerIsAnimating()
			mnd.showTranslatedString("YouAreAlreadyDoingYourBusiness")
			return
		endIf
		mnd.doMasturbation()
	elseIf k==mnd.keyToBathInRivers && mnd.keyToBathInRivers!=0
		mnd.bathInRivers()
	endIf
endEvent

float talkHowLong

Event OnMenuOpen(string menuName)
	if menuName=="Dialogue Menu"
		talkHowLong = Utility.GetCurrentRealTime()
	endIf
endEvent

Event OnMenuClose(string menuName)
	if menuName=="Dialogue Menu"
		if Utility.GetCurrentRealTime() - talkHowLong > 5.0
			mnd.lastTimeTalk = Utility.GetCurrentGameTime()
		endIf
	endIf
endEvent

float timeWeaponEquipped = 0.0

Event OnObjectEquipped(Form akBaseObject, ObjectReference akReference)
	if mnd.grabRandomWeapon>0
		int perc = mnd.grabRandomWeapon
		mnd.grabRandomWeapon = - mnd.grabRandomWeapon
		if Utility.randomInt(0, 6) < perc
			mnd.equipRandomWeapon(0, akBaseObject)
			return ; cannot do it twice
		endIf
		if Utility.randomInt(0, 6) < perc
			mnd.equipRandomWeapon(1, akBaseObject)
		endIf
	endIf
EndEvent

function SendPlayAnimEvent(string anim, bool openMouth)
	int id = ModEvent.Create("mndPlayAnim")
	if id
		ModEvent.PushString(id, anim)
		if openMouth
			ModEvent.PushInt(id, 1)
		else
			ModEvent.PushInt(id, 0)
		endIf
		ModEvent.Send(id)
	endIf
endFunction




