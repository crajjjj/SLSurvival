Scriptname _SLS_SteepFall extends ReferenceAlias

Function Shutdown()
	SteepFallHorse.Stop()
	Self.GetOwningQuest().Stop()
	PlayerRef.RemovePerk(_SLS_FallDamagePerk)
	PlayerRef.RemovePerk(_SLS_DeathResistPerk)
	SendModEvent("dhlp-Resume")
EndFunction

Function Begin()
	Self.GetOwningQuest().Start()
	FallBeginHeight = PlayerRef.GetPositionZ()
	LastWalkHeight = PlayerRef.GetPositionZ()
	LastUpdate = Utility.GetCurrentRealTime()
	RegisterForControl("Forward")
	RegisterForAnimationEvent(PlayerRef, "AnimObjectUnequip")
	SteepFallHorse.Start()
	GoToState("")
EndFunction

Event OnControlDown(string control)
	;Debug.Messagebox("Key down")
	If Game.IsMovementControlsEnabled() && Game.GetCameraState() != 3 ; Not free cam
		RegisterForSingleUpdate(1.0)
	EndIf
EndEvent

Event OnControlUp(string control, float HoldTime)
	;Debug.Messagebox("Key up")
	UnRegisterForUpdate()
EndEvent

Event OnUpdate()
	If Math.Abs(LastWalkHeight - PlayerRef.GetPositionZ()) > JsonUtil.GetFloatValue("SL Survival/SteepFall.json", "fallheight", Missing = 150.0) + Whirlwind + Ethereal + ((Init.IsCrawling as Float) * JsonUtil.GetFloatValue("SL Survival/SteepFall.json", "crawlallowance", Missing = 60.0)); Up or down
		Trip()
	Else
		RecordHeight()
	EndIf
	RegisterForSingleUpdate(1.0)
EndEvent

Event OnPlayerLoadGame()
	RecordHeight()
	_SLS_FallDamageReduction.SetValue(JsonUtil.GetFloatValue("SL Survival/SteepFall.json", "falldamagereduction", Missing = 90.0))
EndEvent

Event OnLocationChange(Location akOldLoc, Location akNewLoc) ; Unfortunately need both this and OnCellLoad to cover everything. Or more at least...
	;Debug.Messagebox("Loc change")
	RecordHeight()
EndEvent

Event OnCellLoad()
	RecordHeight()
	;Debug.Messagebox("Cell load")
EndEvent

Event OnBeginState()
	RegisterForAnimationEvent(PlayerRef, "AnimObjectUnequip")
	;RegisterForAnimationEvent(PlayerRef, "FootRight")
	RecordHeight()
EndEvent

Event OnAnimationEvent(ObjectReference akSource, string asEventName)
	If PlayerRef.GetAnimationVariableBool("bInJumpState")
		;Debug.Messagebox(asEventName)
		GoToState(asEventName)
	EndIf
EndEvent

Function RecordHeight()
	LastWalkHeight = PlayerRef.GetPositionZ()
	LastUpdate =  Utility.GetCurrentRealTime()
	;Debug.Trace("_SLS_ TEST: Time between updates: " + (Utility.GetCurrentRealTime() - LastUpdate))
	;LastUpdate = Utility.GetCurrentRealTime()
EndFunction

Function Trip(Bool IsDrop = false)
	If CanTrip(PlayerRef)
		If IsDrop || Utility.GetCurrentRealTime() -  LastUpdate < 1.2 ; If last update was too long ago then just record height and continue. If it's a drop then time not a factor
			;Debug.Messagebox("IsDrop: + " + IsDrop + "\nTime lapse: " + (Utility.GetCurrentRealTime() -  LastUpdate) + "\nLastWalkHeight: " + LastWalkHeight + "\nCur Height: " + PlayerRef.GetPositionZ() + "\nCalc: " + Math.Abs(LastWalkHeight - PlayerRef.GetPositionZ()))
			GoToState("Fallen")
			PlayerRef.AddPerk(_SLS_FallDamagePerk)
			PlayerRef.AddPerk(_SLS_DeathResistPerk)
			SendModEvent("dhlp-Suspend")
			PlayerRef.PushActorAway(PlayerRef, JsonUtil.GetFloatValue("SL Survival/SteepFall.json", "fallforcemultiplier", Missing = 2.0))
			;_SLS_PushPlayerSpell.Cast(PlayerRef, PlayerRef)
			
			If PlayerRef.IsSneaking()
				If JsonUtil.GetIntValue("SL Survival/SteepFall.json", "falldetectionevent", Missing = 1) && Utility.RandomFloat(0.0, 100.0) > PlayerRef.GetAv("Sneak")
					;Debug.Messagebox("Noisy")
					DoTripSound()
				;Else
					;Debug.Messagebox("Quiet")
				EndIf
			Else
				DoTripSound()
			EndIf
			StripItemByCount(Count = Utility.RandomInt(JsonUtil.GetIntValue("SL Survival/SteepFall.json", "itemstripcountmin", Missing = 1), JsonUtil.GetIntValue("SL Survival/SteepFall.json", "itemstripcountmax", Missing = 3)))
		Else
			;Debug.Notification("Failed time window")
			RecordHeight()
		EndIf
	EndIf
EndFunction

Function DoTripSound()
	Int Pain = _SLS_PainSM.Play(PlayerRef)
	Sound.SetInstanceVolume(Pain , 0.5)
	PlayerRef.CreateDetectionEvent(PlayerRef, aiSoundLevel = 25 + (100 - (PlayerRef.GetAv("Sneak") as Int)))
EndFunction

Function HorseTrip(Actor Horsey)
	;/ Can't rag doll the horse, only stagger :( 
	Horsey.PushActorAway(Horsey, 100.0)
	_SLS_PushPlayerSpell.Cast(Horsey, Horsey)
	/;
EndFunction

Bool Function CanTrip(Actor akActor)
	If akActor.IsSwimming() || akActor.IsInFaction(SexlabAnimatingFaction)
		Return false
	EndIf
	Return true
EndFunction

State AnimObjectUnequip ; Begin falling
	Event OnBeginState()
		;Debug.Messagebox("AnimObjectUnequip")
		UnRegisterForAnimationEvent(PlayerRef, "AnimObjectUnequip")
		RegisterForAnimationEvent(PlayerRef, "JumpDown") ; Land
		;UnRegisterForUpdate()
		;RegisterForAnimationEvent(PlayerRef, "IdleStop")
		RegisterForAnimationEvent(PlayerRef, "FootRight")
		RegisterForAnimationEvent(PlayerRef, "FootLeft")
		FallBeginHeight = PlayerRef.GetPositionZ()
		;Debug.Messagebox("Fall Begin")
	EndEvent
	
	Event OnEndState()
		UnRegisterForAnimationEvent(PlayerRef, "FootRight")
		UnRegisterForAnimationEvent(PlayerRef, "FootLeft")
		UnRegisterForAnimationEvent(PlayerRef, "JumpDown") ; Land
		RecordHeight()
	EndEvent
	
	Event OnAnimationEvent(ObjectReference akSource, string asEventName)
		;Debug.Messagebox("Landed???: " + asEventName + "\nJumpstate: " + PlayerRef.GetAnimationVariableBool("bInJumpState"))
		If (asEventName == "FootLeft" || asEventName == "FootRight") && !PlayerRef.GetAnimationVariableBool("bInJumpState") ; Don't trip if JumpDown didn't fire and the player is running and is not in jump state - Looks wrong to land safe then start running and fall
			;Debug.Messagebox("Just continue")
			GoToState("")
		ElseIf asEventName == "JumpDown"; || !PlayerRef.GetAnimationVariableBool("bInJumpState") ; Player can scooby-do in the air while falling - firing FootLeft or FootRight falsely triggering land event.
			;Debug.Messagebox("Actual land")
			;If Math.Abs(FallBeginHeight - PlayerRef.GetPositionZ()) > 140.0 ; Up or down
			If FallBeginHeight - PlayerRef.GetPositionZ() > JsonUtil.GetFloatValue("SL Survival/SteepFall.json", "fallheight", Missing = 150.0) + Whirlwind + Ethereal ; Down only
				;Debug.Messagebox("Fall Trip")
				Trip(true)
			Else
				GoToState("")
			EndIf
		EndIf
	EndEvent
	
	Event OnUpdate()
		RegisterForSingleUpdate(1.0)
	EndEvent
EndState

State Fallen
	Event OnBeginState()
		;Debug.Messagebox("Fallen")
		RegisterForAnimationEvent(PlayerRef, "getupend")
		UnRegisterForUpdate()
		;RegisterForAnimationEvent(PlayerRef, "FootLeft")
		;RegisterForAnimationEvent(PlayerRef, "FootRight")
	EndEvent
	
	Event OnEndState()
		UnRegisterForAnimationEvent(PlayerRef, "getupend")
		;UnRegisterForAnimationEvent(PlayerRef, "FootLeft")
		;UnRegisterForAnimationEvent(PlayerRef, "FootRight")
		RecordHeight()
		PlayerRef.RemovePerk(_SLS_FallDamagePerk)
		PlayerRef.RemovePerk(_SLS_DeathResistPerk)
		SendModEvent("dhlp-Resume")
		If LostCount > 0
			;Debug.Messagebox("HEELO")
			Utility.Wait(0.2)
			Debug.Notification("<font color='#CC0000'>Lost " + LostCount + " items!</font>")
			LostCount = 0
		EndIf
		RegisterForSingleUpdate(1.0)
	EndEvent
	
	Event OnAnimationEvent(ObjectReference akSource, string asEventName)
		;Debug.Messagebox("GetUp: " + asEventName)
		GoToState("")
	EndEvent
	
	Event OnUpdate()
		RegisterForSingleUpdate(1.0)
	EndEvent
	
	Function Trip(Bool IsDrop = false)
	EndFunction
EndState

Function StripItemByCount(Int Count)
	GetStripableItems()
	ObjectReference Trig = PlayerRef.PlaceAtMe(_SLS_DroppedItemTrig)
	Trig.MoveTo(Trig, afZOffset = 20.0)
	While Count >= 1
		Count -= 1
		If JsonUtil.GetFloatValue("SL Survival/SteepFall.json", "stripchance", Missing = 50.0) > Utility.RandomFloat(0.0, 100.0)
			If StorageUtil.FormListCount(PlayerRef, "_SLS_SteepFallStripForms") > 0
				StripItem(StorageUtil.FormListGet(PlayerRef, "_SLS_SteepFallStripForms", Utility.RandomInt(0, StorageUtil.FormListCount(PlayerRef, "_SLS_SteepFallStripForms") - 1)), Trig)
			EndIf
		EndIf
	EndWhile
	If StorageUtil.FormListCount(Trig, "_SLS_DroppedItems") > 0
		_SLS_FemaleGasp.Play(PlayerRef)
		LostCount = StorageUtil.FormListCount(Trig, "_SLS_DroppedItems")
		(Trig as _SLS_DroppedItemTrigger).InitTrigger()
	Else
		(Trig as _SLS_DroppedItemTrigger).Shutdown()
	EndIf
EndFunction

Function StripItem(Form akForm, ObjectReference Trig)
	;PlayerRef.UnequipItem(akForm)
	PlayerRef.UnequipItemEx(akForm, equipSlot = 0, preventEquip = false)
	If Menu.DropItems
		Debug.Trace("_SLS_ SteepFall: Dropping: " + akForm.GetName() + " - " + akForm)
		
		;ObjectReference ObjRef = PlayerRef.DropObject(akForm)
		ObjectReference ObjRef = LostFound.DropItem(PlayerRef, akForm)
		If ObjRef
			;ObjRef.SetMotionType(4, true)
			Int i = 10
			While !ObjRef.Is3DLoaded() && i > 0
				Utility.Wait(0.1)
				i -= 1
			EndWhile
			ObjRef.MoveTo(PlayerRef, 40.0 * Math.Sin(PlayerRef.GetAngleZ()), 40.0 * Math.Cos(PlayerRef.GetAngleZ()), PlayerRef.GetHeight() + 20.0)
			ObjRef.ApplyHavokImpulse(Utility.RandomFloat(-1.0, 1.0), Utility.RandomFloat(-1.0, 1.0), Utility.RandomFloat(-1.0, 0.5), Utility.RandomFloat(JsonUtil.GetFloatValue("SL Survival/SteepFall.json", "stripforcemin", Missing = 50.0), JsonUtil.GetFloatValue("SL Survival/SteepFall.json", "stripforcemax", Missing = 100.0)))
			StorageUtil.FormListRemove(PlayerRef, "_SLS_SteepFallStripForms", akForm)
			StorageUtil.FormListAdd(Trig, "_SLS_DroppedItems", ObjRef, AllowDuplicate = false)
			StorageUtil.SetFormValue(ObjRef, "_SLS_DroppedItemTriggerRef", Trig)
		Else
			Debug.Trace("_SLS_ SteepFall: Error dropping: " + akForm.GetName() + " - " + akForm + " - No ObjRef")
		EndIf
	EndIf
EndFunction

Function GetStripableItems()
	Int i = 0
	Form akForm
	StorageUtil.FormListClear(PlayerRef, "_SLS_SteepFallStripForms")
	While i < Menu.SlotMasks.Length
		akForm = PlayerRef.GetWornForm(Menu.SlotMasks[i])
		If IsStripable(akForm)
			StorageUtil.FormListAdd(PlayerRef, "_SLS_SteepFallStripForms", akForm)
		EndIf
		i += 1
	EndWhile
	akForm = PlayerRef.GetEquippedWeapon(abLeftHand = false)
	If IsStripable(akForm)
		StorageUtil.FormListAdd(PlayerRef, "_SLS_SteepFallStripForms", akForm)
	EndIf
	akForm = PlayerRef.GetEquippedWeapon(abLeftHand = true)
	If IsStripable(akForm)
		StorageUtil.FormListAdd(PlayerRef, "_SLS_SteepFallStripForms", akForm, AllowDuplicate = false)
	EndIf
EndFunction

Bool Function IsStripable(Form akForm)
	If akForm && akForm.GetName() && !akForm.HasKeyword(SexlabNoStrip)
		Return true
	EndIf
	Return false
EndFunction

Int LostCount

Float LastUpdate
Float LastWalkHeight
Float FallBeginHeight
Float Property Whirlwind Auto Hidden
Float Property Ethereal Auto Hidden

Actor Property PlayerRef Auto

Perk Property _SLS_FallDamagePerk Auto
Perk Property _SLS_DeathResistPerk Auto

Faction Property SexlabAnimatingFaction Auto

Spell Property _SLS_PushPlayerSpell Auto

Sound Property _SLS_PainSM Auto
Sound Property _SLS_FemaleGasp Auto

GlobalVariable Property _SLS_FallDamageReduction Auto

Keyword Property SexlabNoStrip Auto

Activator Property _SLS_DroppedItemTrig Auto

_SLS_LostFound Property LostFound Auto
_SLS_SteepFallHorse Property SteepFallHorse Auto
SLS_Init Property Init Auto
SLS_Mcm Property Menu Auto
