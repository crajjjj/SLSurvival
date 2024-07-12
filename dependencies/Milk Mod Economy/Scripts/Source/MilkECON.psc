Scriptname MilkECON extends Quest
{Economy script, contains all MME milks and foods}

MilkQUEST Property MilkQ Auto

MiscObject Property Gold Auto
Message Property MilkTrade Auto
Message Property MilkTradeDialogue Auto
Message Property MilkTradeDialogue5 Auto

int Property MilkEcoCaravan Auto
int Property MilkEcoDawnstar Auto
int Property MilkEcoFalkreath Auto
int Property MilkEcoMarkarth Auto
int Property MilkEcoOrc Auto
int Property MilkEcoRiften Auto
int Property MilkEcoSolitude Auto
int Property MilkEcoWhiterun Auto
int Property MilkEcoWindhelm Auto
int Property MilkEcoMorrowind Auto

int Property MilkDemandCaravan Auto
int Property MilkDemandDawnstar Auto
int Property MilkDemandFalkreath Auto
int Property MilkDemandMarkarth Auto
int Property MilkDemandOrc Auto
int Property MilkDemandRiften Auto
int Property MilkDemandSolitude Auto
int Property MilkDemandWhiterun Auto
int Property MilkDemandWindhelm Auto
int Property MilkDemandMorrowind Auto

Perk Property Haggling00 Auto
Perk Property Haggling20 Auto
Perk Property Haggling40 Auto
Perk Property Haggling60 Auto
Perk Property Haggling80 Auto

;Inns
Location Property DawnstarWindpeakInnLocation Auto
Location Property FalkreathDeadMansDrinkLocation Auto
Location Property OldHroldanInnLocation Auto
Location Property MarkarthSilverBloodInnLocation Auto
Location Property RiftenBeeandBarbLocation Auto
Location Property IvarsteadVilemyrInnLocation Auto
Location Property DragonBridgeFourShieldsTavernLocation Auto
Location Property MorthalMoorsideInnLocation Auto
Location Property SolitudeWinkingSkeeverLocation Auto
Location Property RiverwoodSleepingGiantInnLocation Auto
Location Property WhiterunBanneredMareLocation Auto
Location Property RoriksteadFrostfruitInnLocation Auto
Location Property WindhelmCandlehearthHallLocation Auto
Location Property WindhelmNewGnisisCornerclubLocation Auto
Location Property WinterholdTheFrozenHearthLocation Auto
Location Property KynesgroveBraidwoodInnLocation Auto
;orc
Location Property locMorKhazgur Auto
Location Property locDushnikhYal Auto
Location Property locNarzulbur Auto
Location Property locLargashbur Auto
;skyrim
Location Property locDawnstar Auto
Location Property locDawnstarSanctuary Auto
Location Property locFalkreath Auto
Location Property locMarkarth Auto
Location Property locOldHroldan Auto
Location Property locRiften Auto
Location Property locShorsStone Auto
Location Property locSolitude Auto
Location Property locDragonBridge Auto
Location Property locMorthal Auto
Location Property locWhiterun Auto
Location Property locRiverwood Auto
Location Property locRorikstead Auto
Location Property locWindhelm Auto
Location Property locWinterhold Auto
Location Property locCollegeofWinterhold Auto
Location Property locKynesgrove Auto
Location Property locKarthwasten Auto
;HF DLC
Location Property locHeljarchenHall Auto
Location Property locWindstadManor Auto
Location Property locLakeviewManor Auto
;Dawnguard
Location Property locFortDawnguard Auto
Location Property locDayspringCanyon Auto
;Dragonborn DLC
Location Property locRavenRock Auto
Location Property locSkaalVillage Auto
Location Property locTelMithryn Auto
;Empty DLC placeholder
Location Property locMMEEmpty Auto			

Formlist Property MilkTypeFormList Auto

;Length - 10
Int[] PrevMilkEcos
Int[] CurrMilkEcos
String[] Property MarketNames Auto
Int[] MilkDemandCDs
Int[] MilkDemands
Int[] SaturationPenalties

;Length - 12
String[] Property MilkNames Auto

int Property divnull = 10 Auto
int Property Updates = 0 Auto

;---------------------------------------------------------------------------------------------------------------------

bool Function MilkEconMaintenance()
	debug.Trace("MilkModEconomy ECON market names array resetting")
	MarketNames = new String[10]
	MarketNames[0] = "with the Khajiit Caravaneers"
	MarketNames[1] = "in " + locDawnstar.GetName()
	MarketNames[2] = "in " + locFalkreath.GetName()
	MarketNames[3] = "in " + locMarkarth.GetName()
	MarketNames[4] = "with the Orcish Strongholds"
	MarketNames[5] = "in " + locRiften.GetName()
	MarketNames[6] = "in " + locSolitude.GetName()
	MarketNames[7] = "in " + locWhiterun.GetName()
	MarketNames[8] = "in " + locWindhelm.GetName()
	MarketNames[9] = "in the province of Solstheim"
	
	debug.Trace("MilkModEconomy ECON milk names array resetting")
	string milk = " Milk"
	MilkNames = new String[12]
	MilkNames[0] = "Nothing"
	MilkNames[1] = MilkQ.MME_Races.GetAt(0).GetName() + milk
	MilkNames[2] = MilkQ.MME_Races.GetAt(1).GetName() + milk
	MilkNames[3] = MilkQ.MME_Races.GetAt(2).GetName() + milk
	MilkNames[4] = MilkQ.MME_Races.GetAt(3).GetName() + milk
	MilkNames[5] = MilkQ.MME_Races.GetAt(4).GetName() + milk
	MilkNames[6] = MilkQ.MME_Races.GetAt(5).GetName() + milk
	MilkNames[7] = MilkQ.MME_Races.GetAt(6).GetName() + milk
	MilkNames[8] = MilkQ.MME_Races.GetAt(7).GetName() + milk
	MilkNames[9] = MilkQ.MME_Races.GetAt(8).GetName() + milk
	MilkNames[10] = MilkQ.MME_Races.GetAt(9).GetName() + milk
	MilkNames[11] = "Exotic" + milk
	return true
EndFunction

bool Function InitializeMilkProperties()
	If divnull == 10
		MilkEcoCaravan = Utility.RandomInt(0, 1000/(MilkQ.TimesMilkedMult/divnull))
		MilkEcoDawnstar = Utility.RandomInt(0, 1000/(MilkQ.TimesMilkedMult/divnull))
		MilkEcoFalkreath = Utility.RandomInt(0, 1000/(MilkQ.TimesMilkedMult/divnull))
		MilkEcoMarkarth = Utility.RandomInt(0, 1000/(MilkQ.TimesMilkedMult/divnull))
		MilkEcoOrc = Utility.RandomInt(0, 1000/(MilkQ.TimesMilkedMult/divnull))
		MilkEcoRiften = Utility.RandomInt(0, 1000/(MilkQ.TimesMilkedMult/divnull))
		MilkEcoSolitude = Utility.RandomInt(0, 1000/(MilkQ.TimesMilkedMult/divnull))
		MilkEcoWhiterun = Utility.RandomInt(0, 1000/(MilkQ.TimesMilkedMult/divnull))
		MilkEcoWindhelm = Utility.RandomInt(0, 1000/(MilkQ.TimesMilkedMult/divnull))
		MilkEcoMorrowind = Utility.RandomInt(0, 1000/(MilkQ.TimesMilkedMult/divnull))

		SaturationPenalties = new Int[10]
		SaturationPenalties[0] = 0
		SaturationPenalties[1] = 200/(MilkQ.TimesMilkedMult/divnull)
		SaturationPenalties[2] = 200/(MilkQ.TimesMilkedMult/divnull)
		SaturationPenalties[3] = 300/(MilkQ.TimesMilkedMult/divnull)
		SaturationPenalties[4] = 300/(MilkQ.TimesMilkedMult/divnull)
		SaturationPenalties[5] = 300/(MilkQ.TimesMilkedMult/divnull)
		SaturationPenalties[6] = 300/(MilkQ.TimesMilkedMult/divnull)
		SaturationPenalties[7] = 425/(MilkQ.TimesMilkedMult/divnull)
		SaturationPenalties[8] = 425/(MilkQ.TimesMilkedMult/divnull)
		SaturationPenalties[9] = 800/(MilkQ.TimesMilkedMult/divnull)

		MilkDemands = new Int[10]
		MilkDemandCDs = new Int[10]
	else
		Debug.Trace("MilkModEconomy InitializeMilkProperties divnull is "+divnull+", mod is broken, have a nice day!")
	endif

	return true
EndFunction

Event OnUpdateGameTime()
	If divnull == 10
		if MilkQ.EconFlag == True
			RegisterForSingleUpdateGameTimeAt(9.0)
			MilkEcoCycle()
			;StorageUtil.SetIntValue(Game.Getplayer(), "MME.MilkMaid.FreeLactacid", MilkQ.MME_Storage.getMaidLevel(Game.Getplayer()) as int)
		endif
	else
		Debug.Trace("MilkModEconomy OnUpdateGameTime divnull is "+divnull+", mod is broken, have a nice day!")
	endif
endEvent

float Function GetCurrentHourOfDay() global
{Returns the current time of day in hours since midnight}
 
	float Time = Utility.GetCurrentGameTime()
	Time -= Math.Floor(Time) ; Remove "previous in-game days passed" bit
	Time *= 24 ; Convert from fraction of a day to number of hours
	Return Time
EndFunction
 
Function RegisterForSingleUpdateGameTimeAt(float GameTime)
{Registers for a single UpdateGameTime event at the next occurrence
of the specified GameTime (in hours since midnight)}
 
	float CurrentTime = GetCurrentHourOfDay()
	If (GameTime <= CurrentTime)
		GameTime += 24
	EndIf
 
	RegisterForSingleUpdateGameTime(GameTime - CurrentTime)
EndFunction

;-----------------------------------\
;----C-Y-C-L-E----F-U-N-C-T-I-O-N-S----\
;---------------------------------------------------------------------------------------------------------------------

Function MilkEcoCycle()
	BeginMilkEcoCycle()
	MilkEcoRestore()
	MilkEcoSaturationEvent()
	MilkEcoDemandEvent()
	EndMilkEcoCycle()
EndFunction

;-----------------------------------\
;----C-O-R-E----F-U-N-C-T-I-O-N-S----\
;---------------------------------------------------------------------------------------------------------------------

Function InitiateTradeToContainer(int MilkCount, int boobgasmcount, Actor akActor, Objectreference MilkBarrel)

	Potion NfinalPotion = none
	int NfinalQty = 0

	Potion BfinalPotion = none
	int BfinalQty = 0
	
	if boobgasmcount > 0 && MME_Storage.getMaidLevel(akActor) == 0
		boobgasmcount = 0
	endif
	
	if (milkCount - boobgasmcount) > 0
		NfinalPotion = GetMilkType(milkCount, 0, akActor) as Potion
		NfinalQty = GetMilkQty(milkCount-boobgasmcount)
	endif
	
	if boobgasmcount > 0
		BfinalPotion = GetMilkType(boobgasmcount, boobgasmcount, akActor) as Potion
		BfinalQty = boobgasmcount
	endif

	KeepMilkContainer(NfinalPotion, NfinalQty, 0, MilkBarrel)
	KeepMilkContainer(BfinalPotion, BfinalQty, 0, MilkBarrel)
endFunction

Function InitiateTrade(int MilkCount, int boobgasmcount, Actor akActor, bool mobilemilking)
	;handles milk selling after milking, one type of basic milk, one type of race milk
	Race maidRace = akActor.GetActorBase().GetRace()
	int marketIndex = GetMarketIndexFromLocation(akActor.GetCurrentLocation())
	int raceIndex = GetRaceIndexFromRace(maidRace)

	Potion NfinalPotion = none
	int NfinalQty = 0
	int Nupkeep = 0
	int NbaseTrade = 0
	int NmilkTax = 0

	Potion BfinalPotion = none
	int BfinalQty = 0
	int Bupkeep = 0
	int BbaseTrade = 0
	int BmilkTax = 0
	
	if boobgasmcount > 0 && MME_Storage.getMaidLevel(akActor) == 0
		boobgasmcount = 0
	endif
	
	if (milkCount - boobgasmcount) > 0
		NfinalPotion = GetMilkType(milkCount, 0, akActor) as Potion
		NfinalQty = GetMilkQty(milkCount-boobgasmcount)
		Nupkeep = GetUpKeepCost(milkCount-boobgasmcount)
		NbaseTrade = CalculateBaseTrade(NfinalPotion, NfinalQty) * MilkQ.MilkPriceMod
		NmilkTax = CalculateServiceTax(marketIndex, NbaseTrade)
	endif
	
	if boobgasmcount > 0
		BfinalPotion = GetMilkType(boobgasmcount, boobgasmcount, akActor) as Potion
		BfinalQty = boobgasmcount
		Bupkeep = GetUpKeepCost(boobgasmcount)
		BbaseTrade = CalculateBaseTrade(BfinalPotion, BfinalQty) * MilkQ.MilkPriceMod
		BmilkTax = CalculateServiceTax(marketIndex, BbaseTrade)
	endif

	; multiply value of baseTrade after tax is calculated if there is demand
	if MilkDemands[marketIndex] == raceIndex
		NbaseTrade = NbaseTrade * 3
		BbaseTrade = BbaseTrade * 3
	else
		NbaseTrade = NbaseTrade * 2
		BbaseTrade = BbaseTrade * 2
	endif

	if MilkQ.EconFlag && mobilemilking == false
		int ButtonPressed = (MilkTrade).Show(Nupkeep + Bupkeep, NbaseTrade, NmilkTax, BbaseTrade, BmilkTax)
		if ButtonPressed == 1
			SellMilk(marketIndex, NbaseTrade + BbaseTrade, NmilkTax + BmilkTax, Nupkeep + Bupkeep, akActor)
		elseif ButtonPressed == 2
			SellMilk(marketIndex, NbaseTrade, NmilkTax, Nupkeep, akActor)
			KeepMilk(BfinalPotion, BfinalQty, Bupkeep, akActor)
		elseif ButtonPressed == 3
			SellMilk(marketIndex, BbaseTrade, BmilkTax, Bupkeep, akActor)
			KeepMilk(NfinalPotion, NfinalQty, Nupkeep, akActor)
		else
			KeepMilk(NfinalPotion, NfinalQty, Nupkeep, akActor)
			KeepMilk(BfinalPotion, BfinalQty, Bupkeep, akActor)
		endif
	else
		KeepMilk(NfinalPotion, NfinalQty, NfinalQty * 2, akActor)
		KeepMilk(BfinalPotion, BfinalQty, BfinalQty * 2, akActor)
	endif
endFunction

Function InitiateDialogueTrade(Actor akActor, int MilkType)
	;handles milk selling through dialogues, many types of milk
	;MilkType=1 - normal milk
	;MilkType=2 - race milk 
	;MilkType=3 - both milk(1+2)
	;MilkType=4 - vampire/ww/succ milk
	;MilkType=5 - fence milk(all)
	
	Potion finalPotion
	int i
	int raceIndex
	int finalQty
	int upkeep
	int baseTrade
	int finalbaseTrade
	int milkTax
	int ButtonPressed = 1
	MilkTypeFormList.revert()
	
	if MilkQ.MilkQC.MME_SimpleMilkPotions == true && (MilkType == 1 || MilkType == 2)	;fix if user has normal potions and have SimpleMilkPotions enabled
		MilkType = 3
	endif
	
	if MilkType == 1
		MilkTypeFormList = MilkQ.MME_Milk_Basic
	elseif MilkType == 2
		MilkTypeFormList = MilkQ.MME_Milk_Race
	elseif MilkType == 3
		i = 0
		while i < MilkQ.MME_Milk_Basic.GetSize()
			MilkTypeFormList.AddForm(MilkQ.MME_Milk_Basic.GetAt(i))
			i += 1
		endwhile
		i = 0
		while i < MilkQ.MME_Milk_Race.GetSize()
			MilkTypeFormList.AddForm(MilkQ.MME_Milk_Race.GetAt(i))
			i += 1
		endwhile
	elseif MilkType == 4
		i = 0
		while i < MilkQ.MME_Milk_Succubus.GetSize()
			MilkTypeFormList.AddForm(MilkQ.MME_Milk_Succubus.GetAt(i))
			i += 1
		endwhile
		i = 0
		while i < MilkQ.MME_Milk_Vampire.GetSize()
			MilkTypeFormList.AddForm(MilkQ.MME_Milk_Vampire.GetAt(i))
			i += 1
		endwhile
		i = 0
		while i < MilkQ.MME_Milk_Werewolf.GetSize()
			MilkTypeFormList.AddForm(MilkQ.MME_Milk_Werewolf.GetAt(i))
			i += 1
		endwhile
	elseif MilkType == 5
		i = 0
		while i < MilkQ.MME_Milk_Basic.GetSize()
			MilkTypeFormList.AddForm(MilkQ.MME_Milk_Basic.GetAt(i))
			i += 1
		endwhile
		i = 0
		while i < MilkQ.MME_Milk_Race.GetSize()
			MilkTypeFormList.AddForm(MilkQ.MME_Milk_Race.GetAt(i))
			i += 1
		endwhile
		i = 0
		while i < MilkQ.MME_Milk_Succubus.GetSize()
			MilkTypeFormList.AddForm(MilkQ.MME_Milk_Succubus.GetAt(i))
			i += 1
		endwhile
		i = 0
		while i < MilkQ.MME_Milk_Vampire.GetSize()
			MilkTypeFormList.AddForm(MilkQ.MME_Milk_Vampire.GetAt(i))
			i += 1
		endwhile
		i = 0
		while i < MilkQ.MME_Milk_Werewolf.GetSize()
			MilkTypeFormList.AddForm(MilkQ.MME_Milk_Werewolf.GetAt(i))
			i += 1
		endwhile
	endif
	Utility.wait(1)
		
	i = 0
	int marketIndex = GetMarketIndexFromLocation(akActor.GetCurrentLocation())
		;Debug.Notification("1 " + MilkTypeFormList.GetSize())
	while i < MilkTypeFormList.GetSize()
		if akActor.GetItemCount(MilkTypeFormList.GetAt(i)) > 0
			finalPotion = MilkTypeFormList.GetAt(i) as potion
			finalQty = akActor.GetItemCount(MilkTypeFormList.GetAt(i))
			;Debug.Notification(akActor.GetItemCount(MilkTypeFormList.GetAt(i)) + " " + (MilkTypeFormList.GetAt(i) as potion).GetName())
			raceIndex = GetRaceIndexFromMilk(finalPotion)
			upkeep = upkeep + GetUpKeepCost(finalQty)
			baseTrade = CalculateBaseTrade(finalPotion, finalQty) * MilkQ.MilkPriceMod
			if MilkDemands[marketIndex] == raceIndex								; multiply value of baseTrade after tax is calculated
				finalbaseTrade = finalbaseTrade + baseTrade * 3
			else
				finalbaseTrade = finalbaseTrade + baseTrade * 2
			endif
		endif
		i += 1
	endwhile
	;Debug.Notification("marketIndex "+marketIndex+" MilkDemands[marketIndex] "+MilkDemands[marketIndex]+" raceIndex "+raceIndex)
	;Debug.Notification("upkeep "+upkeep+" baseTrade "+baseTrade+" finalbaseTrade "+finalbaseTrade)

	milkTax = CalculateServiceTax(marketIndex, finalbaseTrade)
	if MilkType == 5 || marketIndex == 4  || marketIndex == 0
		upkeep = 0
		milkTax = 0
		ButtonPressed = (MilkTradeDialogue5).Show(finalbaseTrade)
	else
		ButtonPressed = (MilkTradeDialogue).Show(finalbaseTrade, upkeep, milkTax)
	endif
	if ButtonPressed == 0
		SellMilkDialogue(marketIndex, finalbaseTrade, milkTax , upkeep, akActor)
		RemoveMilk(akActor)
	endif
endFunction

Function RemoveMilk(Actor akActor)
	int i = 0
	while i < MilkTypeFormList.GetSize()
		if akActor.GetItemCount(MilkTypeFormList.GetAt(i)) > 0
			akActor.removeitem(MilkTypeFormList.GetAt(i), akActor.GetItemCount(MilkTypeFormList.GetAt(i)))
		endif
		i = i + 1
	endwhile
endFunction

Function SellMilkDialogue(int marketIndex, int baseTrade, int milkTax, int upkeep, Actor akActor)
	int finalPayout = baseTrade
	finalPayout = math.Ceiling((finalPayout - milkTax - upkeep) * MilkQ.TimesMilkedMult/20)
	if finalPayout < 0
		finalPayout = 0
	endif
	
	akActor.AddItem(Gold, finalPayout)
	Debug.Notification("You've made " + finalPayout + " gold.")
	UpdateEconomy(marketIndex, baseTrade)
endFunction

Function SellMilk(int marketIndex, int baseTrade, int milkTax, int upkeep, Actor akActor)
	int finalPayout = baseTrade
	finalPayout = math.Ceiling((finalPayout - milkTax - upkeep) * MilkQ.TimesMilkedMult/20)
	if finalPayout < 0
		finalPayout = 0
	endif

	if MilkQ.PlayerREF == akActor
		MilkQ.PlayerREF.AddItem(Gold, finalPayout)
		Debug.Notification("You've made " + finalPayout + " gold.")
	else
		akActor.AddItem(Gold, finalPayout)
	endif
	UpdateEconomy(marketIndex, baseTrade)
endFunction

Function KeepMilkContainer(Potion finalPotion, int finalQty, int upkeep, objectreference MilkBarrel)
	if finalQty > 0
		MilkBarrel.AddItem(finalPotion, finalQty)
	endif
endFunction

Function KeepMilk(Potion finalPotion, int finalQty, int upkeep, Actor akActor)
	if finalQty > 0
		akActor.AddItem(finalPotion, finalQty)
	endif
endFunction

;-----------------------------------\
;----U-T-I-L-I-T-Y----F-U-N-C-T-I-O-N-S----\
;---------------------------------------------------------------------------------------------------------------------

;-----------------------------------------------------------------------------------------------------
;
; At the end of the milking cycle, use the following variables to inform the user:
; Upkeep     - from GetUpkeepCost(int)
; Milk Type  - from GetMilkType(int, Race)
; Milk Qty   - from GetMilkQty(int)
; Base Trade - from CalculateBaseTrade(Potion, int)
; Tax        - from CalculateServiceTax(Location, int)
;
; If the user sells, call the following function
;    UpdateEconomy(Location, int)
;
; If the user keeps the milk, 
;    just add milk and qty to MilkQ.PlayerREF in the calling script
;
;-----------------------------------------------------------------------------------------------------

int Function GetUpkeepCost(int milkCount)
	return milkCount * 2
endFunction

int Function GetMilkQty(int milkCount)
	int c = milkCount
	
	if c <= 4
		return c
	elseif c <= 12
		return ((c - 3) / 2) + 4
	else
		return ((c - 6) / 3) + 6
	endif
EndFunction

Form Function GetMilkType(int milkCount, int boobgasmcount, Actor milkMaid)
	Race maidRace = milkMaid.GetActorBase().GetRace()
	Int MaidLevel = MME_Storage.getMaidLevel(milkMaid)
	Float MilkMax = MME_Storage.getMilkMaximum(milkMaid)
	
	if MilkQ.MilkQC.MME_SimpleMilkPotions
		boobgasmcount = boobgasmcount + milkCount
	endif
	
	if boobgasmcount > 0
		Int SubRace = 0 ; SubRace 0: Normal. 1: Werewolf. 2: Vampire. 3: Succubus
		;mod detection || mcm manual override
		if MilkQ.isSuccubus(milkMaid) || StorageUtil.GetIntValue(milkMaid,"MME.MilkMaid.IsSuccubus") == 1
			SubRace = 3
		elseif MilkQ.isVampire(milkMaid) || StorageUtil.GetIntValue(milkMaid,"MME.MilkMaid.IsVampire") == 1
			SubRace = 2
		elseif MilkQ.isWerewolf(milkMaid) || StorageUtil.GetIntValue(milkMaid,"MME.MilkMaid.IsWerewolf") == 1
			SubRace = 1
		endif

;drugs and alcohol
;		elseif StorageUtil.GetFloatValue(milkMaid,"MME.MilkMaid.Skooma") > 0
;			return MilkQ.MME_Milk_Werewolf.GetAt(0)
;		elseif StorageUtil.GetFloatValue(milkMaid,"MME.MilkMaid.LeafSkooma") > 0
;			return MilkQ.MME_Milk_Werewolf.GetAt(0)
;		elseif StorageUtil.GetFloatValue(milkMaid,"MME.MilkMaid.Mead") > 0
;			return MilkQ.MME_Milk_Werewolf.GetAt(0)
;		elseif StorageUtil.GetFloatValue(milkMaid,"MME.MilkMaid.BBMead") > 0
;			return MilkQ.MME_Milk_Werewolf.GetAt(0)

		if SubRace == 0
			if maidRace == MilkQ.MME_Races.GetAt(0)
				return GetMilkTypeHelper(boobgasmcount, MilkQ.MME_Milk_Altmer_Normal, MaidLevel)
			elseif maidRace == MilkQ.MME_Races.GetAt(1)
				return GetMilkTypeHelper(boobgasmcount, MilkQ.MME_Milk_Argonian_Normal, MaidLevel)
			elseif maidRace == MilkQ.MME_Races.GetAt(2)
				return GetMilkTypeHelper(boobgasmcount, MilkQ.MME_Milk_Bosmer_Normal, MaidLevel)
			elseif maidRace == MilkQ.MME_Races.GetAt(3)
				return GetMilkTypeHelper(boobgasmcount, MilkQ.MME_Milk_Breton_Normal, MaidLevel)
			elseif maidRace == MilkQ.MME_Races.GetAt(4)
				return GetMilkTypeHelper(boobgasmcount, MilkQ.MME_Milk_Dunmer_Normal, MaidLevel)
			elseif maidRace == MilkQ.MME_Races.GetAt(5)
				return GetMilkTypeHelper(boobgasmcount, MilkQ.MME_Milk_Imperial_Normal, MaidLevel)
			elseif maidRace == MilkQ.MME_Races.GetAt(6)
				return GetMilkTypeHelper(boobgasmcount, MilkQ.MME_Milk_Khajiit_Normal, MaidLevel)
			elseif maidRace == MilkQ.MME_Races.GetAt(7)
				return GetMilkTypeHelper(boobgasmcount, MilkQ.MME_Milk_Nord_Normal, MaidLevel)
			elseif maidRace == MilkQ.MME_Races.GetAt(8)
				return GetMilkTypeHelper(boobgasmcount, MilkQ.MME_Milk_Orc_Normal, MaidLevel)
			elseif maidRace == MilkQ.MME_Races.GetAt(9)
				return GetMilkTypeHelper(boobgasmcount, MilkQ.MME_Milk_Redguard_Normal, MaidLevel)
			else 	;maidRace = Custom Race
				return GetMilkTypeHelper(boobgasmcount, MilkQ.MME_Milk_Exotic_Normal, MaidLevel)
			endif
		elseif SubRace == 1
			if maidRace == MilkQ.MME_Races.GetAt(0)
				return GetMilkTypeHelper(boobgasmcount, MilkQ.MME_Milk_Altmer_Werewolf, MaidLevel)
			elseif maidRace == MilkQ.MME_Races.GetAt(1)
				return GetMilkTypeHelper(boobgasmcount, MilkQ.MME_Milk_Argonian_Werewolf, MaidLevel)
			elseif maidRace == MilkQ.MME_Races.GetAt(2)
				return GetMilkTypeHelper(boobgasmcount, MilkQ.MME_Milk_Bosmer_Werewolf, MaidLevel)
			elseif maidRace == MilkQ.MME_Races.GetAt(3)
				return GetMilkTypeHelper(boobgasmcount, MilkQ.MME_Milk_Breton_Werewolf, MaidLevel)
			elseif maidRace == MilkQ.MME_Races.GetAt(4)
				return GetMilkTypeHelper(boobgasmcount, MilkQ.MME_Milk_Dunmer_Werewolf, MaidLevel)
			elseif maidRace == MilkQ.MME_Races.GetAt(5)
				return GetMilkTypeHelper(boobgasmcount, MilkQ.MME_Milk_Imperial_Werewolf, MaidLevel)
			elseif maidRace == MilkQ.MME_Races.GetAt(6)
				return GetMilkTypeHelper(boobgasmcount, MilkQ.MME_Milk_Khajiit_Werewolf, MaidLevel)
			elseif maidRace == MilkQ.MME_Races.GetAt(7)
				return GetMilkTypeHelper(boobgasmcount, MilkQ.MME_Milk_Nord_Werewolf, MaidLevel)
			elseif maidRace == MilkQ.MME_Races.GetAt(8)
				return GetMilkTypeHelper(boobgasmcount, MilkQ.MME_Milk_Orc_Werewolf, MaidLevel)
			elseif maidRace == MilkQ.MME_Races.GetAt(9)
				return GetMilkTypeHelper(boobgasmcount, MilkQ.MME_Milk_Redguard_Werewolf, MaidLevel)
			else 	;maidRace = Custom Race
				return GetMilkTypeHelper(boobgasmcount, MilkQ.MME_Milk_Exotic_Werewolf, MaidLevel)
			endif
		elseif SubRace == 3
			if maidRace == MilkQ.MME_Races.GetAt(0)
				return GetMilkTypeHelper(boobgasmcount, MilkQ.MME_Milk_Altmer_Succubus, MaidLevel)
			elseif maidRace == MilkQ.MME_Races.GetAt(1)
				return GetMilkTypeHelper(boobgasmcount, MilkQ.MME_Milk_Argonian_Succubus, MaidLevel)
			elseif maidRace == MilkQ.MME_Races.GetAt(2)
				return GetMilkTypeHelper(boobgasmcount, MilkQ.MME_Milk_Bosmer_Succubus, MaidLevel)
			elseif maidRace == MilkQ.MME_Races.GetAt(3)
				return GetMilkTypeHelper(boobgasmcount, MilkQ.MME_Milk_Breton_Succubus, MaidLevel)
			elseif maidRace == MilkQ.MME_Races.GetAt(4)
				return GetMilkTypeHelper(boobgasmcount, MilkQ.MME_Milk_Dunmer_Succubus, MaidLevel)
			elseif maidRace == MilkQ.MME_Races.GetAt(5)
				return GetMilkTypeHelper(boobgasmcount, MilkQ.MME_Milk_Imperial_Succubus, MaidLevel)
			elseif maidRace == MilkQ.MME_Races.GetAt(6)
				return GetMilkTypeHelper(boobgasmcount, MilkQ.MME_Milk_Khajiit_Succubus, MaidLevel)
			elseif maidRace == MilkQ.MME_Races.GetAt(7)
				return GetMilkTypeHelper(boobgasmcount, MilkQ.MME_Milk_Nord_Succubus, MaidLevel)
			elseif maidRace == MilkQ.MME_Races.GetAt(8)
				return GetMilkTypeHelper(boobgasmcount, MilkQ.MME_Milk_Orc_Succubus, MaidLevel)
			elseif maidRace == MilkQ.MME_Races.GetAt(9)
				return GetMilkTypeHelper(boobgasmcount, MilkQ.MME_Milk_Redguard_Succubus, MaidLevel)
			else 	;maidRace = Custom Race
				return GetMilkTypeHelper(boobgasmcount, MilkQ.MME_Milk_Exotic_Succubus, MaidLevel)
			endif
		elseif SubRace == 2
			if maidRace == MilkQ.MME_RacesVampire.GetAt(0)
				return GetMilkTypeHelper(boobgasmcount, MilkQ.MME_Milk_Altmer_Vampire, MaidLevel)
			elseif maidRace == MilkQ.MME_RacesVampire.GetAt(1)
				return GetMilkTypeHelper(boobgasmcount, MilkQ.MME_Milk_Argonian_Vampire, MaidLevel)
			elseif maidRace == MilkQ.MME_RacesVampire.GetAt(2)
				return GetMilkTypeHelper(boobgasmcount, MilkQ.MME_Milk_Bosmer_Vampire, MaidLevel)
			elseif maidRace == MilkQ.MME_RacesVampire.GetAt(3)
				return GetMilkTypeHelper(boobgasmcount, MilkQ.MME_Milk_Breton_Vampire, MaidLevel)
			elseif maidRace == MilkQ.MME_RacesVampire.GetAt(4)
				return GetMilkTypeHelper(boobgasmcount, MilkQ.MME_Milk_Dunmer_Vampire, MaidLevel)
			elseif maidRace == MilkQ.MME_RacesVampire.GetAt(5)
				return GetMilkTypeHelper(boobgasmcount, MilkQ.MME_Milk_Imperial_Vampire, MaidLevel)
			elseif maidRace == MilkQ.MME_RacesVampire.GetAt(6)
				return GetMilkTypeHelper(boobgasmcount, MilkQ.MME_Milk_Khajiit_Vampire, MaidLevel)
			elseif maidRace == MilkQ.MME_RacesVampire.GetAt(7)
				return GetMilkTypeHelper(boobgasmcount, MilkQ.MME_Milk_Nord_Vampire, MaidLevel)
			elseif maidRace == MilkQ.MME_RacesVampire.GetAt(8)
				return GetMilkTypeHelper(boobgasmcount, MilkQ.MME_Milk_Orc_Vampire, MaidLevel)
			elseif maidRace == MilkQ.MME_RacesVampire.GetAt(9)
				return GetMilkTypeHelper(boobgasmcount, MilkQ.MME_Milk_Redguard_Vampire, MaidLevel)
			else 	;maidRace = Custom Race
				return GetMilkTypeHelper(boobgasmcount, MilkQ.MME_Milk_Exotic_Vampire, MaidLevel)
			endif
		endif
	else
		if milkCount == 0
			return None
		elseif milkCount <= MilkMax * 0.25
			return MilkQ.MME_Milk_Basic.GetAt(0)
		elseif milkCount <= MilkMax * 0.50
			return MilkQ.MME_Milk_Basic.GetAt(1)
		elseif milkCount <= MilkMax * 0.75
			return MilkQ.MME_Milk_Basic.GetAt(2)
		elseif milkCount > MilkMax * 0.75
			return MilkQ.MME_Milk_Basic.GetAt(3)
		endif
	endif
EndFunction

Form Function GetMilkTypeHelper(int milkCount, Formlist FLST, int MaidLevel)
	if MilkQ.MilkQC.MME_SimpleMilkPotions
		return FLST.GetAt(0)
	elseif MaidLevel < 3
		return FLST.GetAt(1)
	elseif MaidLevel < 6
		return FLST.GetAt(2)
	elseif MaidLevel < 9
		return FLST.GetAt(3)
	else
		return FLST.GetAt(4)
	endif
EndFunction

int Function CalculateBaseTrade(Potion finalPotion, int finalQty)
	if finalPotion == none || finalQty == 0
		return 0
	endif
	int baseTrade = finalPotion.GetGoldValue() * finalQty
	Float Level = PapyrusUtil.ClampFloat(StorageUtil.GetFloatValue(none,"MME.Progression.Level"), 0, 10)

	; Formula below kind of conforms to the way selling does in game, ignoring potions/enchants
	float priceFactor
	if MilkQ.PlayerREF.GetActorValue("Speechcraft") >= 100
		priceFactor = 2 
	else
		priceFactor = 3.3 - (1.3 * MilkQ.PlayerREF.GetActorValue("Speechcraft") / 100)
	endif
	
	float hagglingSkill = 0
	if MilkQ.PlayerREF.HasPerk(Haggling80)
		hagglingSkill = 0.3
	elseif MilkQ.PlayerREF.HasPerk(Haggling60)
		hagglingSkill = 0.25
	elseif MilkQ.PlayerREF.HasPerk(Haggling40)
		hagglingSkill = 0.2
	elseif MilkQ.PlayerREF.HasPerk(Haggling20)
		hagglingSkill = 0.15
	elseif MilkQ.PlayerREF.HasPerk(Haggling00)
		hagglingSkill = 0.1
	endif

	float goodCustomerModifier = Level / MilkQ.TimesMilkedMult
	float sellPriceModifier = (1 + hagglingSkill) * (1 + goodCustomerModifier) ;* 1.25
	baseTrade = (baseTrade / priceFactor * sellPriceModifier) as int

	return baseTrade
EndFunction

int Function CalculateServiceTax(int marketIndex, int basePayout)
	int fee = 0

	if marketIndex == 0
		;fee = CalculateServiceTaxHelper(MilkEcoCaravan, basePayout)
		fee = (basePayout * CalculateServiceTaxHelper(MilkEcoCaravan)) as int
	elseif marketIndex == 1
		;fee = CalculateServiceTaxHelper(MilkEcoDawnstar, basePayout)
		fee = (basePayout * CalculateServiceTaxHelper(MilkEcoDawnstar)) as int
	elseif marketIndex == 2
		;fee = CalculateServiceTaxHelper(MilkEcoFalkreath, basePayout)
		fee = (basePayout * CalculateServiceTaxHelper(MilkEcoFalkreath)) as int
	elseif marketIndex == 3
		;fee = CalculateServiceTaxHelper(MilkEcoMarkarth, basePayout)
		fee = (basePayout * CalculateServiceTaxHelper(MilkEcoMarkarth)) as int
	elseif marketIndex == 4
		;fee = CalculateServiceTaxHelper(MilkEcoOrc, basePayout)
		fee = (basePayout * CalculateServiceTaxHelper(MilkEcoOrc)) as int
	elseif marketIndex == 5
		;fee = CalculateServiceTaxHelper(MilkEcoRiften, basePayout)
		fee = (basePayout * CalculateServiceTaxHelper(MilkEcoRiften)) as int
	elseif marketIndex == 6
		;fee = CalculateServiceTaxHelper(MilkEcoSolitude, basePayout)
		fee = (basePayout * CalculateServiceTaxHelper(MilkEcoSolitude)) as int
	elseif marketIndex == 7
		;fee = CalculateServiceTaxHelper(MilkEcoWhiterun, basePayout)
		fee = (basePayout * CalculateServiceTaxHelper(MilkEcoWhiterun)) as int
	elseif marketIndex == 8
		;fee = CalculateServiceTaxHelper(MilkEcoWindhelm, basePayout)
		fee = (basePayout * CalculateServiceTaxHelper(MilkEcoWindhelm)) as int
	elseif marketIndex == 9
		;fee = CalculateServiceTaxHelper(MilkEcoMorrowind, basePayout)
		fee = (basePayout * CalculateServiceTaxHelper(MilkEcoMorrowind)) as int
	else
		; Catch all - fee is fixed at 50%
		fee = basePayout / 2
	endif
	return fee
EndFunction

;int Function CalculateServiceTaxHelper(int varEco, int basePayout)
;	float fBasePayout = basePayout as float
;	int fee = 0
;	
;	if varEco < 0
;		fee = (fBasePayout * 0.75) as int
;	elseif varEco < 200/(MilkQ.TimesMilkedMult/divnull)
;		fee = (fBasePayout * 0.50) as int
;	elseif varEco < 400/(MilkQ.TimesMilkedMult/divnull)
;		fee = (fBasePayout * 0.25) as int
;	elseif varEco < 600/(MilkQ.TimesMilkedMult/divnull)
;		fee = (fBasePayout * 0) as int
;	endif
;	
;	return fee
;EndFunction

float Function CalculateServiceTaxHelper(int varEco)
	float fee = 0
	
	if varEco < 0
		fee = 0.75
	elseif varEco < 200/(MilkQ.TimesMilkedMult/divnull)
		fee = 0.50
	elseif varEco < 400/(MilkQ.TimesMilkedMult/divnull)
		fee = 0.25
	elseif varEco < 600/(MilkQ.TimesMilkedMult/divnull)
		fee = 0
	endif
	
	return fee
EndFunction

int Function GetMarketIndexFromLocation(Location marketLocation)
	string locName = marketLocation.GetName()
	
	;milkpump locations
	;inn locations
	if locName == locDawnstar.GetName() || locName == locDawnstarSanctuary.GetName()\
	|| locName == DawnstarWindpeakInnLocation.GetName()
		return 1
	elseif locName == locFalkreath.GetName()\
	|| locName == FalkreathDeadMansDrinkLocation.GetName()
		return 2
	elseif locName == locMarkarth.GetName() || locName == locOldHroldan.GetName() || locName == locKarthwasten.GetName()\
	|| locName == OldHroldanInnLocation.GetName() || locName == MarkarthSilverBloodInnLocation.GetName()
		return 3
	elseif locName == locMorKhazgur.GetName() || locName == locDushnikhYal.GetName() || locName == locNarzulbur.GetName() || locName == locLargashbur.GetName()
		return 4
	elseif locName == locRiften.GetName() || locName == locShorsStone.GetName()\
	|| locName == RiftenBeeandBarbLocation.GetName() || locName == IvarsteadVilemyrInnLocation.GetName()
		return 5
	elseif locName == locSolitude.GetName() || locName == locDragonBridge.GetName() || locName == locMorthal.GetName()\
	|| locName == DragonBridgeFourShieldsTavernLocation.GetName() || locName == MorthalMoorsideInnLocation.GetName() || locName == SolitudeWinkingSkeeverLocation.GetName()
		return 6
	elseif locName == locWhiterun.GetName() || locName == locRiverwood.GetName() || locName == locRorikstead.GetName()\
	|| locName == RiverwoodSleepingGiantInnLocation.GetName() || locName == WhiterunBanneredMareLocation.GetName() || locName == RoriksteadFrostfruitInnLocation.GetName()
		return 7
	elseif locName == locWindhelm.GetName() || locName == locWinterhold.GetName() || locName == locCollegeofWinterhold.GetName() || locName == locKynesgrove.GetName()\
	|| locName == WindhelmCandlehearthHallLocation.GetName() || locName == WindhelmNewGnisisCornerclubLocation.GetName() || locName == WinterholdTheFrozenHearthLocation.GetName() || locName == KynesgroveBraidwoodInnLocation.GetName()
		return 8
		
	;DLC
	elseif locName == locHeljarchenHall.GetName() || locName == locWindstadManor.GetName()										;MilkQ.Plugin_HearthFires
		return 1
	elseif locName == locLakeviewManor.GetName() 																				;MilkQ.Plugin_HearthFires
		return 2
	elseif locName == locFortDawnguard.GetName() || locName == locDayspringCanyon.GetName()										;MilkQ.Plugin_Dawnguard
		return 5
	elseif locName == locRavenRock.GetName() || locName == locSkaalVillage.GetName() || locName == locTelMithryn.GetName()		;MilkQ.Plugin_Dragonborn
		return 9

	;none of above, returning khajit caravan
	else
		return 0
	endif
EndFunction

int Function GetRaceIndexFromRace(Race maidRace)

	if maidRace == MilkQ.MME_Races.GetAt(0)	;highelf
		return 1
	elseif maidRace == MilkQ.MME_Races.GetAt(1)	;argonian
		return 2
	elseif maidRace == MilkQ.MME_Races.GetAt(2)	;woodelf
		return 3
	elseif maidRace == MilkQ.MME_Races.GetAt(3)	;breton
		return 4
	elseif maidRace == MilkQ.MME_Races.GetAt(4)	;darkelf
		return 5
	elseif maidRace == MilkQ.MME_Races.GetAt(5)	;imperial
		return 6
	elseif maidRace == MilkQ.MME_Races.GetAt(6)	;khajiit
		return 7
	elseif maidRace == MilkQ.MME_Races.GetAt(7)	;nord
		return 8
	elseif maidRace == MilkQ.MME_Races.GetAt(8)	;orc
		return 9
	elseif maidRace == MilkQ.MME_Races.GetAt(9)	;redguard
		return 10
	else 									;exotic
		return 11
	endif
EndFunction

int Function GetRaceIndexFromMilk(Potion Milk)
	if MilkQ.MME_Milk_Altmer_Normal.Find(Milk) != -1			;highelf
		return 1
	elseif MilkQ.MME_Milk_Argonian_Normal.Find(Milk) != -1		;argonian
		return 2
	elseif MilkQ.MME_Milk_Bosmer_Normal.Find(Milk) != -1		;woodelf
		return 3
	elseif MilkQ.MME_Milk_Breton_Normal.Find(Milk) != -1		;breton
		return 4
	elseif MilkQ.MME_Milk_Dunmer_Normal.Find(Milk) != -1		;darkelf
		return 5
	elseif MilkQ.MME_Milk_Imperial_Normal.Find(Milk) != -1		;imperial
		return 6
	elseif MilkQ.MME_Milk_Khajiit_Normal.Find(Milk) != -1		;khajiit
		return 7
	elseif MilkQ.MME_Milk_Nord_Normal.Find(Milk) != -1			;nord
		return 8
	elseif MilkQ.MME_Milk_Orc_Normal.Find(Milk) != -1			;orc
		return 9
	elseif MilkQ.MME_Milk_Redguard_Normal.Find(Milk) != -1		;redguard
		return 10
	elseif MilkQ.MME_Milk_Exotic_Normal.Find(Milk) != -1		;exotic
		return 11
		
	;these never used in eco
	elseif MilkQ.MME_Milk_Vampire.Find(Milk) != -1				;vampire
		return 12
	elseif MilkQ.MME_Milk_Werewolf.Find(Milk) != -1				;werewolf
		return 13
	elseif MilkQ.MME_Milk_Succubus.Find(Milk) != -1				;succubus
		return 14
	else 														;basic
		return 15
	endif
EndFunction

Function UpdateEconomy(int marketIndex, int basePayout)
	int newValue = 0
	; Cannot count on the arrays
	
	if marketIndex == 0
		newValue = MilkEcoCaravan
	elseif marketIndex == 1
		newValue = MilkEcoDawnstar
	elseif marketIndex == 2
		newValue = MilkEcoFalkreath 
	elseif marketIndex == 3
		newValue = MilkEcoMarkarth
	elseif marketIndex == 4
		newValue = MilkEcoOrc
	elseif marketIndex == 5
		newValue = MilkEcoRiften
	elseif marketIndex == 6
		newValue = MilkEcoSolitude
	elseif marketIndex == 7
		newValue = MilkEcoWhiterun
	elseif marketIndex == 8
		newValue = MilkEcoWindhelm
	elseif marketIndex == 9
		newValue = MilkEcoMorrowind
	endif	

	newValue = newValue - basePayout
	if divnull != 0 && MilkQ.TimesMilkedMult != 0
		if newValue < -500/(MilkQ.TimesMilkedMult/divnull)
			newValue = -500/(MilkQ.TimesMilkedMult/divnull)
		endif
	endif

	if newValue < 0 && MilkQ.MilkEMsgs && marketIndex == GetMarketIndexFromLocation(Game.GetPlayer().GetCurrentLocation()) && marketIndex != 0
		Debug.Notification("There is no demand for milk " + MarketNames[marketIndex] + "!")
	endif

	if marketIndex == 0
		MilkEcoCaravan = newValue
	elseif marketIndex == 1
		MilkEcoDawnstar = newValue
	elseif marketIndex == 2
		MilkEcoFalkreath= newValue
	elseif marketIndex == 3
		MilkEcoMarkarth = newValue
	elseif marketIndex == 4
		MilkEcoOrc = newValue
	elseif marketIndex == 5
		MilkEcoRiften = newValue
	elseif marketIndex == 6
		MilkEcoSolitude = newValue
	elseif marketIndex == 7
		MilkEcoWhiterun = newValue
	elseif marketIndex == 8
		MilkEcoWindhelm = newValue
	elseif marketIndex == 9
		MilkEcoMorrowind = newValue
	endif
EndFunction

Function BeginMilkEcoCycle()
	PrevMilkEcos = new Int[10]
	CurrMilkEcos = new Int[10]
	
	PrevMilkEcos[0] = MilkEcoCaravan
	PrevMilkEcos[1] = MilkEcoDawnstar
	PrevMilkEcos[2] = MilkEcoFalkreath
	PrevMilkEcos[3] = MilkEcoMarkarth
	PrevMilkEcos[4] = MilkEcoOrc
	PrevMilkEcos[5] = MilkEcoRiften
	PrevMilkEcos[6] = MilkEcoSolitude
	PrevMilkEcos[7] = MilkEcoWhiterun
	PrevMilkEcos[8] = MilkEcoWindhelm
	PrevMilkEcos[9] = MilkEcoMorrowind

	CurrMilkEcos[0] = PrevMilkEcos[0]
	CurrMilkEcos[1] = PrevMilkEcos[1]
	CurrMilkEcos[2] = PrevMilkEcos[2]
	CurrMilkEcos[3] = PrevMilkEcos[3]
	CurrMilkEcos[4] = PrevMilkEcos[4]
	CurrMilkEcos[5] = PrevMilkEcos[5]
	CurrMilkEcos[6] = PrevMilkEcos[6]
	CurrMilkEcos[7] = PrevMilkEcos[7]
	CurrMilkEcos[8] = PrevMilkEcos[8]
	CurrMilkEcos[9] = PrevMilkEcos[9]
EndFunction

Function EndMilkEcoCycle()
	int index = 0
	while index < 10
		if MilkQ.MilkEMsgs && index == GetMarketIndexFromLocation(Game.GetPlayer().GetCurrentLocation())
			if PrevMilkEcos[index] < 1000/(MilkQ.TimesMilkedMult/divnull) && CurrMilkEcos[index] == 1000/(MilkQ.TimesMilkedMult/divnull) && MilkQ.MilkEMsgs
				Debug.Notification("The demand for milk " + MarketNames[index] + " is high!")
			endif
			if PrevMilkEcos[index] <= 0 && CurrMilkEcos[index] > 0 && MilkQ.MilkEMsgs
				Debug.Notification("Milk demand has normalized " + MarketNames[index] + ".")
			endif
		endif

		index += 1
	endwhile

	MilkEcoCaravan = CurrMilkEcos[0]
	MilkEcoDawnstar = CurrMilkEcos[1]
	MilkEcoFalkreath = CurrMilkEcos[2]
	MilkEcoMarkarth = CurrMilkEcos[3]
	MilkEcoOrc = CurrMilkEcos[4]
	MilkEcoRiften = CurrMilkEcos[5]
	MilkEcoSolitude = CurrMilkEcos[6]
	MilkEcoWhiterun = CurrMilkEcos[7]
	MilkEcoWindhelm = CurrMilkEcos[8]
	MilkEcoMorrowind = CurrMilkEcos[9]

 	MilkDemandCaravan = MilkDemands[0]
 	MilkDemandDawnstar = MilkDemands[1]
	MilkDemandFalkreath = MilkDemands[2]
	MilkDemandMarkarth = MilkDemands[3]
	MilkDemandOrc = MilkDemands[4]
	MilkDemandRiften = MilkDemands[5]
	MilkDemandSolitude = MilkDemands[6]
	MilkDemandWhiterun = MilkDemands[7]
	MilkDemandWindhelm = MilkDemands[8]
	MilkDemandMorrowind = MilkDemands[9]
EndFunction

Function MilkEcoRestore()
	int index = 0
	while index < 10
		CurrMilkEcos[index] = PrevMilkEcos[index] + 100/(MilkQ.TimesMilkedMult/divnull)
		if CurrMilkEcos[index] > 1000/(MilkQ.TimesMilkedMult/divnull)
			CurrMilkEcos[index] = 1000/(MilkQ.TimesMilkedMult/divnull)
		endif

		index += 1
	endwhile
EndFunction

Function MilkEcoSaturationEvent()
	int[] marketsAtCap = new int[10]
	int j = 0										; count of marketsAtCap
	int i = 0
	while i < 10
		if CurrMilkEcos[i] == 1000/(MilkQ.TimesMilkedMult/divnull)
			marketsAtCap[j] = i
			j += 1
		endif
		i += 1
	endwhile

	; Reduce Market indices if more than 5 markets at cap at the same time.
	if j >= 4
		; Notification("Saturation Event has been hit")
		j -= 1
		while j >= 0
			int k = Utility.RandomInt(0, SaturationPenalties.Length - 1)
			int l = marketsAtCap[j]
			CurrMilkEcos[l] = CurrMilkEcos[l] - SaturationPenalties[k]
			j -= 1
		endwhile
	endif
EndFunction

Function MilkEcoDemandEvent()
	int i = 0
	int j = 0										; count of marketsWithDemand
	int[] marketsWithDemand = new int[10]
	int k = 0										; count of marketsWithoutDemand
	int[] marketsWithoutDemand = new int[10]
	while i < 10
		if MilkDemandCDs[i] > 0
			MilkDemandCDs[i] = MilkDemandCDs[i] - 1
			if MilkDemandCDs[i] == 0
				if MilkQ.MilkEMsgs && i == GetMarketIndexFromLocation(Game.GetPlayer().GetCurrentLocation()) && i != 0
					Debug.Notification("Craze for " + MilkNames[MilkDemands[i]] + " " + MarketNames[i] + " has faded.")
				endif
				MilkDemands[i] = 0					; Set demand to nothing
				marketsWithDemand[j] = i			; Exclude most recently retired ones
				j += 1
			else
				marketsWithDemand[j] = i
				j += 1
			endif
		else
			marketsWithoutDemand[k] = i
			k += 1
		endif
		i += 1
	endwhile

	if k > 0
		; The fewer demands going on, the higher chance a demand appears
		int chance = Utility.RandomInt(0, 100 + (j - k) * 5)
		; Notification("Chance is: " + chance)
		if chance <= 49
			int randomMarket = Utility.RandomInt(0, k - 1)
			int marketIndex = marketsWithoutDemand[randomMarket]
			int milkIndex = Utility.RandomInt(1, 10)
			MilkDemands[marketIndex] = milkIndex
			MilkDemandCDs[marketIndex] = 6
			if MilkQ.MilkEMsgs && marketIndex == GetMarketIndexFromLocation(Game.GetPlayer().GetCurrentLocation()) && marketIndex != 0
				Debug.Notification(MilkNames[milkIndex] + " craze has begun " + MarketNames[marketIndex]) 
			endif
			; if demand is poor, immediately raise to an acceptable level
			if CurrMilkEcos[marketIndex] < 750/(MilkQ.TimesMilkedMult/divnull)
				CurrMilkEcos[marketIndex] = 750/(MilkQ.TimesMilkedMult/divnull)
			endif
		endif
	endif
EndFunction