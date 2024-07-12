Scriptname SLS_KennelHaybedOpen extends ObjectReference  

Event OnActivate(ObjectReference akActionRef)
	If akActionRef == Game.GetPlayer()
		SleepScript.TrapSleepEvents()
		SleepScript.IsCellBed = false
	EndIf
EndEvent

SLS_KennelKeeperPlayerAlias Property SleepScript Auto