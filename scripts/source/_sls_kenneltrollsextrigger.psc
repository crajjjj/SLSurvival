Scriptname _SLS_KennelTrollSexTrigger extends ObjectReference  

Event OnTriggerEnter(ObjectReference akActionRef)
	If akActionRef == PlayerRef
		(Game.GetFormFromFile(0x02C168, "SL Survival.esp") as _SLS_KennelUtil).KennelTrollEnterTrigger()
	EndIf
EndEvent

Actor Property PlayerRef Auto
