Scriptname SLS_StashTrackPlayer extends ReferenceAlias  

Event OnInit()
	RegisterForMenu("ContainerMenu")
	ImportStashExceptions()
EndEvent

Event OnPlayerLoadGame()
EndEvent

Event OnMenuOpen(String MenuName) ; Only interested in OnItemRemoved when player is in container menu. Should reduce events slightly
	If IsTrackableContainer(Game.GetCurrentCrosshairRef())
		GoToState("TrackDrops")
	EndIf
EndEvent

Event OnMenuClose(String MenuName)
	GoToState("")
EndEvent

Bool Function IsTrackableContainer(ObjectReference ContainerRef)
	If ContainerRef && ContainerRef.GetBaseObject() as Container
		Return true
	EndIf
	Return false
EndFunction

State TrackDrops
	Event OnItemRemoved(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akDestContainer)
		If akDestContainer != None
			If !_SLS_StashAddExceptionQuest.IsRunning() && StorageUtil.GetIntValue(akDestContainer, "_SLS_StashExceptionContainer", Missing = -1) <= 0 && akDestContainer.GetBaseObject() as Container ; Exclude actors & exceptions
				;Debug.notification("Object is a container")
				Debug.trace("SLS_: Object is a container")
				ObjectReference CrosshairContainer = Game.GetCurrentCrosshairRef()
				If akDestContainer == CrosshairContainer && akDestContainer.GetBaseObject() != _SLS_EvictionConfiscatedChest as Form ; UI.IsMenuOpen("ContainerMenu") && ; akDestContainer.Is3Dloaded() ; Exclude Barter/Gift Menu. Exclude container that don't have their 3Ds loaded - This should exclude scripted containers (Hopefully)
					;Debug.notification("In inventory menu and is crosshairRef - Processing")
					Debug.trace("SLS_: In inventory menu and is crosshairRef - Processing")
					Location kCurrentLoc = PlayerRef.GetCurrentLocation()
					Bool IsPlayerHouse = false
					If kCurrentLoc
						IsPlayerHouse = kCurrentLoc.HasKeyword(LocTypePlayerHouse)
					EndIf
					If !IsPlayerHouse && UI.IsMenuOpen("ContainerMenu") && akDestContainer != None

						If LastContainer != akDestContainer
							LastContainer = akDestContainer
							ItemCount = 0
							GoldValue = 0
						EndIf
						ItemCount += aiItemCount
						If QueueUpdate
							If akBaseItem == Gold001
								GoldValue += aiItemCount
							Else
								GoldValue += akBaseItem.GetGoldValue() * aiItemCount
							EndIf
						EndIf
						
						If !QueueUpdate
							QueueUpdate = true
							ContainerClosed(akDestContainer)
						EndIf
					EndIf

				Else
					;Debug.Notification("SLS_: Not in the right menu or is NOT crosshairRef - Ignoring")
					Debug.trace("SLS_: Not in the right menu or is NOT crosshairRef or is excluded container type - Ignoring")
				EndIf
				
			Else
				;Debug.notification("SLS_: " + akDestContainer.GetBaseObject().GetName() + " is not a container" + akDestContainer)
				Debug.trace("SLS_: " + akDestContainer.GetBaseObject().GetName() + " is not a container or is exception or exception quest is started " + akDestContainer)
			EndIf
		EndIf
	EndEvent
EndState

Function ContainerClosed(ObjectReference akDestContainer)
	GoldValue += GetContentsValue(akDestContainer) ; Tally up the container contents while we wait
	While UI.IsMenuOpen("ContainerMenu") ; Wait for player to stop stashing shit
		Utility.Wait(0.2)
	EndWhile
	QueueUpdate = false
	LastContainer = None
	Debug.trace("SLS_: Player stashed " + ItemCount + " items worth " + GoldValue)
	If _SLS_TrackedContainerList.HasForm(akDestContainer) ; Either we are already tracking this container
		; Player adding to tracked stash
		CheckPryingEyes(akDestContainer)
		debug.trace("SLS_: Player adding to existing stash")
	
	ElseIf (GoldValue > LowestValue || UsedAliasCount < _SLS_StashTrack.GetNumAliases() - 1) && akDestContainer.Is3DLoaded() ; Or its new to us and it is of a value worth tracking OR we still have empty aliases to fill with lowest values
		; Track new stash
		AssignAlias(akDestContainer)
		CheckPryingEyes(akDestContainer)
		debug.trace("SLS_: New stash created")
		
	Else
		; Not interested in anything else
		debug.trace("SLS_: Nothing worth tracking")
	EndIf
EndFunction

Function CheckPryingEyes(ObjectReference akContainer)
	_SLS_PryingEyes.Stop()
	_SLS_PryingEyes.Start()
	Int i = 0
	Actor  ActorRef
	ReferenceAlias nthAlias
	While i < _SLS_PryingEyes.GetNumAliases()
		nthAlias = _SLS_PryingEyes.GetNthAlias(i) as ReferenceAlias
		ActorRef = nthAlias.GetReference() as Actor
		If ActorRef != None
			If !IsExcludedFaction(ActorRef)
				If ActorRef.HasLOS(PlayerRef)
					Debug.trace("SLS_: " + ActorRef.GetActorBase().GetName() + " - (" + ActorRef +  ") saw you at " + akContainer)
					StorageUtil.FormListAdd(akContainer, "SLS_Peekaboo", ActorRef, allowDuplicate = false)
					StorageUtil.FormListRemove(akContainer, "SLS_InTheArea", ActorRef, false)
				Else
					Debug.trace("SLS_: " + ActorRef.GetActorBase().GetName() + " - (" + ActorRef +  ") did NOT see you at " + akContainer)
					If StorageUtil.FormListFind(akContainer, "SLS_Peekaboo", ActorRef) == -1 ; Don't add actors that already know about this stash
						StorageUtil.FormListAdd(akContainer, "SLS_InTheArea", ActorRef, allowDuplicate = false)
					EndIf
				EndIf
			EndIf
		Else
			Return
		EndIf
		i += 1
	EndWhile
EndFunction

Bool Function IsExcludedFaction(Actor akActor)
	If Init.PahInstalled && akActor.IsInFaction(Init.PahFaction)
		Debug.Trace("SLS_: " + akActor.GetBaseObject().GetName() + " is in excluded faction: PAH slave")
		return true
	EndIf
	If Init.SbcInstalled && akActor.IsInFaction(Init.SbcFaction)
		Debug.Trace("SLS_: " + akActor.GetBaseObject().GetName() + " is in excluded faction: SBC slave")
		return true
	EndIf
	Debug.Trace("SLS_: " + akActor.GetBaseObject().GetName() + " is NOT in an excluded faction")
	return false
EndFunction

ObjectReference Function GetLowestValueContainer()
	Int i = 0
	Int Lowest = 0
	Int Current
	ObjectReference Loser
	While i < _SLS_TrackedContainerList.GetSize()
		Current = StorageUtil.GetIntValue(_SLS_TrackedContainerList.GetAt(i), "SLS_ContainerValue", -1)
		If Current < Lowest || Lowest == 0
			Loser = _SLS_TrackedContainerList.GetAt(i) as ObjectReference
			Lowest = Current
		EndIf
		i += 1
	EndWhile
	LowestValue = Lowest
	Return Loser
EndFunction

Int Function GetContainerAliasIndex(ObjectReference akContainer)
	Int i = 1 ; Stash aliases start at 1 not 0
	While i < _SLS_StashTrack.GetNumAliases()
		If (_SLS_StashTrack.GetNthAlias(i) as ReferenceAlias).GetReference() == akContainer
			return i
		EndIf
		i += 1
	EndWhile
	Return -1
EndFunction

Function AssignAlias (ObjectReference akContainer)
	ReferenceAlias NewRef
	If UsedAliasCount < _SLS_StashTrack.GetNumAliases() - 1 ; -1 because one alias is not a stash alias
		; Assign an empty alias
		NewRef = _SLS_StashTrack.GetNthAlias(GetContainerAliasIndex(None)) as ReferenceAlias
		NewRef.ForceRefTo(akContainer)
		UsedAliasCount += 1

	Else
		; Overwrite an existing alias
		NewRef = _SLS_StashTrack.GetNthAlias(GetContainerAliasIndex(LowestValueContainer)) as ReferenceAlias
		ObjectReference LoserObj = NewRef.GetReference()
		ClearObjStorageUtil(LoserObj)
		_SLS_TrackedContainerList.RemoveAddedForm(NewRef.GetReference())
		NewRef.ForceRefTo(akContainer)
		
	EndIf
	
	StorageUtil.SetIntValue(akContainer, "SLS_ContainerValue", GetContentsValue(akContainer))
	_SLS_TrackedContainerList.AddForm(akContainer)
	SLS_StashMonitor StashScript = NewRef as SLS_StashMonitor 
	StashScript.SetupContainer()
	
	LowestValueContainer = GetLowestValueContainer()
EndFunction

Function ClearObjStorageUtil(ObjectReference ToBeCleared)
	StorageUtil.UnSetIntValue(ToBeCleared, "SLS_ContainerValue")
	StorageUtil.FormListClear(ToBeCleared, "SLS_Peekaboo")
	StorageUtil.FormListClear(ToBeCleared, "SLS_InTheArea")
EndFunction

Int Function GetContentsValue(ObjectReference akDestContainer)
	If akDestContainer == None
		Return 0
	EndIf
	Int i = 0
	Int GoldTotal = 0
	Int NumItems = 0
	Form CurrentItem
	While i < akDestContainer.GetNumItems()
		CurrentItem = akDestContainer.GetNthForm(i)
		NumItems = akDestContainer.GetItemCount(CurrentItem)
		If CurrentItem == Gold001
				GoldTotal += NumItems
		Else
				GoldTotal += CurrentItem.GetGoldValue() * NumItems
		EndIf
		i += 1
	EndWhile
	Return GoldTotal
EndFunction

Function ToggleException(ObjectReference akDestContainer, Bool Silent = false)
	If StorageUtil.GetIntValue(akDestContainer, "_SLS_StashExceptionContainer", Missing = -1) <= 0 ; Add exception
		AddException(akDestContainer, Silent)
	Else ; Remove exception
		RemoveException(akDestContainer, Silent)
	EndIf
EndFunction

Function AddException(ObjectReference akDestContainer, Bool Silent = false)
	String Note = ""
	StorageUtil.SetIntValue(akDestContainer, "_SLS_StashExceptionContainer", 1)
	Int i = _SLS_StashTrack.GetNumAliases()
	While i > 1
		i -= 1
		If (_SLS_StashTrack.GetNthAlias(i) as SLS_StashMonitor).WhatIAm == akDestContainer
			(_SLS_StashTrack.GetNthAlias(i) as SLS_StashMonitor).SetContainerException()
		EndIf
	EndWhile
	StorageUtil.FormListAdd(None, "_SLS_StashExceptionsAll", akDestContainer, allowDuplicate = false)
	;Debug.Messagebox("Shift: " + Math.RightShift(Math.LogicalAnd(akDestContainer.GetFormID(), 0xFF000000), 24) + "\nNew: " + (Math.LogicalAnd(akDestContainer.GetFormID(), 0xFF000000) == 0xFF000000))
	If Math.LogicalAnd(akDestContainer.GetFormID(), 0xFF000000) != 0xFF000000
		JsonUtil.FormListAdd("SL Survival/StashExceptions.json", "StashExceptions", akDestContainer, allowDuplicate = false)
		JsonUtil.Save("SL Survival/StashExceptions.json")
	Else
		StorageUtil.FormListAdd(None, "_SLS_StashExceptionsTemp", akDestContainer, allowDuplicate = false)
		Note = "\n\nNote: This container is a dynamically created object and will not be saved to the json file because it's reference will not be the same in a different game"
	EndIf
	If !Silent
		Debug.Messagebox("Added stash exception!" + "\nakDestContainer: " + akDestContainer + Note)
	EndIf
EndFunction

Function RemoveException(ObjectReference akDestContainer, Bool Silent = false)
	StorageUtil.UnSetIntValue(akDestContainer, "_SLS_StashExceptionContainer")
	JsonUtil.FormListRemove("SL Survival/StashExceptions.json", "StashExceptions", akDestContainer, allInstances = true)
	StorageUtil.FormListRemove(None, "_SLS_StashExceptionsAll", akDestContainer, allInstances = true)
	StorageUtil.FormListRemove(None, "_SLS_StashExceptionsTemp", akDestContainer, allInstances = true)
	JsonUtil.Save("SL Survival/StashExceptions.json")
	If !Silent
		Debug.Messagebox("Removed stash exception!" + "\nakDestContainer: " + akDestContainer)
	EndIf
EndFunction

Function ImportStashExceptions()
	Int i = JsonUtil.FormListCount("SL Survival/StashExceptions.json", "StashExceptions")
	ObjectReference ObjRef
	While i > 0
		i -= 1
		ObjRef = JsonUtil.FormListGet("SL Survival/StashExceptions.json", "StashExceptions", i) as ObjectReference
		If ObjRef
			StorageUtil.SetIntValue(ObjRef, "_SLS_StashExceptionContainer", 1)
		EndIf
	EndWhile
EndFunction

Function AddContainerTracking(ObjectReference akContainer, Float TheftFreq = -1.0, Float ContSafety = -1.0)
	If !_SLS_TrackedContainerList.HasForm(akContainer)
		ContainerClosed(akContainer)
		ReferenceAlias StashAlias = GetStashAlias(akContainer)
		If StashAlias
			If TheftFreq != -1.0 || ContSafety != -1.0
				(StashAlias as SLS_StashMonitor).SetStashAttributes(TheftFreq, ContSafety)
			EndIf
		Else
			Debug.Trace("_SLS_: AddContainerTracking(): Attempted to add stash tracking to " + akContainer + " but it is not valuable enough to track")
		EndIf
	Else
		Debug.Trace("_SLS_: AddContainerTracking(): Container is already being tracked: " + akContainer)
	EndIf
EndFunction

Function StopTrackingContainer(ObjectReference akContainer)
	If _SLS_TrackedContainerList.HasForm(akContainer)
		ObjectReference ObjRef
		ReferenceAlias AliasSelect
		Int i = 1
		While i < _SLS_StashTrack.GetNumAliases()
			AliasSelect = (_SLS_StashTrack.GetNthAlias(i)) as ReferenceAlias
			ObjRef = ((_SLS_StashTrack.GetNthAlias(i)) as ReferenceAlias).GetReference()
			If AliasSelect.GetReference() == akContainer
				(AliasSelect as SLS_StashMonitor).StopTracking()
				ClearObjStorageUtil(akContainer)
				_SLS_TrackedContainerList.RemoveAddedForm(akContainer)
				AliasSelect.Clear()
				UsedAliasCount -= 1
				Return
			EndIf
			i += 1
		EndWhile
		Debug.Trace("_SLS_: StopTrackingContainer(): Could not find container alias for: " + akContainer)
	Else
		Debug.Trace("_SLS_: StopTrackingContainer(): Container is not being tracked: " + akContainer)
	EndIf
EndFunction

Function TerminateTracking()
	Int i = _SLS_StashTrack.GetNumAliases()
	ObjectReference ContainerRef
	While i > 1
		i -= 1
		ContainerRef = (_SLS_StashTrack.GetNthAlias(i) as SLS_StashMonitor).WhatIAm
		If ContainerRef
			ClearObjStorageUtil(ContainerRef)
		EndIf
	EndWhile
	_SLS_TrackedContainerList.Revert()
	_SLS_StashTrack.Stop()
EndFunction

Function ResetAllContainerDiscoverabilityVars()
	ObjectReference Stash
	Int i = 1
	While i < _SLS_StashTrack.GetNumAliases()
		Stash = (_SLS_StashTrack.GetNthAlias(i) as ReferenceAlias).GetReference()
		If Stash
			((_SLS_StashTrack.GetNthAlias(i) as ReferenceAlias) as SLS_StashMonitor).SetupContainer()
		EndIf
		i += 1
	EndWhile
EndFunction

Function ToggleTracking(ObjectReference akContainer)
	If _SLS_TrackedContainerList.HasForm(akContainer)
		Debug.Notification("Tracking stopped on: " + akContainer)
		StopTrackingContainer(akContainer)
	Else
		Debug.Notification("Tracking started on: " + akContainer)
		AddContainerTracking(akContainer)
	EndIf
EndFunction

ReferenceAlias Function GetStashAlias(ObjectReference Stash)
	Int i = 1
	ReferenceAlias AliasSelect
	While i < _SLS_StashTrack.GetNumAliases()
		AliasSelect = _SLS_StashTrack.GetNthAlias(i) as ReferenceAlias
		If AliasSelect.GetReference() && AliasSelect.GetReference() == Stash
			Return AliasSelect
		EndIf
		i += 1
	EndWhile
	Return None
EndFunction

; ==================================================

;/ Original values
Float LocFactorCity = 0.5
Float LocFactorTown = 0.6
Float LocFactorHabitation = 0.7
Float LocFactorDungeonInt = 0.6
Float LocFactorDungeonIntCleared = 0.8
Float LocFactorDungeonOutside = 0.9
Float LocFactorWilderness = 1.0

Float TheftFreqCity = 6.0
Float TheftFreqTown = 8.0
Float TheftFreqHabitation = 12.0
Float TheftFreqDungeon = 12.0
Float TheftFreqClearedDungeon = 24.0
Float TheftFreqWilderness = 48.0

Float ContTypeNormal = 0.5
Float ContTypeHB = 1.0
/;

Float LocFactorCity = 0.25
Float LocFactorTown = 0.3
Float LocFactorHabitation = 0.35
Float LocFactorDungeonInt = 0.5
Float LocFactorDungeonIntCleared = 0.7
Float LocFactorDungeonOutside = 0.8
Float LocFactorWilderness = 1.0

Float TheftFreqCity = 0.5
Float TheftFreqTown = 1.0
Float TheftFreqHabitation = 1.0
Float TheftFreqDungeon = 2.0
Float TheftFreqClearedDungeon = 5.0
Float TheftFreqWilderness = 8.0

Float ContTypeNormal = 0.5
Float ContTypeHB = 1.0

Function LoadStashVariables()
	LocFactorCity = 0.25
	LocFactorTown = 0.3
	LocFactorHabitation = 0.35
	LocFactorDungeonInt = 0.5
	LocFactorDungeonIntCleared = 0.7
	LocFactorDungeonOutside = 0.8
	LocFactorWilderness = 1.0

	TheftFreqCity = 0.5
	TheftFreqTown = 1.0
	TheftFreqHabitation = 1.0
	TheftFreqDungeon = 2.0
	TheftFreqClearedDungeon = 5.0
	TheftFreqWilderness = 8.0

	ContTypeNormal = 0.5
	ContTypeHB = 1.0
EndFunction

Float Function GetRoadFactor(ObjectReference akRef)
	; Road Factor: Distance to the nearest road. Further from busy roads = better
	Float RoadDist = Menu.RoadDist
	ObjectReference Road = Game.FindClosestReferenceOfAnyTypeInListFromRef(_SLS_RoadObjects, akRef, Menu.RoadDist)
	If Road
		;Debug.Messagebox("Road found: " + Road + "\nDistance: " + PlayerRef.GetDistance(Road))
		RoadDist = akRef.GetDistance(Road)
	EndIf
	Return (RoadDist / Menu.RoadDist)
EndFunction

Float Function GetContainerFactor(ObjectReference akRef)
	; Container factor: Only factor now is if the container is a hunterborn 'disguised' cache
	If !Menu.ContTypeCountsT
		Return ContTypeHB
	ElseIf Init.HunterbornInstalled && akRef.GetBaseObject() == Init.HuntersCache
		Return ContTypeHB
	EndIf
	Return ContTypeNormal
EndFunction

Float Function GetLocTypeFactor(ObjectReference akRef)
	Location kCurrentLoc = akRef.GetCurrentLocation()
	If kCurrentLoc
		If kCurrentLoc.HasKeyword(LocTypeCity)
			Return LocFactorCity
		ElseIf kCurrentLoc.HasKeyword(LocTypeTown) || kCurrentLoc.HasKeyword(LocTypeDwelling)
			Return LocFactorTown
		ElseIf kCurrentLoc.HasKeyword(LocTypeHabitation) || kCurrentLoc.HasKeyword(LocTypeSettlement)
			Return LocFactorHabitation
		ElseIf kCurrentLoc.HasKeyword(LocTypeDungeon)
			If akRef.IsInInterior()
				If kCurrentLoc.IsCleared()
					Return LocFactorDungeonIntCleared
				Else
					Return LocFactorDungeonInt
				EndIf
			Else
				Return LocFactorDungeonOutside
			EndIf
		EndIf
	EndIf
	Return LocFactorWilderness
EndFunction

Float Function GetTheftFreq(Float LocFactor)
	If LocFactor == LocFactorCity
		Return TheftFreqCity
	ElseIf LocFactor == LocFactorTown || LocFactor == LocFactorDungeonInt
		Return TheftFreqTown
	ElseIf LocFactor == LocFactorHabitation || LocFactor == LocFactorDungeonInt
		Return TheftFreqHabitation
	ElseIf LocFactor == LocFactorDungeonIntCleared || LocFactor == LocFactorDungeonOutside
		Return TheftFreqClearedDungeon
	Else
		Return TheftFreqWilderness
	EndIf	
EndFunction

String Function GetStashDescription()
	ObjectReference ObjRef = Game.GetCurrentCrosshairRef()
	If StorageUtil.GetIntValue(ObjRef, "_SLS_StashExceptionContainer", Missing = -1) <= 0
		
		String S1
		String S2
		String S3
		
		; Container factor: Only factor now is if the container is a hunterborn 'disguised' cache
		If ObjRef && ObjRef.GetBaseObject() as Container
			If GetContainerFactor(ObjRef) <= ContTypeNormal
				S1 = "This stash is pretty obvious. "
			Else
				S1 = "This stash is well hidden. "
			EndIf
		Else
			ObjRef = PlayerRef
		EndIf
		
		; Road factor description: Distance to the nearest road. Further from busy roads = better
		If !ObjRef.IsInInterior()
			Float RoadFactor = GetRoadFactor(ObjRef)
			If RoadFactor < 0.5
				S3 = " and the road is too close."
			ElseIf RoadFactor < 1.0
				S3 = " and the road is fairly close."
			Else
				S3 = " and there are no roads nearby."
			EndIf
		ElseIf ObjRef.GetCurrentLocation().IsCleared()
			S3 = " and someone is bound to come around eventually"
		Else
			S3 = ". This place is not safe."
		EndIf

		; Location type factor description
		Float LocTypeFactor = GetLocTypeFactor(ObjRef)
		If LocTypeFactor <= LocFactorTown
			s2 = "There are a lot of eyes around here."
		ElseIf LocTypeFactor <= LocFactorDungeonInt
			S2 = "It's quite busy here"
		ElseIf LocTypeFactor <= LocFactorDungeonOutside
			S2 = "There are signs of footprints here"
		Else
			S2 = "It's fairly remote here"
		EndIf

		Return S1 + S2 + S3
	
	Else
		Return "This stash is safe"
	EndIf
EndFunction

ObjectReference LastContainer
;ObjectReference CrosshairContainer

Int ItemCount
Int GoldValue
Bool QueueUpdate = false

Int UsedAliasCount = 0

; Plug alias scripts into these 2
ObjectReference Property LowestValueContainer Auto Hidden
Int Property LowestValue = 0 Auto Hidden

Keyword Property LocTypePlayerHouse Auto
Keyword Property LocTypeDwelling Auto
Keyword Property LocTypeHabitation Auto
Keyword Property LocTypeSettlement Auto
Keyword Property LocTypeTown Auto
Keyword Property LocTypeCity Auto
Keyword Property LocTypeDungeon Auto

MiscObject Property Gold001 Auto

Actor Property PlayerRef Auto

Quest Property _SLS_PryingEyes Auto
Quest Property _SLS_StashTrack Auto
Quest Property _SLS_StashAddExceptionQuest Auto

ReferenceAlias Property _SLS_StashMonitor01 Auto
ReferenceAlias Property _SLS_StashMonitor02 Auto
ReferenceAlias Property _SLS_StashMonitor03 Auto

Formlist Property _SLS_TrackedContainerList Auto
Formlist Property _SLS_RoadObjects Auto

Container Property _SLS_EvictionConfiscatedChest Auto

SLS_Init Property Init Auto
SLS_Mcm Property Menu Auto
