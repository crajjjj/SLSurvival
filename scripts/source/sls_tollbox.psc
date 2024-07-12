Scriptname SLS_TollBox extends ObjectReference

Event OnActivate(ObjectReference akActionRef)
	TollUtil.TollBoxActivate(Self, akActionRef, BoxLoc, TollGate)
EndEvent

_SLS_TollUtil Property TollUtil Auto

Int Property BoxLoc Auto ; 0 - Whiterun, 1 - Solitude, 2 - Markarth, 3 - Windhelm, 4 - Riften
ReferenceAlias Property TollGate  Auto  
