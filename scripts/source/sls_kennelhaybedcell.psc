Scriptname SLS_KennelHayBedCell extends ObjectReference   

Event OnActivate(ObjectReference akActionRef)
	If akActionRef == Game.GetPlayer()
		SleepScript.TrapSleepEvents()
		SleepScript.IsCellBed = true
	EndIf
EndEvent

SLS_KennelKeeperPlayerAlias Property SleepScript Auto