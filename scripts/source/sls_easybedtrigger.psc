Scriptname SLS_EasyBedTrigger extends ObjectReference  

SLS_Mcm Property Menu Auto
SLS_EasyBeds Property EasyBeds Auto
Actor Property PlayerRef Auto

Event OnActivate(ObjectReference akActionRef)
	If akActionRef == PlayerRef && Menu.EasyBedTraps
		EasyBeds.TrapSleepEvents()
	EndIf
EndEvent