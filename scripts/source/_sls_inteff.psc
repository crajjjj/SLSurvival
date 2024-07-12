Scriptname _SLS_IntEff Hidden 

ObjectReference Function GetEffInv(Actor FollowerActor, Quest EffQuest) Global
	EFFCore Eff = EffQuest as EFFCore
	Int index = Eff.XFL_GetIndex(FollowerActor)
	If index != -1
		ObjectReference refInventory = Eff.XFL_FollowerInventories[index]
		Return refInventory
	Endif
	Return None
EndFunction

Function AddFollower(ObjectReference Follower, Quest EffQuest) Global
	(EffQuest as EFFCore).XFL_AddFollower(Follower)
EndFunction
