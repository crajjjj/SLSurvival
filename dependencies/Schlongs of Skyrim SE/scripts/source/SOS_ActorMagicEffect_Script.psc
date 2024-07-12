Scriptname SOS_ActorMagicEffect_Script extends activemagiceffect
{ The effects that ensures that nude people have their schlongs visible, and dressed ones don't, unless they wear something revealing }

;----------PROPERTIES----------

SOS_SetupQuest_Script Property SOS_Quest Auto
SOS_Config Property config Auto

Spell Property SOS_ActorSpell Auto
Spell Property SOS_SetupSpell  Auto
MagicEffect Property SOS_ErectionMagicEffect Auto
FormList Property SOS_RevealingArmors Auto
Keyword Property SOS_Underwear Auto
Keyword Property SOS_Genitals Auto
Keyword Property SOS_Revealing Auto
Keyword Property SOS_Concealing Auto
Keyword Property SOS_Potion Auto
Keyword Property SOS_Merchant Auto
Faction Property SOS_SchlongifiedFaction Auto
Faction Property SOS_DialogSetup Auto
Race Property WereWolfBeastRace Auto

;----------ACTOR PROPERTIES----------

Actor Property ActorRef Auto
Actor Property PlayerRef Auto
int iFlexFactor = 0
bool schlongedBeforeWW = false

;----------EVENTS----------

Auto State Active

	Event OnEffectStart(Actor akTarget, Actor akCaster)
		If ScriptIsBroken("OnEffectStart")
			Return
		EndIf
		
		RegisterForModEvent("ReSchlongify", "OnReSchlongify")
		
		ActorRef = akTarget
		
		Form addon = SOS_Quest.GetActiveAddon(ActorRef)
		If addon
			addon = ReSchlongify(addon)
		Else
			addon = Schlongify()
		EndIf
		
	EndEvent
	
	Event OnReSchlongify(string eventName, string strArg, float numArg, Form sender)
		If strArg == ""
			
			; main ReSchlongification process
			ReSchlongify()
			
		ElseIf strArg == "ScaleSchlongs"
		
			Form addon = SOS_Quest.GetActiveAddon(ActorRef)
			If addon
				int size = ActorRef.GetFactionRank(SOS_Data.GetFaction(addon))
				SOS_Quest.ScaleSchlongBones(addon, ActorRef, size)
			EndIf
		
		ElseIf strArg == "GoToSchlongless" && ActorRef && ActorRef.GetFormID() == numArg
			; character schlong has been removed through MCM
			GoToState("SchlongLess")
			
		;Else
		;	int handle = ModEvent.Create(strArg)
		;	if handle
		;		ModEvent.PushForm(handle, ActorRef)
		;		ModEvent.Send(handle)
		;	endIf
		EndIf
	EndEvent

	Event OnObjectUnequipped(Form akBaseObject, ObjectReference akReference)
		Armor unequipped = akBaseObject as Armor
		If !unequipped || ScriptIsBroken("OnObjectUnequipped")
			Return
		EndIf
		;Debug.trace("SOS - U: " + akBaseObject.GetName() + " (" + akBaseObject.GetFormId() + ")")

		Utility.Wait(0.05)
		Armor PelvisEquipped =  ActorRef.GetWornForm(0x00400000) as Armor
		
		If !PelvisEquipped
			; check if we need to equip the genitals
			
			Armor BodyEquipped = ActorRef.GetWornForm(0x00000004) as Armor
			; Equip genitals if actor is nude, or is wearing revealing armor and the item removed is a panty/underwear
			If (!BodyEquipped || (HasPelvisSlot(unequipped) && SOS_SKSE.IsRevealing(BodyEquipped)))
				EquipGenitals()
				
				; update needed if the camera is in TFC mode
				If Game.GetCameraState() == 3
					SOS_Quest.UpdateNinodes(ActorRef)
				EndIf
				
				; this fixes the permaunderwear bug during SL animations when SL's Auto TFC mode setting is on
				; where SOS equips the schlong and doesn't show up until the camera mode changes back
				Utility.wait(0.1)
			EndIf
		EndIf

	EndEvent

	Event OnObjectEquipped(Form akBaseObject, ObjectReference akReference)
		;Debug.trace("SOS - E: " + akBaseObject.GetName() + " (" + akBaseObject.GetFormId() + ")")
		Armor akArmor = akBaseObject as Armor
		
		If ActorRef.GetLeveledActorBase().GetRace() != WerewolfBeastRace ; prevents unequipping genitals when an outfit is autoequipped during WW transform
			If akArmor && HasBodySlot(akArmor)
				If !SOS_SKSE.IsRevealing(akArmor) && !IsConcealing(akArmor)
					MarkArmorAsConcealing(akArmor)
					; SOS_Quest.UpdateNiNodes(ActorRef) testing if needed
				EndIf

				If HasPelvisSlot(akArmor)
					; concealing armor, the slot 52 hides the schlong, remove it from inventory
					UnequipGenitals()
				ElseIf !ActorRef.GetWornForm(akArmor.kSlotMask52) as Armor
					; revealing armor, equip schlong if not already equipped
					EquipGenitals()
				EndIf
			EndIf
		EndIf

	EndEvent
	
	Event OnRaceSwitchComplete()
		;Debug.trace("SOS Actor ME Active - OnRaceSwitchComplete")
		
		Form addon = SOS_Quest.GetActiveAddon(ActorRef)
		
		If ActorRef.GetLeveledActorBase().GetRace() != WerewolfBeastRace
			ScaleSchlongToCurrentSize(addon)
		Else
		
			schlongedBeforeWW = true

			; check MCM for schlong availability
			Float raceProbability = SOS_Quest.GetRaceProbability(addon, WerewolfBeastRace)
			If raceProbability <= 0.0
				GoToState("SchlongLess")
				If ActorRef.WornHasKeyword(SOS_Genitals)
					Debug.trace("SOS OnRaceSwitchComplete: No schlong for Werewolf. Werewolf race is disabled in MCM for the equipped schlong")
					UnequipGenitals()
				EndIf
			Else
				If !ActorRef.WornHasKeyword(SOS_Genitals)
					Debug.trace("SOS OnRaceSwitchComplete: equipping schlong after Werewolf transition")
					EquipGenitals(addon)
				EndIf
				ScaleSchlongToCurrentSize(addon, 1.5) ; + 50% bigger to compensate WW body
			EndIf
		EndIf
		
	EndEvent

EndState



State SchlongLess
	
	Event OnBeginState()
		;Debug.Trace("SOS SchlongLess: " + ActorRef.GetLeveledActorBase().GetName() + " entered schlongless state")
	EndEvent
	
	Event OnRaceSwitchComplete()
		
		; reequip schlong if reverting from WW
		If schlongedBeforeWW && ActorRef.GetLeveledActorBase().GetRace() != WerewolfBeastRace
			Debug.trace("SOS Werewolf: reequipping schlong after beast form")
			schlongedBeforeWW = false
			Form addon = SOS_Quest.GetActiveAddon(ActorRef)
			ScaleSchlongToCurrentSize(addon)
			EquipGenitals(addon, false)
			GoToState("Active")
		EndIf
		
	EndEvent
	
	Event OnObjectUnequipped(Form akBaseObject, ObjectReference akReference)
	EndEvent

EndState

; event handling for any state

Event OnReSchlongify(string eventName, string strArg, float numArg, Form sender)
	; force active state on previously SchlongLess actors
	If strArg == "GoToActive" && ActorRef && ActorRef.GetFormID() == numArg
		GoToState("Active")
	;ElseIf strArg && strArg != "ScaleSchlongs" && strArg != "GoToSchlongless"
	;	int handle = ModEvent.Create(strArg)
	;	if handle
	;		ModEvent.PushForm(handle, ActorRef)
	;		ModEvent.Send(handle)
	;	endIf
	EndIf
EndEvent

Event OnItemAdded(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
	{Check for SOS Potions that an NPC gets in its inventory, and use them}
	If ScriptIsBroken("OnItemAdded")
		Return
	EndIf
	
	Potion addedPotion = akBaseItem as Potion
	If addedPotion && ActorRef != PlayerRef ; Only NPCs should automatically use potions
		If addedPotion.HasKeyword(SOS_Potion) ;Is it a Normal Potion? Only Schlongified NPCs can use it then
			If SOS_Quest.GetActiveAddon(ActorRef)
				Debug.Trace("SOS OnItemAdded: NPC " + ActorRef.GetLeveledActorBase().GetName() + " got a normal potion " + akBaseItem.GetName() + " and should use it")
				ActorRef.EquipItem(akBaseItem)
			EndIf
		EndIf
	EndIf
EndEvent

Function MarkArmorAsConcealing(Armor akArmor)
	Debug.Trace("SOS MarkArmorAsConcealing: registering armor as concealing " + akArmor.GetName())
	akArmor.AddSlotToMask(akArmor.kSlotMask52)
	SOS_Data.AddConcealingArmor(akArmor)
EndFunction

Bool Function IsConcealing(Armor akArmor)
	; armor has both slots 32 and 52, or is flagged as concealing
	int concealingMask = akArmor.kSlotMask32 + akArmor.kSlotMask52
	Return Math.LogicalAnd(akArmor.GetSlotMask(), concealingMask) == concealingMask \
		|| SOS_Data.FindConcealingArmor(akArmor) != -1
EndFunction

Function EquipGenitals(Form addon = None, Bool checkErection = true)
	If !addon
		addon = SOS_Quest.GetActiveAddon(ActorRef)
		If !addon
			; most likely this is caused by and OnObjectEquipped or OnObjectUnequipped
			; before the scripts are finished assigning a schlong
			Return
		EndIf
	EndIf
	
	Armor genitals = SOS_Data.GetGenitalArmor(addon)
	
	;If ActorRef.GetWornForm(0x00400000)
		; make sure there is nothing on the slot 52 item
		; this could happen if swapping a body armor (32+52) via scripting
		; 1. unequipping the armor triggers sos to put the schlong
		; 2. then a second armor is equipped before the schlong has been equipped
		; 3. finally sos equips the schlong, which unequips the body armor
		;Return
	;EndIf
	ActorRef.EquipItem(genitals, false, true)
	If checkErection && ActorRef.HasMagicEffect(SOS_ErectionMagicEffect)
		Debug.SendAnimationEvent(ActorRef, "SOSFastErect")
	EndIf
EndFunction

Function UnequipGenitals()
	Form addon = SOS_Quest.GetActiveAddon(ActorRef)
	Armor genitals = SOS_Data.GetGenitalArmor(addon)
	;Debug.trace("SOS Unequip Genitals from " + ActorRef.GetLeveledActorBase().GetName())
	If genitals
		ActorRef.RemoveItem(genitals, 999, true)
	EndIf
EndFunction

Function ScaleSchlongToCurrentSize(Form addon, float factor = 1.0)
	int size = ActorRef.GetFactionRank(SOS_Data.GetFaction(addon)) as int
	size = Math.Floor(size * factor)
	If size > 40
		size = 40
	EndIf
	SOS_Quest.ScaleSchlongBones(addon, ActorRef, size)
EndFunction

Bool Function ScriptIsBroken(String func)

	Bool isBroken = !SOS_Quest || SOS_SchlongifiedFaction as String == "[Faction <None>]"

	If isBroken
		; Probably this script is a remainder of a previous SOS installation, baked in the savegame.
		; It points to None references, dispel
		Debug.Trace("SOS " + func + ": leftover script on " + ActorRef)
		Dispel()
	EndIf

	Return isBroken
EndFunction

Form Function Schlongify()

	; the actor has no schlong yet, so we select one for him/her if available
	Form addon = SOS_Quest.DetermineSchlongType(ActorRef)
	If !addon
		GoToState("SchlongLess")
		Return None
	EndIf
	
	int size = SOS_Quest.DetermineSchlongSize(addon, ActorRef)
	SOS_Quest.SetSchlongSize(addon, ActorRef, size)
	SOS_Quest.RegisterNewSchlongifiedActor(ActorRef, addon)
	Debug.Trace("SOS Actor Schlongify: new schlong for " + ActorRef.GetLeveledActorBase().GetName() + " got schlong index " + SOS_Data.FindAddon(addon) + " size " + size)
	
	CheckArmor(addon)
	
	int handle = ModEvent.Create("Schlongify")
	if handle
		ModEvent.PushForm(handle, ActorRef)
		ModEvent.PushForm(handle, addon)
		ModEvent.Send(handle)
	endIf
	
	Return addon
	
EndFunction

Form Function ReSchlongify(Form addon = None)
	{Fixes bones scales}
	If ActorRef as String == "[Actor <None>]"
		Return None
	ElseIf !ActorRef.Is3DLoaded()
		; when loading an autosave after zone change, actors may have not been fully loaded
		Utility.wait(1)
		If !ActorRef.Is3DLoaded()
			; actor is not in player's location, no need to fix
			Return None
		EndIf
	EndIf
	
	If !addon
		addon = SOS_Quest.GetActiveAddon(ActorRef)
	EndIf
	
	If addon
		int size = ActorRef.GetFactionRank(SOS_Data.GetFaction(addon))
		ActorRef.SetFactionRank(SOS_SchlongifiedFaction, size) ; sinchronize factions
		SOS_Quest.ScaleSchlongBones(addon, ActorRef, size) ; scales
		;Debug.Trace("SOS ReSchlongify: fixing " + SOS_Data.GetFaction(addon).GetName() + "[" + size +"] for actor " + ActorRef.GetLeveledActorBase().getName())
		CheckArmor(addon)
	ElseIf SOS_Data.FindBlacklisted(actorRef) == -1
		Debug.Trace("SOS ReSchlongify: " + ActorRef.GetLeveledActorBase().getName() + " somehow lost his schlong!?!")
		addon = Schlongify()
	Endif
	
	Return addon
	
EndFunction

Function CheckArmor(Form addon)
	If !addon
		Return
	EndIf
	
	Armor bodyArmor = ActorRef.GetWornForm(0x00000004) as Armor
	Bool isRevealingArmor = SOS_SKSE.IsRevealing(bodyArmor)
	
	If bodyArmor && !isRevealingArmor && !IsConcealing(bodyArmor)
		; a custom armor has been equipped for the 1st time
		MarkArmorAsConcealing(bodyArmor)
		
		; Now that the armor has the slot 52, update actor
		; this hides the underwear AA from the SkinNaked
		SOS_Quest.UpdateNiNodes(ActorRef)
		
	ElseIf !bodyArmor || isRevealingArmor
		; Nude or revealing armor. Equip genitals if the pelvis slot is free
		Armor pelvisArmor = ActorRef.GetWornForm(0x00400000) as Armor
		If !pelvisArmor
			EquipGenitals(addon, false)
		ElseIf bodyArmor && SOS_Data.FindRevealingArmor(bodyArmor) != -1
			; armor has been set up as revealing, make the schlong poke out
			SOS_Quest.UpdateNiNodes(ActorRef)
		EndIf
		
	EndIf
EndFunction

Bool Function HasBodySlot(Armor akArmor)
	Return Math.LogicalAnd(akArmor.GetSlotMask(), akArmor.kSlotMask32)
EndFunction

Bool Function HasPelvisSlot(Armor akArmor)
	Return Math.LogicalAnd(akArmor.GetSlotMask(), akArmor.kSlotMask52)
EndFunction

; =========== DEPRECATED =======================================================================

FormList Property SOS_ConcealingArmors Auto
Keyword Property SOS_ShapePotion Auto
Message Property SOS_ShapePotionCustomRace Auto
FormList Property SOS_EnabledRaces Auto
FormList Property SOS_Factions Auto
FormList Property SOS_GenitalArmors Auto
FormList Property SOS_Bones Auto
FormList Property SOS_ShapePotions Auto
