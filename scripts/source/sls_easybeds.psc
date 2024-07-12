Scriptname SLS_EasyBeds extends ReferenceAlias

Function TrapSleepEvents()
	RegisterForSleep()
	RegisterForMenu("Sleep/Wait Menu")
	Debug.Messagebox("You have a sneaking suspicion the others are up to something. ")
EndFunction

Event OnSleepStart(float afSleepStartTime, float afDesiredSleepEndTime)
	IsPlayerSleeping = true
	Int StartTime = Math.Floor(GameHour.GetValue())
	_SLS_PlayerSleepMarker.MoveTo(PlayerRef)
	
	While Math.Floor(GameHour.GetValue()) == StartTime && IsPlayerSleeping
		Utility.WaitMenuMode(0.2)
		If Math.Floor(GameHour.GetValue()) != StartTime
			If Init.DclInstalled
				If Utility.RandomFloat(1.0, 100.0) > 75.0
					IsPlayerSleeping = false
					PlayerRef.MoveTo(_SLS_PlayerSleepMarker)
					SleepyTimeFadeIn.Apply()
					;FadeToBlackHoldImod.Apply()
					If Utility.RandomFloat(1.0, 100.0) > 50.0
						SendModEvent("dcur-triggerbondageadventure")
					Else
						SendModEvent("dcur-triggerleaveinwilderness")
					EndIf
				EndIf
			Else
			
			EndIf
		EndIf
		StartTime = Math.Floor(GameHour.GetValue())
	EndWhile

	If Init.DclInstalled
		Int Count = 0
		While PlayerRef.GetCurrentLocation().IsSameLocation(_SLS_PlayerSleepMarker.GetCurrentLocation()) && Count < 45 ; Give DCL 90 seconds to move player
			Utility.Wait(2.0)
			Count += 1
		EndWhile
		
		If Count < 20
			FadeToBlackHoldImod.Remove()
			SleepyTimeFadeIn.Apply()
			PlayerRef.PlayIdle(Idle_1stPersonWoozyGetUpFromBed)
		Else
			Debug.Trace("SLS_: EasyBed event aborted - timeout")
		EndIf
	EndIf
	
EndEvent

Event OnSleepStop(bool abInterrupted)
	IsPlayerSleeping = false
	UnRegisterForSleep()
	UnRegisterForMenu("Sleep/Wait Menu")
EndEvent

Event OnMenuClose(String MenuName)
	UnRegisterForSleep()
	UnRegisterForMenu("Sleep/Wait Menu")
EndEvent

ImageSpaceModifier Property FadeToBlackHoldImod Auto
ImageSpaceModifier Property SleepyTimeFadeIn Auto
Idle Property Idle_1stPersonWoozyGetUpFromBed Auto
Bool Property IsPlayerSleeping = false Auto
ObjectReference Property _SLS_PlayerSleepMarker Auto
Actor Property PlayerRef Auto
GlobalVariable Property GameHour Auto
SLS_Init Property Init Auto
