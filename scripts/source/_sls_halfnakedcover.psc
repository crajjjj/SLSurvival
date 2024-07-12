Scriptname _SLS_HalfNakedCover extends ReferenceAlias  

SLS_Mcm Property Menu Auto

Armor Property _SLS_HalfNakedCoverArmor Auto

Actor Property PlayerRef Auto

Keyword Property SexLabNoStrip Auto

Int[] Property SlotMasks Auto

Int Property PantySlot = 49 Auto Hidden
Int Property BraSlot = 56 Auto Hidden

Bool Property CoverStripsCuirass = false Auto Hidden

Event OnInit()
	SlotMasks = new Int[32]
	SlotMasks[0] = 1 ; kSlotMask30
	SlotMasks[1] = 2 ; kSlotMask31
	SlotMasks[2] = 4 ; kSlotMask32
	SlotMasks[3] = 8 ; kSlotMask33
	SlotMasks[4] = 16 ; kSlotMask34
	SlotMasks[5] = 32 ; kSlotMask35
	SlotMasks[6] = 64 ; kSlotMask36
	SlotMasks[7] = 128 ; kSlotMask37
	SlotMasks[8] = 256 ; kSlotMask38
	SlotMasks[9] = 512 ; kSlotMask39
	SlotMasks[10] = 1024 ; kSlotMask40
	SlotMasks[11] = 2048 ; kSlotMask41
	SlotMasks[12] = 4096 ; kSlotMask42
	SlotMasks[13] = 8192 ; kSlotMask43
	SlotMasks[14] = 16384 ; kSlotMask44
	SlotMasks[15] = 32768 ; kSlotMask45
	SlotMasks[16] = 65536 ; kSlotMask46
	SlotMasks[17] = 131072 ; kSlotMask47
	SlotMasks[18] = 262144 ; kSlotMask48
	SlotMasks[19] = 524288 ; kSlotMask49
	SlotMasks[20] = 1048576 ; kSlotMask50
	SlotMasks[21] = 2097152 ; kSlotMask51
	SlotMasks[22] = 4194304 ; kSlotMask52
	SlotMasks[23] = 8388608 ; kSlotMask53
	SlotMasks[24] = 16777216 ; kSlotMask54
	SlotMasks[25] = 33554432 ; kSlotMask55
	SlotMasks[26] = 67108864 ; kSlotMask56
	SlotMasks[27] = 134217728 ; kSlotMask57
	SlotMasks[28] = 268435456 ; kSlotMask58
	SlotMasks[29] = 536870912 ; kSlotMask59
	SlotMasks[30] = 1073741824 ; kSlotMask60
	SlotMasks[31] = 0x80000000 ; kSlotMask61 - Use hex otherwise number ends up being 1 short....?
	
	PantySlot = Menu.HalfNakedPanty
	BraSlot = Menu.HalfNakedBra
	CoverStripsCuirass = Menu.HalfNakedStrips
	
	CheckCover()
EndEvent

State InProc
	Event OnObjectEquipped(Form akBaseObject, ObjectReference akReference)
	EndEvent

	Event OnObjectUnEquipped(Form akBaseObject, ObjectReference akReference)
	EndEvent
EndState

Event OnObjectEquipped(Form akBaseObject, ObjectReference akReference)
	EventFired(akBaseObject)
EndEvent

Event OnObjectUnEquipped(Form akBaseObject, ObjectReference akReference)
	EventFired(akBaseObject)
EndEvent

Function EventFired(Form akBaseObject)
	If akBaseObject as Armor
		If akBaseObject.IsPlayable() && !akBaseObject.HasKeyword(SexLabNoStrip)
			Int SlotMask = (akBaseObject as Armor).GetSlotMask()
			If Math.LogicalAnd(SlotMask, SlotMasks[2]) == SlotMasks[2] || Math.LogicalAnd(SlotMask, SlotMasks[(PantySlot - 30)]) == SlotMasks[(PantySlot - 30)]	||	Math.LogicalAnd(SlotMask, SlotMasks[(BraSlot - 30)]) == SlotMasks[(BraSlot - 30)]
				GoToState("InProc")
				CheckCover()
			EndIf
		EndIf
	EndIf
EndFunction

Function CheckCover()
	Form Panty = PlayerRef.GetWornForm(SlotMasks[(PantySlot - 30)])
	Form Bra = PlayerRef.GetWornForm(SlotMasks[(BraSlot - 30)])
	Armor Cuirass = PlayerRef.GetWornForm(SlotMasks[2]) as Armor
	
	If Cuirass
		If !Cuirass.IsPlayable()
			Cuirass = None
		EndIf
	EndIf	
	
	Bool IsCovered = false
	If Panty != None && Bra != None
		If (!Panty.HasKeyword(SexLabNoStrip) && Panty.IsPlayable()) && (!Bra.HasKeyword(SexLabNoStrip) && Bra.IsPlayable())
			IsCovered = true
		EndIf
	EndIf
	
	If Cuirass == None
		If IsCovered
			EquipCover(true)
		Else
			EquipCover(false)
		EndIf
	
	ElseIf CoverStripsCuirass
		If IsCovered
			EquipCover(true)
		EndIf
	EndIf
	GoToState("")
EndFunction

Function EquipCover(Bool EquipIt)
	If EquipIt
		If PlayerRef.GetItemCount(_SLS_HalfNakedCoverArmor) == 0
			PlayerRef.AddItem(_SLS_HalfNakedCoverArmor, 1, true)
		EndIf
		PlayerRef.EquipItem(_SLS_HalfNakedCoverArmor, abPreventRemoval = false, abSilent = true)
	
	Else
		PlayerRef.UnEquipItem(_SLS_HalfNakedCoverArmor, abPreventEquip = false, abSilent = true)
	EndIf
EndFunction
