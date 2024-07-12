Scriptname _SLS_LicenceGateActivator extends ObjectReference  

Int Property ActLocation Auto ; 0 - Whiterun, 1 - Solitude, 2 - Markarth, 3 - Windhelm, 4 - Riften

Actor Property PlayerRef Auto

_SLS_LicenceUtil Property LicUtil Auto

Event OnTriggerEnter(ObjectReference akActionRef)
	If akActionRef == PlayerRef
		LicUtil.GateLicenceCheck(ActLocation)
	EndIf
EndEvent

Event OnTriggerLeave(ObjectReference akActionRef)
	If akActionRef == PlayerRef
		LicUtil.GateLicenceCheckActLeave()
	EndIf
EndEvent