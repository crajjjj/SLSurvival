Scriptname _SLS_AmputationHelplessAlias extends ReferenceAlias  

Event OnInit()
	If Self.GetOwningQuest().IsRunning()
		AMP_KWDProsthetic = Game.GetFormFromFile(0x0099C1, "Amputator.esm") as Keyword ; Amputator would need to be installed to get this far so no point checking
		AddInventoryEventFilter(_SLS_NeverAddedItem)
		If Amp.LeftHandDisabled && Amp.RightHandDisabled
			;Debug.Messagebox("Both")
			GoToState("BothHands")
		ElseIf Amp.LeftHandDisabled
			;Debug.Messagebox("Left")
			GoToState("LeftHand")
		ElseIf Amp.RightHandDisabled
			;Debug.Messagebox("Right")
			GoToState("RightHand")
		EndIf
	EndIf
EndEvent

Event On_SLS_PlayerCombatChange(Bool InCombat)
EndEvent

Event OnItemAdded(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
EndEvent

State LeftHand
	Event OnObjectEquipped(Form akBaseObject, ObjectReference akReference)
		If akBaseObject as Weapon
			Int WeaponType = (akBaseObject as Weapon).GetWeaponType()
			If (WeaponType >= 5 && WeaponType <= 7) || WeaponType == 9 ; Two handed or bow or crossbow
				PlayerRef.UnequipItemEx(akBaseObject, equipSlot = 1, preventEquip = false)
			Else
				PlayerRef.UnequipItemEx(akBaseObject, equipSlot = 2, preventEquip = false)
			EndIf

		ElseIf akBaseObject as Spell
			If Amp.BlockMagic && PlayerRef.GetEquippedSpell(0) != None
				PlayerRef.UnequipSpell(akBaseObject as Spell, 0)
			EndIf
			
		ElseIf akBaseObject as Armor && akBaseObject.HasKeyword(ArmorShield)
			PlayerRef.UnequipItem(akBaseObject)
			
		ElseIf akBaseObject as Light
			PlayerRef.UnequipItemEx(akBaseObject, equipSlot = 2, preventEquip = false)
		EndIf
	EndEvent
	
	Event OnSit(ObjectReference akFurniture)
		String ObjectName = akFurniture.GetBaseObject().GetName()
		If StringUtil.Find(ObjectName, "This Should Not Be Visible", 0) != -1
			PlayerRef.MoveTo(PlayerRef)
			Debug.Notification("I need both hands to mine")
		EndIf
	EndEvent
EndState

State RightHand
	Event OnObjectEquipped(Form akBaseObject, ObjectReference akReference)
		If akBaseObject as Weapon
			PlayerRef.UnequipItemEx(akBaseObject, equipSlot = 1, preventEquip = false)
		
		ElseIf akBaseObject as Spell
			If Amp.BlockMagic && PlayerRef.GetEquippedSpell(1) != None
				PlayerRef.UnequipSpell(akBaseObject as Spell, 1)
			EndIf
		EndIf
	EndEvent
	
	Event OnSit(ObjectReference akFurniture)
		String ObjectName = akFurniture.GetBaseObject().GetName()
		If StringUtil.Find(ObjectName, "This Should Not Be Visible", 0) != -1
			PlayerRef.MoveTo(PlayerRef)
			Debug.Notification("I need both hands to mine")
		EndIf
	EndEvent
EndState

State BothHands
	Event OnBeginState()
		;Debug.Messagebox("HIHI")
		RegisterForModEvent("_SLS_PlayerCombatChange", "On_SLS_PlayerCombatChange")
		;PlayerRef.AddSpell(_SLS_CombatChangeDetectSpell, false)
		Amp.ForbidBathing()
		_SLS_AmpIsHandless.SetValueInt(1)
		PlayerRef.AddPerk(_SLS_AmputationContainerBlockPerk)
		RemoveAllInventoryEventFilters()
		On_SLS_PlayerCombatChange(InCombat = true)
		;RegisterForMenu("ContainerMenu")
		;_SLS_AmpArmlessPacifyQuest.Stop()
		;_SLS_AmpArmlessPacifyQuest.Start()
	EndEvent

	Event OnItemAdded(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
		ObjectReference ObjRef = Game.GetCurrentCrosshairRef()
		If akSourceContainer == None && !akBaseItem.HasKeyword(SexlabNoStrip) && akBaseItem.GetName() != "" && !Devious.IsDeviousInvDevice(akBaseItem) && !_SLS_AmpAllowedPickups.HasForm(akBaseItem)
			If Utility.RandomFloat(0.0, 100.0) > 70.0
				Debug.Notification("Despite not having any hands you manage to pick up " + akBaseItem.GetName())
			Else
				PlayerRef.DropObject(akBaseItem, aiItemCount)
				;LostFound.DropItem(PlayerRef, akBaseItem)
			EndIf
		EndIf
	EndEvent
	
	;/
	Event OnEndState()
		UnregisterForMenu("ContainerMenu")
	EndEvent

	Event OnMenuOpen(String MenuName)
		While Utility.IsInMenuMode()
			Input.TapKey(Input.GetMappedKey("Tween Menu", DeviceType = 0xFF))
			Utility.WaitMenuMode(0.1)
		EndWhile
		Utility.Wait(0.1)
		Debug.Notification("I can't open containers without any hands!")
	EndEvent
	/;
	
	Event On_SLS_PlayerCombatChange(Bool InCombat)
		If InCombat && StorageUtil.GetIntValue(Menu, "DismemberCombatStop", Missing = 1)
			_SLS_AmpArmlessPacifyQuest.Stop()
			_SLS_AmpArmlessPacifyQuest.Start()
			If Devious.GetState() == "Installed"
				If MQ104.GetCurrentStageID() >= 90 && !Devious.IsPlayerGagged() ; MQ104 - Player has learned to shout
					_SLS_AmpHelplessGagQuest.Stop()
					_SLS_AmpHelplessGagQuest.Start()
					Actor Gagger = (_SLS_AmpHelplessGagQuest.GetNthAlias(0) as ReferenceAlias).GetReference() as Actor
					If Gagger
						Gagger.EvaluatePackage()
					EndIf
				EndIf
			EndIf
		EndIf
	EndEvent

	Event OnObjectEquipped(Form akBaseObject, ObjectReference akReference)
		If akBaseObject as Weapon
			PlayerRef.UnequipItemEx(akBaseObject, equipSlot = 2, preventEquip = false)
			PlayerRef.UnequipItemEx(akBaseObject, equipSlot = 1, preventEquip = false)
		
		ElseIf akBaseObject as Spell
			If Amp.BlockMagic && (PlayerRef.GetEquippedSpell(0) != None || PlayerRef.GetEquippedSpell(1) != None)
				PlayerRef.UnequipSpell(akBaseObject as Spell, 0)
				PlayerRef.UnequipSpell(akBaseObject as Spell, 1)
			EndIf
			
		ElseIf akBaseObject as Armor && !akBaseObject.HasKeyword(AMP_KWDProsthetic)
			If !akBaseObject.HasKeyword(SexlabNoStrip) && _SLS_AmpAllowEquip.GetValueInt() == 0 && akBaseObject.GetName() != "" && !Devious.IsDeviousInvDevice(akBaseObject)
				PlayerRef.UnequipItem(akBaseObject)
				Debug.Notification("I can't dress myself. Maybe my follower can help")
			EndIf
			
		ElseIf akBaseObject as Light
			PlayerRef.UnequipItemEx(akBaseObject, equipSlot = 2, preventEquip = false)
		EndIf
	EndEvent
	
	Event OnSit(ObjectReference akFurniture)
		String ObjectName = akFurniture.GetBaseObject().GetName()
		If StringUtil.Find(ObjectName, "This Should Not Be Visible", 0) != -1
			PlayerRef.MoveTo(PlayerRef)
			Debug.Notification("I can't mine without hands!")
		EndIf
	EndEvent
EndState

GlobalVariable Property _SLS_AmpIsHandless Auto
GlobalVariable Property _SLS_AmpAllowEquip Auto

MiscObject Property _SLS_NeverAddedItem Auto

Keyword zad_DeviousGag
Keyword AMP_KWDProsthetic
Keyword Property ArmorShield Auto
Keyword Property SexlabNoStrip Auto

Quest Property _SLS_AmpArmlessPacifyQuest Auto
Quest Property _SLS_AmpHelplessGagQuest Auto
Quest Property MQ104 Auto

Spell Property _SLS_CombatChangeDetectSpell Auto

Actor Property PlayerRef Auto

Perk Property _SLS_AmputationContainerBlockPerk Auto

Formlist Property _SLS_AmpAllowedPickups Auto

_SLS_Amputation Property Amp Auto
_SLS_InterfaceDevious Property Devious Auto
SLS_Mcm Property Menu Auto
