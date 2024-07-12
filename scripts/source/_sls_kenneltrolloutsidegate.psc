Scriptname _SLS_KennelTrollOutsideGate extends ObjectReference  

Event OnTriggerEnter(ObjectReference akActionRef)
	If akActionRef == PlayerRef
		KennelUtil.KennelTrollOutsideGateTrig()
	EndIf
EndEvent

Actor Property PlayerRef Auto

_SLS_KennelUtil Property KennelUtil Auto
