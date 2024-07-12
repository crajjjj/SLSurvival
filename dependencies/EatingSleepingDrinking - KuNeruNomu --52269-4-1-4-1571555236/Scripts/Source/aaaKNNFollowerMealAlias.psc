Scriptname aaaKNNFollowerMealAlias extends ReferenceAlias

Package Property FollowerMealPackage auto
bool Property IsFood auto

Event OnPackageStart(Package akNewPackage)
	if FollowerMealPackage == akNewPackage
		;Debug.Trace("OnPackageStart : " + akNewPackage)
		(GetOwningQuest() as aaaKNNFollowerMealQuest).StartFollowerMeal(GetActorReference(), IsFood)
	endIf
EndEvent