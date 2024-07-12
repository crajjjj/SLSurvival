scriptName _KNNWaterBarrelPlayerAlias extends ReferenceAlias

MiscObject Property WaterBarrel auto
Activator Property WaterBarrelMovableACTI auto

Function SetUp()
	AddInventoryEventFilter(WaterBarrel)
EndFunction

Event OnItemRemoved(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akDestContainer)
	if WaterBarrel == akBaseItem && akItemReference && !akDestContainer
		int i = 0
		while i < aiItemCount
			akItemReference.PlaceAtMe(WaterBarrelMovableACTI, 1)
			i += 1
		endWhile
		akItemReference.Disable()
		akItemReference.Delete()
	endIf
EndEvent