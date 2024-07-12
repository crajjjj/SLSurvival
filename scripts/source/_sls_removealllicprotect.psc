Scriptname _SLS_RemoveAllLicProtect extends ReferenceAlias  

Event OnInit()
	RemoveAllInventoryEventFilters()
	AddInventoryEventFilter(Game.GetFormFromFile(0x041B54, "SL Survival.esp"))
	AddInventoryEventFilter(Game.GetFormFromFile(0x043BAE, "SL Survival.esp"))
	AddInventoryEventFilter(Game.GetFormFromFile(0x043BAF, "SL Survival.esp"))
	AddInventoryEventFilter(Game.GetFormFromFile(0x0492C7, "SL Survival.esp"))
	AddInventoryEventFilter(Game.GetFormFromFile(0x0492CB, "SL Survival.esp"))
EndEvent

Event OnItemRemoved(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akDestContainer)
	;Debug.Messagebox("akBaseItem: " + akBaseItem + "\nakItemReference: " + akItemReference + "\nakDestContainer: " + akDestContainer)
	If !akItemReference && !akDestContainer ; Licence was destroyed by RemoveAllItems
		LicUtil.CheckAllLicencesExpiry()
	EndIf
EndEvent

_SLS_LicenceUtil Property LicUtil Auto
