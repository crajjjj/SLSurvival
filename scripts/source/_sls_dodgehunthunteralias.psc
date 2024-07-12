Scriptname _SLS_DodgeHuntHunterAlias extends ReferenceAlias  

Function SetupHunter()
	;Debugging = false
	RegisterForControl("Activate")
	RegisterForModEvent("_SLS_UpdateTollHunterPackage", "On_SLS_UpdateTollHunterPackage")
	Hunter = Self.GetReference() as Actor
	;If Debugging
	;	Debug.Messagebox("Setup hunter: " + Hunter)
	;EndIf
	RegisterForSingleUpdate(0.1)
EndFunction


Event OnControlDown(string control)
	If Hunter
		Location OldLocation = PlayerRef.GetCurrentLocation()
		ObjectReference ThisDoor = Game.GetCurrentCrosshairRef()
		If ThisDoor
			If ThisDoor.GetBaseObject() as Door
				;Debug.Messagebox("Is door")
				If Hunter.HasLos(PlayerRef) ;PlayerRef.IsDetectedBy(Hunter)
					DodgeHunt.SawPlayerChangeCell = true
					;Debug.Messagebox(Hunter + " saw player leave")
					Utility.Wait(2.0) ; Wait for door to animate
					If !OldLocation.IsSameLocation(PlayerRef.GetCurrentLocation()) ; Was transition door
						DodgeHunt.SawPlayerChangeCell = true
						Hunter.EvaluatePackage()
						Utility.Wait(3.0)
						DodgeHunt.SawPlayerChangeCell = false
						
					Else
						DodgeHunt.SawPlayerChangeCell = false
					EndIf
					
				;Else
					;Debug.Messagebox(Hunter + " did not see player leave")
				EndIf
					
			;Else
			;	Debug.Messagebox("Is NOT door")
			EndIf
		EndIf		
	EndIf
EndEvent


Event OnUpdate()
	If Hunter
		If PlayerRef.IsDetectedBy(Hunter)
			;Debug.Messagebox(Hunter.GetVoiceType())
			DetectionCount += 1
			DetectionAtZeroCount = 0
			Hunter.EvaluatePackage()
			;If Debugging
			;	Debug.Messagebox("Detected. Count: " + DodgeHunt.DetectionCount + "\nPackage: " + Hunter.GetCurrentPackage() + "\nDistance: " + PlayerRef.GetDistance(Hunter) + "\nLOS: " + Hunter.HasLos(PlayerRef) + "\nHunter: " + Hunter)
			;EndIf
			If DetectionCount == 1
				SaySomething(_SLS_TollDodgeHuhTopic)
			ElseIf DetectionCount == 2
				SaySomething(_SLS_TollDodgeOverHereTopic)
			ElseIf DetectionCount >= 3
				SaySomething(_SLS_TollDodgeGetHerTopic)
			EndIf

		Else
			DetectionCount -= 1
			If DetectionCount <= 0
				DetectionCount = 0
				DetectionAtZeroCount += 1
				If Utility.RandomFloat(0.0, 100.0) > 50.0
					Hunter.Say(_SLS_TollDodgeWhereAreYou)
				EndIf
			EndIf

			;If Debugging
			;	Debug.Messagebox("Not Detected\nPackage: " + Hunter.GetCurrentPackage())
			;EndIf
		EndIf
		If DetectionCount > 50 || DetectionAtZeroCount > 10
			;If Debugging
			;	Debug.Messagebox("Hunter could not catch up to player - timeout")
			;EndIf
			;Hunter.Say(_SLS_TollDodgeGiveUpSearch)
			UnRegisterForUpdate()
			Self.Clear()
			DodgeHunt.HunterSlotUsage -= 1
			Return
			;GoToState("")
		EndIf
		RegisterForSingleUpdate(3.0)
	EndIf
EndEvent

Event On_SLS_UpdateTollHunterPackage()
	If Hunter
		Hunter.EvaluatePackage()
	EndIf
EndEvent

Function SaySomething(Topic WhatToSay)
	If WhatToSay == LastTopic
		If TopicCooloff < 1
			Hunter.Say(WhatToSay)
			LastTopic = WhatToSay
		EndIf
		
	Else
		Hunter.Say(WhatToSay)
		LastTopic = WhatToSay
		TopicCooloff = 3
	EndIf
EndFunction

Actor Hunter
Topic LastTopic
Int TopicCooloff

Int Property DetectionCount = 0 Auto Hidden
Int Property DetectionAtZeroCount = 0 Auto Hidden

Bool Debugging

_SLS_TollDodgeHunt Property DodgeHunt Auto

Actor Property PlayerRef Auto

Topic Property _SLS_TollDodgeHuhTopic Auto
Topic Property _SLS_TollDodgeOverHereTopic Auto
Topic Property _SLS_TollDodgeWhereAreYou Auto
Topic Property _SLS_TollDodgeGetHerTopic Auto
