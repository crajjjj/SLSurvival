Scriptname SLS_RestAnywhereTrack extends ReferenceAlias  

Event OnInit()
	RegisterForSleep()
EndEvent

Event OnSleepStart(float afSleepStartTime, float afDesiredSleepEndTime)
	If (StorageUtil.GetIntValue(PlayerRef, "_SD_iSleepAnywhereON", Missing = 0) == 1 || StorageUtil.GetIntValue(PlayerRef, "_SLS_SleepingRough", Missing = 0) == 1) && Init.IsPlayerInside && !PlayerRef.IsInInterior()
		Debug.Notification("Player is sleeping rough in the city")
		
		; I'm just assuming there's a guard here because the quest to search for a guard won't start in menu mode :S
		_SLS_PlayerSleepMarker.MoveTo(PlayerRef)
		PlayerRef.MoveTo(_SLS_PlayerSleepMarker)
		_SLS_RestDisturbApproach.SetValueInt(0)
		_SLS_RestAnywhereDisturb.Start()	
		
		Actor Guard = GetGuard()
		If !Guard ; If no guards were found, shut down quest.
			_SLS_RestAnywhereDisturb.Stop()
			;Debug.MessageBox("SLS_: Detected player sleeping rough in city but no nearby guards")
			Debug.Trace("SLS_: Rest anywhere - No guards found. Shutting down")
		Else ; Else disturb player
			_SLS_PlayerSleepMarker.MoveTo(PlayerRef)
			PlayerRef.MoveTo(_SLS_PlayerSleepMarker)
			Debug.Notification("Someone is approaching")
			SleepyTimeFadeIn.Apply()
			Utility.Wait(0.5)
			
			Input.TapKey(Input.GetMappedKey("Jump"))
			
			;/
			Game.ForceFirstPerson()
			PlayerRef.PlayIdle(Idle_1stPersonWoozyGetUpFromBed)/;
			Utility.Wait(2.0)
			Guard.MoveTo(PlayerRef, afXOffset = 64.0)
			_SLS_RestDisturbApproach.SetValueInt(1)
			Guard.EvaluatePackage()
			RegisterForSingleUpdateGameTime(12.0)
		EndIf
	EndIf
EndEvent

Event OnUpdateGameTime()
	Init.SleepRoughWarning = false
EndEvent

Actor Function GetGuard()
	Int i = 0
	Actor Guard
	While i < 5
		Guard = (_SLS_RestAnywhereDisturb.GetNthAlias(i) as ReferenceAlias).GetReference() as Actor
		If Guard
			Return Guard
		EndIf
		i += 1
	EndWhile
	Return None
EndFunction

SLS_Init Property Init Auto
Actor Property PlayerRef Auto
Quest Property _SLS_RestAnywhereDisturb Auto
ObjectReference Property _SLS_PlayerSleepMarker Auto
ImageSpaceModifier Property SleepyTimeFadeIn Auto
Idle Property Idle_1stPersonWoozyGetUpFromBed Auto
GlobalVariable Property _SLS_RestDisturbApproach Auto
