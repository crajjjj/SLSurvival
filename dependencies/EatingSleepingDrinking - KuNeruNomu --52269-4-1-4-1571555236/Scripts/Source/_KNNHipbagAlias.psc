Scriptname _KNNHipbagAlias extends ReferenceAlias

Function StartUp(Form[] filterArray)
	int i = 0
	while i < filterArray.Length
		if filterArray[i] && (filterArray[i] as MiscObject || filterArray[i] as Armor)
			AddInventoryEventFilter(filterArray[i])
		endIf
		i += 1
	endwhile
EndFunction

Function CleanUp()
	RemoveAllInventoryEventFilters()
EndFunction

Event OnItemAdded(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
	if akSourceContainer && 0 < aiItemCount && akBaseItem
		GetReference().RemoveItem(akBaseItem, aiItemCount, true, akSourceContainer)
	endIf
EndEvent