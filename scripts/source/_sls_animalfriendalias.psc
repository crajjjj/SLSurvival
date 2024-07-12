Scriptname _SLS_AnimalFriendAlias extends ReferenceAlias  
;/
Event OnEnterBleedout()
	Debug.Messagebox(Self.GetReference() + " entered bleedout")
	AnimalFriend.EnterBleedout(Self.GetReference() as Actor)
EndEvent
/;
Event OnUpdateGameTime()
	Actor Friend = Self.GetReference() as Actor
	If Friend
		If Friend.Is3dLoaded()
			;_SLS_AnimalFriendApproachCount.SetValueInt(StorageUtil.GetIntValue(Friend, "_SLS_AnimalFriendApproachCount", missing = 0))
			If AnimalFriend.BeginHornyFg(Friend)
				InGrace = false
				ApproachOnLoad = false
			Else
				RegisterForSingleUpdateGameTime(1.0)
			EndIf
		
		Else
			If InGrace
				String Name = Friend.GetDisplayName()
				If !Name
					Name = Friend.GetLeveledActorBase().GetName()
				EndIf
				Debug.Notification("<font color='#CC0000'>" + Name + " has become bored and is going home (Allure +" + (AnimalFriend.GetAllureCost(Friend) as Int) + ")</font>")
				AnimalFriend.DismissFriend(Self.GetReference() as Actor, MoveHome = true)
			Else
				InGrace = true
				ApproachOnLoad = true
				RegisterForSingleUpdateGameTime(1.0)
			EndIf
		EndIf
	EndIf
EndEvent

Event OnCellAttach()
	If ApproachOnLoad
		;_SLS_AnimalFriendApproachCount.SetValueInt(StorageUtil.GetIntValue(Self.GetReference(), "_SLS_AnimalFriendApproachCount", missing = 0))
		If AnimalFriend.BeginHornyFg(Self.GetReference() as Actor)
			ApproachOnLoad = false
			InGrace = false
		Else
			RegisterForSingleUpdateGameTime(1.0)
		EndIf
	EndIf
EndEvent

Event OnDeath(Actor akKiller)
	Actor akFriend = Self.GetReference() as Actor
	StorageUtil.AdjustFloatValue(akFriend, "_SLS_AnimalFriendBleedoutCount", 1.0)
	If AnimalFriend.FriendDeath(akFriend, akKiller)
		InGrace = false
		ApproachOnLoad = false
		UnRegisterForUpdateGameTime()
		Self.Clear()
	EndIf
EndEvent

Function SetUpdate(Float TimeInHours)
	;Debug.Messagebox("TimeInHours: " + TimeInHours)
	UpdateTime = Utility.GetCurrentGameTime() + (TimeInHours / 24.0)
	RegisterForSingleUpdateGameTime(TimeInHours)
EndFunction

Bool InGrace = false
Bool ApproachOnLoad = false

Float Property UpdateTime = 0.0 Auto Hidden

GlobalVariable Property _SLS_AnimalFriendApproachCount Auto

_SLS_AnimalFriend Property AnimalFriend Auto
