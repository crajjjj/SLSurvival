Scriptname aaaKNNFollowerStrikeBedrollAlias extends ReferenceAlias  

Package Property followerStrikeBedrollPackage auto

Event OnPackageStart(Package akNewPackage)
	if followerStrikeBedrollPackage == akNewPackage
		;Debug.Trace("OnPackageStart")
		(GetOwningQuest() as aaaKNNFollowerStrikBedrollQuest).PlayStrikeBedroll(Self.GetActorReference())
	endIf
EndEvent 