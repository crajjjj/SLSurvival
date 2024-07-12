Scriptname aaaKNNFollowerMakingBedrollQuest extends Quest

aaaKNNAnimControlQuest Property AnimUtil auto
Quest Property PerkAnim auto
ReferenceAlias Property bedroll auto
GlobalVariable Property aaaKNNIsShieldUnequip auto

Function PlayMakingBedroll(Actor followerAlias)
	;Debug.Trace("PlayMakingBedroll")
	ObjectReference bedrollRef = bedroll.GetReference()
	if !followerAlias || !bedrollRef
		if Self.IsRunning()
			Self.Stop()
		endIf
		return
	endIf
	Utility.wait(1.5)
	bool IsPlayAnim = false
	int maxWaitTime = 5
	while !IsPlayAnim && 0 < maxWaitTime
		IsPlayAnim = (PerkAnim as aaaKNNPlayPerkBedAnimQuest).IsGoToBedWithAnim(followerAlias)
		;Debug.Trace("PlayMakingBedroll -> IsPlayAnim:"+IsPlayAnim)
		maxWaitTime -= 1
		if !IsPlayAnim
			Utility.wait(1.0)
		endIf
	endwhile
	int index = AnimUtil.GetBedrollIndex(bedrollRef.GetBaseObject())
	if 0 <= index
		bedrollRef.PlaceAtMe(AnimUtil.Bedroll_FURN_List.GetAt(index))
		bedrollRef.Disable()
		bedrollRef.Delete()
	endIf
	if IsPlayAnim
		if 0 < aaaKNNIsShieldUnequip.GetValueInt()
			Form shield = followerAlias.GetWornForm(0x00000200)
			if shield
				followerAlias.UnequipItemEx(shield)
			endIf
		endif
		bool IsFemale = AnimUtil.GetGender(followerAlias)
		;bedrollSpell.Cast(followerAlias)
		;Debug.sendAnimationEvent(akActor, "idleStop")
		;Utility.wait(0.1)
		if IsFemale
			Debug.SendAnimationEvent(followerAlias, "KNNMakeBedroll")
		else
			Debug.SendAnimationEvent(followerAlias, "KNNMakeBedroll_M")
		endIf
		Utility.wait(5.0)
	endIf
	Self.Stop()
EndFunction

;Function RegisterAnim()
;	RegisterForAnimationEvent(follower.GetReference(), "KNNPickupBedrollEnd")
;	RegisterForAnimationEvent(follower.GetReference(), "KNNMakeBedrollEnd")
;EndFunction

;Event OnAnimationEvent(ObjectReference akSource, string asEventName)
;	Debug.Trace(asEventName)
;	if akSource != follower.GetReference()
;		return
;	endIf
;	if asEventName == "KNNPickupBedrollEnd" || asEventName == "KNNPickupBedrollEnd"
;		;Debug.Notification("OnAnimationEvent : " + asEventName)
;		Self.Stop()
;	endIf
;EndEvent