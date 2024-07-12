Scriptname aaaKNNFollowerStrikBedrollQuest extends Quest  

aaaKNNAnimControlQuest Property AnimUtil auto
Quest Property PerkAnim auto
ReferenceAlias Property bedroll auto
GlobalVariable Property aaaKNNIsShieldUnequip auto

Function PlayStrikeBedroll(Actor folloewrAlias)
	;Debug.Trace("PlayStrikeBedroll")
	ObjectReference bedrollRef = bedroll.GetReference()
	if !folloewrAlias || !bedrollRef
		if Self.IsRunning()
			Stop()
		endIf
		return
	endIf
	Utility.wait(1.5)
	bool IsPlayAnim = false
	int maxWaitTime = 5
	while !IsPlayAnim && 0 < maxWaitTime
		IsPlayAnim = (PerkAnim as aaaKNNPlayPerkBedAnimQuest).IsGoToBedWithAnim(folloewrAlias)
		maxWaitTime -= 1
		if !IsPlayAnim
			Utility.wait(1.0)
		endIf
	endwhile
	;Utility.wait(1.0)
	if IsPlayAnim
		if 0 < aaaKNNIsShieldUnequip.GetValueInt()
			Form shield = folloewrAlias.GetWornForm(0x00000200)
			if shield
				folloewrAlias.UnequipItemEx(shield)
			endIf
		endif
		bool IsFemale = AnimUtil.GetGender(folloewrAlias)
		;bedrollSpell.Cast(folloewrAlias)
		if IsFemale
			Debug.SendAnimationEvent(folloewrAlias, "KNNPickupBedroll")
		else
			Debug.SendAnimationEvent(folloewrAlias, "KNNPickupBedroll_M")
		endIf
		Utility.wait(1.0)
	endIf
	int index = AnimUtil.GetBedrollIndex(bedrollRef.GetBaseObject())
	if 0 <= index
		folloewrAlias.AddItem(AnimUtil.Bedroll_MISC_List.GetAt(index), 1 , true)
	endIf
	bedrollRef.Disable()
	bedrollRef.Delete()
	Stop()
EndFunction