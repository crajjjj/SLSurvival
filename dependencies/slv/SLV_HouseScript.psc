Scriptname SLV_HouseScript extends Quest Conditional
{script for individual house quests}

event OnStart()
	debug.trace(self + "OnStart")
endEvent

event OnInit()
	debug.trace(self + "OnInit")
endEvent

; function to disable all "interior swap triggers" (which are in the exterior)
; called when player enters interior to make sure they get turned off when not needed
function DisableInteriorSwapTriggers()
	; loop through existing furniture
	int currentIndex = 0
	while currentIndex < InteriorSwapTriggers.length
		InteriorSwapTriggers[currentIndex].DisableNoWait()
		currentIndex = currentIndex + 1
	endwhile
endFunction

; special function for porch bridges
function FinishPorchRoom()
	debug.trace(self + "FinishPorchRoom START")
	; first, make sure porch rails are enabled
	if GetStageDone(1030)
		Room3Rail[iStyleIndex].EnableNoWait()
	endif

	if GetStageDone(1060)
		Room6RailLeft[iStyleIndex].EnableNoWait()
		Room6RailRight[iStyleIndex].EnableNoWait()
	endif

	if GetStageDone(1090)
		Room9Rail[iStyleIndex].EnableNoWait()
	endif

	; now, enable bridge if appropriate and disable rails
	if GetStageDone(1060)
		debug.trace(self + "FinishPorchRoom 1060 DONE")

		if GetStageDone(1030) ; room03 exists, so connect room06 porch to it
			debug.trace(self + "FinishPorchRoom 1030 DONE")

			; enable left bridge
			Room6BridgeLeft[iStyleIndex].EnableNoWait()
			; disables left rails
			Room6RailLeft[iStyleIndex].DisableNoWait()
			Room3Rail[iStyleIndex].DisableNoWait()
			; disable left navmesh cut
			Room6BridgeLeftNavCut.DisableNoWait()
		endif

		if GetStageDone(1090) ; room09 exists, so connect room06 porch to it
			debug.trace(self + "FinishPorchRoom 1090 DONE")
			; enable right bridge
			Room6BridgeRight[iStyleIndex].EnableNoWait()
			; disables right rails
			Room6RailRight[iStyleIndex].DisableNoWait()
			Room9Rail[iStyleIndex].DisableNoWait()
			; disable right navmesh cut
			Room6BridgeRightNavCut.DisableNoWait()
		endif

	endif

endFunction

; special function for remodeling initial room into entry to main hall
function RemodelEntryRoom(int partID)
	bRoom1Remodeled = true
	; reset room done global, in case room was already fully furnished in A version (starting house)
	(RoomDoneFlags.GetAt(0) as GlobalVariable).SetValueInt(1)
	; B version also marked as done (entry room)
	(RoomDoneFlags.GetAt(1) as GlobalVariable).SetValueInt(1)

	; move and disable existing furniture (except containers)
	MoveEntryRoomFurniture()

	; disable existing room workbench
	EnableList[Room1WorkbenchIndex].DisableNoWait()
	; enable "B" workbench
	EnableList[Room1BWorkbenchIndex].EnableNoWait()

	debug.trace(self + "RemodelEntryRoom: adding workbench " + BYOHHouseBuildingRoomWorkbenches.GetAt(12))
	; add workbench for this room to player (so you won't see the "build" option in the crafting menu)
	; SPECIAL CASE - added workbenchB as item 12 in the form list for simplicity
	AddBuildingItemToPlayer(BYOHHouseBuildingRoomWorkbenches.GetAt(12))

	; disable existing exterior
	int currentIndex = 0
	while currentIndex <= Room1MaxIndex
		EnableList[currentIndex].DisableNoWait()
		currentIndex = currentIndex + 1
	endwhile

	; enable correct exterior - based on partID
	; TODO - change this into an array index?
	; NOTE: this is not needed at the moment since we only have 1 version of the house
	if partID == 1
	elseif partID == 2
	elseif partID == 3
	endif

endFunction

; call this function to "move" entry room furniture to the main hall (move = disable in entry room, enable matching furniture in main hall)
bool function MoveEntryRoomFurniture()
	debug.trace(self + "MoveEntryRoomFurniture")

	; loop through existing furniture
	int currentIndex = 0
	while currentIndex < Room01RemodelDisableList.length
		ObjectReference currentFurniture = Room01RemodelDisableList[currentIndex]

		; if this ref is enabled, get ID from matching form list
		if currentFurniture.IsDisabled() == false
			Room01RemodelEnableList[currentIndex].EnableNoWait()
			; add base object to room's holding chest
			RoomHoldingChests[2].AddItem(SLV_HouseBuilding.BYOHHouseBuildingRoom01RemodelList.GetAt(currentIndex))
		endif
		; disable this ref
		currentFurniture.DisableNoWait()

		currentIndex = currentIndex + 1
	endwhile

endFunction

; called when an "interior part" is added to player's inventory (furniture crafted from the interior workbenches)
function BuildHouseInteriorPart(int roomID, string variantID, int iRoomIndex)
	debug.trace(self + "BuildHouseInteriorPart " + roomID + ", " + variantID + ", " + iRoomIndex)
	ObjectReference[] foundEnableList
	ObjectReference[] foundDisableList
	; find correct arrays
		if roomID==1
			if variantID == "A"	|| variantID == "a"		; small house version of room 1
				foundEnableList = Room01AEnableList
				foundDisableList = Room01ADisableList
			elseif variantID == "B"	|| variantID == "b"	; entry room version of room 1
				debug.trace(self + "BuildHouseInteriorPart: found lists for room 1B ")

				foundEnableList = Room01BEnableList
				foundDisableList = Room01BDisableList
			endif
		elseif roomID == 2
			foundEnableList = Room02EnableList
			foundDisableList = Room02DisableList
		elseif roomID == 3
			foundEnableList = Room03EnableList
			foundDisableList = Room03DisableList
		elseif roomID == 4
			foundEnableList = Room04EnableList
			foundDisableList = Room04DisableList
		elseif roomID == 5
			foundEnableList = Room05EnableList
			foundDisableList = Room05DisableList
		elseif roomID == 6
			foundEnableList = Room06EnableList
			foundDisableList = Room06DisableList
		elseif roomID == 7
			foundEnableList = Room07EnableList
			foundDisableList = Room07DisableList
		elseif roomID == 8
			foundEnableList = Room08EnableList
			foundDisableList = Room08DisableList
		elseif roomID == 9
			foundEnableList = Room09EnableList
			foundDisableList = Room09DisableList
		elseif roomID == 10
			foundEnableList = Room10EnableList
			foundDisableList = Room10DisableList
		elseif roomID == 11
			foundEnableList = Room11EnableList
			foundDisableList = Room11DisableList
		elseif roomID == 12
			foundEnableList = Room12EnableList
			foundDisableList = Room12DisableList
		endif

	; enable ref that matches this index
	debug.trace(self + "BuildHouseInteriorPart: enabling " + foundEnableList[iRoomIndex])
	foundEnableList[iRoomIndex].EnableNoWait()
	debug.trace(self + "BuildHouseInteriorPart: enabled ")
	
	; disable ref that matches this index
	if foundDisableList
		if foundDisableList.length >= iRoomIndex 
			if foundDisableList[iRoomIndex] != none
				debug.trace(self + "BuildHouseInteriorPart: disabling " + foundDisableList[iRoomIndex])
				foundDisableList[iRoomIndex].Disable()
			endif
		endif
	endif

endFunction

function DisableAdditionLayout()
	; call this function to disable all layout refs for the addition rooms
	int currentIndex = AdditionLayoutIndexMin
	while currentIndex <= AdditionLayoutIndexMax
		EnableList[currentIndex].DisableNoWait()
		currentIndex = currentIndex + 1
	endwhile
endFunction

; TEMP:
bool Property ShowEnableList = true auto

; called when a "house part" is added to player's inventory (pieces of the house itself - floor, walls, roof, etc.)
function BuildHousePart(int iMasterIndex, int iFinishRoomID = 0, int iStartRoomID = 0)
	debug.trace(self + "BuildHousePart " + iMasterIndex)
	; first time player uses drafting table, set stage 120
	;SetStage(120)
	; enable ref that matches this index
	debug.trace(self + "BuildHousePart: enabling " + EnableList[iMasterIndex])
	
	; TEMP
	if ShowEnableList
		int iLoop = 0
		while iLoop < EnableList.length
			debug.trace(self + "BuildHousePart: EnableList[" + iLoop + "]= " + EnableList[iLoop])
			iLoop = iLoop + 1
		endWhile
	endif
	; END TEMP

	if EnableList[iMasterIndex]
		EnableList[iMasterIndex].EnableNoWait()
	endif
	; enable additional refs if they exist
	if EnableList2[iMasterIndex]
		EnableList2[iMasterIndex].EnableNoWait()
	endif
	if EnableList3[iMasterIndex]
		EnableList3[iMasterIndex].EnableNoWait()
	endif
	if EnableList4[iMasterIndex]
		EnableList4[iMasterIndex].EnableNoWait()
	endif
	; disable ref that matches this index
	if DisableList[iMasterIndex]
		debug.trace(self + "BuildHousePart: disabling " + DisableList[iMasterIndex])
		DisableList[iMasterIndex].DisableNoWait()
	endif
	if DisableList2
		debug.trace(self + "BuildHousePart: disabling2 size " + DisableList2.length)
		if ShowEnableList
			int iLoop = 0
			while iLoop < DisableList2.length
				debug.trace(self + "BuildHousePart: DisableList2[" + iLoop + "]= " + DisableList2[iLoop])
				iLoop = iLoop + 1
			endWhile
		endif
	else
		debug.trace(self + "BuildHousePart: disabling2 is null")
	endif
	if DisableList2[iMasterIndex]
		debug.trace(self + "BuildHousePart: disabling " + DisableList2[iMasterIndex])
		DisableList2[iMasterIndex].DisableNoWait()
	endif

	; if this starts a room:
	if iStartRoomID > 0
		; first time player starts a room, set stage 130
		;SetStage(130)
		; get room index
		int roomIndex = iStartRoomID - 1
		if RoomStartDisableList[roomIndex]
			RoomStartDisableList[roomIndex].DisableNoWait()
		endif

		; set global flag
		; if room 1, we're starting "room 0" (small house version of room 1), otherwise we're starting by roomID
		if iStartRoomID == 1
			(RoomStartedFlags.GetAt(0) as GlobalVariable).SetValueInt(1)
		else
			(RoomStartedFlags.GetAt(iStartRoomID) as GlobalVariable).SetValueInt(1)
		endif
	endif

	; if this finishes a room, set a stage
	if iFinishRoomID > 0
		debug.trace(self + "BuildHousePart: finishing room " + iFinishRoomID)
		numRoomsCompleted = numRoomsCompleted + 1
		; set keyword data on location
		if HouseLocation && BYOHHouseLocation
			HouseLocation.GetLocation().SetKeywordData(BYOHHouseLocation, numRoomsCompleted)
		endif

		int roomIndex = iFinishRoomID - 1
		if RoomEnableList[roomIndex]
			RoomEnableList[roomIndex].EnableNoWait()
		endif
		if RoomDisableList[roomIndex]
			RoomDisableList[roomIndex].DisableNoWait()
		endif

		; set global flag
		; if room 1, we're finishing "room 0" (small house version of room 1), otherwise we're finishing by roomID
		if iFinishRoomID == 1
			(RoomDoneFlags.GetAt(0) as GlobalVariable).SetValueInt(1)
		else
			(RoomDoneFlags.GetAt(iFinishRoomID) as GlobalVariable).SetValueInt(1)
		endif

		debug.trace(self + "BuildHousePart: adding workbench " + BYOHHouseBuildingRoomWorkbenches.GetAt(roomIndex))
		; add workbench for this room to player (because workbenches start enabled)
		AddBuildingItemToPlayer(BYOHHouseBuildingRoomWorkbenches.GetAt(roomIndex))

		; special handling
		;SetStage(1000 + (iFinishRoomID * 10) )
	endif
endFunction

; called when an "exterior part" is added to player's inventory (miscellaneous exterior craftable items - smelter, animal pen, garden, stable, etc.)
function BuildHouseExteriorPart(int iMasterIndex)
	debug.trace(self + "BuildHouseExteriorPart" + iMasterIndex)
	; enable ref that matches this index
	debug.trace(self + "BuildHouseExteriorPart: enabling " + ExteriorEnableList[iMasterIndex])
	ExteriorEnableList[iMasterIndex].EnableNoWait()
endFunction

; utility function for giving crafting items to player - if in crafting trigger, give to player; otherwise, put in holding chest
function AddBuildingItemToPlayer(Form itemToAdd)
		if HouseCraftingTrigger.bPlayerInTrigger
			Game.Getplayer().AddItem(itemToAdd, 1, true) ; give token item silently
		else
			; if player has left trigger, put token in holding chest
			HouseHoldingChest.AddItem(itemToAdd, 1, true) ; give token item silently
		endif
endFunction

function BuyProperty()
	; set flag for owning property
	bOwnProperty = true
	; remove gold
	Game.GetPlayer().RemoveItem(Gold001, BYOHHPCost.GetValueInt())
	; tell master quest
	SLV_HouseBuilding.BuyProperty(iHouseIndex)
	; enable basic building site
	SiteEnableMarker.Enable()
	; map marker
	HouseMapMarker.Enable()
	HouseMapMarker.AddToMap()
	; give player some logs to start with (since they can't be taken from chest)
	Game.GetPlayer().AddItem(BYOHMaterialLog, 20, true)
endFunction

function HireCarriageDriver()
	bBoughtCarriage = true
	Game.GetPlayer().RemoveItem(gold001, BYOHHPCostCarriage.GetValueInt())
endFunction

function HireBard()
	bBoughtBard = true
	Game.GetPlayer().RemoveItem(gold001, BYOHHPCostBard.GetValueInt())
endFunction

function BuyGarden()
	bBoughtGarden = true
	Game.GetPlayer().RemoveItem(gold001, BYOHHPCostGarden.GetValueInt())
endFunction

function BuyCow()
	numCows = numCows + 1
	Game.GetPlayer().RemoveItem(gold001, BYOHHPCostCow.GetValueInt())
	; NOTE - cows enable themselves as they are bought by checking numCows
endFunction

function BuyChicken()
	numChickens = numChickens + 1
	Game.GetPlayer().RemoveItem(gold001, BYOHHPCostChicken.GetValueInt())
	; NOTE - cows enable themselves as they are bought by checking numCows
endFunction

function BuyHorse()
	bBoughtHorse = true
	Game.GetPlayer().RemoveItem(gold001, HorseCost.GetValueInt())
endFunction

; animal scripts call this function OnCellDetach when the animal is dead, so player can replace them
function HouseAnimalDied(ObjectReference akDeadAnimal)
	debug.trace(self + "HouseAnimalDied " + akDeadAnimal)
	akDeadAnimal.Disable()
	akDeadAnimal.Reset()
	if (akDeadAnimal as BYOHHouseHorseScript)
		bBoughtHorse = false
	elseif (akDeadAnimal as BYOHHouseCowScript )
		numCows = numCows - 1
	elseif (akDeadAnimal as BYOHHouseChickenScript )
		numChickens = numChickens - 1
	endif
endFunction

ObjectReference[] Property EnableList  Auto  
{enable list which matches the BYOHHouseBuildingMasterList}

ObjectReference[] Property DisableList  Auto  

Bool Property bOwnProperty  Auto  Conditional
{ set to true when player buys property in this hold }

SLV_HouseBuildingScript Property SLV_HouseBuilding auto

int Property iHouseIndex Auto
{ set on quest script to correct index for this quest:
0 = Falkreath
1 = Hjaalmarch
2 = The Pale
}

MiscObject Property Gold001  Auto  

GlobalVariable Property BYOHHPCost  Auto  

ObjectReference Property SiteEnableMarker Auto
{ enable marker for building site - turn on when property is bought, turn off when all construction finished }

ObjectReference Property HouseMapMarker  Auto  

ObjectReference[] Property RoomEnableList  Auto  
{list of refs to enable whenever a room is finished
indexed by (RoomID - 1)
}


;*****************************************************
; Arrays of refs for each room - index matches BYOHHouseBuildingRoomXXMasterList

ObjectReference[] Property Room01AEnableList  Auto  
{enable list for Room 1 - starting house furniture}
ObjectReference[] Property Room01ADisableList  Auto  

ObjectReference[] Property Room01RemodelDisableList  Auto  
{disable list for Room 1 furniture when remodeling}

ObjectReference[] Property Room01RemodelEnableList  Auto  
{matches Room01RemodelDisableList - list of matching refs in Room 2 to enable when disabling furniture in Room 1}

ObjectReference[] Property Room01BEnableList  Auto  
{enable list for Room 1 - entryway furniture}
ObjectReference[] Property Room01BDisableList  Auto  

ObjectReference[] Property Room02EnableList  Auto  
ObjectReference[] Property Room02DisableList  Auto  

ObjectReference[] Property Room03EnableList  Auto  
ObjectReference[] Property Room03DisableList  Auto  

ObjectReference[] Property Room04EnableList  Auto  
ObjectReference[] Property Room04DisableList  Auto  

ObjectReference[] Property Room05EnableList  Auto  
ObjectReference[] Property Room05DisableList  Auto  

ObjectReference[] Property Room06EnableList  Auto  
ObjectReference[] Property Room06DisableList  Auto  

ObjectReference[] Property Room07EnableList  Auto  
ObjectReference[] Property Room07DisableList  Auto  

ObjectReference[] Property Room08EnableList  Auto  
ObjectReference[] Property Room08DisableList  Auto  

ObjectReference[] Property Room09EnableList  Auto  
ObjectReference[] Property Room09DisableList  Auto  

ObjectReference[] Property Room10EnableList  Auto  
ObjectReference[] Property Room10DisableList  Auto  

ObjectReference[] Property Room11EnableList  Auto  
ObjectReference[] Property Room11DisableList  Auto  

ObjectReference[] Property Room12EnableList  Auto  
ObjectReference[] Property Room12DisableList  Auto  

;*****************************************************

Bool Property bHaveSteward  Auto   Conditional

Int Property numCows  Auto  Conditional
{number of cows at house}

GlobalVariable Property numCowsMax  Auto
{maximum number of cows (increased by building fenced pastures)}

Int Property numChickens  Auto  Conditional
{number of chickens at house}

Bool Property bBoughtCarriage  Auto  Conditional

Bool Property bBoughtGarden  Auto  Conditional

Bool Property bBoughtHorse  Auto  Conditional

Bool Property bBoughtBard  Auto  Conditional

GlobalVariable Property BYOHHPCostCow  Auto  

GlobalVariable Property BYOHHPCostChicken  Auto  

GlobalVariable Property BYOHHPCostGarden  Auto  

GlobalVariable Property BYOHHPCostCarriage  Auto  

GlobalVariable Property HorseCost  Auto  

GlobalVariable Property BYOHHPCostBard  Auto  

Int Property numRoomsCompleted  Auto  Conditional

ObjectReference[] Property RoomDisableList  Auto  
{list of refs to disable when each room is completed}

ObjectReference[] Property RoomStartDisableList  Auto  
{list of refs to disable when each room is STARTED}


Int Property Room1MaxIndex  Auto  
{the final index for the room 1 exterior - 
used to determine which exterior pieces to disable
when remodeling the starting house into the style
that matches the main hall}

ObjectReference Property HoldingChestRoom1  Auto  
{holding chest for Room1 interior parts (prior to revision into entry hall)
}

Int Property Room1WorkbenchIndex = 20  Auto  
{index to room1's interior workbench (EnableList)
so it can be disabled when remodeled into entryway}

Int Property Room1BWorkbenchIndex = 24  Auto  
{index to room1's interior workbench (version B) (EnableList)
so it can be enabled when remodeled into entryway}

ObjectReference[] Property EnableList2  Auto  
{second object ref to enable, matches EnableList index}

ObjectReference[] Property EnableList3  Auto  
{3rd ref to enable}

ObjectReference[] Property EnableList4  Auto  
{4th ref to enable}

Int Property AdditionLayoutIndexMin  Auto  
Int Property AdditionLayoutIndexMax  Auto  
{The min and max of the indices on EnableList for the layout refs for the addition rooms
 Used to disable all the layout refs at once}

ObjectReference[] Property DisableList2  Auto  
{indexed array of additional refs to disable}

; special cases:
; porch railing/bridge - enabled in room finish quest stages
ObjectReference[] Property Room3Rail Auto
ObjectReference[] Property Room9Rail Auto
ObjectReference[] Property Room6RailLeft Auto
ObjectReference[] Property Room6RailRight Auto
ObjectReference[] Property Room6BridgeLeft Auto
ObjectReference[] Property Room6BridgeRight Auto
ObjectReference Property Room6BridgeLeftNavCut auto
ObjectReference Property Room6BridgeRightNavCut auto

Keyword Property BYOHHouseLocation  Auto  

LocationAlias Property houseLocation  Auto  

Bool Property bAllowSpouse  Auto  Conditional
{set to true when spouse is allowed to move in
(Room 1 + bed built)
}

Bool Property bAllowChildren  Auto  Conditional
{set to true when children are allowed to move here
(Room 2 + 2 beds & chest built, or equivalent in room 3)
}

Bool Property bChildrenRoom3 auto Conditional
{ set to true when children should use room 3}

ObjectReference[] Property ExteriorEnableList  Auto  
{enable list which matches the BYOHHouseBuildingExteriorMasterList}

ObjectReference[] Property ChildBedRefsRoom2  Auto  
{disable these loc ref type markers when room 3 is ready for children}

Int Property iStyleIndex  Auto  Conditional
{index for house style: 0, 1, 2 (used for porch bridge arrays)
}


ObjectReference Property StewardChest  Auto  
{chest where items bought by steward are placed}

ObjectReference Property HouseHoldingChest  Auto  
{holding chests for exterior workbenches}

SLV_HouseCraftingTriggerScript Property HouseCraftingTrigger Auto
{exterior crafting trigger, to track when player is in it}

FormList Property BYOHHouseBuildingRoomWorkbenches  Auto  
{form list of workbench base objects, used to add to holding chest when room is built}

FormList Property RoomDoneFlags  Auto  
{formlist of globals which are set to 1 when rooms are done, set to 2 when steward is furnishing them, 3 when completed
indexed by roomID (room1A = 0, room1B = 1, room2 = 2, etc.)
}

Bool Property bRoom1Remodeled  Auto  Conditional
{set to true when entryway remodeled}

MiscObject Property BYOHMaterialLog  Auto  

ObjectReference[] Property RoomHoldingChests  Auto  
{array of room holding chests, indexed by roomID
(room 1 = 0, room 1B = 1, room 2 = 2, etc.)
}

Bool Property bHaveSkeever  Auto  Conditional
{set to true by BYOHHouseSkeeverInfestation when tame skeever is placed}

ObjectReference[] Property InteriorSwapTriggers  Auto  
{all interior swap triggers - disable them each time player enters house
}

ObjectReference Property ChildChestRoom2  Auto  
{child chest - loc ref type version
this is disabled when room 3 becomes "child ready"
}

ObjectReference Property ChildChestRoom2Replacement  Auto  
{this is the non-child version of the chest 
that gets enabled when room 3 is child ready}


FormList Property RoomStartedFlags  Auto  
{flags to show when each room is started
used to condition recipes to control the order that pieces are completed
due to script lag}
