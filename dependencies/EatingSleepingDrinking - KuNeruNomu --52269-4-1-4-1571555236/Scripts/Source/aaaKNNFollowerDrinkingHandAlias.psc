Scriptname aaaKNNFollowerDrinkingHandAlias extends ReferenceAlias

Package Property DrinkingHandPackage  auto

Event OnPackageStart(Package akNewPackage)
	if DrinkingHandPackage == akNewPackage
		;Debug.Trace("OnPackageStart")
		(GetOwningQuest() as aaaKNNFollowerDrinkingHandQuest).SetFollowerDrinkWaterUsingHand(Self.GetActorReference())
	endIf
EndEvent 
