Scriptname _SLS_AnimalFriendPlayerAlias extends ReferenceAlias  

Event OnInit()
	RegisterForSleep()
EndEvent

Event OnPlayerLoadGame()
	Friend.PlayerLoadsGame()
EndEvent

Event OnSleepStart(float afSleepStartTime, float afDesiredSleepEndTime)
	Friend.SleepStart(afSleepStartTime, afDesiredSleepEndTime)
EndEvent

Event OnSleepStop(bool abInterrupted)
	Friend.SleepStop(abInterrupted)
EndEvent

_SLS_AnimalFriend Property Friend Auto
