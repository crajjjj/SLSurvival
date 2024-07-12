Scriptname _SLS_AnimalFriendBleedout extends ReferenceAlias  

Function BeginBleedout(Actor akActor)
	Self.ForceRefTo(akActor)
	RegisterForSingleUpdateGameTime(1.0)
EndFunction

Function Revive(Actor akActor)
	If akActor == Self.GetReference() as Actor
		UnRegisterForUpdate()
		Self.Clear()
	Else
		Debug.Trace("_SLS_: Revive (ALIAS): akActor does not match alias. akActor: " + akActor + ". Alias: " + Self.GetReference() as Actor)
	EndIf
EndFunction

Event OnUpdateGameTime()
	Friend.BleedoutExpire(Self.GetReference() as Actor)
	Self.Clear()
EndEvent

_SLS_AnimalFriend Property Friend Auto
