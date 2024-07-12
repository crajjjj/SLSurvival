Scriptname _SLS_PlayerDirt extends Quest  

Event OnInit()
	If Self.IsRunning()
		RegisterForModEvent("Bis_BatheEvent", "OnBis_BatheEvent")
		If Game.GetModByName("Bathing in Skyrim - Main.esp") != 255
			GoToState("Installed")
		EndIf
	EndIf
EndEvent

Function BeginUpdates()
	RegisterForSingleUpdateGameTime(1.0)
EndFunction

Event OnUpdateGameTime()
EndEvent

Event OnBis_BatheEvent(Form akActor)
	; BiS was not initially installed but is now
	GoToState("Installed")
EndEvent

Event OnAnimationEnd(int tid, bool HasPlayer)
EndEvent

Function UpdateLocalDirtyness()
	_SLS_PlayerDirtyness.SetValue(0.0)
EndFunction

State Installed
	Event OnBeginState()
		mzinDirtinessPercentage = Game.GetFormFromFile(0x000DA8, "Bathing in Skyrim - Main.esp") as GlobalVariable
		RegisterForModEvent("HookAnimationEnd", "OnAnimationEnd")
		UpdateLocalDirtyness()
		BeginUpdates()
	EndEvent
	
	Event OnUpdateGameTime()
		Utility.Wait(3.0) ; Wait for BiS to update
		UpdateLocalDirtyness()
		RegisterForSingleUpdateGameTime(1.0)
	EndEvent
	
	Event OnBis_BatheEvent(Form akActor)
		If akActor && (akActor as Actor) == PlayerRef
			UpdateLocalDirtyness()
		EndIf
	EndEvent
	
	Event OnAnimationEnd(int tid, bool HasPlayer)
		If HasPlayer
			Utility.Wait(4.0) ; Wait for BiS to finish updating
			UpdateLocalDirtyness()
		EndIf
	EndEvent
	
	Function UpdateLocalDirtyness()
		_SLS_PlayerDirtyness.SetValue(mzinDirtinessPercentage.GetValue())
	EndFunction
EndState

GlobalVariable mzinDirtinessPercentage

GlobalVariable Property _SLS_PlayerDirtyness Auto

Actor Property PlayerRef Auto
