Scriptname SLS_StashMonitor extends ReferenceAlias  

;/
Event OnInit()
	RegisterForModEvent("_BC_OnBackPackDrop", "On_BC_OnBackPackDrop")
	RegisterForModEvent("_BC_OnBackPackEquip", "On_BC_OnBackPackEquip")
EndEvent

Event On_BC_OnBackPackDrop(Form Pack)
	If Pack as ObjectReference == WhatIAm
		StashTrack.ClearObjStorageUtil(WhatIAm)
		SetupContainer()
		StashTrack.CheckPryingEyes(WhatIAm)
	EndIf
EndEvent

Event On_BC_OnBackPackEquip(Form Pack)
	If Pack as ObjectReference == WhatIAm
		UnRegisterForUpdate()
	EndIf
EndEvent
/;

Event OnCellDetach()
	If !FirstTheft
		FirstTheft = true
		OnUpdateGameTime()
	EndIf
EndEvent

Event OnItemAdded(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
	If Self.GetReference() != WhatIAm ; Reference changed. Setup new container
		;WhatIAm = Self.GetReference()
		SetupContainer()
	EndIf
	Int GoldValue = 0
	If akBaseItem == Gold001
		GoldValue += aiItemCount
	Else
		GoldValue += akBaseItem.GetGoldValue() * aiItemCount
	EndIf
	StorageUtil.AdjustIntValue(WhatIAm, "SLS_ContainerValue", GoldValue)
	If IsEmpty
		IsEmpty = false
		RegisterForSingleUpdateGameTime(TheftFrequency)
	EndIf
EndEvent

Event OnItemRemoved(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akDestContainer)
	Int GoldValue = 0
	If akBaseItem == Gold001
		GoldValue += aiItemCount
	Else
		GoldValue += akBaseItem.GetGoldValue() * aiItemCount
	EndIf
	StorageUtil.AdjustIntValue(WhatIAm, "SLS_ContainerValue", -GoldValue)
	AmILowest(StorageUtil.GetIntValue(WhatIAm, "SLS_ContainerValue", 0))
EndEvent

Event OnUpdateGameTime()
	;Debug.Messagebox("WhatIAm: " + WhatIAm + "\nDistance: " + PlayerRef.GetDistance(WhatIAm) + "\nBase: " + WhatIAm.GetBaseObject() + "\n\n_BC_Backpack_Container : " +  StorageUtil.GetFormValue(PlayerRef, "_BC_Backpack_Container") as ObjectReference)
	If PlayerRef.GetDistance(WhatIAm) >= 4096.0 && (WhatIAm != StorageUtil.GetFormValue(PlayerRef, "_BC_Backpack_Container") as ObjectReference) ; Player is far enough away and the container is not the players currently equipped backpack
		; try rob shit
		Int i
		BuildStealList()
		;Float CompValue = Math.pow((BaseContSafety / 3.0), 0.2) * 100.0
		If BaseContSafety < 1.0 ; NPCs can only find your stash if it's comp value is < 100.0. No point calculating otherwise
			
			; Give Npcs in the area a chance to stumble onto your stash. Move from InTheArea to Peekaboo
			i = StorageUtil.FormListCount(WhatIAm, "SLS_InTheArea")
			If i > 0
				While i > 0
					i -= 1
					Float RanFloat = Utility.RandomFloat(0.0, 1.0)
					
					debug.trace("_SLS_: " + WhatIAm + " - RanFloat: " + RanFloat + ". BaseContSafety: " + BaseContSafety)

					If RanFloat > BaseContSafety
						Actor PotThief = StorageUtil.FormListGet(WhatIAm, "SLS_InTheArea", i) as Actor
						If PotThief
							StorageUtil.FormListRemove(WhatIAm, "SLS_InTheArea", PotThief, false)
							StorageUtil.FormListAdd(WhatIAm, "SLS_Peekaboo", PotThief, false)
							Debug.Trace("SLS_: " + PotThief.GetBaseObject().GetName() + " - " + PotThief + " discovered your stash " + WhatIAm)
						Else ; Remove non persistent actor
							StorageUtil.FormListRemoveAt(WhatIAm, "SLS_InTheArea", i)
						EndIf
					EndIf
				EndWhile
				
			Else ; Give a chance that a 'wanderer' will find your stash - Once off theft. Only when no NPCs
				
				Float RanFloat = Utility.RandomFloat(0.0, 1.0)
				debug.trace("_SLS_: RanFloat: " + RanFloat + ". BaseContSafety: " + BaseContSafety + ". WhatIAm: " + WhatIAm)
				If RanFloat > BaseContSafety
					StealSomething(SLS_StolenContainer, WhatIAm)
				EndIf
			EndIf
		Else
			Debug.Trace("SLS_: This stash is too well hidden for NPCs to stumble upon it: " + WhatIAm)
		EndIf
		
		; Npcs that are aware of your stash will always try to steal from it
		Int NpcsStashAware = StorageUtil.FormListCount(WhatIAm, "SLS_Peekaboo")
		If NpcsStashAware > 0
			;Debug.Messagebox("Steallist: " + StorageUtil.FormListToArray(WhatIAm, "_SLS_StealList"))
			i = 0
			Actor Thief
			While i < NpcsStashAware
				Thief = StorageUtil.FormListGet(WhatIam, "SLS_Peekaboo", i) as Actor
				If Thief != None ; NEED TO LOOK INTO THIS. NON PERSISTENT ACTORS SHOULDN'T BE ABLE TO STEAL YOUR STUFF!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
					If Thief.IsDead() ; Dead people keep stealing my stuff :(
						StorageUtil.FormListRemove(WhatIam, "SLS_Peekaboo", Thief, false)
					Else
						Int j = 0
						While j < Menu.StealXItems && StorageUtil.FormListCount(WhatIAm, "_SLS_StealList") > 0
							StealSomething(Thief, WhatIAm)
							j += 1
						EndWhile
					EndIf
				Else
					; If
				EndIf
				i += 1
			EndWhile
		EndIf
		
	Else
		Debug.Trace("SLS_: WhatIAm: " + WhatIAm + " is too close to the player to be stolen from")
	EndIf
	
	Debug.Trace("SLS_: WhatIAm: " + WhatIAm + " is worth " + StorageUtil.GetIntValue(WhatIAm, "SLS_ContainerValue") + ". Theft freq: " + TheftFrequency)
	If WhatIAm.GetNumItems() == 0
		IsEmpty = true
	Else
		RegisterForSingleUpdateGameTime(TheftFrequency)
	EndIf
EndEvent

Function StealSomething(ObjectReference Thief, ObjectReference akSrcContainer)
	HasBeenLooted = true
	Form RandomItem = StorageUtil.FormListGet(WhatIAm, "_SLS_StealList", (Utility.RandomInt(0, StorageUtil.FormListCount(WhatIAm, "_SLS_StealList") - 1)))
	Int AmountToSteal = 1
	If RandomItem == Gold001
		Int GoldTotal = akSrcContainer.GetItemCount(Gold001)
		If GoldTotal > 100
			AmountToSteal = Utility.RandomInt(1, Math.Floor(GoldTotal/15))
			If AmountToSteal < 150
				AmountToSteal = Utility.RandomInt(100, 150)
			EndIf
		Else
			AmountToSteal = GoldTotal
		EndIf
	EndIf
	akSrcContainer.RemoveItem(RandomItem, AmountToSteal, true, Thief)
	If akSrcContainer.GetItemCount(RandomItem) == 0
		StorageUtil.FormListRemove(WhatIAm, "_SLS_StealList", RandomItem)
	EndIf
	Debug.Trace("SLS_: " + Thief.GetBaseObject().GetName() + " stole " + AmountToSteal + " " + RandomItem.GetName())
EndFunction

Function BuildStealList()
	StorageUtil.FormListClear(WhatIAm, "_SLS_StealList")
	Form akBaseItem
	Int i = 0
	While i < WhatIAm.GetNumItems()
		akBaseItem = WhatIAm.GetNthForm(i)
		If akBaseItem.GetName() && akBaseItem.IsPlayable()
			StorageUtil.FormListAdd(WhatIAm, "_SLS_StealList", akBaseItem)
		EndIf
		i += 1
	EndWhile
EndFunction

Function AmILowest(Int TestValue)
	If TestValue < StashTrack.LowestValue
		StashTrack.LowestValue = TestValue
		StashTrack.LowestValueContainer = WhatIAm
	EndIf
EndFunction

Function SetupContainer()
	WhatIAm = Self.GetReference()
	IsEmpty = WhatIAm.GetNumItems() == 0
	HasBeenLooted = false
	FirstTheft = false
	
	Float RoadFactor = StashTrack.GetRoadFactor(WhatIAm)
	Float ContTypeFactor = StashTrack.GetContainerFactor(WhatIAm)
	Float LocTypeFactor = StashTrack.GetLocTypeFactor(WhatIAm)
	
	TheftFrequency = StashTrack.GetTheftFreq(LocTypeFactor)
	BaseContSafety = GetTotalContainerSafety(RoadFactor, ContTypeFactor, LocTypeFactor)
	
	Debug.Trace("SLS_: RoadFactor: " + RoadFactor + ". ContTypeFactor: " + ContTypeFactor + ". LocTypeFactor: " + LocTypeFactor + ". TheftFrequency: " + TheftFrequency + ". Container: " + WhatIAm)
	If Init.DebugMode
		Debug.Notification("RoadFactor: " + RoadFactor + ". ContTypeFactor: " + ContTypeFactor + ". LocTypeFactor: " + LocTypeFactor + ". TheftFrequency: " + TheftFrequency)
	EndIf
	RegisterForSingleUpdateGameTime(TheftFrequency)
EndFunction

Function SetStashAttributes(Float TheftFreq = -1.0, Float ContSafety = -1.0)
	If ContSafety < 0.0
		BaseContSafety = GetTotalContainerSafety(StashTrack.GetRoadFactor(WhatIAm), StashTrack.GetContainerFactor(WhatIAm), StashTrack.GetLocTypeFactor(WhatIAm))
	Else
		BaseContSafety = ContSafety
	EndIf
	
	If TheftFreq <= 0.0
		TheftFrequency = StashTrack.GetTheftFreq(StashTrack.GetLocTypeFactor(WhatIAm))
	Else
		TheftFrequency = TheftFreq
	EndIf
	RegisterForSingleUpdateGameTime(TheftFrequency)
EndFunction

Float Function GetTotalContainerSafety(Float RoadFactor, Float ContTypeFactor, Float LocTypeFactor)
	Return (RoadFactor * 0.25) + (ContTypeFactor * 0.25) + (LocTypeFactor * 0.25) ; Base 25% of discovery
EndFunction

Function SetContainerException()
	UnRegisterForUpdateGameTime()
	StashTrack.ClearObjStorageUtil(WhatIAm)
	_SLS_TrackedContainerList.RemoveAddedForm(WhatIAm)
	WhatIAm = None
	Self.Clear()
EndFunction

Event OnActivate(ObjectReference akActionRef)
	If akActionRef == PlayerRef
		If HasBeenLooted
			HasBeenLooted = false
			Debug.Notification("Some of my stuff is missing!")
		Else
			Debug.Notification("I think everything is still here")
		EndIf
	EndIf
EndEvent

Function StopTracking()
	WhatIAm = None
	UnRegisterForUpdateGameTime()
EndFunction

; Container details
ObjectReference Property WhatIAm = None Auto Hidden
Float BaseContSafety
Float TheftFrequency
Bool IsEmpty
Bool HasBeenLooted = false
Bool FirstTheft = false

SLS_StashTrackPlayer Property StashTrack Auto
SLS_Mcm Property Menu Auto
SLS_Init Property Init Auto

MiscObject Property Gold001 Auto

Formlist Property _SLS_TrackedContainerList Auto

ObjectReference Property SLS_StolenContainer  Auto 

Actor Property PlayerRef Auto 
