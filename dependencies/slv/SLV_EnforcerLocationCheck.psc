Scriptname SLV_EnforcerLocationCheck extends Quest 

SLV_MCMMenu Property MCMMenu Auto
SLV_Utilities Property SLV_UtilitiesScript Auto
Actor Property PlayerRef Auto
Quest Property SLV_MainquestQuest Auto
Quest Property SLV_Mainquest2Quest Auto

Bool Function SLV_IsSkyrimFree()
return SLV_IsWhiterunFree()
EndFunction	

Bool Function SLV_IsWhiterunFree()
if SLV_MainquestQuest.GetStage() < 1000 || SLV_MainquestQuest.GetStage() >= 50000
	return true
endif
if SLV_Mainquest2Quest.GetStage() >= 12000
	return true
endif
return false
EndFunction	

Bool Function SLV_IsRiverwoodFree()
if SLV_MainquestQuest.GetStage() < 2000 || SLV_MainquestQuest.GetStage() >= 50000
	return true
endif
if SLV_Mainquest2Quest.GetStage() >= 11000
	return true
endif
return false
EndFunction

Bool Function SLV_IsFalkreathFree()
if SLV_MainquestQuest.GetStage() < 3000 || SLV_MainquestQuest.GetStage() >= 50000
	return true
endif
if SLV_Mainquest2Quest.GetStage() >= 10000
	return true
endif
return false
EndFunction

Bool Function SLV_IsDawnstarFree()
if SLV_MainquestQuest.GetStage() < 4000 || SLV_MainquestQuest.GetStage() >= 50000
	return true
endif
if SLV_Mainquest2Quest.GetStage() >= 9000
	return true
endif
return false
EndFunction

Bool Function SLV_IsMarkarthFree()
if SLV_MainquestQuest.GetStage() < 5000 || SLV_MainquestQuest.GetStage() >= 50000
	return true
endif
if SLV_Mainquest2Quest.GetStage() >= 8000
	return true
endif
return false
EndFunction

Bool Function SLV_IsRiftenFree()
if SLV_MainquestQuest.GetStage() < 6000 || SLV_MainquestQuest.GetStage() >= 50000
	return true
endif
if SLV_Mainquest2Quest.GetStage() >= 7000
	return true
endif
return false
EndFunction

Bool Function SLV_IsMorthalFree()
if SLV_MainquestQuest.GetStage() < 7000 || SLV_MainquestQuest.GetStage() >= 50000
	return true
endif
if SLV_Mainquest2Quest.GetStage() >= 6000
	return true
endif
return false
EndFunction

Bool Function SLV_IsWinterholdFree()
if SLV_MainquestQuest.GetStage() < 8000 || SLV_MainquestQuest.GetStage() >= 50000
	return true
endif
if SLV_Mainquest2Quest.GetStage() >= 5000
	return true
endif
return false
EndFunction

Bool Function SLV_IsRavenRockFree()
if SLV_MainquestQuest.GetStage() < 11000 || SLV_MainquestQuest.GetStage() >= 50000
	return true
endif
if SLV_Mainquest2Quest.GetStage() >= 4000
	return true
endif
return false
EndFunction

Bool Function SLV_IsWindhelmFree()
if SLV_MainquestQuest.GetStage() < 9000 || SLV_MainquestQuest.GetStage() >= 50000
	return true
endif
if SLV_Mainquest2Quest.GetStage() >= 3000
	return true
endif
return false
EndFunction

Bool Function SLV_IsSolitudeFree()
if SLV_MainquestQuest.GetStage() < 10000 || SLV_MainquestQuest.GetStage() >= 50000
	return true
endif
if SLV_Mainquest2Quest.GetStage() >= 2000
	return true
endif
return false
EndFunction
	
; Globals
String PlayerCurrentWorldName = ""
String PlayerCurrentLocationName = ""
Bool OpenCitiesFound = false
WorldSpace PlayerCurrentWorld
Location PlayerCurrentLocation
string[] cellnames
string File = "../Slaverun/SlaverunConfig.json"
int cellcount = 0
int count
	

Bool Function PlayerIsInEnforcedLocation()

if PlayerIsInAEnforcedLocation() > 0
	return true
else
	return false
endif
EndFunction


int Function PlayerIsInAEnforcedLocation()
; init variables	
PlayerCurrentWorld = PlayerRef.GetWorldSpace()
PlayerCurrentWorldName = ""
if PlayerCurrentWorld == None 
	PlayerCurrentWorldName = ""
else
	PlayerCurrentWorldName = PlayerCurrentWorld.GetName()
endif

PlayerCurrentLocation = PlayerRef.GetCurrentLocation()
PlayerCurrentLocationName = ""
if PlayerCurrentLocation == None 
	PlayerCurrentLocationName =""
else
	PlayerCurrentLocationName = PlayerCurrentLocation.GetName()
endif

SLV_UtilitiesScript.SLV_DisplayDebug2("Location = (" + PlayerCurrentLocationName + ") Worldspace = (" + PlayerCurrentWorldName + ")")
	
if PlayerCurrentLocation == None 
	SLV_UtilitiesScript.SLV_DisplayDebug1("PlayerCurrentLocation is null")
	return 0
endif
	
; is Skyrim free?
if SLV_IsSkyrimFree()
	return 0
endif

OpenCitiesFound = false
if  Game.GetModByName("Open Cities Skyrim.esp") != 255
	OpenCitiesFound = true
else
	OpenCitiesFound = false
endif

;string[] cellnames
File = "../Slaverun/SlaverunConfig.json"
cellcount = 0

cellcount = JsonUtil.StringListCount(File, "excludelocations")
cellnames= Utility.ResizeStringArray(cellnames, cellcount)
JsonUtil.StringListSlice(File, "excludelocations", cellnames)
count = cellcount - 1
	
SLV_UtilitiesScript.SLV_DisplayDebug1("Exclude locs: " + cellcount)
while count >= 0
	SLV_UtilitiesScript.SLV_DisplayDebug1("Exclude loc name :" + cellnames[count])
	SLV_UtilitiesScript.SLV_DisplayDebug1("Player loc name :" + PlayerCurrentLocationName)
	
	if cellnames[count] != "" && PlayerCurrentLocationName == cellnames[count]
		SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in :" + cellnames[count])
		cellnames= Utility.ResizeStringArray(cellnames, 0)
		return 0
	endif
	count = count - 1
endwhile
cellnames= Utility.ResizeStringArray(cellnames, 0)
		
	
; is Whiterun still free?
if !SLV_IsWhiterunFree()
	if SLV_IsPlayerInWhiterun()
		return 1
	endif
endif	
	
; is Riverwood still free?
if !SLV_IsRiverwoodFree()
	if SLV_IsPlayerInRiverwood()
		return 2
	endif
endif	
	
; is Falkreath still free?
if !SLV_IsFalkreathFree()
	if SLV_IsPlayerInFalkreath()
		return 3
	endif
endif	
	
; is Dawnstar still free?
if !SLV_IsDawnstarFree()
	if SLV_IsPlayerInDawnstar()
		return 4
	endif
endif	
	
; is Markarth still free?
if !SLV_IsMarkarthFree()
	if SLV_IsPlayerInMarkarth()
		return 5
	endif
endif	
	
; is Riften still free?
if !SLV_IsRiftenFree()
	if SLV_IsPlayerInRiften()
		return 6
	endif
endif	
	
; is Morthal still free?
if !SLV_IsMorthalFree()
	if SLV_IsPlayerInMorthal()
		return 7
	endif
endif	
	
; is Winterhold still free?
if !SLV_IsWinterholdFree()
	if SLV_IsPlayerInWinterhold()
		return 8
	endif
endif	
	
; is Windhelm still free?
if !SLV_IsWindhelmFree()
	if SLV_IsPlayerInWindhelm()
		return 9
	endif
endif	
	
; is Solitude still free?
if !SLV_IsSolitudeFree()
	if SLV_IsPlayerInSolitude()
		return 10
	endif
endif	

; is RavenRock still free?
if !SLV_IsRavenRockFree()
	if SLV_IsPlayerInRavenRock()
		return 11
	endif
endif
	
return 0;
EndFunction	
	
	


Bool Function SLV_IsPlayerInWhiterun()
	SLV_UtilitiesScript.SLV_DisplayDebug2("Now checking Whiterun Locations")
	;if PlayerCurrentLocation == WhiterunBreezehomeLocation
		;return false
	;endif
	if PlayerCurrentWorld == WhiterunWorld
		SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in WhiterunWorld")
		return true
	endif
	if PlayerCurrentLocationName == "Whiterun" && OpenCitiesFound 
		SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in Whiterun Opencities")
		return true
	endif
	
	if !MCMMenu.EnforcerLocationJSON
		if PlayerCurrentLocation == WhiterunAmrensHouseLocation
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in WhiterunAmrensHouseLocation")
			return true
		endif
		if PlayerCurrentLocation == WhiterunArcadiasCauldronLocation
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in WhiterunArcadiasCauldronLocation")
			return true
		endif
		if PlayerCurrentLocation == WhiterunBanneredMareLocation
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in WhiterunBanneredMareLocation")
			return true
		endif
		if PlayerCurrentLocation == WhiterunBelethorsGeneralGoodsLocation
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in WhiterunBelethorsGeneralGoodsLocation")
			return true
		endif
		if PlayerCurrentLocation == WhiterunCarlottaValentiasHouseLocation
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in WhiterunCarlottaValentiasHouseLocation")
			return true
		endif
		if PlayerCurrentLocation == WhiterunDragonsreachBasementLocation
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in WhiterunDragonsreachBasementLocation")
			return true
		endif
		if PlayerCurrentLocation == WhiterunDragonsreachLocation
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in WhiterunDragonsreachLocation")
			return true
		endif
		if PlayerCurrentLocation == WhiterunDrunkenHuntsmanLocation
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in WhiterunDrunkenHuntsmanLocation")
			return true
		endif
		if PlayerCurrentLocation == WhiterunGuardHouseLocation
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in WhiterunGuardHouseLocation")
			return true
		endif
		If PlayerCurrentLocation == WhiterunHeimskrsHouseLocation 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in WhiterunHeimskrsHouseLocation")
			return true
		endif
		If PlayerCurrentLocation == WhiterunHouseGrayManeLocation 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in WhiterunHouseGrayManeLocation")
			return true
		endif
		If PlayerCurrentLocation == WhiterunHouseofClanBattleBornLocation 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in WhiterunHouseofClanBattleBornLocation")
			return true
		endif
		If PlayerCurrentLocation == WhiterunHouseoftheDeadLocation 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in WhiterunHouseoftheDeadLocation")
			return true
		endif
		;If PlayerCurrentLocation == WhiterunJailLocation 
			;SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in WhiterunJailLocation")
			;return true
		;endif
		If PlayerCurrentLocation == WhiterunJorrvaskrBasementLocation 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in WhiterunJorrvaskrBasementLocation")
			return true
		endif
		If PlayerCurrentLocation == WhiterunJorrvaskrLocation 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in WhiterunJorrvaskrLocation")
			return true
		endif
		If PlayerCurrentLocation == WhiterunOlavatheFeeblesHouseLocation 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in WhiterunOlavatheFeeblesHouseLocation")
			return true
		endif
		If PlayerCurrentLocation == WhiterunSeverioPelagiasHouseLocation 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in WhiterunSeverioPelagiasHouseLocation")
			return true
		endif
		;If PlayerCurrentLocation == WhiterunTempleofKynarethLocation 
			;SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in WhiterunTempleofKynarethLocation")
			;return true
		;endif
		If PlayerCurrentLocation == WhiterunUlfberthsHouseLocation 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in WhiterunUlfberthsHouseLocation")
			return true
		endif
		If PlayerCurrentLocation == WhiterunUnderforgeInteriorLocation 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in WhiterunUnderforgeInteriorLocation")
			return true
		endif
		If PlayerCurrentLocation == WhiterunUthgerdTheUnbrokensHouseLocation 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in WhiterunUthgerdTheUnbrokensHouseLocation")
			return true
		endif
		If PlayerCurrentLocation == WhiterunWarmaidensLocation 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in WhiterunWarmaidensLocation")
			return true
		endif
		If PlayerCurrentLocation == WhiterunYsoldasHouseLocation
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in WhiterunYsoldasHouseLocation")
			return true
		endif
		If PlayerCurrentLocation == SLV_ColosseumEnforcerLocation
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in SLV_ColosseumEnforcerLocation")
			return true
		endif
		
	endif

	;string[] cellnames
	;string File = "../Slaverun/SlaverunConfig.json"
	;int cellcount = 0

	cellcount = JsonUtil.StringListCount(File, "whiterunlocations")
	cellnames= Utility.ResizeStringArray(cellnames, cellcount)
	JsonUtil.StringListSlice(File, "whiterunlocations", cellnames)
	count = cellcount - 1
	
	SLV_UtilitiesScript.SLV_DisplayDebug1("Whiterun locs: " + cellcount)
	while count >= 0
		SLV_UtilitiesScript.SLV_DisplayDebug1("Whiterun loc name :" + cellnames[count])
		SLV_UtilitiesScript.SLV_DisplayDebug1("Player loc name :" + PlayerCurrentLocationName)
		
		if cellnames[count] != "" && PlayerCurrentLocationName == cellnames[count]
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in :" + cellnames[count])
			cellnames= Utility.ResizeStringArray(cellnames, 0)
			return true
		endif
		count = count - 1
	endwhile
	cellnames= Utility.ResizeStringArray(cellnames, 0)

	return false
EndFunction
	


Bool Function SLV_IsPlayerInRiverwood()
	SLV_UtilitiesScript.SLV_DisplayDebug2("Now checking Riften Locations")
	if PlayerCurrentLocation == RiverwoodLocation
		SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in RiverwoodLocation")
		return true
	endif		
	if !MCMMenu.EnforcerLocationJSON
		if PlayerCurrentLocation == RiverwoodAlvorsHouse 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in RiverwoodAlvorsHouse")
			return true
		endif
		if PlayerCurrentLocation == RiverwoodFaendalsHouse 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in RiverwoodFaendalsHouse")
			return true
		endif
		if PlayerCurrentLocation == RiverwoodGerdursHouse 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in RiverwoodGerdursHouse")
			return true
		endif
		if PlayerCurrentLocation == RiverwoodRiverwoodTrader
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in RiverwoodRiverwoodTrader")
			return true
		endif	
		if PlayerCurrentLocation == RiverwoodSleepingGiantInn 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in RiverwoodSleepingGiantInn")
			return true
		endif	
		if PlayerCurrentLocation == RiverwoodSvensHouse 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in RiverwoodSvensHouse")
			return true
		endif
	endif

	cellcount = JsonUtil.StringListCount(File, "riverwoodlocations")
	cellnames= Utility.ResizeStringArray(cellnames, cellcount)
	JsonUtil.StringListSlice(File, "riverwoodlocations", cellnames)
	count = cellcount - 1
	
	SLV_UtilitiesScript.SLV_DisplayDebug1("Riverwood locs: " + cellcount)
	while count >= 0
		SLV_UtilitiesScript.SLV_DisplayDebug1("Riverwood loc name :" + cellnames[count])
		SLV_UtilitiesScript.SLV_DisplayDebug1("Player loc name :" + PlayerCurrentLocationName)
		
		if cellnames[count] != "" && PlayerCurrentLocationName == cellnames[count]
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in :" + cellnames[count])
			cellnames= Utility.ResizeStringArray(cellnames, 0)
			return true
		endif
		count = count - 1
	endwhile
	cellnames= Utility.ResizeStringArray(cellnames, 0)

	return false
EndFunction
	


Bool Function SLV_IsPlayerInFalkreath()
	SLV_UtilitiesScript.SLV_DisplayDebug2("Now checking Falkreath Locations")
	if !MCMMenu.EnforcerLocationJSON
		if PlayerCurrentLocation == FalkreathBarracks 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in FalkreathBarracks")
			return true
		endif	
		;if PlayerCurrentLocation == FalkreathBarracksJail 
			;SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in FalkreathBarracksJail")
			;return true
		;endif	
		if PlayerCurrentLocation == FalkreathCorpselightFarm 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in FalkreathCorpselightFarm")
			return true
		endif	
		if PlayerCurrentLocation == FalkreathDeadMansDrink 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in FalkreathDeadMansDrink")
			return true
		endif	
		if PlayerCurrentLocation == FalkreathDengeirsHall 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in FalkreathDengeirsHall")
			return true
		endif	
		if PlayerCurrentLocation == FalkreathGrayPineGoods 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in FalkreathGrayPineGoods")
			return true
		endif	
		if PlayerCurrentLocation == Falkreath 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in Falkreath")
			return true
		endif
		;if PlayerCurrentLocation == FalkreathHouseofArkay 
			;SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in FalkreathHouseofArkay")
			;return true
		;endif
		if PlayerCurrentLocation == FalkreathJarlsLonghouse 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in FalkreathJarlsLonghouse")
			return true
		endif
		if PlayerCurrentLocation == FalkreathLodsHouse 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in FalkreathLodsHouse")
			return true
		endif
	endif

	cellcount = JsonUtil.StringListCount(File, "falkreathlocations")
	cellnames= Utility.ResizeStringArray(cellnames, cellcount)
	JsonUtil.StringListSlice(File, "falkreathlocations", cellnames)
	count = cellcount - 1
	
	SLV_UtilitiesScript.SLV_DisplayDebug1("Falkreath locs: " + cellcount)
	while count >= 0
		SLV_UtilitiesScript.SLV_DisplayDebug1("Falkreath loc name :" + cellnames[count])
		SLV_UtilitiesScript.SLV_DisplayDebug1("Player loc name :" + PlayerCurrentLocationName)
		
		if cellnames[count] != "" && PlayerCurrentLocationName == cellnames[count]
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in :" + cellnames[count])
			return true
		endif
		count = count - 1
	endwhile
	return false
EndFunction
	

	
Bool Function SLV_IsPlayerInDawnstar()
	SLV_UtilitiesScript.SLV_DisplayDebug2("Now checking Dawnstar Locations")
	if !MCMMenu.EnforcerLocationJSON
		if PlayerCurrentLocation == DawnstarBarracks 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in DawnstarBarracks")
			return true
		endif
		if PlayerCurrentLocation == Dawnstar 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in Dawnstar")
			return true
		endif
		if PlayerCurrentLocation == DawnstarBeitildsHouse 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in DawnstarBeitildsHouse")
			return true
		endif
		if PlayerCurrentLocation == DawnstarBrinasHouse 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in DawnstarBrinasHouse")
			return true
		endif
		if PlayerCurrentLocation == DawnstarFrukisHouse 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in DawnstarFrukisHouse")
			return true
		endif
		if PlayerCurrentLocation == DawnstarIrgnirsHouse 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in DawnstarIrgnirsHouse")
			return true
		endif
		if PlayerCurrentLocation == DawnstarLeigelfsHouse 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in DawnstarLeigelfsHouse")
			return true
		endif
		if PlayerCurrentLocation == DawnstarMortarandPestle 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in DawnstarMortarandPestle")
			return true
		endif
		if PlayerCurrentLocation == DawnstarRustleifsHouse 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in DawnstarRustleifsHouse")
			return true
		endif
		if PlayerCurrentLocation == DawnstarSanctuary 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in DawnstarSanctuary")
			return true
		endif
		if PlayerCurrentLocation == DawnstarSilussHouse 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in DawnstarSilussHouse")
			return true
		endif
		if PlayerCurrentLocation == DawnstarTheWhitheHall 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in DawnstarTheWhitheHall")
			return true
		endif
		if PlayerCurrentLocation == DawnstarWindpeakInn 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in DawnstarWindpeakInn")
			return true
		endif
	endif

	cellcount = JsonUtil.StringListCount(File, "dawnstarlocations")
	cellnames= Utility.ResizeStringArray(cellnames, cellcount)
	JsonUtil.StringListSlice(File, "dawnstarlocations", cellnames)
	count = cellcount - 1
	
	SLV_UtilitiesScript.SLV_DisplayDebug1("Dawnstar locs: " + cellcount)
	while count >= 0
		SLV_UtilitiesScript.SLV_DisplayDebug1("Dawnstar loc name :" + cellnames[count])
		SLV_UtilitiesScript.SLV_DisplayDebug1("Player loc name :" + PlayerCurrentLocationName)
		
		if cellnames[count] != "" && PlayerCurrentLocationName == cellnames[count]
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in :" + cellnames[count])
			return true
		endif
		count = count - 1
	endwhile
	return false
EndFunction
	

Bool Function SLV_IsPlayerInMarkarth()
	SLV_UtilitiesScript.SLV_DisplayDebug2("Now checking Markarth Locations")
	if PlayerCurrentWorld == MarkarthWorld
		SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in MarkarthWorld")
		return true
	endif
	if PlayerCurrentLocationName == "Markarth" && OpenCitiesFound 
		SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in Markarth OpenCities")
		return true
	endif
	if !MCMMenu.EnforcerLocationJSON
		if PlayerCurrentLocation == MarkathAbandonedHouse 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in MarkathAbandonedHouse")
			return true
		endif
		if PlayerCurrentLocation == MarkathArnleifandSonsTradingCompany 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in MarkathArnleifandSonsTradingCompany")
			return true
		endif
		if PlayerCurrentLocation == MarkathEndonsHouse 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in MarkathEndonsHouse")
			return true
		endif
		if PlayerCurrentLocation == MarkathGuardTower 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in MarkathGuardTower")
			return true
		endif
		if PlayerCurrentLocation == MarkathHagsCure 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in MarkathHagsCure")
			return true
		endif
		if PlayerCurrentLocation == MarkathHalloftheDead 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in MarkathHalloftheDead")
			return true
		endif
		if PlayerCurrentLocation == MarkathNepossHouse 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in MarkathNepossHouse")
			return true
		endif
		if PlayerCurrentLocation == MarkathOgmundsHouse 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in MarkathOgmundsHouse")
			return true
		endif
		;if PlayerCurrentLocation == MarkathShrineofTalos 
			;SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in MarkathShrineofTalos")
			;return true
		;endif
		if PlayerCurrentLocation == MarkathSilverBloodInn 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in MarkathSilverBloodInn")
			return true
		endif
		if PlayerCurrentLocation == MarkathSmelterOverseersHouse 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in MarkathSmelterOverseersHouse")
			return true
		endif
		if PlayerCurrentLocation == MarkathStableHouse 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in MarkathStableHouse")
			return true
		endif
		if PlayerCurrentLocation == MarkathTreasureyHouse 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in MarkathTreasureyHouse")
			return true
		endif
		if PlayerCurrentLocation == MarkathUnderStonekeep 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in MarkathUnderStonekeep")
			return true
		endif
		;if PlayerCurrentLocation == MarkathVlindrelHall 
			;SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in MarkathVlindrelHall")
			;return true
		;endif
		if PlayerCurrentLocation == MarkathWarrens 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in MarkathWarrens")
			return true
		endif
		if PlayerCurrentLocation == MarkathWizardsQuarter01 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in MarkathWizardsQuarter01")
			return true
		endif
		if PlayerCurrentLocation == MarkathWizardsQuarter02 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in MarkathWizardsQuarter02")
			return true
		endif
		if PlayerCurrentLocation == Markath
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in Markath")
			return true
		endif
	endif

	cellcount = JsonUtil.StringListCount(File, "markarthlocations")
	cellnames= Utility.ResizeStringArray(cellnames, cellcount)
	JsonUtil.StringListSlice(File, "markarthlocations", cellnames)
	count = cellcount - 1
	
	SLV_UtilitiesScript.SLV_DisplayDebug1("Markarth locs: " + cellcount)
	while count >= 0
		SLV_UtilitiesScript.SLV_DisplayDebug1("Markarth loc name :" + cellnames[count])
		SLV_UtilitiesScript.SLV_DisplayDebug1("Player loc name :" + PlayerCurrentLocationName)
		
		if cellnames[count] != "" && PlayerCurrentLocationName == cellnames[count]
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in :" + cellnames[count])
			return true
		endif
		count = count - 1
	endwhile

	return false
EndFunction
	

Bool Function SLV_IsPlayerInRiften()
	SLV_UtilitiesScript.SLV_DisplayDebug2("Now checking Riften Locations")
	if PlayerCurrentWorld == RiftenWorld
		SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in RiftenWorld")
		return true
	endif
	if PlayerCurrentLocationName == "Riften" && OpenCitiesFound 
		SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in Riften OpenCities")
		return true
	endif
	if !MCMMenu.EnforcerLocationJSON
		if PlayerCurrentLocation == RiftenBeeandBarb 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in RiftenBeeandBarb")
			return true
		endif
		if PlayerCurrentLocation == RiftenBeggarsRow 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in RiftenBeggarsRow")
			return true
		endif
		if PlayerCurrentLocation == RiftenBlackBriarManor
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in RiftenBlackBriarManor") 
			return true
		endif
		if PlayerCurrentLocation == RiftenBlackBriarMeadery 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in RiftenBlackBriarMeadery")
			return true
		endif
		if PlayerCurrentLocation == RiftenBlacksmith 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in RiftenBlacksmith")
			return true
		endif
		if PlayerCurrentLocation == RiftenBollisHouse 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in RiftenBollisHouse")
			return true
		endif
		if PlayerCurrentLocation == RiftenElgrimsElixier 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in RiftenElgrimsElixier")
			return true
		endif
		if PlayerCurrentLocation == RiftenEsbernsVault 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in RiftenEsbernsVault")
			return true
		endif
		if PlayerCurrentLocation == RiftenFishery 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in RiftenFishery")
			return true
		endif
		if PlayerCurrentLocation == RiftenHaelgasBunkhouse 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in RiftenHaelgasBunkhouse")
			return true
		endif
		if PlayerCurrentLocation == RiftenHonorhallOrphanage 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in RiftenHonorhallOrphanage")
			return true
		endif
		if PlayerCurrentLocation == RiftenHouseofClanSnowShod 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in RiftenHouseofClanSnowShod")
			return true
		endif
		if PlayerCurrentLocation == RiftenHouseofMjolltheLioness 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in RiftenHouseofMjolltheLioness")
			return true
		endif
		;if PlayerCurrentLocation == RiftenJail01 
			;SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in RiftenJail01")
			;return true
		;endif
		if PlayerCurrentLocation == Riften
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in Riften")
			return true
		endif
		if PlayerCurrentLocation == RiftenMariseAravelsHouse 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in RiftenMariseAravelsHouse")
			return true
		endif
		;if PlayerCurrentLocation == RiftenMausoleum 
			;SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in RiftenMausoleum")
			;return true
		;endif
		if PlayerCurrentLocation == RiftenMercerFreyHouse 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in RiftenMercerFreyHouse")
			return true
		endif
		if PlayerCurrentLocation == RiftenMistveilBarracks
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in RiftenMistveilBarracks") 
			return true
		endif
		if PlayerCurrentLocation == RiftenMistveilKeep 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in RiftenMistveilKeep")
			return true
		endif
		if PlayerCurrentLocation == RiftenMistveilKeepJarlsChambers 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in RiftenMistveilKeepJarlsChambers")
			return true
		endif
		if PlayerCurrentLocation == RiftenPawnedPrawn 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in RiftenPawnedPrawn")
			return true
		endif
		if PlayerCurrentLocation == RiftenRaggedFlagon 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in RiftenRaggedFlagon")
			return true
		endif
		if PlayerCurrentLocation == RiftenRomlynDrethsHouse 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in RiftenRomlynDrethsHouse")
			return true
		endif
		if PlayerCurrentLocation == RiftenStables 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in RiftenStables")
			return true
		endif
		;if PlayerCurrentLocation == RiftenTempleofMara 
			;SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in RiftenTempleofMara")
			;return true
		;endif
		if PlayerCurrentLocation == RiftenValindorsHouse 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in RiftenValindorsHouse")
			return true
		endif
		if PlayerCurrentLocation == RiftenWarehouse 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in RiftenWarehouse")
			return true
		endif
	endif

	cellcount = JsonUtil.StringListCount(File, "riftenlocations")
	cellnames= Utility.ResizeStringArray(cellnames, cellcount)
	JsonUtil.StringListSlice(File, "riftenlocations", cellnames)
	count = cellcount - 1
	
	SLV_UtilitiesScript.SLV_DisplayDebug1("Riften locs: " + cellcount)
	while count >= 0
		SLV_UtilitiesScript.SLV_DisplayDebug1("Riften loc name :" + cellnames[count])
		SLV_UtilitiesScript.SLV_DisplayDebug1("Player loc name :" + PlayerCurrentLocationName)
		
		if cellnames[count] != "" && PlayerCurrentLocationName == cellnames[count]
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in :" + cellnames[count])
			return true
		endif
		count = count - 1
	endwhile

	return false
EndFunction
	

Bool Function SLV_IsPlayerInMorthal()
	SLV_UtilitiesScript.SLV_DisplayDebug2("Now checking Morthal Locations")
	if !MCMMenu.EnforcerLocationJSON
		if PlayerCurrentLocation == MorthalAlvasHouse 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in MorthalAlvasHouse")
			return true
		endif
		if PlayerCurrentLocation == Morthal
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in Morthal") 
			return true
		endif
		if PlayerCurrentLocation == MorthalFalionsHouse
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in MorthalFalionsHouse") 
			return true
		endif
		if PlayerCurrentLocation == MorthalGuardhouse 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in MorthalGuardhouse")
			return true
		endif
		;if PlayerCurrentLocation == MorthalGuardhouseJail 
			;SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in MorthalGuardhouseJail")
			;return true
		;endif
		if PlayerCurrentLocation == MorthalHighmoonHall 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in MorthalHighmoonHall")
			return true
		endif
		if PlayerCurrentLocation == MorthalJorgenandLamisHouse
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in MorthalJorgenandLamisHouse") 
			return true
		endif
		if PlayerCurrentLocation == MorthalMoorsideInn 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in MorthalMoorsideInn")
			return true
		endif
		if PlayerCurrentLocation == MorthalThaumaturgistsHut 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in MorthalThaumaturgistsHut")
			return true
		endif
		if PlayerCurrentLocation == MorthalThonnirsHouse 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in MorthalThonnirsHouse")
			return true
		endif
	endif

	cellcount = JsonUtil.StringListCount(File, "morthallocations")
	cellnames= Utility.ResizeStringArray(cellnames, cellcount)
	JsonUtil.StringListSlice(File, "morthallocations", cellnames)
	count = cellcount - 1
	
	SLV_UtilitiesScript.SLV_DisplayDebug1("Morthal locs: " + cellcount)
	while count >= 0
		SLV_UtilitiesScript.SLV_DisplayDebug1("Morthal loc name :" + cellnames[count])
		SLV_UtilitiesScript.SLV_DisplayDebug1("Player loc name :" + PlayerCurrentLocationName)
		
		if cellnames[count] != "" && PlayerCurrentLocationName == cellnames[count]
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in :" + cellnames[count])
			return true
		endif
		count = count - 1
	endwhile
	return false
EndFunction
	

Bool Function SLV_IsPlayerInWinterhold()
	SLV_UtilitiesScript.SLV_DisplayDebug2("Now checking Winterhold Locations")
	if !MCMMenu.EnforcerLocationJSON
		if PlayerCurrentLocation == WinterholdCollegeArcanaeum 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in WinterholdCollegeArcanaeum")
			return true
		endif
		if PlayerCurrentLocation == WinterholdCollegeArchMageQuarters 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in WinterholdCollegeArchMageQuarters")
			return true
		endif
		if PlayerCurrentLocation == WinterholdCollegeHallofAttainment 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in WinterholdCollegeHallofAttainment")
			return true
		endif
		if PlayerCurrentLocation == WinterholdCollegeHallofCountenance 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in WinterholdCollegeHallofCountenance")
			return true
		endif
		if PlayerCurrentLocation == WinterholdCollegeHalloftheElements 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in WinterholdCollegeHalloftheElements")
			return true
		endif
		if PlayerCurrentLocation == WinterholdCollege
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in WinterholdCollege") 
			return true
		endif
		if PlayerCurrentLocation == WinterholdCollegeMidden
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in WinterholdCollegeMidden")
			return true
		endif
		if PlayerCurrentLocation == WinterholdJarlsLonghouse 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in WinterholdJarlsLonghouse")
			return true
		endif
		if PlayerCurrentLocation == WinterholdKorirsHouse 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in WinterholdKorirsHouse")
			return true
		endif
		if PlayerCurrentLocation == WinterholdRanmirsHouse 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in WinterholdRanmirsHouse")
			return true
		endif
		;if PlayerCurrentLocation == WinterholdTheFrozenHearth 
			;SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in WinterholdTheFrozenHearth")
			;return true
		;endif
		if PlayerCurrentLocation == Winterhold 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in Winterhold")
			return true
		endif
	endif

	cellcount = JsonUtil.StringListCount(File, "winterholdlocations")
	cellnames= Utility.ResizeStringArray(cellnames, cellcount)
	JsonUtil.StringListSlice(File, "winterholdlocations", cellnames)
	count = cellcount - 1
	
	SLV_UtilitiesScript.SLV_DisplayDebug1("Winterhold locs: " + cellcount)
	while count >= 0
		SLV_UtilitiesScript.SLV_DisplayDebug1("Winterhold loc name :" + cellnames[count])
		SLV_UtilitiesScript.SLV_DisplayDebug1("Player loc name :" + PlayerCurrentLocationName)
		
		if cellnames[count] != "" && PlayerCurrentLocationName == cellnames[count]
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in :" + cellnames[count])
			return true
		endif
		count = count - 1
	endwhile

	return false
EndFunction
	

Bool Function SLV_IsPlayerInWindhelm()
	SLV_UtilitiesScript.SLV_DisplayDebug2("Now checking Windhelm Locations")
	if PlayerCurrentWorld == WindhelmWorld
		SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in WindhelmWorld")
		return true
	endif
	if PlayerCurrentLocationName == "Windhelm" && OpenCitiesFound 
		SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in Windhelm OpenCities")
		return true
	endif
	if !MCMMenu.EnforcerLocationJSON
		if PlayerCurrentLocation == WindhelmAretinoResidence 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in WindhelmAretinoResidence")
			return true
		endif
		if PlayerCurrentLocation == WindhelmArgonianAssemblage 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in WindhelmArgonianAssemblage")
			return true
		endif
		if PlayerCurrentLocation == WindhelmAtheronResidence 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in WindhelmAtheronResidence")
			return true
		endif
		if PlayerCurrentLocation == WindhelmBelynHlallusHouse 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in WindhelmBelynHlallusHouse")
			return true
		endif
		if PlayerCurrentLocation == WindhelmBloodworks 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in WindhelmBloodworks")
			return true
		endif
		if PlayerCurrentLocation == WindhelmBrunwulfFreeWintersHouse 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in WindhelmBrunwulfFreeWintersHouse")
			return true
		endif
		if PlayerCurrentLocation == WindhelmCalixtosHouseofCuriosities 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in WindhelmCalixtosHouseofCuriosities")
			return true
		endif
		if PlayerCurrentLocation == WindhelmCandlehearthHall 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in WindhelmCandlehearthHall")
			return true
		endif
		if PlayerCurrentLocation == WindhelmClanShatterShieldOffice 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in WindhelmClanShatterShieldOffice")
			return true
		endif
		if PlayerCurrentLocation == WindhelmEastEmpireCompany 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in WindhelmEastEmpireCompany")
			return true
		endif
		if PlayerCurrentLocation == WindhelmHalloftheDead 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in WindhelmHalloftheDead")
			return true
		endif
		;if PlayerCurrentLocation == WindhelmHjerim 
			;SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in WindhelmHjerim")
			;return true
		;endif
		if PlayerCurrentLocation == WindhelmHouseofClanCruelSea 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in WindhelmHouseofClanCruelSea")
			return true
		endif
		if PlayerCurrentLocation == WindhelmHouseofClanShatterShield 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in WindhelmHouseofClanShatterShield")
			return true
		endif
		if PlayerCurrentLocation == WindhelmNewGnisisCornerclub 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in WindhelmNewGnisisCornerclub")
			return true
		endif
		if PlayerCurrentLocation == WindhelmNiranyesHouse 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in WindhelmNiranyesHouse")
			return true
		endif
		if PlayerCurrentLocation == WindhelmPalaceoftheKings 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in WindhelmPalaceoftheKings")
			return true
		endif
		if PlayerCurrentLocation == WindhelmPalaceUpstairs02 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in WindhelmPalaceUpstairs02")
			return true
		endif
		if PlayerCurrentLocation == WindhelmSadrisUsedWares 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in WindhelmSadrisUsedWares")
			return true
		endif
		if PlayerCurrentLocation == WindhelmStables 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in WindhelmStables")
			return true
		endif
		;if PlayerCurrentLocation == WindhelmTempleofTalos 
			;SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in WindhelmTempleofTalos")
			;return true
		;endif
		if PlayerCurrentLocation == WindhelmViolaGiordanosHouse 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in WindhelmViolaGiordanosHouse")
			return true
		endif
		if PlayerCurrentLocation == WindhelmWarehouse 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in WindhelmWarehouse")
			return true
		endif
		if PlayerCurrentLocation == WindhelmWhitePhial 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in WindhelmWhitePhial")
			return true
		endif
	endif

	cellcount = JsonUtil.StringListCount(File, "windhelmlocations")
	cellnames= Utility.ResizeStringArray(cellnames, cellcount)
	JsonUtil.StringListSlice(File, "windhelmlocations", cellnames)
	count = cellcount - 1
	
	SLV_UtilitiesScript.SLV_DisplayDebug1("Windhelm locs: " + cellcount)
	while count >= 0
		SLV_UtilitiesScript.SLV_DisplayDebug1("Windhelm loc name :" + cellnames[count])
		SLV_UtilitiesScript.SLV_DisplayDebug1("Player loc name :" + PlayerCurrentLocationName)
		
		if cellnames[count] != "" && PlayerCurrentLocationName == cellnames[count]
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in :" + cellnames[count])
			return true
		endif
		count = count - 1
	endwhile

	return false
EndFunction
	


Bool Function SLV_IsPlayerInSolitude()
	SLV_UtilitiesScript.SLV_DisplayDebug2("Now checking Solitude Locations")
	if PlayerCurrentWorld == SolitudeWorld
		SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in SolitudeWorld")
		return true
	endif
	if PlayerCurrentLocationName == "Solitude" && OpenCitiesFound 
		SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in Solitude OpenCities")
		return true
	endif
	if !MCMMenu.EnforcerLocationJSON
		if PlayerCurrentLocation == SolitudeAddvarsHouse 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in SolitudeAddvarsHouse")
			return true
		endif
		if PlayerCurrentLocation == SolitudeAngelinesAromatics 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in SolitudeAngelinesAromatics")
			return true
		endif
		if PlayerCurrentLocation == SolitudeBardsCollege 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in SolitudeBardsCollege")
			return true
		endif
		if PlayerCurrentLocation == SolitudeBitsandPieces 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in SolitudeBitsandPieces")
			return true
		endif
		if PlayerCurrentLocation == SolitudeBlackSmith 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in SolitudeBlackSmith")
			return true
		endif
		if PlayerCurrentLocation == SolitudeBluePalace 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in SolitudeBluePalace")
			return true
		endif
		if PlayerCurrentLocation == SolitudeBrylingsHouse 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in SolitudeBrylingsHouse")
			return true
		endif
		if PlayerCurrentLocation == SolitudeCastleDour 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in SolitudeCastleDour")
			return true
		endif
		if PlayerCurrentLocation == SolitudeCastleDourEmperorsTower 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in SolitudeCastleDourEmperorsTower")
			return true
		endif
		if PlayerCurrentLocation == SolitudeCastleDourTower 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in SolitudeCastleDourTower")
			return true
		endif
		if PlayerCurrentLocation == SolitudeErikursHouse 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in SolitudeErikursHouse")
			return true
		endif
		if PlayerCurrentLocation == SolitudeEvetteSansHouse 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in SolitudeEvetteSansHouse")
			return true
		endif
		if PlayerCurrentLocation == SolitudeFletcher 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in SolitudeFletcher")
			return true
		endif
		if PlayerCurrentLocation == SolitudeHalloftheDead 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in SolitudeHalloftheDead")
			return true
		endif
		;if PlayerCurrentLocation == SolitudeHalloftheDeadCatacombs 
			;SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in SolitudeHalloftheDeadCatacombs")
			;return true
		;endif
		if PlayerCurrentLocation == SolitudeJalasHouse 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in SolitudeJalasHouse")
			return true
		endif
		if PlayerCurrentLocation == Solitude 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in Solitude")
			return true
		endif
		if PlayerCurrentLocation == SolitudeLighthouse 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in SolitudeLighthouse")
			return true
		endif
		if PlayerCurrentLocation == SolitudeRadiantRaiment 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in SolitudeRadiantRaiment")
			return true
		endif
		if PlayerCurrentLocation == SolitudeRedWave 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in SolitudeRedWave")
			return true
		endif
		if PlayerCurrentLocation == SolitudeSawmill 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in SolitudeSawmill")
			return true
		endif
		if PlayerCurrentLocation == SolitudeStables 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in SolitudeStables")
			return true
		endif
		;if PlayerCurrentLocation == SolitudeTempleoftheDivines 
			;SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in SolitudeTempleoftheDivines")
			;return true
		;endif
		if PlayerCurrentLocation == SolitudeVittoriaVicisHouse 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in SolitudeVittoriaVicisHouse")
			return true
		endif
		if PlayerCurrentLocation == SolitudeWinkingSkeever 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in SolitudeWinkingSkeever")
			return true
		endif
		if PlayerCurrentLocation == SolitudeSinkhole01 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in SolitudeSinkhole01")
			return true
		endif
		if PlayerCurrentLocation == SolitudeSinkholeMinesHouse 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in SolitudeSinkholeMinesHouse")
			return true
		endif
	endif
	
	cellcount = JsonUtil.StringListCount(File, "solitudelocations")
	cellnames= Utility.ResizeStringArray(cellnames, cellcount)
	JsonUtil.StringListSlice(File, "solitudelocations", cellnames)
	count = cellcount - 1
	
	SLV_UtilitiesScript.SLV_DisplayDebug1("Solitude locs: " + cellcount)
	while count >= 0
		SLV_UtilitiesScript.SLV_DisplayDebug1("Solitude loc name :" + cellnames[count])
		SLV_UtilitiesScript.SLV_DisplayDebug1("Player loc name :" + PlayerCurrentLocationName)
		
		if cellnames[count] != "" && PlayerCurrentLocationName == cellnames[count]
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in :" + cellnames[count])
			return true
		endif
		count = count - 1
	endwhile

	return false
EndFunction
	


Bool Function SLV_IsPlayerInRavenRock()	
	SLV_UtilitiesScript.SLV_DisplayDebug2("Now checking RavenRock Locations")
	if PlayerCurrentWorld == RavenRockWorld
		SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in RavenRockWorld")
		return true
	endif
	if PlayerCurrentLocationName == "RavenRock" && OpenCitiesFound 
		SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in RavenRock OpenCities")
		return true
	endif
	if !MCMMenu.EnforcerLocationJSON
		if PlayerCurrentLocation == DLC2TelMithrynApothecaryLocation 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in DLC2TelMithrynApothecaryLocation")
			return true
		endif
	endif
	if !MCMMenu.EnforcerLocationJSON
		if PlayerCurrentLocation == DLC2TelMithrynKitchenLocation 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in DLC2TelMithrynKitchenLocation")
			return true
		endif
	endif
	if !MCMMenu.EnforcerLocationJSON
		if PlayerCurrentLocation == DLC2TelMithrynLocation 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in DLC2TelMithrynLocation")
			return true
		endif
	endif	
	if !MCMMenu.EnforcerLocationJSON
		if PlayerCurrentLocation == DLC2TelMithrynStewardLocation 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in DLC2TelMithrynStewardLocation")
			return true
		endif
	endif
	if !MCMMenu.EnforcerLocationJSON
		if PlayerCurrentLocation == DLC2TelMithrynTowerLocation 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in DLC2TelMithrynTowerLocation")
			return true
		endif
	endif
	if !MCMMenu.EnforcerLocationJSON
		if PlayerCurrentLocation == DLC2SVBaldorsHouseLocation 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in DLC2SVBaldorsHouseLocation")
			return true
		endif
	endif
	if !MCMMenu.EnforcerLocationJSON
		if PlayerCurrentLocation == DLC2SVDeorsHouseLocation 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in DLC2SVDeorsHouseLocation")
			return true
		endif
	endif
	if !MCMMenu.EnforcerLocationJSON
		if PlayerCurrentLocation == DLC2SVEdlasHouseLocation 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in DLC2SVEdlasHouseLocation")
			return true
		endif
	endif
	if !MCMMenu.EnforcerLocationJSON
		if PlayerCurrentLocation == DLC2SVGreathallLocation 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in DLC2SVGreathallLocation")
			return true
		endif
	endif
	if !MCMMenu.EnforcerLocationJSON
		if PlayerCurrentLocation == DLC2SVMorwendsHouseLocation 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in DLC2SVMorwendsHouseLocation")
			return true
		endif
	endif
	if !MCMMenu.EnforcerLocationJSON
		if PlayerCurrentLocation == DLC2SVOlslafsHouseLocation 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in DLC2SVOlslafsHouseLocation")
			return true
		endif
	endif
	if !MCMMenu.EnforcerLocationJSON
		if PlayerCurrentLocation == DLC2SVShamansHutLocation 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in DLC2SVShamansHutLocation")
			return true
		endif
	endif
	if !MCMMenu.EnforcerLocationJSON
		if PlayerCurrentLocation == DLC2SVWulfsHouseLocation 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in DLC2SVWulfsHouseLocation")
			return true
		endif
	endif
	if !MCMMenu.EnforcerLocationJSON
		if PlayerCurrentLocation == DLC2SkaalVillageLocation 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in DLC2SkaalVillageLocation")
			return true
		endif
	endif
	if !MCMMenu.EnforcerLocationJSON
		if PlayerCurrentLocation == DLC2RavenRockLocation 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in DLC2RavenRockLocation")
			return true
		endif
	endif
	if !MCMMenu.EnforcerLocationJSON
		if PlayerCurrentLocation == DLC2RavenRockMineLocation 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in DLC2RavenRockMineLocation")
			return true
		endif
	endif
	if !MCMMenu.EnforcerLocationJSON
		if PlayerCurrentLocation == DLC2RRAlorHouseLocation 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in DLC2RRAlorHouseLocation")
			return true
		endif
	endif
	if !MCMMenu.EnforcerLocationJSON
		if PlayerCurrentLocation == DLC2RRBulwarkLocation 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in DLC2RRBulwarkLocation")
			return true
		endif
	endif
	if !MCMMenu.EnforcerLocationJSON
		if PlayerCurrentLocation == DLC2RRCresciusHouseLocation 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in DLC2RRCresciusHouseLocation")
			return true
		endif
	endif
	if !MCMMenu.EnforcerLocationJSON
		if PlayerCurrentLocation == DLC2RRGloverMalloryHouseLocation 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in DLC2RRGloverMalloryHouseLocation")
			return true
		endif
	endif
	if !MCMMenu.EnforcerLocationJSON
		if PlayerCurrentLocation == DLC2RRIenthFarmLocation 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in DLC2RRIenthFarmLocation")
			return true
		endif
	endif
	if !MCMMenu.EnforcerLocationJSON
		if PlayerCurrentLocation == DLC2RRMorwaynManorLocation 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in DLC2RRMorwaynManorLocation")
			return true
		endif
	endif
	if !MCMMenu.EnforcerLocationJSON
		if PlayerCurrentLocation == DLC2RRSeverinManorLocation 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in DLC2RRSeverinManorLocation")
			return true
		endif
	endif
	if !MCMMenu.EnforcerLocationJSON
		if PlayerCurrentLocation == DLC2RRRetchingNetchLocation 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in DLC2RRRetchingNetchLocation")
			return true
		endif
	endif
	if !MCMMenu.EnforcerLocationJSON
		if PlayerCurrentLocation == DLC2RRTempleLocation 
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in DLC2RRTempleLocation")
			return true
		endif
	endif
	
	;string[] cellnames
	File = "../Slaverun/SlaverunConfig.json"
	cellcount = 0

	cellcount = JsonUtil.StringListCount(File, "ravenrocklocations")
	cellnames= Utility.ResizeStringArray(cellnames, cellcount)
	JsonUtil.StringListSlice(File, "ravenrocklocations", cellnames)
	count = cellcount - 1
	
	SLV_UtilitiesScript.SLV_DisplayDebug1("RavenRock locs: " + cellcount)
	while count >= 0
		SLV_UtilitiesScript.SLV_DisplayDebug1("RavenRock loc name :" + cellnames[count])
		SLV_UtilitiesScript.SLV_DisplayDebug1("Player loc name :" + PlayerCurrentLocationName)
		
		if cellnames[count] != "" && PlayerCurrentLocationName == cellnames[count]
			SLV_UtilitiesScript.SLV_DisplayDebug1("Player is in :" + cellnames[count])
			return true
		endif
		count = count - 1
	endwhile

	return false
EndFunction


Location Property WhiterunAmrensHouseLocation auto
Location Property WhiterunArcadiasCauldronLocation auto
Location Property WhiterunBanneredMareLocation auto
Location Property WhiterunBelethorsGeneralGoodsLocation auto
Location Property WhiterunBreezehomeLocation auto
Location Property WhiterunCarlottaValentiasHouseLocation auto
Location Property WhiterunDragonsreachBasementLocation auto
Location Property WhiterunDragonsreachLocation auto
Location Property WhiterunDrunkenHuntsmanLocation auto
Location Property WhiterunGuardHouseLocation auto
Location Property WhiterunHeimskrsHouseLocation auto
Location Property WhiterunHouseGrayManeLocation auto
Location Property WhiterunHouseofClanBattleBornLocation auto
Location Property WhiterunHouseoftheDeadLocation auto
Location Property WhiterunJailLocation auto
Location Property WhiterunJorrvaskrBasementLocation auto
Location Property WhiterunJorrvaskrLocation auto
Location Property WhiterunOlavatheFeeblesHouseLocation auto
Location Property WhiterunSeverioPelagiasHouseLocation auto
Location Property WhiterunTempleofKynarethLocation auto
Location Property WhiterunUlfberthsHouseLocation auto
Location Property WhiterunUnderforgeInteriorLocation auto
Location Property WhiterunUthgerdTheUnbrokensHouseLocation auto
Location Property WhiterunWarmaidensLocation auto
Location Property WhiterunYsoldasHouseLocation auto
Location Property SLV_ColosseumEnforcerLocation auto

Location Property RiverwoodLocation auto
Location Property RiverwoodAlvorsHouse auto
Location Property RiverwoodFaendalsHouse auto
Location Property RiverwoodGerdursHouse auto
Location Property RiverwoodRiverwoodTrader auto
Location Property RiverwoodSleepingGiantInn auto
Location Property RiverwoodSvensHouse auto

Location Property FalkreathBarracks auto
Location Property FalkreathBarracksJail auto
Location Property FalkreathCorpselightFarm auto
Location Property FalkreathDeadMansDrink auto
Location Property FalkreathDengeirsHall auto
Location Property Falkreath auto
Location Property FalkreathGrayPineGoods auto
Location Property FalkreathHouseofArkay auto
Location Property FalkreathJarlsLonghouse auto
Location Property FalkreathLodsHouse auto

Location Property DawnstarBarracks auto
Location Property Dawnstar auto
Location Property DawnstarBeitildsHouse auto
Location Property DawnstarBrinasHouse auto
Location Property DawnstarFrukisHouse auto
Location Property DawnstarIrgnirsHouse auto
Location Property DawnstarLeigelfsHouse auto
Location Property DawnstarMortarandPestle auto
Location Property DawnstarRustleifsHouse auto
Location Property DawnstarSanctuary auto
Location Property DawnstarSilussHouse auto
Location Property DawnstarTheWhitheHall auto
Location Property DawnstarWindpeakInn auto

Location Property MarkathAbandonedHouse auto
Location Property MarkathArnleifandSonsTradingCompany auto
Location Property MarkathEndonsHouse auto
Location Property MarkathGuardTower auto
Location Property MarkathHagsCure auto
Location Property MarkathHalloftheDead auto
Location Property MarkathNepossHouse auto
Location Property MarkathOgmundsHouse auto
Location Property MarkathShrineofTalos auto
Location Property MarkathSilverBloodInn auto
Location Property MarkathSmelterOverseersHouse auto
Location Property MarkathStableHouse auto
Location Property MarkathTreasureyHouse auto
Location Property MarkathUnderStonekeep auto
Location Property MarkathVlindrelHall auto
Location Property MarkathWarrens auto
Location Property MarkathWizardsQuarter01 auto
Location Property MarkathWizardsQuarter02 auto
Location Property Markath auto

Location Property RiftenBeeandBarb auto
Location Property RiftenBeggarsRow auto
Location Property RiftenBlackBriarManor auto
Location Property RiftenBlackBriarMeadery auto
Location Property RiftenBlacksmith auto
Location Property RiftenBollisHouse auto
Location Property RiftenElgrimsElixier auto
Location Property RiftenEsbernsVault auto
Location Property RiftenFishery auto
Location Property RiftenHaelgasBunkhouse auto
Location Property RiftenHonorhallOrphanage auto
Location Property RiftenHouseofClanSnowShod auto
Location Property RiftenHouseofMjolltheLioness auto
Location Property RiftenJail01 auto
Location Property Riften auto
Location Property RiftenMariseAravelsHouse auto
Location Property RiftenMausoleum auto
Location Property RiftenMercerFreyHouse auto
Location Property RiftenMistveilBarracks auto
Location Property RiftenMistveilKeep auto
Location Property RiftenMistveilKeepJarlsChambers auto
Location Property RiftenPawnedPrawn auto
Location Property RiftenRaggedFlagon auto
Location Property RiftenRomlynDrethsHouse auto
Location Property RiftenStables auto
Location Property RiftenTempleofMara auto
Location Property RiftenValindorsHouse auto
Location Property RiftenWarehouse auto

Location Property MorthalAlvasHouse auto
Location Property Morthal auto
Location Property MorthalFalionsHouse auto
Location Property MorthalGuardhouse auto
Location Property MorthalGuardhouseJail auto
Location Property MorthalHighmoonHall auto
Location Property MorthalJorgenandLamisHouse auto
Location Property MorthalMoorsideInn auto
Location Property MorthalThaumaturgistsHut auto
Location Property MorthalThonnirsHouse auto

Location Property WinterholdCollegeArcanaeum auto
Location Property WinterholdCollegeArchMageQuarters auto
Location Property WinterholdCollegeHallofAttainment auto
Location Property WinterholdCollegeHallofCountenance auto
Location Property WinterholdCollegeHalloftheElements auto
Location Property WinterholdCollege auto
Location Property WinterholdCollegeMidden auto
Location Property WinterholdJarlsLonghouse auto
Location Property WinterholdKorirsHouse auto
Location Property WinterholdRanmirsHouse auto
Location Property WinterholdTheFrozenHearth auto
Location Property Winterhold auto

Location Property WindhelmAretinoResidence auto
Location Property WindhelmArgonianAssemblage auto
Location Property WindhelmAtheronResidence auto
Location Property WindhelmBelynHlallusHouse auto
Location Property WindhelmBloodworks auto
Location Property WindhelmBrunwulfFreeWintersHouse auto
Location Property WindhelmCalixtosHouseofCuriosities auto
Location Property WindhelmCandlehearthHall auto
Location Property WindhelmClanShatterShieldOffice auto
Location Property WindhelmEastEmpireCompany auto
Location Property WindhelmHalloftheDead auto
Location Property WindhelmHjerim auto
Location Property WindhelmHouseofClanCruelSea auto
Location Property WindhelmHouseofClanShatterShield auto
Location Property WindhelmNewGnisisCornerclub auto
Location Property WindhelmNiranyesHouse auto
Location Property WindhelmPalaceoftheKings auto
Location Property WindhelmPalaceUpstairs02 auto
Location Property WindhelmSadrisUsedWares auto
Location Property WindhelmStables auto
Location Property WindhelmTempleofTalos auto
Location Property WindhelmViolaGiordanosHouse auto
Location Property WindhelmWarehouse auto
Location Property WindhelmWhitePhial auto

Location Property SolitudeAddvarsHouse auto
Location Property SolitudeAngelinesAromatics auto
Location Property SolitudeBardsCollege auto
Location Property SolitudeBitsandPieces auto
Location Property SolitudeBlackSmith auto
Location Property SolitudeBluePalace auto
Location Property SolitudeBrylingsHouse auto
Location Property SolitudeCastleDour auto
Location Property SolitudeCastleDourEmperorsTower auto
Location Property SolitudeCastleDourTower auto
Location Property SolitudeErikursHouse auto
Location Property SolitudeEvetteSansHouse auto
Location Property SolitudeFletcher auto
Location Property SolitudeHalloftheDead auto
Location Property SolitudeHalloftheDeadCatacombs auto
Location Property SolitudeJalasHouse auto
Location Property Solitude auto
Location Property SolitudeLighthouse auto
Location Property SolitudeRadiantRaiment auto
Location Property SolitudeRedWave auto
Location Property SolitudeSawmill auto
Location Property SolitudeStables auto
Location Property SolitudeTempleoftheDivines auto
Location Property SolitudeVittoriaVicisHouse auto
Location Property SolitudeWinkingSkeever auto
Location Property SolitudeSinkhole01 auto
Location Property SolitudeSinkholeMinesHouse auto

Location Property DLC2TelMithrynApothecaryLocation auto
Location Property DLC2TelMithrynKitchenLocation auto
Location Property DLC2TelMithrynLocation auto
Location Property DLC2TelMithrynStewardLocation auto
Location Property DLC2TelMithrynTowerLocation auto
Location Property DLC2SVBaldorsHouseLocation auto
Location Property DLC2SVDeorsHouseLocation auto
Location Property DLC2SVEdlasHouseLocation auto
Location Property DLC2SVGreathallLocation auto
Location Property DLC2SVMorwendsHouseLocation auto
Location Property DLC2SVOlslafsHouseLocation auto
Location Property DLC2SVShamansHutLocation auto
Location Property DLC2SVWulfsHouseLocation auto
Location Property DLC2SkaalVillageLocation auto
Location Property DLC2RavenRockLocation auto
Location Property DLC2RavenRockMineLocation auto
Location Property DLC2RRAlorHouseLocation auto
Location Property DLC2RRBulwarkLocation auto
Location Property DLC2RRCresciusHouseLocation auto
Location Property DLC2RRGloverMalloryHouseLocation auto
Location Property DLC2RRIenthFarmLocation auto
Location Property DLC2RRMorwaynManorLocation auto
Location Property DLC2RRSeverinManorLocation auto
Location Property DLC2RRRetchingNetchLocation auto
Location Property DLC2RRTempleLocation auto

Worldspace Property WhiterunWorld auto
Worldspace Property MarkarthWorld auto
Worldspace Property RiftenWorld auto
Worldspace Property WindhelmWorld auto
Worldspace Property SolitudeWorld auto
Worldspace Property SkyrimWorld auto
Worldspace Property RavenRockWorld auto
