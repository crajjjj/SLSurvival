Scriptname _SLS_TollDodgeTollDueDetection extends Quest  

Event OnInit()
	If Self.IsRunning()
		RegisterForSingleUpdate(0.0)
	EndIf
EndEvent

Event OnUpdate()
	If !Self.IsRunning() ; Quest.Stop() doesn't unregister a pending update - don't flag toll due after leaving the city
		Return
	EndIf
	Actor[] Guards = SLS_Utility.FillSearchQuest(_SLS_TollDodgeGuardSearch)
	Int i = Guards.Length
	Actor Guard
	While i > 0
		i -= 1
		Guard = Guards[i]
		If Guard
			If PlayerRef.IsDetectedBy(Guard) && Guard.HasLos(PlayerRef)
				Debug.Notification("The guards have spotted me. They'll expect the toll be paid before I leave";/ + Guard.GetBaseObject().GetName()/;)
				Debug.Trace("_SLS_: The guards have spotted me: " + Guard + " - " + Guard.GetBaseObject().GetName())
				TollDodge.SetTollDue(TollDodge.LastTollLocation, true)
				Self.Stop()
				Return
			EndIf
		EndIf
	EndWhile
	RegisterForSingleUpdate(Menu.TollDodgeHuntFreq)
EndEvent

Quest Property _SLS_TollDodgeGuardSearch Auto

Actor Property PlayerRef Auto

SLS_Mcm Property Menu Auto
_SLS_TollDodge Property TollDodge Auto
