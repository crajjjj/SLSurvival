Scriptname SLS_EvictionSleepTrack extends ReferenceAlias

Event OnInit()
	RegisterForSleep()
EndEvent

Event OnSleepStart(float afSleepStartTime, float afDesiredSleepEndTime)
	Location PlayerLocation = PlayerRef.GetCurrentLocation()
	If PlayerLocation
		If PlayerLocation.HasKeyword(LocTypePlayerHouse)

			EvictionTrack.UpdateEvictions()
			
			; Whiterun
			If WhiterunBreezehomeLocation.IsSameLocation(PlayerLocation) && EvictionTrack.IsBarredWhiterun
				(_SLS_EvictionTossOut.GetAliasByName("DoorToTossOut") as ReferenceAlias).ForceRefTo(WhiterunDoor)
				(_SLS_EvictionTossOut.GetAliasByName("EvictionChest") as ReferenceAlias).ForceRefTo(EvictionChestWhiterun)
				_SLS_DoorBangMarker.Play(WhiterunDoor)
				EvictionTrack.EvictWhiterun(true)
				Evict(_SLS_EvictionGuardMarkerWhiterun)

			; Solitude
			ElseIf SolitudeProudspireManorLocation.IsSameLocation(PlayerLocation) && EvictionTrack.IsBarredSolitude
				(_SLS_EvictionTossOut.GetAliasByName("DoorToTossOut") as ReferenceAlias).ForceRefTo(SolitudeDoor)
				(_SLS_EvictionTossOut.GetAliasByName("EvictionChest") as ReferenceAlias).ForceRefTo(EvictionChestSolitude)
				_SLS_DoorBangMarker.Play(SolitudeDoor)
				EvictionTrack.EvictSolitude(true)
				Evict(_SLS_EvictionGuardMarkerSolitude)
				
			; Markarth
			ElseIf MarkarthVlindrelHallLocation.IsSameLocation(PlayerLocation) && EvictionTrack.IsBarredMarkarth
				(_SLS_EvictionTossOut.GetAliasByName("DoorToTossOut") as ReferenceAlias).ForceRefTo(MarkarthDoor)
				(_SLS_EvictionTossOut.GetAliasByName("EvictionChest") as ReferenceAlias).ForceRefTo(EvictionChestMarkarth)
				_SLS_DoorBangMarker.Play(MarkarthDoor)
				EvictionTrack.EvictMarkarth(true)
				Evict(_SLS_EvictionGuardMarkerMarkarth)
				
			; Windhelm
			ElseIf WindhelmHjerimLocation.IsSameLocation(PlayerLocation) && EvictionTrack.IsBarredWindhelm
				(_SLS_EvictionTossOut.GetAliasByName("DoorToTossOut") as ReferenceAlias).ForceRefTo(WindhelmDoor)
				(_SLS_EvictionTossOut.GetAliasByName("EvictionChest") as ReferenceAlias).ForceRefTo(EvictionChestWindhelm)
				_SLS_DoorBangMarker.Play(WindhelmDoor)
				EvictionTrack.EvictWindhelm(true)
				Evict(_SLS_EvictionGuardMarkerWindhelm)
				
			; Riften
			ElseIf RiftenHoneysideLocation.IsSameLocation(PlayerLocation) && EvictionTrack.IsBarredRiften
				(_SLS_EvictionTossOut.GetAliasByName("DoorToTossOut") as ReferenceAlias).ForceRefTo(RiftenDoor)
				(_SLS_EvictionTossOut.GetAliasByName("EvictionChest") as ReferenceAlias).ForceRefTo(EvictionChestRiften)
				_SLS_DoorBangMarker.Play(RiftenDoor)
				EvictionTrack.EvictRiften(true)
				Evict(_SLS_EvictionGuardMarkerRiften)
				
			EndIf
		EndIf
	EndIf
EndEvent

Function Evict(ObjectReference PlaceMarker)
	Game.DisablePlayerControls(!Game.IsMovementControlsEnabled(), !Game.IsFightingControlsEnabled(), !Game.IsCamSwitchControlsEnabled(), !Game.IsLookingControlsEnabled(), !Game.IsSneakingControlsEnabled(), true, true, !Game.IsJournalControlsEnabled())
	_SLS_PlayerSleepMarker.MoveTo(PlayerRef)
	PlayerRef.MoveTo(_SLS_PlayerSleepMarker)
	Game.ForceFirstPerson()
	SleepyTimeFadeIn.Apply()
	PlayerRef.PlayIdle(Idle_1stPersonWoozyGetUpFromBed)
	Debug.Notification("You're awoken by a cresendo of banging and shouting")
	Init.EvictionForceGreetDone = false
	Actor[] Guards = PlaceGuards(PlaceMarker)
	(_SLS_EvictionTossOut.GetAliasByName("PlayerAlias") as ReferenceAlias).ForceRefTo(PlayerRef)
	Utility.Wait(5.0)
	_SLS_EvictionTossOut.Start()
	Int i = 0
	While i < Guards.Length
		(_SLS_EvictionTossOut.GetNthAlias(i) as ReferenceAlias).ForceRefTo(Guards[i])
		Guards[i].EvaluatePackage()
		i += 1
	EndWhile
EndFunction

Actor[] Function PlaceGuards(ObjectReference PlaceMarker)
	Actor[] Guards = new Actor[3]
	
	; Build a list of guards to pull x unique guards from
	Int i = 0
	While i < _SLS_TollGuards.GetSize() - 1
		_SLS_GuardListEmpty.AddForm(_SLS_TollGuards.GetAt(i))
		i += 1
	EndWhile
	
	; Place guards at given marker
	i = 0
	While i < Guards.Length
		Int j = Utility.RandomInt(0, _SLS_GuardListEmpty.GetSize() - 1)
		Guards[i] = PlaceMarker.PlaceActorAtMe(_SLS_GuardListEmpty.GetAt(j) as ActorBase)
		_SLS_GuardListEmpty.RemoveAddedForm(_SLS_GuardListEmpty.GetAt(j))
		i += 1
	EndWhile
	_SLS_GuardListEmpty.Revert()
	Return Guards
EndFunction

Function CleanUp()
	Game.EnablePlayerControls(!Game.IsMovementControlsEnabled(), !Game.IsFightingControlsEnabled(), !Game.IsCamSwitchControlsEnabled(), !Game.IsLookingControlsEnabled(), !Game.IsSneakingControlsEnabled(), true, true, !Game.IsJournalControlsEnabled())
	UnregisterForAllMenus()
	;Game.EnablePlayerControls(!Game.IsMovementControlsEnabled(), !Game.IsFightingControlsEnabled(), !Game.IsCamSwitchControlsEnabled(), !Game.IsLookingControlsEnabled(), !Game.IsSneakingControlsEnabled(), Game.IsMenuControlsEnabled(), true, !Game.IsJournalControlsEnabled())
	Game.ForceFirstPerson()
	SleepyTimeFadeIn.Apply()
	PlayerRef.PlayIdle(Idle_1stPersonWoozyGetUpFromBed)
	Debug.Notification("They've already boarded up your door and gone. You hear them laughing in the distance")
	Int i = 0
	Actor Guard
	While i < 3
		Guard = (_SLS_EvictionTossOut.GetNthAlias(i) as ReferenceAlias).GetReference() as Actor
		Guard.Disable()
		Guard.DeleteWhenAble()
		i += 1
	EndWhile
	_SLS_EvictionTossOut.Stop()
EndFunction

Actor Property PlayerRef Auto

Keyword Property LocTypePlayerHouse Auto

FormList Property _SLS_TollGuards Auto
FormList Property _SLS_GuardListEmpty Auto

Location Property WhiterunBreezehomeLocation Auto
Location Property SolitudeProudspireManorLocation Auto
Location Property MarkarthVlindrelHallLocation Auto
Location Property WindhelmHjerimLocation Auto
Location Property RiftenHoneysideLocation Auto

ImageSpaceModifier Property SleepyTimeFadeIn Auto

Idle Property Idle_1stPersonWoozyGetUpFromBed Auto

Sound Property _SLS_DoorBangMarker Auto

ObjectReference Property _SLS_PlayerSleepMarker Auto

ObjectReference Property WhiterunDoor Auto
ObjectReference Property SolitudeDoor Auto
ObjectReference Property MarkarthDoor Auto
ObjectReference Property WindhelmDoor Auto
ObjectReference Property RiftenDoor Auto

ObjectReference Property EvictionChestWhiterun Auto
ObjectReference Property EvictionChestSolitude Auto
ObjectReference Property EvictionChestMarkarth Auto
ObjectReference Property EvictionChestWindhelm Auto
ObjectReference Property EvictionChestRiften Auto

ObjectReference Property _SLS_EvictionGuardMarkerWhiterun Auto
ObjectReference Property _SLS_EvictionGuardMarkerSolitude Auto
ObjectReference Property _SLS_EvictionGuardMarkerMarkarth Auto
ObjectReference Property _SLS_EvictionGuardMarkerWindhelm Auto
ObjectReference Property _SLS_EvictionGuardMarkerRiften Auto

Quest Property _SLS_EvictionTossOut Auto

SLS_EvictionTrack Property EvictionTrack Auto
SLS_Init Property Init Auto