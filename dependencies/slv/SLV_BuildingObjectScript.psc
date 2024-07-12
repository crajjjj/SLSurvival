Scriptname SLV_BuildingObjectScript extends Form  

{script for fake inventory objects used for crafting house pieces
}

Event OnContainerChanged(ObjectReference akNewContainer, ObjectReference akOldContainer)
	If akNewContainer == Game.GetPlayer() && akOldContainer == None
		;debug.trace(self+" akNewContainer = "+akNewContainer+",  akOldContainer = "+akOldContainer)
		; get active house right now (in case player moves between houses quickly...)
		int myActiveHouseLocation = SLV_HouseBuilding.activeHouseLocation
		; remove item if appropriate
		if RemoveItem
			Game.GetPlayer().RemoveItem(RemoveItem, 1, true) ; remove item silently
		endif
		if RemoveItem2
			Game.GetPlayer().RemoveItem(RemoveItem2, 1, true) ; remove item silently
		endif
		; tell master script that I've been built
		SLV_HouseBuilding.BuildHousePart(myActiveHouseLocation, ID, myself, finishRoomID, startRoomID, bDisableAdditionLayouts)
	EndIf
EndEvent

SLV_HouseBuildingScript Property SLV_HouseBuilding  Auto  

Int Property ID  Auto  
{custom unique ID (because script can't get at formID of object in inventory)}

MiscObject Property mySelf Auto
{replace ID - this is the object itself which we'll use to search the array - much faster than searching by ID}

Int Property FinishRoomID = 0 Auto
{ if non-zero, indicates that this piece finishes the specified room }

Int Property StartRoomID = 0 Auto
{ if non-zero, indicates that this piece starts the specified room }


MiscObject Property RemoveItem Auto
{ for mutually exclusive items, this is the item to remove from player when I am created }

MiscObject Property RemoveItem2 Auto
{ for mutually exclusive items, this is the item to remove from player when I am created }

FormList Property RemoveItemList Auto
{ can also use a form list to remove items, when you have to remove lots
  NOTE: will NEVER remove itself, in order to allow using the same list for all the layouts}

bool Property bDisableAdditionLayouts Auto
{ set to true on all "addition" layout pieces }