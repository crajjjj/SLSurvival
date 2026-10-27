Scriptname _SLS_RemoveAllLicProtect extends ReferenceAlias

; An inventory event sent before OnInit has set the filters arrives unfiltered, and on a heavy new
; game that is every item the start moves. Each one used to call into LicUtil, which deadlocked it
; against SLS_Init's own startup (a 0.802 save), so only a licence gets past this script.
Form[] Licences

Event OnInit()
	RemoveAllInventoryEventFilters()
	FillLicences()
	Int i = Licences.Length
	While i > 0
		i -= 1
		AddInventoryEventFilter(Licences[i])
	EndWhile
EndEvent

Event OnItemRemoved(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akDestContainer)
	;Debug.Messagebox("akBaseItem: " + akBaseItem + "\nakItemReference: " + akItemReference + "\nakDestContainer: " + akDestContainer)
	If !akItemReference && !akDestContainer && IsLicence(akBaseItem) ; Licence was destroyed by RemoveAllItems
		LicUtil.CheckAllLicencesExpiry()
	EndIf
EndEvent

Bool Function IsLicence(Form akBaseItem)
	If !(akBaseItem as Book)
		Return false
	EndIf
	If !Licences ; Older saves ran OnInit without filling it
		FillLicences()
	EndIf
	Return Licences.Find(akBaseItem) >= 0
EndFunction

Function FillLicences()
	; Assigned once complete: GetFormFromFile lets another event in, which must not see a half-filled list
	Form[] Lics = new Form[5]
	Lics[0] = Game.GetFormFromFile(0x041B54, "SL Survival.esp") ; _SLS_LicenceMagic
	Lics[1] = Game.GetFormFromFile(0x043BAE, "SL Survival.esp") ; _SLS_LicenceArmor
	Lics[2] = Game.GetFormFromFile(0x043BAF, "SL Survival.esp") ; _SLS_LicenceWeapon
	Lics[3] = Game.GetFormFromFile(0x0492C7, "SL Survival.esp") ; _SLS_LicenceBikini
	Lics[4] = Game.GetFormFromFile(0x0492CB, "SL Survival.esp") ; _SLS_LicenceClothes
	Licences = Lics
EndFunction

_SLS_LicenceUtil Property LicUtil Auto
