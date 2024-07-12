Scriptname _SLS_DodgeTrack extends ReferenceAlias  

_SLS_TollDodge Property TollDodge Auto

String Property MyLocation Auto

Function BeginTollDodge(Float GracePeriod)
	;TollDodge.Init.IsPlayerInside = false ; Now handled in LocTrackCentral
	Debug.Notification("It won't be long before the guards notice I'm missing")
	RegisterForSingleUpdateGameTime(GracePeriod)
EndFunction

Function PlayerReturnedInTime()
	;TollDodge.Init.IsPlayerInside = true ; Now handled in LocTrackCentral
	Debug.Notification("I think no-one noticed I skipped out")
	UnRegisterForUpdateGameTime()
EndFunction

Event OnUpdateGameTime()
	Debug.Notification("The guards in " + MyLocation + " will have noticed I'm gone by now.")
	TollDodge.GraceExpired(MyLocation)
EndEvent
