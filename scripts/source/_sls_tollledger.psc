Scriptname _SLS_TollLedger extends ObjectReference  

Event OnActivate(ObjectReference akActionRef)
	;If akActionRef == PlayerRef
		;ObjectReference TollBox = Game.FindClosestReferenceOfTypeFromRef(Game.GetFormFromFile(0x009EDB, "SL Survival.esp"), arCenter = Game.GetPlayer(), afRadius = 1000.0)
		
		;Debug.Messagebox("Toll Cost Remaining: " + (TollBox as SLS_TollBox).GetTollCost())
		TollUtil.TollLedgerActivate(akActionRef, Loc)
	;EndIf
EndEvent

Int Property Loc Auto

;Actor Property PlayerRef Auto

;GlobalVariable Property _SLS_TollCost Auto

;_SLS_LicenceUtil Property LicUtil Auto

_SLS_TollUtil Property TollUtil Auto
