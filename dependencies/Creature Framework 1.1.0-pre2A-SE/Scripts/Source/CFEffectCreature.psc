Scriptname CFEffectCreature extends ActiveMagicEffect
{The effect script that handles sending/receiving events and armour swapping for a creature | Creature Framework}

; General properties
CreatureFramework property API auto hidden
Spell property CreatureSpell auto

; The target actor
Actor savedTarget

; Whether or not the actor is currently having sex
bool havingSex

; The most recent override gender and arousal
int savedOverrideGender
int savedOverrideArousal
int jSavedCreatureModMap

;CF FIX - Make arousedArmor global so we don't have to waste resources grabbing it again
Armor arousedArmor

; The effect has started
event OnEffectStart(Actor target, Actor caster)
	if target == none
		CFDebug.Log("[Creature] Started with no target; Skyrim shit its pants")
		Dispel()
		return
	endIf

	API = CreatureFrameworkUtil.GetAPI()
	savedTarget = target
	Race raceForm = target.GetRace()
	Armor skinForm = API.GetSkinOrFakeFromActor(target)
	CFDebug.Log("[Creature] Started on " + CreatureFrameworkUtil.GetDetailedActorName(target) + " with race/skin " + CreatureFrameworkUtil.GetDetailedFormName(raceForm) + CreatureFrameworkUtil.GetDetailedFormName(skinForm))

	; Register for mod events
	UnregisterForAllModEvents()
	RegisterForModEvent("CFInternal_ArousedSettingChanged", "OnArousedSettingChanged")
	RegisterForModEvent("CFInternal_ClearCreatures", "OnClearCreatures")
	RegisterForModEvent("CFInternal_Update_" + target, "OnForceUpdate")
	RegisterForModEvent("CFInternal_Update_" + raceForm.GetFormID() + "_" + skinForm.GetFormID(), "OnForceUpdate")
	RegisterForModEvent("CFInternal_SaveGenders", "OnSaveGenders")

	; Force an immediate update
	OnForceUpdate()
endEvent

; The effect has finished
event OnEffectFinish(Actor target, Actor caster)
	if target == none
		target = savedTarget
	endIf
	if target != none
		CFDebug.Log("[Creature] Finished on " + CreatureFrameworkUtil.GetDetailedActorName(target))
		API.DeactivateActor(target)
		ChangeArousal(false, false, false, true, true)
		target.RemoveSpell(CreatureSpell)
	else
		CFDebug.Log("[Creature] Couldn't properly finish the effect on a creature; none object")
	endIf
endEvent

; One of the Aroused settings has been changed
event OnArousedSettingChanged()
	UnregisterForUpdate()
	if API.IsArousedEnabled() && savedOverrideArousal == 0
		RegisterForSingleUpdate(0.25)
	else
		if !havingSex && GetState() == "ArousalAroused"
			ChangeArousal(false, false, true)
		endIf
		GotoState("")
	endIf
endEvent

; The creatures are being cleared
event OnClearCreatures()
	Dispel()
endEvent

; An update has been triggered forcefully
event OnForceUpdate()
	bool updateArousal = true
	int arousalSource = API.GetArousalSource(savedTarget)
	UnregisterForUpdate()
	UnregisterForModEvent("CFInternal_SexLabSceneStart_" + savedTarget)
	UnregisterForModEvent("CFInternal_SexLabSceneEnd_" + savedTarget)
	CFDebug.Log("[Creature] Update being forced on " + CreatureFrameworkUtil.GetDetailedActorName(savedTarget) + "; havingSex=" + havingSex + " savedOverrideArousal=" + savedOverrideArousal + " arousalSource=" + arousalSource)

	; Update arousal status with SLA or override
	if (arousalSource == 2 || arousalSource == 3) && API.IsAroused(savedTarget, havingSex)
		GotoState("ArousalAroused")
	else
		GotoState("")
	endIf

	; Trigger SexLab events for SexLab animations or arousal strip override
	if !havingSex && (arousalSource == 1 || arousalSource == 4)
		DoStrippedArousal()
		updateArousal = false
	elseIf havingSex && arousalSource != 1 && arousalSource != 4
		DoStrippedArousal(false)
		updateArousal = false
	endIf
	if arousalSource != 4
		RegisterForModEvent("CFInternal_SexLabSceneStart_" + savedTarget, "OnSexLabSceneStart")
		RegisterForModEvent("CFInternal_SexLabSceneEnd_" + savedTarget, "OnSexLabSceneEnd")
	endIf

	if updateArousal
		ChangeArousal(havingSex || GetState() == "ArousalAroused", havingSex, !havingSex)
	endIf

	if API.IsArousedEnabled() && !havingSex && arousalSource < 3
		RegisterForSingleUpdate(API.Config.PrfArousalPollRate)
	endIf
endEvent

;Equips schlong for (an actor having sex OR an actor that's aroused) IF their arousedArmor ISN'T none AND it's NOT equippied
;This check is then triggered in the default OnUpdate() event as well as the OnUpdate() tied to the "ArousalAroused" state
Bool function schlongFixed()

	if (havingSex as Bool || API.IsAroused(savedTarget, false)) && arousedArmor != none && savedTarget.IsEquipped(arousedArmor as form) == false
		debug.Trace("[CF][FIX] Equipping missing aroused armor", 0)
		savedTarget.EquipItem(arousedArmor as form, false, false)
		return true
	endIf
	return false
endFunction

; The framework is telling us that the actor is involved in a SexLab scene
event OnSexLabSceneStart()
	DoStrippedArousal()
endEvent

; The framework is telling us that the actor is no longer involved in a SexLab scene
event OnSexLabSceneEnd()
	DoStrippedArousal(false)
endEvent

; The framework is telling us to save our previous override gender
event OnSaveGenders()
	if savedOverrideGender != 0
		API.SetOverrideGender(savedTarget, savedOverrideGender)
	endIf
endEvent

; An item has been unequipped
event OnObjectUnequipped(Form baseObject, ObjectReference reference)
	; Ensure the event is occurring for an armour
	if !(baseObject as Armor)
		return
	endIf

	if havingSex || GetState() == "ArousalAroused"
		Race raceForm = savedTarget.GetRace()
		Armor skinForm = API.GetSkinOrFakeFromActor(savedTarget)
		string activeMod = API.GetActiveMod(raceForm, skinForm)
		if activeMod == "" && skinForm != API.FakeSkin
			activeMod = API.GetActiveMod(raceForm, none)
		endIf
		if activeMod != ""
			int creatureModMap = API.GetCreatureModMap(activeMod, raceForm, skinForm)
			int creatureModType = JMap.GetInt(creatureModMap, "type")
			int jRestrictedSlots = JMap.GetObj(creatureModMap, "restrictedSlots")
			if JArray.Count(jRestrictedSlots) > 0
				; Handle the armour swap
				if creatureModType == 1 || creatureModType == 2
					int gender = API.GetGender(savedTarget)

					; Get the proper armours to use by gender
					Armor normalArmor
					if gender == 1
						normalArmor = JMap.GetForm(creatureModMap, "normalArmor") as Armor
						arousedArmor = JMap.GetForm(creatureModMap, "arousedArmor") as Armor
					elseIf gender == 2
						normalArmor = JMap.GetForm(creatureModMap, "normalArmorFemale") as Armor
						arousedArmor = JMap.GetForm(creatureModMap, "arousedArmorFemale") as Armor
						if API.Config.GndMaleFallback && normalArmor == none && arousedArmor == none
							normalArmor = JMap.GetForm(creatureModMap, "normalArmor") as Armor
							arousedArmor = JMap.GetForm(creatureModMap, "arousedArmor") as Armor
						endIf
					endIf

					if baseObject != normalArmor && baseObject != arousedArmor
						if arousedArmor != none && !CreatureFrameworkUtil.ActorHasAnyEquippedSlot(savedTarget, jRestrictedSlots)
							CFDebug.Log("[Creature] Equipping aroused armour on " + CreatureFrameworkUtil.GetDetailedActorName(savedTarget) + " from armour unequip; gender=" + gender)
							API.RemoveArmors(savedTarget)
							Utility.Wait(0.05)
							CreatureFrameworkUtil.AddAndEquipArmor(savedTarget, arousedArmor)
						endIf
					endIf
				endIf

				; Handle the event
				if creatureModType == 0 || creatureModType == 2
					API.FireEvent(activeMod, savedTarget, true, raceForm, skinForm, havingSex, !havingSex, true, -1, baseObject as Armor)
				endIf
			endIf
		endIf
	endIf
endEvent

; An update has been triggered
event OnUpdate()
	if !havingSex && API.IsAroused(savedTarget, false)
		GotoState("ArousalAroused")
		ChangeArousal(true, false, true)
	endIf

	; Do it again if Aroused is still enabled and the actor is alive
	if API.IsArousedEnabled() && !savedTarget.IsDead()
		RegisterForSingleUpdate(API.Config.PrfArousalPollRate)
	endIf
	
	;CF FIX - If schlong was fixed wait 250ms and recheck so it stuck
	if(self.schlongFixed() == true)
		self.RegisterForSingleUpdate(0.250000)
	endIf
endEvent

; The actor has been aroused from SexLab Aroused arousal rating
state ArousalAroused
	; An update has been triggered
	event OnUpdate()
		if !havingSex && !API.IsAroused(savedTarget, false)
			GotoState("")
			ChangeArousal(false, false, true)
		endIf

		; Do it again if Aroused is still enabled and the actor is alive
		if API.IsArousedEnabled() && !savedTarget.IsDead()
			RegisterForSingleUpdate(API.Config.PrfArousalPollRate)
		endIf
		
		;CF FIX - If schlong was fixed wait 250ms and recheck so it stuck
		if(self.schlongFixed() == true)
			self.RegisterForSingleUpdate(0.250000)
		endIf
	endEvent
endState

; Handle stripped arousal (for SexLab or override)
function DoStrippedArousal(bool sexing = true)
	if sexing
		havingSex = true
		UnregisterForUpdate()
		ChangeArousal(true, true, false)
	else
		havingSex = false
		if !API.IsAroused(savedTarget, false)
			GotoState("")
			ChangeArousal(false, true, false)
		else
			CFDebug.Log("[Creature] " + CreatureFrameworkUtil.GetDetailedActorName(savedTarget) + " is still aroused after ending stripped arousal")
			DoStrippingOrRestoring(true)
			Utility.Wait(0.05)
			int jRestrictedSlots = JMap.GetObj(jSavedCreatureModMap, "restrictedSlots")
			if CreatureFrameworkUtil.ActorHasAnyEquippedSlot(savedTarget, jRestrictedSlots)
				ChangeArousal(false, false, false, true, true)
			endIf
		endIf
		if API.IsArousedEnabled() && savedOverrideArousal == 0
			RegisterForSingleUpdate(API.Config.PrfArousalPollRate)
		endIf
	endIf
endFunction

; Change the actor's arousal state
function ChangeArousal(bool aroused, bool fromSex, bool fromArousal, bool onlyDoAPIRemoveArmors = false, bool suppressMessage = false)
	string actorName = CreatureFrameworkUtil.GetDetailedActorName(savedTarget)
	Race raceForm = savedTarget.GetRace()
	Armor skinForm = API.GetSkinOrFakeFromActor(savedTarget)

	if !suppressMessage
		if aroused
			CFDebug.Log("[Creature] " + actorName + " aroused")
		else
			CFDebug.Log("[Creature] " + actorName + " unaroused")
		endIf
	endIf

	string activeMod = API.GetActiveMod(raceForm, skinForm)
	if activeMod == "" && skinForm != API.FakeSkin
		skinForm = API.FakeSkin
		activeMod = API.GetActiveMod(raceForm, skinForm)
	endIf
	if activeMod != ""
		int creatureModMap = API.GetCreatureModMap(activeMod, raceForm, skinForm)
		int creatureModType = JMap.GetInt(creatureModMap, "type")
		jSavedCreatureModMap = creatureModMap

		if onlyDoAPIRemoveArmors && creatureModType > 0
			CFDebug.Log("[Creature] Removing both API armours from " + actorName + " and doing nothing else")
			API.RemoveArmors(savedTarget)
			Utility.Wait(0.05)
			return
		endIf

		int jRestrictedSlots = JMap.GetObj(creatureModMap, "restrictedSlots")
		bool stripArmor = JMap.GetInt(creatureModMap, "stripArmor") as bool
		bool stripWeapons = JMap.GetInt(creatureModMap, "stripWeapons") as bool

		; Ensure the restricted slots are empty if necessary
		if (!fromSex || !stripArmor) && CreatureFrameworkUtil.ActorHasAnyEquippedSlot(savedTarget, jRestrictedSlots)
			CFDebug.Log("[Creature] Not doing anything on " + actorName + "; slot restrictions have equipped items")
			return
		endIf

		; Strip/restore armour if we came from sex
		if fromSex
			DoStrippingOrRestoring(!aroused, savedTarget, actorName, raceForm, skinForm, activeMod, creatureModMap, stripArmor, stripWeapons)
			Utility.Wait(0.05)
		endIf

		; Handle the armour swap
		if creatureModType == 1 || creatureModType == 2
			int gender = API.GetGender(savedTarget)

			; Get the proper armours to use by gender
			Armor normalArmor
			if gender == 1
				normalArmor = JMap.GetForm(creatureModMap, "normalArmor") as Armor
				arousedArmor = JMap.GetForm(creatureModMap, "arousedArmor") as Armor
			elseIf gender == 2
				normalArmor = JMap.GetForm(creatureModMap, "normalArmorFemale") as Armor
				arousedArmor = JMap.GetForm(creatureModMap, "arousedArmorFemale") as Armor
				if API.Config.GndMaleFallback && normalArmor == none && arousedArmor == none
					normalArmor = JMap.GetForm(creatureModMap, "normalArmor") as Armor
					arousedArmor = JMap.GetForm(creatureModMap, "arousedArmor") as Armor
				endIf
			endIf

			; Equip appropriate armour
			if aroused
				API.RemoveArmors(savedTarget)
				Utility.Wait(0.05)
				if arousedArmor != none
					CFDebug.Log("[Creature] Equipping aroused armour on " + actorName + "; gender=" + gender)
					CreatureFrameworkUtil.AddAndEquipArmor(savedTarget, arousedArmor)
				else
					if normalArmor != none
						CFDebug.Log("[Creature] Not equipping aroused armour on " + actorName + "; there is no aroused armour; equipping normal armour instead; gender=" + gender)
						CreatureFrameworkUtil.AddAndEquipArmor(savedTarget, normalArmor)
					else
						CFDebug.Log("[Creature] Not equipping aroused armour on " + actorName + "; there is no aroused armour; gender=" + gender)
					endIf
				endIf
			else
				API.RemoveArmors(savedTarget)
				Utility.Wait(0.05)
				if normalArmor != none
					CFDebug.Log("[Creature] Equipping normal armour on " + actorName + "; gender=" + gender)
					CreatureFrameworkUtil.AddAndEquipArmor(savedTarget, normalArmor)
				else
					CFDebug.Log("[Creature] Not equipping normal armour on " + actorName + "; there is no normal armour; gender=" + gender)
				endIf
			endIf
		endIf

		; Handle the event
		if creatureModType == 0 || creatureModType == 2
			API.FireEvent(activeMod, savedTarget, aroused, raceForm, skinForm, fromSex, fromArousal, false)
		endIf

		; Store the current override gender and arousal
		savedOverrideGender = API.GetOverrideGender(savedTarget)
		savedOverrideArousal = API.GetOverrideArousal(savedTarget)

		; Strip the weapons and armour extra hard
		if fromSex && aroused && API.IsCreature(savedTarget)
			if stripArmor
				UnequipArmorSomeMore(savedTarget)
			endIf
			if stripWeapons
				UnequipWeaponsSomeMore(savedTarget)
			endIf
		endIf
	else
		CFDebug.Log("[Creature] No active mod for " + actorName + "; dispelling")
		Dispel()
	endIf
endFunction

; Handle armour/weapon stripping and restoring
function DoStrippingOrRestoring(bool restore, Actor target = none, string actorName = "", Race raceForm = none, Armor skinForm = none, string activeMod = "", int creatureModMap = -1, bool stripArmor = false, bool stripWeapons = false)
	; Fetch a bunch of data if it wasn't provided
	if target == none
		target = savedTarget
		actorName = CreatureFrameworkUtil.GetDetailedActorName(savedTarget)
		raceForm = savedTarget.GetRace()
		skinForm = API.GetSkinOrFakeFromActor(savedTarget)
		activeMod = API.GetActiveMod(raceForm, skinForm)
		if activeMod == "" && skinForm != API.FakeSkin
			skinForm = API.FakeSkin
			activeMod = API.GetActiveMod(raceForm, skinForm)
		endIf
		if activeMod != ""
			creatureModMap = API.GetCreatureModMap(activeMod, raceForm, skinForm)
			stripArmor = JMap.GetInt(creatureModMap, "stripArmor") as bool
			stripWeapons = JMap.GetInt(creatureModMap, "stripWeapons") as bool
		else
			CFDebug.Log("[Creature] Skipping strip/restore routine on " + actorName + "; no active mod")
			return
		endIf
	endIf

	; Handle stripping/equipping only for creatures
	if API.IsCreature(target)
		if !restore
			CFDebug.Log("[Creature] Beginning armour/weapon stripping on " + actorName + "; stripArmor=" + stripArmor + " stripWeapons=" + stripWeapons)

			int jFormBlacklist = JMap.GetObj(creatureModMap, "stripFormBlacklist")

			; Strip away that armour
			if stripArmor
				int jSlotBlacklist = JMap.GetObj(creatureModMap, "stripSlotBlacklist")

				int[] armorSlots = API.GetArmorSlots()
				int s = 0
				while s < armorSlots.length
					Armor wornArmor = target.GetWornForm(armorSlots[s]) as Armor
					if wornArmor
						if !wornArmor.HasKeyword(API.ArmorNormalKeyword) && !wornArmor.HasKeyword(API.ArmorArousedKeyword)
							if JArray.FindForm(jFormBlacklist, wornArmor) == -1 && JArray.FindInt(jSlotBlacklist, armorSlots[s]) == -1
								CFDebug.Log("[Creature] Stripping " + CreatureFrameworkUtil.GetDetailedFormName(wornArmor) + " from " + actorName)
								target.UnequipItem(wornArmor, true, true)
								JFormDB.SetForm(target, ".CFForm.StrippedArmor" + s, wornArmor)
								Utility.Wait(0.05)
							else
								CFDebug.Log("[Creature] Not stripping " + CreatureFrameworkUtil.GetDetailedFormName(wornArmor) + " from " + actorName + "; blacklisted")
							endIf
						else
							CFDebug.Log("[Creature] Not stripping " + CreatureFrameworkUtil.GetDetailedFormName(wornArmor) + " from " + actorName + "; has keyword")
						endIf
					endIf
					s += 1
				endWhile
			endIf

			; Take away their pointy sticks
			if stripWeapons
				Form leftHand = target.GetEquippedObject(0)
				Form rightHand = target.GetEquippedObject(1)

				if leftHand != none
					CFDebug.Log("[Creature] Stripping " + CreatureFrameworkUtil.GetDetailedFormName(leftHand) + " from " + actorName)
					JFormDB.SetForm(target, ".CFForm.StrippedWeaponLeft", leftHand)
					CreatureFrameworkUtil.GenericUnequip(target, leftHand, true, 0)
					Utility.Wait(0.05)
				endIf
				if rightHand != none
					CFDebug.Log("[Creature] Stripping " + CreatureFrameworkUtil.GetDetailedFormName(rightHand) + " from " + actorName)
					JFormDB.SetForm(target, ".CFForm.StrippedWeaponRight", rightHand)
					CreatureFrameworkUtil.GenericUnequip(target, rightHand, true, 1)
					Utility.Wait(0.05)
				endIf
			endIf

			CFDebug.Log("[Creature] Finished armour/weapon stripping on " + actorName)
		else
			CFDebug.Log("[Creature] Beginning armour/weapon restoration on " + actorName)

			; Cover them back up
			if stripArmor
				int[] armorSlots = API.GetArmorSlots()
				int s = 0
				while s < armorSlots.length
					Armor wornArmor = JFormDB.GetForm(target, ".CFForm.StrippedArmor" + s) as Armor
					if wornArmor
						CFDebug.Log("[Creature] Equipping " + CreatureFrameworkUtil.GetDetailedFormName(wornArmor) + " on " + actorName)
						target.EquipItem(wornArmor, false, true)
						JFormDB.SetForm(target, ".CFForm.StrippedArmor" + s, none)
						Utility.Wait(0.05)
					endIf
					s += 1
				endWhile
			endIf

			; Make them lethal again
			if stripWeapons
				Form leftHand = JFormDB.GetForm(target, ".CFForm.StrippedWeaponLeft")
				Form rightHand = JFormDB.GetForm(target, ".CFForm.StrippedWeaponRight")
				if leftHand != none
					CFDebug.Log("[Creature] Equipping " + CreatureFrameworkUtil.GetDetailedFormName(leftHand) + " on " + actorName)
					CreatureFrameworkUtil.GenericEquip(target, leftHand, false, 0)
					JFormDB.SetForm(target, ".CFForm.StrippedWeaponLeft", none)
					Utility.Wait(0.05)
				endIf
				if rightHand != none
					CFDebug.Log("[Creature] Equipping " + CreatureFrameworkUtil.GetDetailedFormName(rightHand) + " on " + actorName)
					CreatureFrameworkUtil.GenericEquip(target, rightHand, false, 1)
					JFormDB.SetForm(target, ".CFForm.StrippedWeaponRight", none)
				endIf
			endIf

			CFDebug.Log("[Creature] Finished armour/weapon restoration on " + actorName)
		endIf
	else
		CFDebug.Log("[Creature] Skipping strip/restore routine on " + actorName + "; not a creature")
	endIf
endFunction

; Unequip armour extra hard, because Skyrim is dumb
function UnequipArmorSomeMore(Actor target)
	int[] armorSlots = API.GetArmorSlots()
	int s = 0
	while s < armorSlots.length
		Armor wornArmor = JFormDB.GetForm(target, ".CFForm.StrippedArmor" + s) as Armor
		if wornArmor
			target.UnequipItem(wornArmor, true, true)
			Utility.Wait(0.05)
		endIf
		s += 1
	endWhile
endFunction

; Unequip the weapons extra hard, because Skyrim is dumb
function UnequipWeaponsSomeMore(Actor target)
	Form leftHand = savedTarget.GetEquippedObject(0)
	Form rightHand = savedTarget.GetEquippedObject(1)
	if leftHand != none
		CreatureFrameworkUtil.GenericUnequip(target, leftHand, true, 0, 3)
		Utility.Wait(0.05)
	endIf
	if rightHand != none
		CreatureFrameworkUtil.GenericUnequip(target, rightHand, true, 1, 3)
	endIf
endFunction
