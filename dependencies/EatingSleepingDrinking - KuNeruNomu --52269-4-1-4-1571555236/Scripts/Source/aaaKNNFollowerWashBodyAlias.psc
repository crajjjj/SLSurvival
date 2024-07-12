Scriptname aaaKNNFollowerWashBodyAlias extends ReferenceAlias  

Quest Property AnimCtrl auto
Quest Property pre auto
Package Property WashBodyPackage auto
;Spell[] Property DirtyBodySpellList auto
Armor[] armors
Event OnPackageStart(Package akNewPackage)
	if WashBodyPackage == akNewPackage
		FollowerPlayWashBody()
	endIf
EndEvent

;Spell Property aaaKNNPlayWashBodySpell auto
Potion Property aaaKNNTowelPotion auto
Function FollowerPlayWashBody()
	Actor ActorRef = Self.GetActorReference()
	;if KNNPlugin_Utility.IsInWater(follower)
	if !ActorRef
		GetOwningQuest().Stop()
		return
	endIf

	int itemCount = ActorRef.GetItemCount(aaaKNNTowelPotion)
	if 1 > itemCount
		GetOwningQuest().Stop()
		return
	endIf
	;ActorRef.EquipItem(aaaKNNTowelPotion, false, true)
	ActorRef.RemoveItem(aaaKNNTowelPotion, 1, true)
	if KNNPlugin_Utility.GetAliasFollower() == ActorRef
		KNNPlugin_Utility.ModBasicNeeds("followerbodyhealth", -1440.0)
	endIf
	;aaaKNNPlayWashBodySpell.Cast(ActorRef)
	Utility.wait(1.0)
	armors = (AnimCtrl as aaaKNNAnimControlQuest).FollowerUnEquipWeapArmor(ActorRef)
	bool IsFemale = (AnimCtrl as aaaKNNAnimControlQuest).GetGender(ActorRef)
	string[] animData = KNNPlugin_Utility.GetAnimation((pre as _KNNPrePlayAnimationQuest).TYPE_WASHING_BODY, IsFemale, none, "random")
	if 2 != animData.Length
		GetOwningQuest().Stop()
	endIf
	Debug.SendAnimationEvent(ActorRef, animData[0])
	float duration = animData[1] as float
	if 20.0 < duration
		duration = 19.83
	endIf
	RegisterForSingleUpdate(duration)
EndFunction
Event OnUpdate()
	if 0 < armors.Length
		(AnimCtrl as aaaKNNAnimControlQuest).FollowerEquipArmors(GetActorReference())
	endIf
	GetOwningQuest().Stop()
EndEvent