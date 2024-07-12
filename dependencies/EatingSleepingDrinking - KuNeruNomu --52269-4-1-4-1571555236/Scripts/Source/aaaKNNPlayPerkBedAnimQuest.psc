Scriptname aaaKNNPlayPerkBedAnimQuest extends Quest

aaaKNNAnimControlQuest Property AnimUtil auto
Quest Property GoToBedQuest auto
Location Property DLC2SolstheimLocation auto
;Quest Property DLC2MQ06 auto
Quest Property DLC2MQ03B auto
Quest Property DLC2Pillar auto
Quest property DBEntranceQuest auto
Worldspace Property DLC2SolstheimWorld auto
Keyword Property LocTypeDwelling  auto

Keyword Property aaaKNNPlayerSleepingKey auto
Faction Property playerFaction auto
;WorldSpace Property DLC2SolstheimWorld auto
Function ActivateBed(ObjectReference akTargetRef, Actor akActor)
	;Debug.Trace("[KNN] ActivateBed")
	if !IsGoToBedWithAnim(akActor)
		if !GoToBedQuest.IsRunning()
			;Debug.Trace("[KNN] !GoToBedQuest.IsRunning()")
			akTargetRef.Activate(akActor)
		endIf
		return
	endIf
	;Debug.Trace("[KNN] Passed 0")
	if KNNPlugin_Utility.IsTeammateFavor()
		;Debug.Trace("[KNN] KNNPlugin_Utility.IsTeammateFavor()")
		akTargetRef.Activate(akActor)
		return
	endIf
	;Debug.Trace("[KNN] Passed 1")
	if DBEntranceQuest.GetStage() == 20 && (DBEntranceQuest as pdbentrancequestscript).pSleepyTime == 1
		;Debug.Trace("[KNN] DBEntranceQuest.GetStage() == 20 && (DBEntranceQuest as pdbentrancequestscript).pSleepyTime == 1")
		akTargetRef.Activate(akActor)
		return
	endIf
	CheckAndGoToBed(akTargetRef, akActor)
EndFunction

Function CheckAndGoToBed(ObjectReference bedRef, Actor akActor)
	if DBEntranceQuest.GetStage() == 20 && (DBEntranceQuest as pdbentrancequestscript).pSleepyTime == 1
		;Debug.Trace("[KNN] DBEntranceQuest.GetStage() == 20 && (DBEntranceQuest as pdbentrancequestscript).pSleepyTime == 1")
		bedRef.Activate(akActor)
		return
	endIf
	;Debug.Trace("[KNN] Passed 2")
	if akActor.IsInLocation(DLC2SolstheimLocation) && !DLC2MQ03B.IsCompleted()
		;Debug.Trace("[KNN] akActor.IsInLocation(DLC2SolstheimLocation) && !DLC2MQ06.IsCompleted()")
		Location loc = akActor.GetCurrentLocation()
		if loc.HasKeyword(LocTypeDwelling) || akActor.GetWorldspace() == DLC2SolstheimWorld
			DLC2PillarScript pillars = DLC2Pillar as DLC2PillarScript
			if pillars && pillars.StandingStones && 0 < pillars.StandingStones.Length
				int i = 0
				while i < pillars.StandingStones.Length
					if !pillars.StandingStones[i].Freed
						bedRef.Activate(akActor)
						return
					endIf
					i += 1
				endwhile
			endIf
		endIf
	endIf
	;Debug.Trace("[KNN] Passed 3")
	if !bedRef.IsFurnitureInUse(true)
		;Debug.Trace("[KNN] !akTargetRef.IsFurnitureInUse(true)")
		if CanPlaySleepAnim(bedRef, akActor)
			return
		endIf
	endIf
	bedRef.Activate(akActor)
EndFunction

bool Function CanPlaySleepAnim(ObjectReference bedRef, Actor activateActor)
	if !bedRef || !activateActor
		;Debug.Trace("[KNN] CanPlaySleepAnim -> !bedRef || !activateActor")
		return false
	endIf
	Actorbase bedOwner = bedRef.GetActorOwner()
	Faction bedFactionOwner = bedRef.GetFactionOwner()
	if !bedOwner
		if !bedFactionOwner
			bedFactionOwner = bedRef.GetParentCell().GetFactionOwner()
		endIf
		if !bedFactionOwner
			if CastGoToBedSpell(bedRef, activateActor)
				return true
			endIf
		else
			if activateActor.IsInFaction(bedFactionOwner)
				if CastGoToBedSpell(bedRef, activateActor)
					return true
				endIf
			elseIf 0 <= bedFactionOwner.GetReaction(playerFaction)
				if CastGoToBedSpell(bedRef, activateActor)
					return true
				endIf
			endIf
		endIf
	else
		if bedOwner == Game.GetPlayer().GetActorBase()
			if CastGoToBedSpell(bedRef, activateActor)
				return true
			endIf
		endIf
		if !bedFactionOwner
			bedFactionOwner = bedRef.GetParentCell().GetFactionOwner()
		endIf

		if bedFactionOwner
			if activateActor.IsInFaction(bedFactionOwner)
				if CastGoToBedSpell(bedRef, activateActor)
					return true
				endIf
			elseIf 0 <= bedFactionOwner.GetReaction(playerFaction)
				if CastGoToBedSpell(bedRef, activateActor)
					return true
				endIf
			endIf
		endIf
	endIf
	return false
EndFunction

Message Property aaaKNNMsgBedrollFURN auto
Function ActivateBedroll(ObjectReference akTargetRef, Actor akActor)
	;Debug.Trace("[KNN] ActivateBedroll")
	if !IsGoToBedWithAnim(akActor)
		if !GoToBedQuest.IsRunning()
			;Debug.Trace("[KNN] !GoToBedQuest.IsRunning()")
			akTargetRef.Activate(akActor)
		endIf
		return
	endIf
	if KNNPlugin_Utility.IsTeammateFavor()
		;Debug.Trace("[KNN] KNNPlugin_Utility.IsTeammateFavor()")
		akTargetRef.Activate(akActor)
		return
	endIf
	int bedrollIndex = AnimUtil.GetBedrollIndex(akTargetRef.GetBaseObject())
	if 0 > bedrollIndex
		return
	endIf
	int index = aaaKNNMsgBedrollFURN.Show()
	if 0 == index
		CheckAndGoToBed(akTargetRef, akActor)
	elseIf 1 == index
		float angleZ = akActor.GetHeadingAngle(akTargetRef)
		if angleZ >= -70 && angleZ <= 70
			AnimUtil.SetThirdPersonCameraState()
			;aaaKNNPlayPerkPickUpBedrollSpell.Cast(akActor)
			;Debug.sendAnimationEvent(akActor, "idleStop")
			;Utility.wait(0.1)
			Debug.SendAnimationEvent(akActor, "KNNPickupBedroll")
			Utility.wait(1.0)
			akActor.AddItem(AnimUtil.Bedroll_MISC_List.GetAt(bedrollIndex), 1, true)
			akTargetRef.Disable()
			akTargetRef.Delete()
			Utility.wait(1.0)
			AnimUtil.ReturnCameraState()
		else
			akActor.AddItem(AnimUtil.Bedroll_MISC_List.GetAt(bedrollIndex), 1, true)
			akTargetRef.Disable()
			akTargetRef.Delete()
		endIf
	elseIf 2 == index
		akTargetRef.PlaceAtMe(AnimUtil.Bedroll_ACTI_List.GetAt(bedrollIndex))
		akTargetRef.Disable()
		akTargetRef.Delete()
	endIf
EndFunction

bool Function CastGoToBedSpell(ObjectReference akTargetRef, Actor akActor)
	;if IsUseKNNHT()
	;	KNNPlugin_Utility.SetExpressionState(0x40)
		;(ExpressionQuest as aaaKNNExpressionClearQuest).RemovePlayerExpressionOverride()
	;endIf
	bool IsSuccess = aaaKNNPlayerSleepingKey.SendStoryEventAndWait(none, akActor, akTargetRef, 0, 0)
	;Debug.Trace("CastGoToBedSpell : " + IsSuccess)
	return IsSuccess
	;aaaKNNPlayGoToBedSpell.Cast(akActor)
	;Game.DisablePlayerControls(true, true, false, false, true, false, true, false, 0)
EndFunction

Message Property aaaKNNMsgBedrollACTI auto
GlobalVariable Property aaaKNNIsShieldUnequip auto
Function ActivateBedrollActivator(ObjectReference bedActiRef, Actor akActor)
	;Debug.Trace("ActivateBedrollActivator")
	;int IsPlayAnim = IsDisabledGoToBedWithAnim(akActor)
	if akActor != Game.GetPlayer() || KNNPlugin_Utility.IsTeammateFavor()
		return
	endIf
	
	int bedrollIndex = AnimUtil.GetBedrollIndex(bedActiRef.GetBaseObject())
	if 0 > bedrollIndex
		return
	endIf
	bool IsPlayAnim = IsGoToBedWithAnim(akActor)
	int index = aaaKNNMsgBedrollACTI.Show()
	if index == 0		
		bedActiRef.PlaceAtMe(AnimUtil.Bedroll_FURN_List.GetAt(bedrollIndex))
		bedActiRef.Disable()
		bedActiRef.Delete()		
		if IsPlayAnim
			AnimUtil.SetThirdPersonCameraState()
			Form shield = none
			int shieldCtrl = aaaKNNIsShieldUnequip.GetValueInt()
			if 1 == shieldCtrl || 2 == shieldCtrl
				shield = akActor.GetWornForm(0x00000200)
				if shield
					akActor.UnequipItemEx(shield)
				endIf
			endif
			;aaaKNNPlayPerkMakeBedrollSpell.Cast(akActor)
			;Debug.sendAnimationEvent(akActor, "idleStop")
			;Utility.wait(0.1)
			Debug.SendAnimationEvent(akActor, "KNNMakeBedroll")
			Utility.wait(7.0)
			AnimUtil.ReturnCameraState()
			if 2 == shieldCtrl && shield
				akActor.EquipItemEx(shield)
			endIf
		endIf
	elseIf index == 1
		float angleZ = akActor.GetHeadingAngle(bedActiRef)
		if angleZ >= -45.0 && angleZ <= 45.0

			if IsPlayAnim
				AnimUtil.SetThirdPersonCameraState()
				;aaaKNNPlayPerkPickUpBedrollSpell.Cast(akActor)
				;Debug.sendAnimationEvent(akActor, "idleStop")
				Utility.wait(0.1)
				Debug.SendAnimationEvent(akActor, "KNNPickupBedroll")
				Utility.wait(1.0)
			endIf
			akActor.AddItem(AnimUtil.Bedroll_MISC_List.GetAt(bedrollIndex), 1 , true)
			bedActiRef.Disable()
			bedActiRef.Delete()
			if IsPlayAnim
				Utility.wait(1.0)
				AnimUtil.ReturnCameraState()
			endIf
		else
			akActor.AddItem(AnimUtil.Bedroll_MISC_List.GetAt(bedrollIndex), 1 , true)
			bedActiRef.Disable()
			bedActiRef.Delete()
		endIf
	endIf
EndFunction

Keyword Property ActorTypeNPC auto
bool Function IsGoToBedWithAnim(Actor akActor)
	if akActor.IsWeaponDrawn()
		;Debug.Trace("IsWeaponDrawn")
		return false
	elseIf akActor.IsInCombat()
		;Debug.Trace("IsInCombat")
		return false
	elseIf akActor.IsOnMount()
		;Debug.Trace("IsOnMount")
		return false
	elseIf akActor.IsSwimming()
		;Debug.Trace("IsSwimming")
		return false
	elseIf akActor.IsSneaking()
		;Debug.Trace("IsSneaking")
		return false
	elseIf akActor.IsBleedingOut()
		;Debug.Trace("IsBleedingOut")
		return false
	elseIf KNNPlugin_Utility.IsTorchOut(akActor)
		;Debug.Trace("IsTorchOut")
		return false
	elseIf akActor.IsTrespassing()
		;Debug.Trace("IsTrespassing")
		return false
	elseIf IsAnimDriven(akActor)
		;Debug.Trace("GetAnimationVariableBool(bAnimationDriven)")
		return false
	elseIf akActor.GetAnimationVariableBool("bInJumpState")
		;Debug.Trace("GetAnimationVariableBool(bInJumpState)")
		return false
	;elseIf akActor.IsDoingFavor()
		;Debug.Trace("GetAnimationVariableBool(bInJumpState)")
		;return false
	elseIf !IsHumanActor(akActor)
		;Debug.Trace("HasKeyword(ActorTypeNPC)")
		return false
	elseIf akActor.GetAnimationVariableFloat("Speed") >= 5.0
		;Debug.Trace("GetAnimationVariableFloat(Speed) : " + akActor.GetAnimationVariableFloat("Speed"))
		return false
	endIf
	return true
EndFunction

bool Function IsAnimDriven(Actor thisActor)
	if thisActor == Game.GetPlayer()
		if thisActor.GetAnimationVariableBool("bAnimationDriven")
			;Debug.Trace("GetAnimationVariableBool(bAnimationDriven)")
			return true
		endIf
	else
		if thisActor.IsDoingFavor() || thisActor.GetCurrentScene()
			if 0 != thisActor.GetSitState() || 0 != thisActor.GetSleepState()
				;Debug.Trace("No Player && 0 != thisActor.GetSitState() || 0 != thisActor.GetSleepState()")
				return true
			endIf
		else
			if thisActor.GetAnimationVariableBool("bAnimationDriven")
				;Debug.Trace("No Player && GetAnimationVariableBool(bAnimationDriven)")
				return true
			endIf
		endIf
	endIf
	return false
EndFunction

bool Function IsPlayedFollowerAnimation()
	if 1 != aaaKNNFollowerPlaySleeping.GetValueInt()
		return false
	endIf
	return true
EndFunction

bool Function IsHumanActor(Actor thisActor)
	if !thisActor || !ActorTypeNPC
		;Debug.Trace("IsHumanActor -> !thisActor || !ActorTypeNPC")
		return false
	endIf
	ActorBase base = thisActor.GetActorBase()
	if !base
		;Debug.Trace("IsHumanActor -> NULL ActorBase")
		return false
	endIf
	Race actorRace = base.GetRace()
	if !actorRace
		;Debug.Trace("IsHumanActor -> NULL Race")
		return false
	endIf
	if !actorRace.HasKeyword(ActorTypeNPC)
		;Debug.Trace("IsHumanActor -> !HasKeyword(ActorTypeNPC)")
		return false
	endIf
	return true
EndFunction

Event KNNOnLoadGame()
	;Debug.Trace("PerkAnimQuest -> KNNOnLoadGame")
	RegisterSleepAnimModEvent()
EndEvent

Keyword Property aaaKNNFollowerSleepingKey auto
GlobalVariable Property aaaKNNFollowerPlaySleeping auto
;ReferenceAlias Property Follower auto

Function SetFollowerSleepAnimEvent(int IsStartFeature)	;From MCM
	if 1 == IsStartFeature
		;=============================================
		;===== Perk Anim Quest is always running =====
		;=============================================
		;if !Self.IsRunning()
		;	Self.Start()
		;	Debug.Trace("SetFollowerAnimEvent -> StartQuest")
		;endIf
		RegisterSleepAnimModEvent()
	else
		UnregisterForModEvent("KNNSendSleepAnim")
		;if Self.IsRunning()
		;	Self.Stop()
		;	Debug.Trace("SetFollowerAnimEvent -> StopQuest")
		;endIf
	endIf
EndFunction
Function RegisterSleepAnimModEvent()
	RegisterForModEvent("KNNSendSleepAnim", "KNNOnFollowerPlaySleepAnim")
EndFunction
Event KNNOnFollowerPlaySleepAnim(string eventName, string strArg, float numArg, Form sender)
	if IsPlayedFollowerAnimation()
		aaaKNNFollowerSleepingKey.SendStoryEvent(none, none, none, 0, 0)
		;Actor actoRref = KNNPlugin_Utility.GetAliasFollower()
		;if actoRref && KNNPlugin_Utility.AreYouAlright(actoRref)
		;	bool IsSucces = aaaKNNFollowerSleepingKey.SendStoryEventAndWait(none, actoRref, none, 0, 0)
		;	;Debug.Trace("KNN Follower Sleeping Feature Processing : " + IsSucces)
		;	;return
		;endIf
	endIf
EndEvent