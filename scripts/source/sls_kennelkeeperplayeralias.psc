Scriptname SLS_KennelKeeperPlayerAlias extends ReferenceAlias

Event OnInit()
	
EndEvent

Function TrapSleepEvents()
	RegisterForSleep()
	RegisterForMenu("Sleep/Wait Menu")
EndFunction

Event OnMenuClose(String MenuName)
	UnregisterForSleep()
	UnregisterForAllMenus()
EndEvent

Event OnSleepStart(float afSleepStartTime, float afDesiredSleepEndTime)
	Bool IsInKennel = true
	If PlayerRef.GetCurrentLocation().IsSameLocation(_SLS_KennelWhiterunLocation)
		Bool IsPlayerSleeping = true
		Int StartTime = Math.Floor(GameHour.GetValue())
		_SLS_PlayerSleepMarker.MoveTo(PlayerRef)
		If !IsCellBed || !CellDoor.IsLocked()
			While Math.Floor(GameHour.GetValue()) == StartTime && IsPlayerSleeping && IsInKennel
				Utility.WaitMenuMode(0.2)
				If !PlayerRef.GetCurrentLocation().IsSameLocation(_SLS_KennelWhiterunLocation)
					Debug.Trace("_SLS_: Player is not in the kennel any more (WAIT). Unregistering for events")
					SendModEvent("dhlp-Resume")
					OnMenuClose("")
					IsInKennel = false
				EndIf
				If Math.Floor(GameHour.GetValue()) != StartTime && IsInKennel
					If Utility.RandomFloat(1.0, 100.0) < (Menu.KennelRapeChancePerHour + IncreasedRapeChance)
						IsPlayerSleeping = false
						_SLS_PlayerSleepMarker.MoveTo(PlayerRef)
						PlayerRef.MoveTo(_SLS_PlayerSleepMarker)
						Game.ForceFirstPerson()
						SleepyTimeFadeIn.Apply()
						PlayerRef.PlayIdle(Idle_1stPersonWoozyGetUpFromBed)
						IncreasedRapeChance = 0.0
						If !Init.KennelForceGreetIntroDone
							KeeperRape()
						ElseIf Init.SlsCreatureEvents
							If Utility.RandomFloat(0.0, 100.0) > Menu.KennelCreatureChance
								KeeperRape()
							
							Else
								CreatureRape()
								
							EndIf
						Else
							KeeperRape()
						EndIf
					Else
						IncreasedRapeChance += 5.0
					EndIf
				EndIf
				StartTime = Math.Floor(GameHour.GetValue())
			EndWhile
		EndIf
		
	Else
		;Debug.Messagebox("IS NOT in kennel\nPlayerLocation: " + PlayerRef.GetCurrentLocation() + "\nKennel: " + _SLS_KennelWhiterunLocation)
		Debug.Trace("_SLS_: Player is not in the kennel any more (OnSleepStart). Unregistering for events")
		SendModEvent("dhlp-Resume")
		OnMenuClose("")
	EndIf
EndEvent

Event OnSleepStop(bool abInterrupted)
	Utility.Wait(2.0) ; Wait for SD etc to teleport player
	If PlayerRef.GetCurrentLocation().IsSameLocation(_SLS_KennelWhiterunLocation)		
		If IsCellBed
			;Needs.Modfatigue(-30)
			Debug.Notification("Despite having your own cell you still have trouble sleeping with the sounds and smells")
		Else
			;Needs.Modfatigue(-60)
			Debug.Notification("It's difficult to sleep here and your body is covered in globs of dog drool")
			Frostfall.ModWetness(500)
		EndIf
		
	Else
		Debug.Trace("_SLS_: Player is not in the kennel any more (OnSleepStop). Unregistering for events")
		SendModEvent("dhlp-Resume")
		OnMenuClose("")
	EndIf
EndEvent

Event OnAnimationEnd(int tid, bool HasPlayer)
	If HasPlayer
		KennelKeeper.MoveTo(KennelEntrance)
		If IsCellBed && !CellDoor.IsLocked()
			Debug.Notification("You should probably lock the door if you don't want to get raped")
		EndIf
		UnregisterForModEvent("HookAnimationEnd")
	EndIf
EndEvent

Function KeeperRape()
	PreviousKennelState = Init.KennelState
	If Init.KennelState != 6
		If Init.KennelForceGreetIntroDone
			Init.KennelState = 5
		Else
			Init.KennelState = 4
		EndIf
	EndIf
	_SLS_KennelGateUnlock.Play((KennelKeeper as SLS_KennelKeeper).LinkedGate)
	Debug.Notification("You hear the kennel gate open and close again")
	KennelKeeper.MoveTo(_SLS_KeeperRapeMarker)
	KeeperRapeAlias.ForceRefTo(KennelKeeper)
	(KennelKeeper as Actor).EvaluatePackage()
EndFunction

Function KeeperSex()
	RegisterForModEvent("HookAnimationEnd", "OnAnimationEnd")
	StorageUtil.SetFloatValue(KennelKeeper, "SLAroused.ActorExposure", Utility.RandomFloat(60.0, 100.0))
	Int RanInt = Utility.RandomInt(1, 3)
	If RanInt == 1
		Main.StartSexOralMale(KennelKeeper as Actor, SexCat = 3, DecWillIncFame = true, Victim = none, TeleportType = 0)
	ElseIf RanInt == 2
		Main.StartSexVaginal(KennelKeeper as Actor, SexCat = 3, DecWillIncFame = true, Victim = none, TeleportType = 0)
	Else
		Main.StartSexAnal(KennelKeeper as Actor, SexCat = 3, DecWillIncFame = true, Victim = none, TeleportType = 0)
	EndIf
EndFunction

Function CreatureRape()
	Debug.Notification("You slowly come around as you realize you've been mounted while you slept")
	Main.UpdateBeggingDialogFactors(KennelKeeper as Actor)
	
	Int RanInt
	If (Init.BeggingDogsFound > 0 || Init.BeggingWolvesFound > 0) && Init.BeggingHorsesFound > 0
		RanInt = Utility.RandomInt(0,1)
	ElseIf (Init.BeggingDogsFound > 0 || Init.BeggingWolvesFound > 0)
		RanInt = 0
	ElseIf Init.BeggingHorsesFound > 0
		RanInt = 1
	EndIf
	
	If RanInt == 0
		If Init.BeggingDogsFound > 0 && Init.BeggingWolvesFound > 0
			RanInt = Utility.RandomInt(0, 1)
			If RanInt == 0
				DoDog()
			Else
				DoWolf()
			EndIf
		ElseIf Init.BeggingDogsFound > 0
			DoDog()
		ElseIf Init.BeggingWolvesFound > 0
			DoWolf()
		EndIf
	ElseIf RanInt == 1
		DoHorse()
	EndIf
EndFunction

Function DoDog()
	Int RanInt
	If Init.BeggingDogsFound > 1 && Init.DogGangbangAnims >= 1
		RanInt = Utility.RandomInt(0, 3)
	Else
		RanInt = Utility.RandomInt(0, 2)
	EndIf
	
	If RanInt == 0
		Main.StartDogSexOral(KennelKeeper as Actor, SexCat = 3, DecWillIncFame = true, Victim = none, TeleportType = 0)
	ElseIf RanInt == 1
		Main.StartDogSexVaginal(KennelKeeper as Actor, SexCat = 3, DecWillIncFame = true, Victim = none, TeleportType = 0)
	ElseIf RanInt == 2
		Main.StartDogSexAnal(KennelKeeper as Actor, SexCat = 3, DecWillIncFame = true, Victim = none, TeleportType = 0)
	ElseIf RanInt == 3
		Main.StartDogSex3p(KennelKeeper as Actor, SexCat = 3, DecWillIncFame = true, Victim = none, TeleportType = 0)
	EndIf
EndFunction

Function DoWolf()
	Int RanInt
	If Init.BeggingWolvesFound > 1 && Init.WolfGangbangAnims >= 1
		RanInt = Utility.RandomInt(0, 3)
	Else
		RanInt = Utility.RandomInt(0, 2)
	EndIf
	
	If RanInt == 0
		Main.StartWolfSexOral(KennelKeeper as Actor, SexCat = 3, DecWillIncFame = true, Victim = none, TeleportType = 1)
	ElseIf RanInt == 1
		Main.StartWolfSexVaginal(KennelKeeper as Actor, SexCat = 3, DecWillIncFame = true, Victim = none, TeleportType = 1)
	ElseIf RanInt == 2
		Main.StartWolfSexAnal(KennelKeeper as Actor, SexCat = 3, DecWillIncFame = true, Victim = none, TeleportType = 1)
	ElseIf RanInt == 3
		Main.StartWolfSex3p(KennelKeeper as Actor, SexCat = 3, DecWillIncFame = true, Victim = none, TeleportType = 1)
	EndIf
EndFunction

Function DoHorse()
	Int RanInt
	If Init.BeggingHorsesFound > 1 && Init.HorseGangbangAnims >= 1
		RanInt = Utility.RandomInt(0, 3)
	Else
		RanInt = Utility.RandomInt(0, 2)
	EndIf
	
	If RanInt == 0
		Main.StartHorseSexOral(KennelKeeper as Actor, SexCat = 3, DecWillIncFame = true, Victim = none, TeleportType = 1)
	ElseIf RanInt == 1
		Main.StartHorseSexVaginal(KennelKeeper as Actor, SexCat = 3, DecWillIncFame = true, Victim = none, TeleportType = 1)
	ElseIf RanInt == 2
		Main.StartHorseSexAnal(KennelKeeper as Actor, SexCat = 3, DecWillIncFame = true, Victim = none, TeleportType = 1)
	ElseIf RanInt == 3
		Main.StartHorseSex3p(KennelKeeper as Actor, SexCat = 3, DecWillIncFame = true, Victim = none, TeleportType = 1)
	EndIf
EndFunction

Int PreviousKennelState

Float IncreasedRapeChance = 0.0

Bool Property IsCellBed Auto Hidden

Actor Property PlayerRef Auto

GlobalVariable Property GameHour Auto

ObjectReference Property KennelKeeper Auto
ObjectReference Property KennelEntrance Auto
ObjectReference Property _SLS_KeeperRapeMarker Auto
ObjectReference Property _SLS_PlayerSleepMarker Auto
ObjectReference Property CellDoor Auto

Location Property _SLS_KennelWhiterunLocation Auto

ReferenceAlias Property KeeperRapeAlias Auto

Sound Property _SLS_KennelGateUnlock Auto

ImageSpaceModifier Property SleepyTimeFadeIn Auto

Idle Property Idle_1stPersonWoozyGetUpFromBed Auto

SLS_Mcm Property Menu Auto
SLS_Init Property Init Auto
SLS_Main Property Main Auto
_SLS_InterfaceFrostfall Property Frostfall Auto
