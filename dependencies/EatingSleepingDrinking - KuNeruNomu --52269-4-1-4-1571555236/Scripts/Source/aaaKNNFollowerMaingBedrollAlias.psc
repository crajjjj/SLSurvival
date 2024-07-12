Scriptname aaaKNNFollowerMaingBedrollAlias extends ReferenceAlias  

Package Property followerMakingBedrollPackage auto

Event OnPackageStart(Package akNewPackage)
	if followerMakingBedrollPackage == akNewPackage
		;Debug.Trace("OnPackageStart")
		(GetOwningQuest() as aaaKNNFollowerMakingBedrollQuest).PlayMakingBedroll(Self.GetActorReference())
	endIf
EndEvent 