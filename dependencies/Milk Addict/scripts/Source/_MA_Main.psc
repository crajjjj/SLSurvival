Scriptname _MA_Main extends ReferenceAlias

Float MainVersion

Float SleepStartTime
Float SpeedMag
Float StaminaMag
int Duration
Int AddictionAmount
Int HealAmount
Int TotalHealAmount = 0

Int AddictionCap = 600
Int OldAddictionStage = 0
Int AddictionStage = 0
Int EffectsStage = 0
Int OldEffectsStage = 0
Int NewAddictionPool
Int OldAddictionPool

Bool EquipInProgress = false
Bool ProcessingQueue = false
Bool RecentReading = false
Bool PlayerIsMaid = false

Float Property AssRip Auto Hidden
Float Property BellyRip Auto Hidden
Float Property TearChance Auto Hidden
Float Property BreastRopeFreq = 15.0 Auto Hidden
Float Property AutoActionChance = 0.0 Auto Hidden
Float ActualLactacid = 0.0
Form[] MilkQueue
Form[] BacklogQueue
Int MilkQueueCount = 0
Int BacklogCount = 0

Form Property EquipToIgnore = None Auto Hidden

ObjectReference CurrentlyEquippedArmor

Int Property CurrentClothesDurabilty Auto Hidden
Int Property CurrentSlutiness Auto Hidden
Float Property SlutinessFactor Auto Hidden
Bool ClothesEquipped = false
Bool MightTear = false

; EVENTS ==============================================================================

Event OnInit()
	MainVersion = 0.53
	MilkQueue = new Form[128]
	BacklogQueue = new Form[128]	
	
	InitFoodstuffs()

	RegisterForModEvent("MME_MilkCycleComplete", "OnMME_MilkCycleComplete")
	RegisterForModEvent("HookAnimationEnd", "OnAnimationEnd")
	RegisterForModEvent("SexLabOrgasmSeparate", "OnSexLabOrgasmSeparate")
	RegisterForModEvent("HookOrgasmStart", "OnOrgasmStart")
	RegisterForModEvent("DeviceVibrateEffectStart", "OnDeviceVibrateEffectStart")
	RegisterForModEvent("_MWA_CuirassEquipEvent", "On_MWA_CuirassEquipEvent")
	RegisterForModEvent("_MWA_DestructionEvent", "On__MWA_DestructionEvent")
	RegisterForMenu("Sleep/Wait Menu")
	AddInventoryEventFilter(_MA_ElixirPlaceholders)
	PlayerRef.AddSpell(Game.GetFormFromFile(0x000192AE, "Milk Addict.esp") as Spell, false)
	PlayerRef.AddPerk(Game.GetFormFromFile(0x020EE1, "Milk Addict.esp") as Perk)
	Debug.Notification("Milk addict started")
EndEvent

Event OnPlayerLoadGame()
	RegisterForModEvent("MME_MilkCycleComplete", "OnMME_MilkCycleComplete")
	RegisterForModEvent("HookAnimationEnd", "OnAnimationEnd")
	RegisterForModEvent("SexLabOrgasmSeparate", "OnSexLabOrgasmSeparate")
	RegisterForModEvent("HookOrgasmStart", "OnOrgasmStart")
	RegisterForModEvent("DeviceVibrateEffectStart", "OnDeviceVibrateEffectStart")
	RegisterForModEvent("_MWA_CuirassEquipEvent", "On_MWA_CuirassEquipEvent")
	RegisterForModEvent("_MWA_DestructionEvent", "On__MWA_DestructionEvent")
	RegisterForMenu("Sleep/Wait Menu")
	
	InitFoodstuffs()	
	Init.PlayerReloadsGame()
	
	DoUpgradeStuff()
endEvent

Function DoUpgradeStuff()
	If MainVersion < 0.53
		; Update stuff
		If MainVersion < 0.46
			RegisterForMenu("Sleep/Wait Menu")
			MainVersion = 0.46
		EndIf
		If MainVersion < 0.48
			_MA_ClothesDurability.Stop()
			_MA_ClothesDurability.Start()
			Armor CurrentArmor = PlayerRef.GetWornForm(0x00000004) as Armor
			If !CurrentArmor.HasKeyword(SexlabNoStrip)
				PlayerRef.UnequipItem(CurrentArmor)
				;PlayerRef.EquipItem(CurrentArmor, false, true)
				PlayerRef.EquipItemEx(CurrentArmor, 0, preventUnequip = false, equipSound = false)
			EndIf
			MainVersion = 0.48
		EndIf
		If MainVersion < 0.50
			PlayerRef.AddPerk(Game.GetFormFromFile(0x020EE1, "Milk Addict.esp") as Perk)
			PlayerRef.AddPerk(_MA_ContainerPerk)
			PlayerRef.AddPerk(_MA_DeadActorPerk)
			MainVersion = 0.50
		EndIf
		If MainVersion < 0.51
			Init._MA_NpcMilkAddList.Revert()
			MainVersion = 0.51
		EndIf
		If MainVersion < 0.52
			MainVersion = 0.52
			Menu.ClearSluttiness()
			Debug.Messagebox("Milk Addict updated to " + MainVersion + "\nThe update required resetting your outfit slutiness settings. Sorry. ")
		EndIf
		If MainVersion < 0.53
			MainVersion = 0.53
			RemoveAllWithdrawalEffects()
			Utility.Wait(1.0)
			SetAddictionEffects()
			Debug.Notification("Milk Addict updated to: " + MainVersion)
		EndIf
	EndIf
EndFunction

Event On_MWA_CuirassEquipEvent(Form akBaseObject, Form ObjRefAsForm)
	;Debug.Messagebox("akBaseObject: " + akBaseObject + ". ObjRef: " + ObjRefAsForm)
	ObjectReference ObjRef = ObjRefAsForm as ObjectReference
	If ObjRef
		CurrentlyEquippedArmor = ObjRef
		ProcessArmor(akBaseObject, ObjRef)
	EndIf
EndEvent

Event On__MWA_DestructionEvent(Form Sender, Form akBaseObject, Form ObjRef)
	If Sender == Self.GetOwningQuest()
		DoMortifiedEffect()
	EndIf
EndEvent

State InMilkPump
	Event OnMagicEffectApply(ObjectReference akCaster, MagicEffect akEffect)
		If akEffect == MME_FeedingStagePassiveEff
			StorageUtil.AdjustFloatValue(PlayerRef, "MME.MilkMaid.LactacidCount", ((Menu.LactacidLactacid *1.5)- 1.0))
			_MA_LactacidAddictionPool.SetValueInt(_MA_LactacidAddictionPool.GetValueInt() + Math.Ceiling(Menu.AddictivenessLactacid * 0.7))
		EndIf
	EndEvent
	
	Event OnEndState() ; Leaving Milking machine - Update stuff
		ActualLactacid = StorageUtil.GetFloatValue(PlayerRef, "MME.MilkMaid.LactacidCount")
		GetAddictionStage()
		GetAddictionEffects()
		SetAddictionEffects()
		UpdateRipChance()
	EndEvent
EndState

Event OnMagicEffectApply(ObjectReference akCaster, MagicEffect akEffect) ; Empty state - Too many magic effects applied to the player
	
EndEvent

Event OnAnimationEvent(ObjectReference akSource, string asEventName)

	If (akSource == PlayerRef)
		If(asEventName == "arrowAttach")
			TryRip(Menu.TearMultBow)
		ElseIf (asEventName == "weaponSwing") || asEventName == "weaponLeftSwing" ; Covers left & right And power attack. Power attack detected by spell conditions
			_MA_AttackRipSpell.Cast(PlayerRef, PlayerRef)
		ElseIf (asEventName == "JumpUp")
			TryRip(Menu.TearMultJump)
		ElseIf (asEventName == "tailSprint")
			TryRip(Menu.TearMultSprint)
		ElseIf (asEventName == "BeginCastRight")
			TryRip(Menu.TearMultMagic)
		ElseIf (asEventName == "BeginCastLeft")
			TryRip(Menu.TearMultMagic)
		ElseIf (asEventName == "BeginCastVoice")
			TryRip(Menu.TearMultShout)
		; Sneaking not implemented yet. Complicated
		;/
		ElseIf (asEventName == "tailSneakIdle")
			Debug.messagebox("sneak standing")
		ElseIf (asEventName == "tailSneakLocomotion")
			Debug.messagebox("sneak moving")
		/;
		EndIf
	EndIf
	
EndEvent

Event OnUpdateGameTime()
	Int NewPool = _MA_LactacidAddictionPool.GetValueInt() - Menu.AddictionDecay
	If NewPool < 0
		NewPool = 0
	ElseIf NewPool > AddictionCap
		NewPool = AddictionCap
	EndIf
	_MA_LactacidAddictionPool.SetValueInt(NewPool)
	RegisterForSingleUpdateGameTime(1.0)
EndEvent

Event OnMenuOpen(String MenuName)
	SleepStartTime = Utility.GetCurrentGameTime()
EndEvent

Event OnMenuClose(String MenuName)
	_MA_LactacidAddictionPool.SetValueInt(Math.Floor(_MA_LactacidAddictionPool.GetValueInt() - (((Utility.GetCurrentGameTime() - SleepStartTime) * 24 * Menu.AddictionDecay) - 1)))
EndEvent

Event OnObjectUnequipped(Form akBaseObject, ObjectReference akReference)
	If akBaseObject as Armor && !akBaseObject.HasKeyword(SexlabNoStrip)
		If Math.LogicalAnd((akBaseObject as Armor).GetSlotMask(), 4) == 4 ; Body Armor
			Utility.Wait(0.5) ; Wait for weird happenings with the DD device hider (more than expected UnEquip events triggered)
			If Menu.SlutFactor
				Int index = JsonUtil.FormListFind("Milk Addict/SlutClothes.json", "ClothesList", PlayerRef.GetWornForm(0x00000004))
				If index >= 0
					CurrentSlutiness = JsonUtil.IntListGet("Milk Addict/SlutClothes.json", "Sluttiness", index)
				Else
					CurrentSlutiness = -1
				EndIf
			EndIf
		EndIf
	EndIf
EndEvent

Event OnObjectEquipped(Form akBaseObject, ObjectReference akReference)

	; Armor
	If akBaseObject as Armor && !Init.IsMwaInstalled
		If Math.LogicalAnd((akBaseObject as Armor).GetSlotMask(), 4) == 4 && akBaseObject != _MA_TornClothes
			;Debug.messagebox(WornObject.GetEnchantment(PlayerRef, 0, 4))
			If akBaseObject != EquipToIgnore
				ObjectReference ArmorObjRef
				If akReference == None && !akBaseObject.HasKeyword(SexlabNoStrip) ; Get a reference
					ArmorObjRef = PlayerRef.DropObject(akBaseObject, 1)
					PlayerRef.AddItem(ArmorObjRef, 1, abSilent = true)
					EquipToIgnore = akBaseObject
					;PlayerRef.EquipItem(akBaseObject, abPreventRemoval = false, abSilent = true)
					PlayerRef.EquipItemEx(akBaseObject, 0, preventUnequip = false, equipSound = false)
				Else 
					ArmorObjRef = akReference
				EndIf
				Debug.Trace("_MA_: Equip - akReference: " + ArmorObjRef)
				CurrentlyEquippedArmor = ArmorObjRef
				ProcessArmor(akBaseObject, ArmorObjRef)
			Else
				EquipToIgnore = None
			EndIf
		EndIf
	
	; Milk / Lactacid
	ElseIf akBaseObject.HasKeyword(MME_Milk) || akBaseObject == MME_Lactacid
		If !RecentReading
			ActualLactacid = MME_Storage.getLactacidCurrent(PlayerRef)
			RecentReading = true
		;Else
		;	ActualLactacid = ActualLactacid ; er yea, for my feeble mind
		EndIf

		If MilkQ.MILKmaid.find(PlayerRef) > -1 ; Player is milkmaid
			PlayerIsMaid = true
		else
			PlayerIsMaid = false
		EndIf
		
		EquipInProgress = true
		If ProcessingQueue
			BacklogQueue[BacklogCount] = akBaseObject
			BacklogCount += 1
		Else
			;EquipInProgress = true
			MilkQueue[MilkQueueCount] = akBaseObject
			MilkQueueCount += 1
		Endif

		while EquipInProgress
			EquipInProgress = false
			If Utility.IsInMenuMode()
				Utility.WaitMenuMode(0.5)
			Else
				Utility.Wait(0.5)
			EndIf
		endwhile
		
		If !ProcessingQueue
			;debug.trace("_MA_: Doing Queue =====================================")
			ProcessingQueue = true
			ProcessMilkQueue()
			MilkQueueCount = 0
			
			If BacklogCount > 0
				;debug.trace("_MA_: Doing Backlog ==================================")
				; Copy Array 
				int i = 0
				while i < BacklogCount
					MilkQueue[i] = BacklogQueue[i]
					i+=1
				endwhile
				MilkQueueCount = BacklogCount
				BacklogCount = 0
				ProcessMilkQueue()
			EndIf
			ProcessingQueue = false
			if akBaseObject != MME_Lactacid
				_MA_MilkSpeed.Cast(PlayerRef, PlayerRef)
				_MA_MilkStamina.Cast(PlayerRef, PlayerRef)
			EndIf
			If Init.AproposInstalled
				Init.AproposHeal(TotalHealAmount)
			EndIf
			If Init.AproposTwoInstalled
				Init.AproposTwoHeal(TotalHealAmount)
			EndIf
		EndIf

	; Food Setup
	ElseIf SetupFood || RemoveFood
		ProcessFood(akBaseObject)
			
	; Lactacid Foods
	ElseIf akBaseObject as Potion
		If _MA_LactacidFoods.HasForm(akBaseObject)
			Int i = _MA_LactacidFoods.Find(akBaseObject)
			Float CurrentLact = MME_Storage.getLactacidCurrent(PlayerRef)
			Float FoodLactacid = JsonUtil.FloatListGet("Milk Addict/Food.json", "FoodLactacid", i)
			Int FoodAddictiveness = JsonUtil.IntListGet("Milk Addict/Food.json", "FoodAddictiveness", i)
			
			_MA_LactacidAddictionPool.SetValueInt(_MA_LactacidAddictionPool.GetValueInt() + FoodAddictiveness)
			MME_Storage.setLactacidCurrent(PlayerRef, CurrentLact + FoodLactacid)
			ActualLactacid = MME_Storage.getLactacidCurrent(PlayerRef)
			GetAddictionStage()
			GetAddictionEffects()
			SetAddictionEffects()
			
		EndIf
	EndIf
EndEvent

Event OnItemAdded(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
	If UI.IsMenuOpen("Crafting Menu")
		Int Alchemy = PlayerRef.GetActorValue("Alchemy") as Int
		Int RanInt = Utility.RandomInt(1, 70)
		Int DifficultyOffset
		Int IngredientOffset
		If Menu.CraftingDifficulty == 0 ; Easy
			DifficultyOffset = 40
		ElseIf Menu.CraftingDifficulty == 1 ; Normal
			DifficultyOffset = 30
		ElseIf Menu.CraftingDifficulty == 2 ; Hard
			DifficultyOffset = 25
		Endif
		
		Int PlayerScore
		If akBaseItem == _MA_ElixirMinorPlaceholder ; Minor
			PlayerRef.RemoveItem(_MA_ElixirMinorPlaceholder, 1, true)
			IngredientOffset = 30
		ElseIf akBaseItem == _MA_ElixirModerateplaceholder ; Moderate
			PlayerRef.RemoveItem(_MA_ElixirModerateplaceholder, 1, true)
			IngredientOffset = 130
		Else
			PlayerRef.RemoveItem(_MA_ElixirStrongPlaceholder, 1, true)
			IngredientOffset = 230
		Endif
		
		PlayerScore = DifficultyOffset + IngredientOffset + Alchemy + RanInt
		;debug.notification("PlayerScore: " + PlayerScore +". Difficulty: " + DifficultyOffset + ". Ingred: " + IngredientOffset + ". Alchemy: " + Alchemy + ". RanInt: " + RanInt)

		If PlayerScore <= 100
			PlayerRef.AddItem(_MA_ElixirUseless, 1, false)
		ElseIf PlayerScore > 100 && PlayerScore <= 200
			PlayerRef.AddItem(_MA_ElixirMinor, 1, false)
		ElseIf PlayerScore > 200 && PlayerScore <= 300
			PlayerRef.AddItem(_MA_ElixirModerate, 1, false)
		ElseIf	PlayerScore > 300
			PlayerRef.AddItem(_MA_ElixirStrong, 1, false)
		EndIf
		
	EndIf
endEvent

Event OnItemRemoved(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)

EndEvent

Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)
	If !Init.IsMwaInstalled && Menu.HitRipChance > 0.0 && akSource as Weapon && !abHitBlocked
		WeaponRip(abPowerAttack)
		Debug.Trace("_MA_: Attack akAggressor: " + akAggressor + " - " + ". Source: " + akSource)
	EndIf
EndEvent

; CUSTOM EVENTS =======================================================

Event OnMME_MilkCycleComplete(string eventName, string strArg, float numArg, Form sender)
	If PlayerIsMaid
		CumReducesLactDecay()
		ActualLactacid = MME_Storage.getLactacidCurrent(PlayerRef)
		If Menu.LactacidCeilingT && ActualLactacid > Menu.LactacidCeiling
			Float Excess = ActualLactacid - Menu.LactacidCeiling
			StorageUtil.SetFloatValue(PlayerRef, "MME.MilkMaid.LactacidCount", ActualLactacid - (Excess * 0.4))
		EndIf
		RefreshCleavageEffect()
		GetAddictionStage()
		GetAddictionEffects()
		SetAddictionEffects()
		UpdateRipChance()
		TryRip(1.0)
		;/ 
		MME time between updates: MilkQ.MilkPoll
		
		Seconds in an hour = 3600
		Timescale 20 -> 1 sec = 20 game seconds
		3600 / Timescale = # seconds per skyrim hour
		Default skyrim => 180 seconds = 1 game hour
		/;
		Float SecondsPerGameHour = (3600 / TimeScale.GetValueInt())
		Float TotalTime = SecondsPerGameHour * MilkQ.MilkPoll ; Total time in seconds available to drain milk until the next MME update
		Float TotalMilk = StorageUtil.GetFloatValue(PlayerRef, "MME.MilkMaid.MilkCount") + 0.01 ; +0.01 - avoid dividing by 0
		BreastRopeFreq = (TotalTime / TotalMilk) - Menu.BreastRopeFreqOffset
		If BreastRopeFreq < 5.0
			BreastRopeFreq = 5.0
		EndIf
		Debug.Trace("_MA_: BreastRopeFreq: " + BreastRopeFreq)
		
		TryBoobLeakSound()
		
		Utility.Wait(2.0)
		If AutoActionChance > Utility.RandomFloat(0.0, 100.0)
			TryAutoActionMilkEquip()
		EndIf
	EndIf
EndEvent

Event OnAnimationEnd(int tid, bool HasPlayer)
	If HasPlayer
		If Init.TripMountEvent
			_MA_TripMountSpectatorsQuest.Stop()
			Init.TripMountEvent = false
			_MA_MountEventCooldownSpell.SetNthEffectDuration(0, Menu.MountCooldownTime)
			_MA_MountEventCooldownSpell.Cast(PlayerRef, PlayerRef)
		EndIf
		If Sexlab.IsVictim(tid, PlayerRef)
			sslBaseAnimation Anim = sexlab.HookAnimation(tid)
			If !Anim.IsCreature
				If Menu.RapeLactacidChance > Utility.RandomFloat(0.0, 100.0)
					If _MA_LactacidAddictionPool.GetValueInt() < 500
						PlayerRef.AddItem(MME_Lactacid, aiCount = 1, abSilent = true)
						PlayerRef.EquipItem(MME_Lactacid, abSilent = true)
						Debug.Notification("You're forced to drink something")
					Else
						Actor[] actorList = SexLab.HookActors(tid as string)
						Int i = 0 
						Actor SexPartner
						While i < actorList.Length && SexPartner == None
							If ActorList[i] != PlayerRef
								SexPartner = ActorList[i]
							EndIf
							i += 1
						EndWhile
						Debug.Notification(SexPartner.GetActorBase().GetName() + ": You look fucked up enough. No fix for you honey")
					EndIf
				EndIf
			EndIf
		EndIf
	EndIf
EndEvent

Event OnDeviceVibrateEffectStart(string eventName, string strArg, float numArg, Form sender)
	If strArg == PlayerRef.GetLeveledActorBase().GetName()
		TryBoobLeakSound()
	EndIf
EndEvent

Event OnSexLabOrgasmSeparate(Form ActorRef, Int tid)
	If (ActorRef as Actor) == PlayerRef
		TryBoobLeakSound()
	EndIf
EndEvent

Event OnOrgasmStart(int tid, bool HasPlayer);(string eventName, string argString, float argNum, form sender)
	If HasPlayer
		TryBoobLeakSound()
	EndIf
EndEvent

; FUNCTIONS =============================================================

float function calculateMilkLimit()
	Float Level = StorageUtil.GetFloatValue(PlayerRef, "MME.MilkMaid.Level")
	int   BreastRows      = 1
	float BreastsPerRow   = 2
	float MilkBasevalue   = StorageUtil.GetFloatValue(PlayerRef, "MME.MilkMaid.MilkMax.Basevalue", missing = 2)
	float MilkScalefactor = StorageUtil.GetFloatValue(PlayerRef, "MME.MilkMaid.MilkMax.Scalefactor", missing = 1)

	return (MilkBasevalue + Level*MilkScalefactor)*BreastRows*BreastsPerRow
endfunction

Function ProcessMilkQueue()
	; Copy milk array
	Form[] TempQueue = new Form[128]
	int Count = MilkQueueCount
	int i = Count
	;Debug.Trace("_MA_: Count: " + Count)
	While i > 0
		i-=1
		TempQueue[i] = MilkQueue[i]
		;Debug.Trace("_MA_: TempQueue " + i + ": " + MilkQueue[i])
	EndWhile

	;Process temp queue
	;Debug.Trace("_MA_: GetLactacidCurrent = " + ActualLactacid)
	TotalHealAmount = 0
	While i < Count
	;Debug.trace("_MA_: i: " + i + ". Count: " + Count)
		;Debug.Trace("_MA_: Processing " + i + " - " + TempQueue[i])
		;Debug.trace("_MA_: PlayerIsMaid = " + PlayerIsMaid)
		If PlayerIsMaid
			ActualLactacid += GetValues(TempQueue[i])
		ElseIf TempQueue[i] == MME_Lactacid || _MA_Milk_Tasty.HasForm(TempQueue[i]) || _MA_Milk_Creamy.HasForm(TempQueue[i]) || _MA_Milk_Enriched.HasForm(TempQueue[i]) || _MA_Milk_Sublime.HasForm(TempQueue[i])
			While MME_Storage.getLactacidCurrent(PlayerRef) == ActualLactacid ; Wait for MME to add lactacid
				Utility.Wait(0.5)
			EndWhile
			ActualLactacid += GetValues(TempQueue[i])
			PlayerIsMaid = true
		Else
			GetValues(TempQueue[i])
		EndIf
		
		;Debug.Trace("_MA_: ActualLactacid = " + ActualLactacid)
		TotalHealAmount += HealAmount
		GetAddictionStage()
		GetAddictionEffects()
		SetAddictionEffects()
		SetSpeedStaminaBuff(TempQueue[i])
		
		i+=1
	EndWhile
	If PlayerIsMaid
		MME_Storage.setLactacidCurrent(PlayerRef, ActualLactacid)
	EndIf
	RecentReading = false
	If !Init.AproposInstalled && !Init.AproposTwoInstalled
		If !PlayerRef.HasMagicEffect(_MA_MoanCooldownMgef)
			_MA_MoanCooldownSpell.Cast(PlayerRef, PlayerRef)
			sslBaseVoice voice = SexLab.PickVoice(PlayerRef)
			voice.Moan(PlayerRef, 10, False)
		EndIf
	EndIf
EndFunction

Function SetSpeedStaminaBuff(Form akBaseObject)
		_MA_MilkSpeed.SetNthEffectMagnitude(0, SpeedMag)
		_MA_MilkSpeed.SetNthEffectDuration(0, Duration)
		_MA_MilkStamina.SetNthEffectMagnitude(0, StaminaMag)
		_MA_MilkStamina.SetNthEffectDuration(0, Duration)
		_MA_MilkSpeed.SetName(akBaseObject.GetName())
		_MA_MilkStamina.SetName(akBaseObject.GetName())
EndFunction

Function GetAddictionStage()
	OldAddictionStage = AddictionStage
	
	OldAddictionPool = _MA_LactacidAddictionPool.GetValueInt()
	NewAddictionPool = OldAddictionPool + AddictionAmount
	AddictionAmount = 0 ; Dump the amount once it has been added to the pool
	_MA_LactacidAddictionPool.SetValueInt(NewAddictionPool)

	If NewAddictionPool < 99 ; Unaffected addiction level
		AddictionStage = 0
	ElseIf NewAddictionPool > 99 && NewAddictionPool < 199 ; Mild addiction level
		AddictionStage = 1
	ElseIf NewAddictionPool > 199 && NewAddictionPool < 299 ; Moderate addiction level
		AddictionStage = 2
	ElseIf NewAddictionPool > 299 && NewAddictionPool < 399 ; Addict addiction level
		AddictionStage = 3
	ElseIf NewAddictionPool > 399 ; Junkie addiction level
		AddictionStage = 4
	EndIf
	If AddictionStage > OldAddictionStage
		Debug.Notification("You have become more addicted to lactacid")
		UpdateAddictionStage()
	ElseIf AddictionStage < OldAddictionStage
		Debug.Notification("You have become less addicted to lactacid")
		UpdateAddictionStage()
	EndIf
EndFunction

Function UpdateAddictionStage()
	If AddictionStage == 0
		_MA_Addicted_0.SetNthEffectMagnitude(0, 0)
		PlayerRef.AddSpell(_MA_Addicted_0, false)
	ElseIf AddictionStage == 1
		_MA_Addicted_1.SetNthEffectMagnitude(0, Menu.RequiredLactMild)
		PlayerRef.AddSpell(_MA_Addicted_1, false)
	ElseIf AddictionStage == 2
		_MA_Addicted_2.SetNthEffectMagnitude(0, Menu.RequiredLactModerate)
		PlayerRef.AddSpell(_MA_Addicted_2, false)
	ElseIf AddictionStage == 3
		_MA_Addicted_3.SetNthEffectMagnitude(0, Menu.RequiredLactAddict)
		PlayerRef.AddSpell(_MA_Addicted_3, false)
	ElseIf AddictionStage == 4
		_MA_Addicted_4.SetNthEffectMagnitude(0, Menu.RequiredLactJunkie)
		PlayerRef.AddSpell(_MA_Addicted_4, false)
	EndIf
EndFunction

Function GetAddictionEffects()
	OldEffectsStage = EffectsStage
	
	If AddictionStage == 0 ; Stage 0 =======================================
		EffectsStage = 0
		
	ElseIf AddictionStage == 1 ; Stage 1 ===================================
		If ActualLactacid >= Menu.RequiredLactMild ; Unaffected
			EffectsStage = 0
		Else ; Mild
			EffectsStage = 1
		EndIf
		
	ElseIf AddictionStage == 2 ; Stage 2 ===================================
		If ActualLactacid >= Menu.RequiredLactModerate ; Unaffected
			EffectsStage = 0
		ElseIf ActualLactacid >= Menu.RequiredLactMild ; Mild
			EffectsStage = 1
		Else ; Moderate
			EffectsStage = 2
		EndIf
	
	ElseIf AddictionStage == 3 ; Stage 3 ===================================
		If ActualLactacid >= Menu.RequiredLactAddict ; Unaffected
			EffectsStage = 0
		ElseIf ActualLactacid >= Menu.RequiredLactModerate ; Mild
			EffectsStage = 1
		ElseIf ActualLactacid >= Menu.RequiredLactMild ; Moderate
			EffectsStage = 2
		Else ; Addict
			EffectsStage = 3
		EndIf
		
	ElseIf AddictionStage == 4 ; Stage 4 ===================================
		If ActualLactacid >= Menu.RequiredLactJunkie ; Unaffected
			EffectsStage = 0
		ElseIf ActualLactacid >= Menu.RequiredLactAddict ; Mild
			EffectsStage = 1
		ElseIf ActualLactacid >= Menu.RequiredLactModerate ; Moderate
			EffectsStage = 2
		ElseIf ActualLactacid >= Menu.RequiredLactMild ; Addict
			EffectsStage = 3
		Else ; Junkie
			EffectsStage = 4
		EndIf
	EndIf
	;debug.notification("Addiction stage: " + AddictionStage + ". Effects stage = " + EffectsStage)
	If OldEffectsStage < EffectsStage ; Increase
		Debug.Notification("Your cravings increase")
		SetAutoActions()
		SetAddictionEffects()
	ElseIf EffectsStage < OldEffectsStage ; Decrease
		Debug.Notification("Your cravings diminish")
		SetAutoActions()
		SetAddictionEffects()
	EndIf
EndFunction

Function RemoveAllWithdrawalEffects()
	PlayerRef.RemoveSpell(_MA_AddictionEffects_0)
	PlayerRef.RemoveSpell(_MA_AddictionEffects_1)
	PlayerRef.RemoveSpell(_MA_AddictionEffects_2)
	PlayerRef.RemoveSpell(_MA_AddictionEffects_3)
	PlayerRef.RemoveSpell(_MA_AddictionEffects_4)
EndFunction

Function SetAddictionEffects()
	If !PlayerRef.HasMagicEffect(_MA_FortifySpeed)
		If EffectsStage == 0 ; Unaffected
				PlayerRef.AddSpell(_MA_AddictionEffects_0, false)
				AutoActionChance = 0.0
				
		ElseIf EffectsStage == 1 ; Mild
				PlayerRef.AddSpell(_MA_AddictionEffects_1, false)
				AutoActionChance = 10.0
				
		ElseIf EffectsStage == 2 ; Moderate
				PlayerRef.AddSpell(_MA_AddictionEffects_2, false)
				TripChance = Menu.TripChanceModerate
				TripFrequency = Menu.TripFreqModerate
				SlipChance = Menu.SlipChanceModerate
				SlipFrequency = Menu.SlipFreqModerate
				TripDropChance = Menu.AdditionalTripDropChanceModerate
				AutoActionChance = 30.0
				
		ElseIf EffectsStage == 3 ; Addict
				PlayerRef.AddSpell(_MA_AddictionEffects_3, false)
				TripChance = Menu.TripChanceAddict
				TripFrequency = Menu.TripFreqAddict
				SlipChance = Menu.SlipChanceAddict
				SlipFrequency = Menu.SlipFreqAddict
				TripDropChance = Menu.AdditionalTripDropChanceAddict
				AutoActionChance = 60.0
				
		ElseIf EffectsStage == 4 ; Junkie
				PlayerRef.AddSpell(_MA_AddictionEffects_4, false)
				TripChance = Menu.TripChanceJunkie
				TripFrequency = Menu.TripFreqJunkie
				SlipChance = Menu.SlipChanceJunkie
				SlipFrequency = Menu.SlipFreqJunkie
				TripDropChance = Menu.AdditionalTripDropChanceJunkie
				AutoActionChance = 95.0
		EndIf
	EndIf
EndFunction

Function NotifyEffectsChange()
	If NewAddictionPool > OldAddictionPool
		Debug.Notification("You have become more addicted to lactacid")
	Else
		Debug.Notification("You have become less addicted to lactacid")
	EndIf
EndFunction

Float Function GetValues(Form akBaseObject)
	Float LactAmount
	If akBaseObject == MME_Lactacid ; Lactacid
		HealAmount = Menu.AproposHealBase + (7 * Menu.AproposHealDelta)
		AddictionAmount = Menu.AddictivenessLactacid
		LactAmount = Menu.LactacidLactacid
		If PlayerRef.HasSpell(_MA_Addicted_1)
			LactAmount = LactAmount * 0.75 ; - 1.5
		ElseIf PlayerRef.HasSpell(_MA_Addicted_2)
			LactAmount = LactAmount * 0.4 ; - 0.8
		ElseIf PlayerRef.HasSpell(_MA_Addicted_3)
			LactAmount = LactAmount * 0.1 ; 0.2
		ElseIf PlayerRef.HasSpell(_MA_Addicted_4)
			LactAmount = LactAmount * 0.01 ; 0.02
		EndIf
		return LactAmount
	ElseIf akBaseObject == MME_MilkPotion00 ; Dilute
		HealAmount = Menu.AproposHealBase
		LactAmount = Menu.LactacidDilute *  FreshLactacidMult
		Duration = Menu.DurationDilute
		SpeedMag = Menu.SpeedDilute
		StaminaMag = Menu.StaminaRateDilute
		AddictionAmount = (Menu.AddictivenessDilute *  FreshAddictivenessMult) as Int
		return LactAmount
	ElseIf akBaseObject == MME_MilkPotion01 ; Weak
		HealAmount = Menu.AproposHealBase + (Menu.AproposHealDelta)
		LactAmount = Menu.LactacidWeak *  FreshLactacidMult
		Duration = Menu.DurationWeak
		SpeedMag = Menu.SpeedWeak
		StaminaMag = Menu.StaminaRateWeak
		AddictionAmount = (Menu.AddictivenessWeak *  FreshAddictivenessMult) as Int
		return LactAmount
	ElseIf akBaseObject == MME_MilkPotion02 ; Regular
		HealAmount = Menu.AproposHealBase + (2 * Menu.AproposHealDelta)
		LactAmount = Menu.LactacidRegular *  FreshLactacidMult
		Duration = Menu.DurationRegular
		SpeedMag = Menu.SpeedRegular
		StaminaMag = Menu.StaminaRateRegular
		AddictionAmount = (Menu.AddictivenessRegular *  FreshAddictivenessMult) as Int
		return	LactAmount
	ElseIf akBaseObject == MME_MilkPotion03 ; Strong
		HealAmount = Menu.AproposHealBase + (3 * Menu.AproposHealDelta)
		LactAmount =Menu.LactacidStrong *  FreshLactacidMult
		Duration = Menu.DurationStrong
		SpeedMag = Menu.SpeedStrong
		StaminaMag = Menu.StaminaRateStrong
		AddictionAmount = (Menu.AddictivenessStrong *  FreshAddictivenessMult) as Int
		return LactAmount
	ElseIf _MA_Milk_Tasty.HasForm(akBaseObject) ; Tasty
		HealAmount = Menu.AproposHealBase + (4 * Menu.AproposHealDelta)
		LactAmount = Menu.LactacidTasty *  FreshLactacidMult
		Duration = Menu.DurationTasty
		SpeedMag = Menu.SpeedTasty
		StaminaMag = Menu.StaminaRateTasty
		AddictionAmount = (Menu.AddictivenessTasty *  FreshAddictivenessMult) as Int
		return LactAmount
	ElseIf _MA_Milk_Creamy.HasForm(akBaseObject) ; Creamy
		HealAmount = Menu.AproposHealBase + (5 * Menu.AproposHealDelta)
		LactAmount = Menu.LactacidCreamy *  FreshLactacidMult
		Duration = Menu.DurationCreamy
		SpeedMag = Menu.SpeedCreamy
		StaminaMag = Menu.StaminaRateCreamy
		AddictionAmount = (Menu.AddictivenessCreamy *  FreshAddictivenessMult) as Int
		return LactAmount
	ElseIf _MA_Milk_Enriched.HasForm(akBaseObject) ; Enriched
		HealAmount = Menu.AproposHealBase + (6 * Menu.AproposHealDelta)
		LactAmount = Menu.LactacidEnriched * FreshLactacidMult
		Duration = Menu.DurationEnriched
		SpeedMag = Menu.SpeedEnriched
		StaminaMag = Menu.StaminaRateEnriched
		AddictionAmount = (Menu.AddictivenessEnriched *  FreshAddictivenessMult) as Int
		return	LactAmount
	ElseIf _MA_Milk_Sublime.HasForm(akBaseObject) ; Sublime
		HealAmount = Menu.AproposHealBase + (7 * Menu.AproposHealDelta)
		LactAmount = Menu.LactacidSublime *  FreshLactacidMult
		Duration = Menu.DurationSublime
		SpeedMag = Menu.SpeedSublime
		StaminaMag = Menu.StaminaRateSublime
		AddictionAmount = (Menu.AddictivenessSublime * FreshAddictivenessMult) as Int
		return LactAmount
	EndIf
	Debug.Trace("_MA_: GetValues did not resolve " + akBaseObject.GetName())
EndFunction

Function MilkMmeNpc(Actor Cow)
	Sexlab.QuickStart(Actor1 = Cow, Actor2 = PlayerRef, Victim = none, Hook = "AnimationStart", AnimationTags = "Breastfeeding")
	MilkQ.MilkingToContainer(akActor = Cow, i = 0, Mode = 4, MilkingType = 0, MilkBarrel = MilkDump)
	; Script attached to container handles equipping milk to player - _MA_MilkDump
EndFunction

Function MilkSgoNpc(Actor Cow)
	Sexlab.QuickStart(Actor1 = Cow, Actor2 = PlayerRef, Victim = none, Hook = "AnimationStart", AnimationTags = "Breastfeeding")
	Form Milk
	int SgoCurrentMilk = Init.GetSgoActorMilkGetCount(Cow)
	FreshAddictivenessMult = Menu.FreshAddictivenessMult
	FreshLactacidMult = Menu.FreshLactacidMult
	
	; Wait for scene to start
	Int i = 0
	While !Sexlab.IsActorActive(PlayerRef) && i < 15
		i += 1
		Utility.Wait(2.0)	
	EndWhile
	
	Utility.Wait(5) ; Wait for actors to position
	_MA_AddictItemAddedQuest.Stop()
	While SgoCurrentMilk > 0
		Milk = ConvertSgoMilk(Cow)
		Init.SgoActorMilkRemove(Cow)
		PlayerRef.AddItem(Milk, 1, true)
		PlayerRef.EquipItem(Milk)
		Utility.Wait(4)
		SgoCurrentMilk = Init.GetSgoActorMilkGetCount(Cow)
	EndWhile
	_MA_AddictItemAddedQuest.Start()
	FreshAddictivenessMult = 1.0
	FreshLactacidMult = 1.0
EndFunction

Form Function ConvertSgoMilk(Actor Cow)
	FormList ListSelect
	int SgoMilkedCount = StorageUtil.GetIntValue(Cow,"SGO.Stat.Milks") ; Get how many times this NPC has been SGO milked
	int FakeMaidLevel = Math.Floor(SgoMilkedCount / Milkq.TimesMilkedMult)
	If FakeMaidLevel > 10
		FakeMaidLevel = 10
	Endif
	int SgoCurrentMilk = Init.GetSgoActorMilkGetCount(Cow)
	int SgoMilkMax = Init.SgoActorMilkGetCapacity(Cow)
	Race CowRace = Cow.GetActorBase().GetRace()

	int Index = MilkQ.MME_Races.Find(CowRace)
	
	If Index != -1
		If Menu.BoobgasmChance + (Menu.BoobgasmChancePerLevel * FakeMaidLevel) > utility.RandomFloat(0.0, 100.0)
			ListSelect = _MA_RaceMilkLists.GetAt(Index) as FormList
			Return MilkE.GetMilkTypeHelper(0, ListSelect, FakeMaidLevel)
		Else
			If SgoCurrentMilk <= SgoMilkMax * 0.25
				Return MilkQ.MME_Milk_Basic.GetAt(0)
			ElseIf SgoCurrentMilk <= SgoMilkMax * 0.50
				Return MilkQ.MME_Milk_Basic.GetAt(1)
			ElseIf SgoCurrentMilk <= SgoMilkMax * 0.75
				Return MilkQ.MME_Milk_Basic.GetAt(2)
			ElseIf SgoCurrentMilk > SgoMilkMax * 0.75
				Return MilkQ.MME_Milk_Basic.GetAt(3)
			EndIf
		EndIf
	Else
		Debug.trace("_MA_: ConvertSgoMilk - Unsupported race: " + CowRace)
		Return MilkQ.MME_Milk_Basic.GetAt(0)
	EndIf
EndFunction

Function InitFoodstuffs()
	_MA_LactacidFoods.Revert()
	Int count = JsonUtil.FormListCount("Milk Addict/Food.json", "FoodList")
	Int i = 0
	While i < count
		_MA_LactacidFoods.AddForm(JsonUtil.FormListGet("Milk Addict/Food.json", "FoodList", i))
		i += 1
	EndWhile	
EndFunction

Function ProcessArmor(Form akBaseObject, ObjectReference ArmorObjRef)
	;Armor Cuirass = PlayerRef.GetWornForm(0x00000004) as Armor
	If akBaseObject != None
		Float CurrentMilk = MME_Storage.getMilkCurrent(PlayerRef)
		Float MilkMax = MME_Storage.getMilkMaximum(PlayerRef) ; Milk Maid level 10, Cap = 24.0
		;debug.messagebox("Milk: " + CurrentMilk + ". Cap: " + MilkMax + ". %: " + (CurrentMilk/MilkMax)*100.0)
		
		; Armor
		If ;/(akBaseObject.HasKeyword(ArmorHeavy) || akBaseObject.HasKeyword(ArmorLight) || akBaseObject.HasKeyword(ArmorClothing)) &&/; !akBaseObject.HasKeyword(SexlabNoStrip) && Menu.ArmorCapacityUnits > -1
			;/
			If CurrentMilk > Menu.ArmorCapacityUnits
				If (CurrentMilk/MilkMax) * 100.0 > Menu.ArmorCapacity
					Debug.Notification("Your breasts are too large to fit into your armor")
					PlayerRef.UnEquipItem(akBaseObject)
				EndIf
			EndIf
		/;
		
		
			If Menu.SlutFactor
				Int index = JsonUtil.FormListFind("Milk Addict/SlutClothes.json", "ClothesList", akBaseObject)
				If index >= 0
					CurrentSlutiness = JsonUtil.IntListGet("Milk Addict/SlutClothes.json", "Sluttiness", index)
				Else
					CurrentSlutiness = -1
				EndIf
				If CurrentSlutiness < 0 || Menu.SetupSlutClothes
					Menu.SetupSlutClothes = false
					Debug.Notification("How slutty is " + akBaseObject.GetName())
					Int Button = _MA_SluttinessMsg.Show(); + 1
					While Button == 8 ; -> View outfit option
						Utility.Wait(6.0)
						Debug.Notification("How slutty is " + akBaseObject.GetName())
						Button = _MA_SluttinessMsg.Show(); + 1
					EndWhile
					If index < 0
						JsonUtil.FormListAdd("Milk Addict/SlutClothes.json", "ClothesList", akBaseObject)
						JsonUtil.IntListAdd("Milk Addict/SlutClothes.json", "Sluttiness", Button)
					Else
						JsonUtil.IntListSet("Milk Addict/SlutClothes.json", "Sluttiness", index, button)
					EndIf
					JsonUtil.Save("Milk Addict/SlutClothes.json")
					CurrentSlutiness = Button
					SendSlutinessConfigureEvent()
				EndIf
				
				;debug.messagebox("Equip - akBaseObject: " + akBaseObject + ". Slutiness: " + CurrentSlutiness)
				UpdateRipChance()
			EndIf
			
			If CurrentSlutiness != 7
				If !Init.IsMwaInstalled
					; Init clothes durability
					If StorageUtil.FormListFind(none, "_MA_ClothesDurabilityList", ArmorObjRef) == -1
						InitClothesDurability(ArmorObjRef)
					EndIf
					CurrentClothesDurabilty = StorageUtil.GetIntValue(ArmorObjRef, "_MA_ClothesDurability")
				Else
					CurrentClothesDurabilty = StorageUtil.GetIntValue(ArmorObjRef, "_MWA_Durability")
				EndIf
				;Debug.Notification("This item has a durability of " + CurrentClothesDurabilty)
				
				
				If !DoBoobsFitArmor(CurrentMilk)
					If !Init.IsMwaInstalled
						PlayerRef.UnequipItem(akBaseObject)
						Debug.Notification("My breasts are too big to fit into this armor")
						
					Else
						Int StressSound = _MA_MetalStress.Play(PlayerRef)
						Sound.SetInstanceVolume(StressSound, Menu.TearVolume)
						Debug.Notification("This armor is too tight")
					EndIf
				EndIf
				
				
				;/
				If CurrentMilk > Menu.ClothesLimitUnits
					If (CurrentMilk/MilkMax) * 100.0 > Menu.ClothesLimit
						If TearChance > 0
							Int RipSound
							Debug.Notification("This " + Menu.SlutClothesDescrip[(CurrentSlutiness - 1)] + " outfit is a really tight fit...")
							RipSound = _MA_SndRipSmall.Play(PlayerRef)
							Sound.SetInstanceVolume(RipSound, Menu.TearVolume)
						Else
							Debug.Notification("It's a good thing these " + Menu.SlutClothesDescrip[(CurrentSlutiness - 1)] + " clothes are a little... looser")
						EndIf
					EndIf
				EndIf
				/;
			EndIf
		
		
			
		; Clothing
		ElseIf akBaseObject.HasKeyword(ArmorClothing) && !akBaseObject.HasKeyword(SexlabNoStrip) && Menu.ClothesLimitUnits > -1
			ClothesEquipped = true
			If Menu.SlutFactor
				Int index = JsonUtil.FormListFind("Milk Addict/SlutClothes.json", "ClothesList", akBaseObject)
				If index >= 0
					CurrentSlutiness = JsonUtil.IntListGet("Milk Addict/SlutClothes.json", "Sluttiness", index)
				Else
					CurrentSlutiness = -1
				EndIf
				If CurrentSlutiness < 0 || Menu.SetupSlutClothes
					Menu.SetupSlutClothes = false
					Debug.Notification("How slutty is " + akBaseObject.GetName())
					Int Button = _MA_SluttinessMsg.Show() + 1
					While Button == 9 ; -> View outfit option
						Utility.Wait(6.0)
						Debug.Notification("How slutty is " + akBaseObject.GetName())
						Button = _MA_SluttinessMsg.Show() + 1
					EndWhile
					If index < 0
						JsonUtil.FormListAdd("Milk Addict/SlutClothes.json", "ClothesList", akBaseObject)
						JsonUtil.IntListAdd("Milk Addict/SlutClothes.json", "Sluttiness", Button)
					Else
						JsonUtil.IntListSet("Milk Addict/SlutClothes.json", "Sluttiness", index, button)
					EndIf
					JsonUtil.Save("Milk Addict/SlutClothes.json")
					CurrentSlutiness = Button
				EndIf
				
				;debug.messagebox("Equip - akBaseObject: " + akBaseObject + ". Slutiness: " + CurrentSlutiness)
				UpdateRipChance()
			EndIf
			
			If CurrentSlutiness != 7
				If !Init.IsMwaInstalled
					; Init clothes durability
					If StorageUtil.FormListFind(none, "_MA_ClothesDurabilityList", ArmorObjRef) == -1
						InitClothesDurability(ArmorObjRef)
					EndIf
					CurrentClothesDurabilty = StorageUtil.GetIntValue(ArmorObjRef, "_MA_ClothesDurability")
				Else
					CurrentClothesDurabilty = StorageUtil.GetIntValue(ArmorObjRef, "_MWA_Durability")
				EndIf
				;Debug.Notification("This item has a durability of " + CurrentClothesDurabilty)
				If CurrentMilk > Menu.ClothesLimitUnits
					If (CurrentMilk/MilkMax) * 100.0 > Menu.ClothesLimit
						If TearChance > 0
							Int RipSound
							Debug.Notification("This " + Menu.SlutClothesDescrip[(CurrentSlutiness)] + " outfit is a really tight fit...")
							RipSound = _MA_SndRipSmall.Play(PlayerRef)
							Sound.SetInstanceVolume(RipSound, Menu.TearVolume)
						Else
							Debug.Notification("It's a good thing these " + Menu.SlutClothesDescrip[(CurrentSlutiness)] + " clothes are a little... looser")
						EndIf
					EndIf
				EndIf
			EndIf
		Else 
			ClothesEquipped = false
		EndIf
	EndIf
EndFunction

Bool Function DoBoobsFitArmor(Float CurrentMilk)
	Float MilkMaxCapacity = 44.0
	Float MilkPerSlutiness = MilkMaxCapacity / 7.0
	If CurrentMilk < MilkPerSlutiness * CurrentSlutiness + 1
		Return true
	Else
		Return false
	EndIf
EndFunction

Function InitClothesDurability(ObjectReference ArmorObjRef)
	ReferenceAlias NextEmptyAlias = GetNextEmptyAlias(_MA_ClothesDurability)
	If NextEmptyAlias == None
		NextEmptyAlias = GetOldestDurabilityAlias()
		(NextEmptyAlias as _MA_ClothesDurabilityAliasExpire).RecycleAlias()
	EndIf
	EquipToIgnore = ArmorObjRef.GetBaseObject()
	NextEmptyAlias.ForceRefTo(ArmorObjRef)	
	(NextEmptyAlias as _MA_ClothesDurabilityAliasExpire).LastEquipped = Utility.GetCurrentGameTime()
	StorageUtil.FormListAdd(none, "_MA_ClothesDurabilityList", ArmorObjRef, allowDuplicate = false)
	StorageUtil.SetIntValue(ArmorObjRef, "_MA_ClothesDurability", Menu.ClothesDurability + Utility.RandomInt(-(Menu.DurabilityTolerance), Menu.DurabilityTolerance))
EndFunction

ReferenceAlias Function GetOldestDurabilityAlias()
	Int AliasCount = _MA_ClothesDurability.GetNumAliases()
	Int i = 0
	Int RefAliasSelect
	Float LowestValue
	ReferenceAlias NextAlias
	
	While i < AliasCount
		NextAlias = _MA_ClothesDurability.GetNthAlias(i) as ReferenceAlias
		If i == 0
			LowestValue = (NextAlias as _MA_ClothesDurabilityAliasExpire).LastEquipped
			RefAliasSelect = 0
		ElseIf (NextAlias as _MA_ClothesDurabilityAliasExpire).LastEquipped < LowestValue
			LowestValue = (NextAlias as _MA_ClothesDurabilityAliasExpire).LastEquipped
			RefAliasSelect = i
		EndIf
		i += 1
	EndWhile
	Return _MA_ClothesDurability.GetNthAlias(RefAliasSelect) as ReferenceAlias
EndFunction

ReferenceAlias Function GetNextEmptyAlias(Quest QuestToCheck)
	Int AliasCount = QuestToCheck.GetNumAliases()
	Int i = 0
	ReferenceAlias NextEmptyAlias
	
	While i < AliasCount && NextEmptyAlias == None
		If (QuestToCheck.GetNthAlias(i) as ReferenceAlias).GetReference() == None
			NextEmptyAlias = QuestToCheck.GetNthAlias(i) as ReferenceAlias
		EndIf
		i += 1
	EndWhile
	Return NextEmptyAlias
EndFunction

Bool Function IsOkToRip()
	Bool Result = false
	Armor CurrentBodyArmor = PlayerRef.GetWornForm(0x00000004) as Armor
	If CurrentBodyArmor != None
		If !Init.IsMwaInstalled
			If CurrentBodyArmor.HasKeyword(ArmorClothing) && CurrentSlutiness != 7 && CurrentBodyArmor.IsPlayable() && !CurrentBodyArmor.HasKeyword(SexlabNoStrip)
				Result = true
			EndIf
		Else
			If CurrentSlutiness != 7 && CurrentBodyArmor.IsPlayable()
				Result = true
			EndIf
		EndIf
	EndIf
	Return Result
EndFunction

Function TryRip(Float Mult)
	If IsOkToRip() && MightTear
		Float RanFloat = Utility.RandomFloat(0.0, 100.0)
		If TearChance * Mult > RanFloat
			Int RipSound
			Sound EffectSelect
			If !Init.IsMwaInstalled
				CurrentClothesDurabilty -= 1
				If CurrentClothesDurabilty > (Menu.ClothesDurability / 2)
					EffectSelect = _MA_SndRipSmall
				Else
					EffectSelect = _MA_SndRipMedium
				EndIf
				StorageUtil.SetIntValue(CurrentlyEquippedArmor, "_MA_ClothesDurability", CurrentClothesDurabilty)
				If CurrentClothesDurabilty < 1
					RipClothes()
				EndIf
			Else
				
				Float MilkPerSlutiness = 44.0 / 7.0
				Float CurrentMilk = MME_Storage.getMilkCurrent(PlayerRef)
				Int RipEvent = ModEvent.Create("_MWA_DamageArmorSlot")
				Int RipDamage = Math.Ceiling((CurrentMilk - (MilkPerSlutiness * (CurrentSlutiness + 1))) / MilkPerSlutiness)
				If RipDamage < 1
					RipDamage = 1
				EndIf
				If (RipEvent)
					ModEvent.PushInt(RipEvent, 32)
					ModEvent.PushInt(RipEvent, RipDamage)
					ModEvent.PushForm(RipEvent, Self.GetOwningQuest())
					ModEvent.Send(RipEvent)
				EndIf
				If CurrentlyEquippedArmor.HasKeyword(ArmorHeavy)
					EffectSelect = _MA_MetalStress
				Else
					CurrentClothesDurabilty = StorageUtil.GetIntValue(CurrentlyEquippedArmor, "_MWA_Durability" , -1)
					If CurrentClothesDurabilty > (Menu.ClothesDurability / 2)
						EffectSelect = _MA_SndRipSmall
					Else
						EffectSelect = _MA_SndRipMedium
					EndIf
				EndIf
			EndIf
			RipSound = EffectSelect.Play(PlayerRef)
			Sound.SetInstanceVolume(RipSound, Menu.TearVolume)
		EndIf
	EndIf
EndFunction

Function WeaponRip(Bool abPowerAttack)
	If IsOkToRip()
		Float RanFloat = Utility.RandomFloat(0.0, 100.0)
		Float RipChance = Menu.HitRipChance
		If abPowerAttack
			RipChance = RipChance * 2
		EndIf
		If PlayerRef.HasMagicEffectWithKeyword(MagicArmorSpell)
			RipChance = RipChance * (Menu.MagicArmorMult / 100.0)
		EndIf
		;Debug.Trace("_MA_: Combat Rip - RipChance= " + RipChance + ". RanFloat" + RanFloat)
		If RipChance > RanFloat
			Int RipSound
			CurrentClothesDurabilty -= 1
			If CurrentClothesDurabilty > (Menu.ClothesDurability / 2)
				RipSound = _MA_SndRipSmall.Play(PlayerRef)
			Else
				RipSound = _MA_SndRipMedium.Play(PlayerRef)
			EndIf
			Sound.SetInstanceVolume(RipSound, Menu.TearVolume)
			StorageUtil.SetIntValue(CurrentlyEquippedArmor, "_MA_ClothesDurability", CurrentClothesDurabilty)
			If CurrentClothesDurabilty < 1
				RipClothes()
			EndIf
		EndIf
	EndIf
EndFunction

Function UpdateRipChance()
	Float BellyScale = 0
	Float AssScale = 0
	If Init.SlifInstalled
		BellyScale = Init.GetSlifBelly() - 1
		AssScale = Init.GetSlifAss()
	EndIf
	
	Float CurrentMilk = MME_Storage.getMilkCurrent(PlayerRef)
	Float MilkMax = MME_Storage.getMilkMaximum(PlayerRef)
	TearChance = 0.0
	If CurrentMilk > Menu.ClothesLimitUnits && CurrentSlutiness != 7 ; CurrentSlutiness 7 = Immune
		Float AdjustedSlutiness = CurrentSlutiness - 2 ; Because 3 is average
		SlutinessFactor = ((0.15 * AdjustedSlutiness) + ((AdjustedSlutiness * AdjustedSlutiness * AdjustedSlutiness) / 350)) * 100 ; https://www.desmos.com/calculator/twhlqwfnkl
		;debug.messagebox("Sluttiness bonus: " + SlutinessFactor)

		; Breasts
		TearChance = (Menu.ClothesTearChanceBase + (Menu.ClothesTearChance * (((CurrentMilk/MilkMax) * 100.0) - (Menu.ClothesLimit + SlutinessFactor))))
		
		; Ass & Belly
		AssRip = ((AssScale * Menu.ClothesTearChanceAss) - ((SlutinessFactor/100) * (AssScale * Menu.ClothesTearChanceAss)))
		BellyRip = (((BellyScale)* Menu.ClothesTearChanceBelly) - ((SlutinessFactor/100) * ((BellyScale) * Menu.ClothesTearChanceBelly)))
		
		;TearChance = (Menu.ClothesTearChanceBase + (Menu.ClothesTearChance * (((CurrentMilk/MilkMax) * 100.0) - (Menu.ClothesLimit + SlutinessFactor))))
		;debug.messagebox("SlutinessFactor: " + SlutinessFactor + "AssScale: " + AssScale + ". BellyScale: " + BellyScale + ". Rip: " + TearChance)
	EndIf
	If TearChance > 0.0
		MightTear = true
		If Menu.TearMultAttack > 0.0 && Menu.TearMultPowerAttack > 0.0
			RegisterForAnimationEvent(PlayerREF, "weaponSwing")
			RegisterForAnimationEvent(PlayerREF, "weaponLeftSwing")			
		EndIf
		If Menu.TearMultJump > 0.0
			RegisterForAnimationEvent(PlayerREF, "JumpUp")
		EndIf
		If Menu.TearMultSprint > 0.0
			RegisterForAnimationEvent(PlayerREF, "tailSprint")
		EndIf
		If Menu.TearMultBow > 0.0
			RegisterForAnimationEvent(PlayerREF, "arrowAttach")
		EndIf
		If Menu.TearMultMagic > 0.0
			RegisterForAnimationEvent(PlayerREF, "BeginCastRight")
			RegisterForAnimationEvent(PlayerREF, "BeginCastLeft")
		EndIf
		If Menu.TearMultShout > 0.0
			RegisterForAnimationEvent(PlayerREF, "BeginCastVoice")
		EndIf
	Else
		MightTear = false
		UnRegisterForAnimationEvent(PlayerREF, "weaponSwing")
		UnRegisterForAnimationEvent(PlayerREF, "weaponLeftSwing")			
		UnRegisterForAnimationEvent(PlayerREF, "JumpUp")
		UnRegisterForAnimationEvent(PlayerREF, "tailSprint")
		UnRegisterForAnimationEvent(PlayerREF, "arrowAttach")
	EndIf
EndFunction

Function RipClothes()
	Armor Cuirass = PlayerRef.GetWornForm(0x00000004) as Armor
	Init.LastTornEnchantment = WornObject.GetEnchantment(PlayerRef, 0, 4)
	ObjectReference LastDrop
	Int RipSound
	RipSound = _MA_SndRipLarge.Play(PlayerRef)
	Sound.SetInstanceVolume(RipSound, Menu.TearVolume)
	ObjectReference RippedArmor = PlayerRef.DropObject(Cuirass, 1)
	_MA_TornOverflow.AddItem(RippedArmor, 1, abSilent = true)
	;PlayerRef.RemoveItem(Cuirass, 1, true, _MA_GarbageDisposal)
	;_MA_TornOverflow.AddItem(Cuirass, 1)
	If Utility.IsInMenuMode()
		Input.TapKey(15)
	EndIf
	Init.LastTornArmor = Cuirass
	PlayerRef.AddItem(_MA_TornClothes, 1, true)
	
	If Menu.DropType == 1
		LastDrop = PlayerRef.DropObject(_MA_TornClothes, 1)
		LastDrop.SetDisplayName("Torn " + Cuirass.GetName())
		Init.InitLostClothes(LastDrop)
	ElseIf Menu.DropType == 0
		LastDrop = PlayerRef.DropObject(_MA_TornClothes, 1)
		LastDrop.SetDisplayName("Torn " + Cuirass.GetName())
		PlayerRef.AddItem(LastDrop, 1, true)
	EndIf
	Init.InitTornClothes(LastDrop)
	
	
	DoMortifiedEffect()
	
	ResetDurabilityAlias(RippedArmor)
EndFunction

Function DoMortifiedEffect()
	Debug.Notification("Oh shit!")
	If !Init.IsMwaInstalled
		Int Gasp = _MA_Gasp.Play(PlayerRef)
		If !PlayerRef.IsOnMount() && !PlayerRef.IsDead() && !PlayerRef.WornHasKeyword(zbfEffectKeepOffsetAnim) && !PlayerRef.IsWeaponDrawn() && !PlayerRef.IsSwimming() && !PlayerRef.IsInFaction(zbfFactionAnimating) && !PlayerRef.IsInFaction(SexlabAnimatingFaction) && PlayerRef.GetSitState() != 3 && PlayerRef.GetSleepState() != 3 && PlayerRef.GetCombatState() == 0
			;Debug.SendAnimationEvent(PlayerRef, "ZaZAPCSHMOFF") ; Covers pussy only
			Debug.SendAnimationEvent(PlayerRef, "ZaZAPCSHFOFF") ; Covers tits and pussy
		EndIf
	EndIf
	
	_MA_MortifiedGawkers.Stop()
	_MA_MortifiedGawkers.Start()
	Int i = 0
	Actor ActorRef
	Int GawkerCount = 0
	ReferenceAlias nthAlias
	While i < _MA_MortifiedGawkers.GetNumAliases()
		nthAlias = _MA_MortifiedGawkers.GetNthAlias(i) as ReferenceAlias
		ActorRef = nthAlias.GetReference() as Actor
		If ActorRef != None
			If ActorRef.HasLOS(PlayerRef)
				GawkerCount += 1
			EndIf
		EndIf
		i += 1
	EndWhile
	If GawkerCount > 0
		_MA_Mortified.SetNthEffectMagnitude(0, (GawkerCount * 5.0))
		_MA_Mortified.SetNthEffectDuration(0, (GawkerCount * 600))
		_MA_Mortified.Cast(PlayerRef, PlayerRef)
	EndIf
EndFunction

Function ResetDurabilityAlias(ObjectReference ArmorObjRef)
	Int AliasCount = _MA_ClothesDurability.GetNumAliases()
	Int i = 0
	ReferenceAlias AliasSelect
	
	While i < AliasCount && AliasSelect == None
		If (_MA_ClothesDurability.GetNthAlias(i) as ReferenceAlias).GetReference() == ArmorObjRef
			AliasSelect = _MA_ClothesDurability.GetNthAlias(i) as ReferenceAlias
		EndIf
		i += 1
	EndWhile
	If AliasSelect
		(AliasSelect as _MA_ClothesDurabilityAliasExpire).RecycleAlias()
	Else
		Debug.Trace("_MA_: Error finding ObjRef: " + ArmorObjRef + " in _MA_ClothesDurability aliases")
	EndIf
EndFunction

Function ProcessFood(Form akBaseObject)
	If akBaseObject as Potion
		Int index
		index = _MA_LactacidFoods.Find(akBaseObject)
		
		If SetupFood
			If index == -1 ; Add new food to storage
				_MA_LactacidFoods.AddForm(akBaseObject)
				index = _MA_LactacidFoods.Find(akBaseObject)
				JsonUtil.FormListAdd("Milk Addict/Food.json", "FoodList", akBaseObject as Form)
				JsonUtil.FloatListAdd("Milk Addict/Food.json", "FoodLactacid", Menu.SetupFoodLactacid)
				JsonUtil.IntListAdd("Milk Addict/Food.json", "FoodAddictiveness", Menu.SetupFoodAddictiveness)
				Debug.Notification(akBaseObject.GetName() + " saved to index " + index + " with lactacid: " + Menu.SetupFoodLactacid + " & addictiveness: " + Menu.SetupFoodAddictiveness)
				JsonUtil.Save("Milk Addict/Food.json")
			
			Else ; Update existing food
				JsonUtil.FormListSet("Milk Addict/Food.json", "FoodList", index, akBaseObject)
				JsonUtil.FloatListSet("Milk Addict/Food.json", "FoodLactacid", index, Menu.SetupFoodLactacid)
				JsonUtil.IntListSet("Milk Addict/Food.json", "FoodAddictiveness", index, Menu.SetupFoodAddictiveness)
				Debug.Notification(akBaseObject.GetName() + " updated at index " + index + " with lactacid: " + Menu.SetupFoodLactacid + " & addictiveness: " + Menu.SetupFoodAddictiveness)
				JsonUtil.Save("Milk Addict/Food.json")
			EndIf
		
		Else ; Remove food from storage
			If index == -1
				Debug.Notification("Can't remove food - not found in storage - Ignoring")
			Else
				JsonUtil.FormListRemove("Milk Addict/Food.json", "FoodList", akBaseObject)
				JsonUtil.FloatListRemove("Milk Addict/Food.json", "FoodLactacid", index)
				JsonUtil.IntListRemove("Milk Addict/Food.json", "FoodAddictiveness", index)
				_MA_LactacidFoods.RemoveAddedForm(akBaseObject)
				Debug.Notification("Removed " + akBaseObject.GetName() + " from storage")
				JsonUtil.Save("Milk Addict/Food.json")
			EndIf
		EndIf
	Else
		Debug.Notification(akBaseObject.GetName() + " is not of type 'Potion'. Ignoring")
	EndIf
	SetupFood = False
	RemoveFood = False
EndFunction

Function RefreshCleavageEffect()
	If Menu.CleavageSpellT
		PlayerRef.RemoveSpell(_MA_Cleavage)
		Init.MilkUnits = (MME_Storage.getMilkCurrent(PlayerRef) / Menu.CleavageMaxUnits) * 100.0
		PlayerRef.AddSpell(_MA_Cleavage, false)
	EndIf
EndFunction

Function TryBoobLeakSound()
	If Menu.LeakyBoobsSoundT
		PlayerRef.AddSpell(_MA_LeakyBoobsSpell, false)
	EndIf
EndFunction

Function UpdateKicker()
	RegisterForSingleUpdateGameTime(1.0)
EndFunction

Function CumReducesLactDecay()
	Float ReductionPerLayer = 15.0 ; percent
	Float CumLayers = SexLab.CountCum(PlayerRef)
	Float DecayRate = MilkQ.LactacidDecayRate
	
	Float LactValue = DecayRate * ((ReductionPerLayer * CumLayers) / 100.0)
	Debug.Trace("_MA_: CumReducesLactDecay() - ActualLactacid: " + ActualLactacid + ". CumLayers: " + CumLayers + ". LactValue: " + LactValue + ". DecayRate: " + DecayRate)
	If ActualLactacid > 0.0  && (ActualLactacid - DecayRate) + (DecayRate - LactValue) > 0.0
		StorageUtil.AdjustFloatValue(PlayerRef, "MME.MilkMaid.LactacidCount", LactValue)
	EndIf
EndFunction

Function SetAutoActions()
	If Menu.InvoluntaryActions
		If AutoActionChance > 0.0
			_MA_AddictItemAddedQuest.Start()
			_MA_AddictShopMenuQuest.Start()
			PlayerRef.AddPerk(_MA_ContainerPerk)
			PlayerRef.AddPerk(_MA_DeadActorPerk)

		Else
			_MA_AddictItemAddedQuest.Stop()
			_MA_AddictShopMenuQuest.Stop()
			PlayerRef.RemovePerk(_MA_ContainerPerk)
			PlayerRef.RemovePerk(_MA_DeadActorPerk)
		EndIf
	EndIf
EndFunction

Function TryAutoActionMilkEquip()
	Debug.Trace("_MA_: TryAutoActionMilkEquip")
	If Init.ClearToTryAutoAction()
		PlayerRef.AddSpell(_MA_GetHasMilkSpell, false)
		Utility.WaitMenuMode(0.1)
		If PlayerHasMilkInventory
			Debug.Notification("Your cravings get the better of you")
			Init.AddictEquipMilk(GetFirstMilkInContainer(PlayerRef))
		EndIf
		PlayerRef.RemoveSpell(_MA_GetHasMilkSpell)
	EndIf
EndFunction

Function TryAutoEquipMilkContainer(ObjectReference akTarget)
	Debug.Trace("_MA_: TryAutoEquipMilkContainer")
	If Init.ClearToTryAutoAction()
		Form MilkSelect = GetFirstMilkInContainer(akTarget)
		If MilkSelect
			If akTarget != PlayerRef
				_MA_AddictItemAddedQuest.Stop()
				akTarget.RemoveItem(MilkSelect, 1, abSilent = true, akOtherContainer = PlayerRef)
				Debug.Notification("Your cravings get the better of you")
				Init.AddictEquipMilk(MilkSelect)
				_MA_AddictItemAddedQuest.Start()
			EndIf
		EndIf
	EndIf
EndFunction

Form Function GetFirstMilkInContainer(ObjectReference TargetContainer)
	Int i = TargetContainer.GetNumItems()
	Form akBaseItem
	While i > 0
		i -= 1
		akBaseItem = TargetContainer.GetNthForm(i)
		If akBaseItem as Potion
			If akBaseItem.HasKeyword(MME_Milk)
				Return akBaseItem
			EndIf
		EndIf
	EndWhile
EndFunction

Function SendSlutinessConfigureEvent()
	Int SlutinessConfigureEvent = ModEvent.Create("_MA_ConfigureSlutiness")
    If (SlutinessConfigureEvent)
		ModEvent.Send(SlutinessConfigureEvent)
    EndIf
EndFunction

Int Function GetCurrentEffectsStage()
	Return EffectsStage
EndFunction

Bool Property SetupFood = false Auto Hidden
Bool Property RemoveFood = false Auto Hidden
Bool Property PlayerHasMilkInventory = false Auto Hidden

Float Property TripChance Auto Hidden
Float Property TripFrequency Auto Hidden
Float Property SlipChance Auto Hidden
Float Property SlipFrequency Auto Hidden
Float Property TripDropChance Auto Hidden
Float Property FreshAddictivenessMult = 1.0 Auto Hidden
Float Property FreshLactacidMult = 1.0 Auto Hidden

FormList Property _MA_Milk_Tasty  Auto  
FormList Property _MA_Milk_Creamy  Auto  
FormList Property _MA_Milk_Enriched  Auto  
FormList Property _MA_Milk_Sublime  Auto  
FormList Property _MA_ElixirPlaceholders Auto
FormList Property _MA_RaceMilkLists  Auto 
FormList Property _MA_LactacidFoods Auto

GlobalVariable Property _MA_LactacidAddictionPool  Auto
GlobalVariable Property TimeScale Auto

SPELL Property _MA_Addicted_0 Auto
SPELL Property _MA_Addicted_1 Auto
SPELL Property _MA_Addicted_2 Auto
SPELL Property _MA_Addicted_3 Auto
SPELL Property _MA_Addicted_4 Auto

SPELL Property _MA_AddictionEffects_0 Auto
SPELL Property _MA_AddictionEffects_1 Auto
SPELL Property _MA_AddictionEffects_2 Auto
SPELL Property _MA_AddictionEffects_3 Auto
SPELL Property _MA_AddictionEffects_4 Auto

SPELL Property _MA_MilkSpeed  Auto  
SPELL Property _MA_WearySpell  Auto  
SPELL Property _MA_MilkStamina  Auto

SPELL Property _MA_AttackRipSpell Auto
Spell Property _MA_Mortified Auto
Spell Property _MA_Cleavage Auto
Spell Property _MA_MountEventCooldownSpell Auto
Spell Property _MA_LeakyBoobsSpell Auto
Spell Property _MA_GetHasMilkSpell Auto
Spell Property _MA_MoanCooldownSpell Auto

MagicEffect Property _MA_damstaminarate Auto
MagicEffect Property _MA_FortifySpeed Auto
MagicEffect Property MME_FeedingStagePassiveEff Auto
MagicEffect Property _MA_MoanCooldownMgef Auto

Potion Property _MA_ElixirMinorPlaceholder Auto
Potion Property _MA_ElixirModerateplaceholder Auto
Potion Property _MA_ElixirStrongPlaceholder Auto
Potion Property _MA_ElixirMinor Auto
Potion Property _MA_ElixirModerate Auto
Potion Property _MA_ElixirStrong Auto
Potion Property _MA_ElixirUseless Auto
Potion Property MME_Lactacid  Auto 

Potion Property MME_MilkPotion00  Auto  
Potion Property MME_MilkPotion01  Auto  
Potion Property MME_MilkPotion02  Auto  
Potion Property MME_MilkPotion03  Auto  

Actor Property PlayerRef  Auto

Keyword Property MME_Milk Auto
Keyword Property ArmorHeavy Auto
Keyword Property ArmorLight Auto
Keyword Property ArmorClothing Auto
Keyword Property SexlabNoStrip Auto
Keyword Property zbfEffectKeepOffsetAnim Auto
Keyword Property MagicArmorSpell Auto

Armor Property _MA_TornClothes Auto

Faction Property zbfFactionAnimating Auto
Faction Property SexlabAnimatingFaction Auto

SexLabFramework Property SexLab Auto
MilkQUEST Property MilkQ auto  
MilkECON Property MilkE Auto

_MA_Mcm Property Menu Auto
_MA_Init Property Init Auto

ObjectReference Property MilkDump Auto
ObjectReference Property _MA_TornOverflow Auto
ObjectReference Property _MA_GarbageDisposal Auto

Quest Property MQ101  Auto 
Quest Property _MA_MortifiedGawkers Auto
Quest Property _MA_ClothesDurability Auto
Quest Property _MA_AddictItemAddedQuest Auto
Quest Property _MA_AddictShopMenuQuest Auto
Quest Property _MA_TripMountSpectatorsQuest Auto

Sound Property _MA_SndRipSmall  Auto
Sound Property _MA_SndRipMedium  Auto
Sound Property _MA_SndRipLarge  Auto
Sound Property _MA_MetalStress Auto
Sound Property _MA_Gasp Auto

Message Property _MA_SluttinessMsg Auto

Perk Property _MA_ContainerPerk Auto
Perk Property _MA_DeadActorPerk Auto
