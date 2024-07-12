Scriptname aaaKNNBedGoToBedAlias extends ReferenceAlias  

Event OnActivate(ObjectReference akActionRef)
	if akActionRef && Game.GetPlayer() != akActionRef
		;Debug.Trace("ObjectReference : " + akActionRef)
		if KNNPlugin_Utility.IsBedSingleMakerNode(GetReference())
			GetOwningQuest().Stop()
		endIf
	endIf
EndEvent