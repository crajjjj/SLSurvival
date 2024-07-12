Scriptname SLV_HouseCraftingTriggerScript extends ObjectReference Conditional
{add/remove all building objects when player leaves trigger
to prevent confusion between recipes when working on multiple houses
}

;Event onTriggerEnter(objectReference akActionRef)
function StartCrafting()
;	if akActionRef == Game.GetPlayer()
		bPlayerInTrigger = true
		while SLV_HouseBuilding.bCraftingTriggerBusy
			debug.trace(self + " " + SLV_HouseBuilding + " busy, waiting...")
			utility.wait(1.0)
		endwhile
		SLV_HouseBuilding.bCraftingTriggerBusy = true
		; complete stage if appropriate
		if HouseQuest && HouseQuest.GetStageDone(110) == 0
			HouseQuest.SetStage(110)
		endif

		debug.trace(self + " give player house crafting items")
		; give player 1 of everything
		HoldingContainer.RemoveItem(ItemList, 1, true, Game.GetPlayer())
		if ItemList2
			HoldingContainer.RemoveItem(ItemList2, 1, true, Game.GetPlayer())
		endif
		if ItemList3
			HoldingContainer.RemoveItem(ItemList3, 1, true, Game.GetPlayer())
		endif
		if ItemList4
			HoldingContainer.RemoveItem(ItemList4, 1, true, Game.GetPlayer())
		endif
		; clear chest - this is failsafe to get rid of duplicates
		HoldingContainer.RemoveAllItems()
		SLV_HouseBuilding.bCraftingTriggerBusy = false
;	endif
;endEvent
endFunction

Event onTriggerLeave(ObjectReference akActionRef)
	if akActionRef == Game.GetPlayer()
		bPlayerInTrigger = false
		while SLV_HouseBuilding.bCraftingTriggerBusy
			debug.trace(self + " " + SLV_HouseBuilding + " busy, waiting...")
			utility.wait(1.0)
		endwhile
		SLV_HouseBuilding.bCraftingTriggerBusy = true
		debug.trace(self + " remove all house crafting items")
		; remove all building objects
		Game.GetPlayer().RemoveItem(ItemList, 99, true, HoldingContainer)
		if ItemList2
			Game.GetPlayer().RemoveItem(ItemList2, 99, true, HoldingContainer)
		endif
		if ItemList3
			Game.GetPlayer().RemoveItem(ItemList3, 99, true, HoldingContainer)
		endif
		if ItemList4
			Game.GetPlayer().RemoveItem(ItemList4, 99, true, HoldingContainer)
		endif
		SLV_HouseBuilding.bCraftingTriggerBusy = false
	endif
endEvent

; PROPERTIES

ObjectReference Property HoldingContainer Auto
{container to move the items to when player leaves the trigger}

FormList Property ItemList Auto
{master list of items to remove from player}

FormList Property ItemList2 Auto
{secondary list of items to remove from player}

FormList Property ItemList3 Auto
{third list of items to remove from player}

FormList Property ItemList4 Auto
{fourth list of items to remove from player}






Quest Property HouseQuest  Auto  

Bool Property bPlayerInTrigger  Auto  

SLV_HouseBuildingScript Property SLV_HouseBuilding Auto
{ use for controlling busy state }

