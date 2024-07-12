Scriptname aaaKNNAnimControlQuest extends Quest

Globalvariable Property aaaKNNIsPCGenderFemale auto
Globalvariable Property aaaKNNIsShieldUnequip auto
GlobalVariable Property aaaKNNIsEnablePOV auto
GlobalVariable Property aaaKNNIsEnableHungry auto
GlobalVariable Property aaaKNNIsBasicNeedsEnable auto
GlobalVariable Property aaaKNNIsEnableExpression auto
int camerastate = 0

;Gender is female : true, male : false
bool Function GetGender(Actor targetActor)
	if targetActor
		if Game.GetPlayer() == targetActor
			;bool IsFemale = (aaaKNNIsPCGenderFemale.GetValueInt() as bool)
			;Debug.Trace(targetActor.GetBaseObject().GetName() + " is Female? : " + IsFemale)
			return (aaaKNNIsPCGenderFemale.GetValueInt() as bool)
		else
			;bool IsFemale = KNNPlugin_Utility.GetActorGender(targetActor)
			;Debug.Trace(targetActor.GetBaseObject().GetName() + " is Female? : " + IsFemale)
			return KNNPlugin_Utility.GetActorGender(targetActor)
		endIf
	endIf
	return true
EndFunction

Function SetQuestControl(bool IsStartQuest)
	if IsStartQuest
		if !Self.IsRunning()
			Self.Start()
			;Debug.Trace("SetQuestControl -> Start")
		endIf
	else
		;if Self.IsRunning()
			Self.Stop()
			;Debug.Trace("SetQuestControl -> Stop")
		;endIf
	endIf
EndFunction

bool Function IsPlayMouthAnimWhileEating()
	if 0 == aaaKNNIsEnableExpression.GetValueInt()
		return false
	endIf
	return true
EndFunction

bool Function SetThirdPersonCameraState()
	camerastate = Game.GetCameraState()
	;Debug.Notification("CameraState : " + camerastate)
	if 9 == camerastate
		return true
	elseIf 0 == camerastate && 0 != aaaKNNIsEnablePOV.GetValueInt()
		;Debug.Notification("forceThirdPerson")		
		Game.forceThirdPerson()
		Utility.Wait(0.1)
		return true
	endIf
	return false
EndFunction

int Function SetThirdPersonCameraStateForBook()
	camerastate = Game.GetCameraState()
	;Debug.Notification("CameraState : " + camerastate)
	if camerastate == 9
		return camerastate
	elseIf camerastate == 0
		;Debug.Notification("forceThirdPerson")
		Game.forceThirdPerson()
		Utility.Wait(0.5)
		return camerastate
	elseIf camerastate == 7
		return camerastate
	;	int limit = 0
	;	while limit < 5
	;		Utility.Wait(1.0)
	;		camerastate = Game.GetCameraState()
	;		if camerastate == 0
	;			Utility.Wait(0.5)
	;			Game.forceThirdPerson()
	;			;Debug.Notification("limit : " + limit)
	;			return true
	;		elseIf camerastate == 9
	;			return true
	;		endIf
	;		limit += 1
	;	endWhile
	endIf
	return -1
EndFunction

Function ReturnCameraStateForBook()
	if camerastate == 0
		Utility.Wait(0.1)
		Game.ForceFirstPerson()
	endIf
EndFunction

Function ReturnCameraState()
	if aaaKNNIsEnablePOV.GetValueInt() == 1 && camerastate == 0
		Game.ForceFirstPerson()
	endIf
EndFunction

Function ForceThirdPersonCameraState()
	camerastate = Game.GetCameraState()
	if camerastate == 0
		Game.forceThirdPerson()
	endIf
EndFunction

Function ForceReturnCameraState()
	if camerastate == 0
		Game.ForceFirstPerson()
	endIf
EndFunction

Function ResetThirdPersonCameraPosition()
	Game.ForceFirstPerson()
	Game.forceThirdPerson()
	Utility.Wait(0.2)
EndFunction

Event OnInIt()	
EndEvent

Armor Function UnequipShield(Actor thisActor)
	if 0 != aaaKNNIsShieldUnequip.GetValueInt()
		if thisActor != Game.GetPlayer()
			Armor sForm = thisActor.GetWornForm(0x00000200) as Armor
			if sForm
				thisActor.UnequipItemEx(sForm)
				return sForm
			endIf
		else
			KNNPlugin_Utility.PlayerUnequipItems(0x00000200)
		endIf
	endIf
	return none
EndFunction

Function EquipShield(Actor thisActor, Armor shield)
	if 2 == aaaKNNIsShieldUnequip.GetValueInt()
		if thisActor != Game.GetPlayer()
			if shield
				if !thisActor.GetWornForm(0x00000200)
					if 0 < thisActor.GetItemCount(shield)
						thisActor.EquipItemEx(shield)
					endIf
				endIf
			endIf
		else
			KNNPlugin_Utility.PlayerEquipItems()
		endIf
	endIf
EndFunction

int Function GetUnequipArmorSlotMasks(Actor akTarget, bool IsSleep)
	int slotMasks = 0
	bool[] globals = GetArmorSlot(akTarget, IsSleep)
	int[] slotMask = new int[29]
	slotMask[0] = 0x00000001
	slotMask[1] = 0x00000002
	slotMask[2] = 0x00000004
	slotMask[3] = 0x00000008
	slotMask[4] = 0x00000010
	slotMask[5] = 0x00000020
	slotMask[6] = 0x00000040
	slotMask[7] = 0x00000080
	slotMask[8] = 0x00000100
	slotMask[9] = 0x00000200
	slotMask[10] = 0x00000400
	slotMask[11] = 0x00000800
	slotMask[12] = 0x00001000
	slotMask[13] = 0x00002000
	slotMask[14] = 0x00004000
	slotMask[15] = 0x00008000
	slotMask[16] = 0x00010000
	slotMask[17] = 0x00020000
	slotMask[18] = 0x00040000
	slotMask[19] = 0x00080000
	slotMask[20] = 0x00400000
	slotMask[21] = 0x00800000
	slotMask[22] = 0x01000000
	slotMask[23] = 0x02000000
	slotMask[24] = 0x04000000
	slotMask[25] = 0x08000000
	slotMask[26] = 0x10000000
	slotMask[27] = 0x20000000
	slotMask[28] = 0x40000000
	if globals.Length == slotMask.Length
		int i = 0
		while i < globals.Length
			if globals[i]
				slotMasks += slotMask[i]
			endIf
			i += 1
		endwhile
	endIf
	return slotMasks
EndFunction

bool[] Function GetArmorSlot(Actor akTarget, bool IsSleep)
	string xml = "EatingSleepingDrinking\\backup\\PlayerWashBodySlot.xml"
	if IsSleep
		xml = "EatingSleepingDrinking\\backup\\PlayerSleepSlot.xml"
	else
		if akTarget != Game.GetPlayer()
			ActorBase base = akTarget.GetLeveledActorBase()
			if base
				if 1 == base.GetSex()
					xml = "EatingSleepingDrinking\\backup\\FemaleFollowersWashBodySlot.xml"
				else
					xml = "EatingSleepingDrinking\\backup\\MaleFollowersWashBodySlot.xml"
				endIf
			endIf
		endIf
	endIf
	return KNNPlugin_Utility.LoadSlotMasks(xml)
EndFunction

Armor[] Function FollowerUnEquipWeapArmor(Actor akTarget)
	if akTarget.IsWeaponDrawn()
		akTarget.SheatheWeapon()
		Utility.Wait(0.5)
	endIf
	
	int i = 0
	while i < 2
		if 0 < akTarget.GetEquippedItemType(i)
			Form handEquippedItem = akTarget.GetEquippedObject(i)
			if handEquippedItem
				int handSlot = 1
				if 0 == i
					handSlot = 2
				endIf
				akTarget.UnequipItemEx(handEquippedItem, handSlot)
			endIf
		endIf	
		i += 1
	endwhile

	form ammoForm = KNNPlugin_Utility.GetEquipAmmo(akTarget)
	if ammoForm
		;akTarget.UnequipItem(ammoForm, false, true)
		akTarget.UnequipItemEx(ammoForm)
	endIf

	Armor[] resultArmor
	bool[] masks = GetArmorSlot(akTarget, false)
	int[] slotMask = new int[29]
	slotMask[0] = 0x00000001
	slotMask[1] = 0x00000002
	slotMask[2] = 0x00000004
	slotMask[3] = 0x00000008
	slotMask[4] = 0x00000010
	slotMask[5] = 0x00000020
	slotMask[6] = 0x00000040
	slotMask[7] = 0x00000080
	slotMask[8] = 0x00000100
	slotMask[9] = 0x00000200
	slotMask[10] = 0x00000400
	slotMask[11] = 0x00000800
	slotMask[12] = 0x00001000
	slotMask[13] = 0x00002000
	slotMask[14] = 0x00004000
	slotMask[15] = 0x00008000
	slotMask[16] = 0x00010000
	slotMask[17] = 0x00020000
	slotMask[18] = 0x00040000
	slotMask[19] = 0x00080000
	slotMask[20] = 0x00400000
	slotMask[21] = 0x00800000
	slotMask[22] = 0x01000000
	slotMask[23] = 0x02000000
	slotMask[24] = 0x04000000
	slotMask[25] = 0x08000000
	slotMask[26] = 0x10000000
	slotMask[27] = 0x20000000
	slotMask[28] = 0x40000000
	bool IsUndressing = false
	Armor[] wearedArmor = new Armor[29]
	if 29 == masks.Length
		i = 0
		while i < 29
			if masks[i]
				 Armor thisArmor = akTarget.GetWornForm(slotMask[i]) as Armor
				if thisArmor
					akTarget.UnequipItemEx(thisArmor)
					wearedArmor[i] = thisArmor
					IsUndressing = true
				endIf
			endIf
			i += 1
		endWhile
	endIf
	if IsUndressing
		resultArmor = wearedArmor
	endIf
	return resultArmor
EndFunction

Function FollowerEquipArmors(Actor thisActor)
	if thisActor
		Form ring = thisActor.GetWornForm(0x00000040)
		if ring
			thisActor.UnequipItemEX(ring)
			Utility.Wait(0.5)
			thisActor.EquipItemEx(ring, 1, false, false)
		else
			Form dummyArmor = Game.GetFormFromFile(0x01CF2B, "Skyrim.esm") ;Game.GetFormEX(Math.LogicalOr(Math.LeftShift(skyModIndex, 24), 0x01CF2B))
			if dummyArmor
				thisActor.AddItem(dummyArmor, 1, true)
				thisActor.EquipItem(dummyArmor, false, true)
				thisActor.RemoveItem(dummyArmor, 1, true)
			endIf
		endIf
	endIf
EndFunction

FormList Property Bedroll_MISC_List auto
FormList Property Bedroll_ACTI_List auto
FormList Property Bedroll_FURN_List auto
int Function GetBedrollIndex(Form bedForm)
	if bedForm && 0 < Bedroll_FURN_List.GetSize() && Bedroll_FURN_List.GetSize() == Bedroll_ACTI_List.GetSize() && Bedroll_FURN_List.GetSize() == Bedroll_MISC_List.GetSize()
		int type = bedForm.GetType()
		if 24 == type;activator
			return Bedroll_ACTI_List.Find(bedForm)
		elseIf 40 == type;furniture
			return Bedroll_FURN_List.Find(bedForm)
		endIf
	endIf
	return -1
EndFunction