Scriptname SLS_GluttonyInflationScript extends Quest

Event OnInit()
	If Self.IsRunning()
		If Game.GetModByName("SexLab Inflation Framework.esp") != 255
			;If Needs.IsNeedsModActive()
			;	RegisterForSingleUpdateGameTime(0.01)
			;Else
			;	RegisterForSingleUpdateGameTime(1.0)
			;EndIf
			OnUpdateGameTime()
		Else
			Debug.Notification("SLS: Slif not installed. Shutting down inflation element")
			;Shutdown()
			Self.Stop()
		EndIf
	EndIf
EndEvent

Event OnUpdateGameTime()
	;Debug.Messagebox("SLS_: BellyScaleUpdate() begin")
	Utility.Wait(3.0)
	BellyScaleUpdate()
	;Debug.MessageBox("GetCurrentGameTime: " + Utility.GetCurrentGameTime() + ". GetLastHungerUpdateTime: " + Needs.GetLastHungerUpdateTime())
	RegisterForSingleUpdateGameTime((Utility.GetCurrentGameTime() - Needs.GetLastHungerUpdateTime()) + 1.0) ; Last RND update + 1.0 hour + a little extra
EndEvent

Function BellyScaleUpdate()
	Float ScaleAmount = Needs.GetBellyScale()
	Int Timeout = 10

	If Needs.IsNeedsModActive()
		While ScaleAmount == -1.0 && Timeout > 0
			Timeout -= 1
			Utility.Wait(0.2)
			ScaleAmount = Needs.GetBellyScale()
		EndWhile
		;Debug.MessageBox("SLS_: BellyScaleUpdate() - ScaleAmount = " + ScaleAmount)

		If ScaleAmount != -1.0
			Debug.trace("SLS_: BellyScaleUpdate(): ScaleAmount = " + ScaleAmount)
			Int SLIF_event = ModEvent.Create("SLIF_inflate")
			If SLIF_event
				ModEvent.PushForm(SLIF_event, PlayerRef)        ; <-- the actor that will be affected
				ModEvent.PushString(SLIF_event, "Sexlab Survival")     ; <-- the name of your mod
				ModEvent.PushString(SLIF_event, "slif_belly")        ; <-- the node to be modified (see the documentation for node names)
				ModEvent.PushFloat(SLIF_event, ScaleAmount)        ; <-- the value that should be assigned to the body node (values go usually from 0.0 to 100.0)
				ModEvent.PushString(SLIF_event, "")  ; <-- only need to delete existing NetImmerse Override nodes otherwise use empty string
				ModEvent.Send(SLIF_event)
			EndIf
		EndIf
	EndIf
EndFunction

Function Shutdown()
	Int SLIF_event = ModEvent.Create("SLIF_unregisterActor")
	If (SLIF_event)
		ModEvent.PushForm(SLIF_event, PlayerRef)
		ModEvent.PushString(SLIF_event, "Sexlab Survival")
		ModEvent.Send(SLIF_event)
	EndIf
EndFunction

Actor Property PlayerRef Auto

SLS_Mcm Property Menu Auto
_SLS_Needs Property Needs Auto
