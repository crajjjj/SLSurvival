Scriptname _SLS_TollDodgeTollDueDetection extends Quest  

Event OnInit()
	If Self.IsRunning()
		RegisterForSingleUpdate(0.0)
	EndIf
EndEvent

Event OnUpdate()
	_SLS_TollDodgeGuardSearch.Stop()
	_SLS_TollDodgeGuardSearch.Start()
	
	Int i = _SLS_TollDodgeGuardSearch.GetNumAliases()
	Actor Guard
	While i > 0
		i -= 1
		Guard = (_SLS_TollDodgeGuardSearch.GetNthAlias(i) as ReferenceAlias).GetReference() as Actor
		If Guard
			If PlayerRef.IsDetectedBy(Guard) && Guard.HasLos(PlayerRef)
				Debug.Notification("The guards have spotted me. They'll expect the toll be paid before I leave";/ + Guard.GetBaseObject().GetName()/;)
				Debug.Trace("_SLS_: The guards have spotted me: " + Guard + " - " + Guard.GetBaseObject().GetName())
				TollDodge.SetTollDue(TollDodge.LastTollLocation, true)
				Return
				Self.Stop()
			EndIf
		EndIf
	EndWhile
	RegisterForSingleUpdate(Menu.TollDodgeHuntFreq)
EndEvent

Quest Property _SLS_TollDodgeGuardSearch Auto

Actor Property PlayerRef Auto

SLS_Mcm Property Menu Auto
_SLS_TollDodge Property TollDodge Auto
