scriptName _KNNWaterBarrelActiRef extends ObjectReference

Quest Property KNNWBQuest auto
Message Property WBSMsg auto
MiscObject Property WaterBarrel auto

Event OnActivate(ObjectReference akActionRef)
	if Game.GetPlayer() != akActionRef
		return
	endIf
	int index = WBSMsg.Show()
	if 1 == index
		if (KNNWBQuest as _KNNWaterBarrelQuest).SetWaterBarrel(self)
			Disable()
			Delete()
		endIf
	elseIf 2 == index
		Game.GetPlayer().Additem(WaterBarrel, 1)
		Disable()
		Delete()
	endIf
EndEvent