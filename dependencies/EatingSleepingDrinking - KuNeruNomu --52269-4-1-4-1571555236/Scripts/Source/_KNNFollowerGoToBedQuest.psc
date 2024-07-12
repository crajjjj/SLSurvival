Scriptname _KNNFollowerGoToBedQuest extends Quest

ReferenceAlias Property followerAlias auto

Function GetUp()
	actor follower = followerAlias.GetActorReference()
	if follower
		MfgConsoleFunc.ResetPhonemeModifier(follower)
		follower.ClearExpressionOverride()
		;Debug.Trace(follower.GetBaseObject().GetName() + "->ClearExpressionOverride()")
		int handle = ModEvent.Create("CallFollowerEvent")
		if handle
			ModEvent.PushForm(handle, self)
			ModEvent.PushForm(handle, followerAlias.GetActorReference())
			ModEvent.PushString(handle, "Wakeup")
			ModEvent.PushInt(handle, 0)
			ModEvent.Send(handle)
		endIf
	endIf
EndFunction

Function GoToBed()
	int handle = ModEvent.Create("CallFollowerEvent")
	if handle
		ModEvent.PushForm(handle, self)
		ModEvent.PushForm(handle, followerAlias.GetActorReference())
		ModEvent.PushString(handle, "GoToBed")
		ModEvent.PushInt(handle, 0)
		ModEvent.Send(handle)
	endIf
EndFunction