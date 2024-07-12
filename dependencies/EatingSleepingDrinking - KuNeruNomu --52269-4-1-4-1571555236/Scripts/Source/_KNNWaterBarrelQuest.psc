scriptName _KNNWaterBarrelQuest extends Quest

ReferenceAlias Property player auto
ReferenceAlias[] Property waterBarrels auto
Activator Property WaterBarrelStaticACTI auto
Quest Property PreAnimQuest auto
Quest Property BasicNeedsQuest auto
Keyword Property ActorTypeNPC auto
GlobalVariable Property aaaAnimDrinkSitting auto
GlobalVariable Property aaaAnimDrinkStanding auto
bool Property IsLocationDisplayed = false auto

Function StartUp()
	(player as _KNNWaterBarrelPlayerAlias).SetUp()
EndFunction

Function ShutDown()
	int i = 0
	while i < waterBarrels.Length
		ObjectReference ref = waterBarrels[i].GetReference()
		if ref
			if IsLocationDisplayed && IsObjectiveDisplayed(i)
				SetObjectiveDisplayed(i, false)
			endIf
			ref.Disable()
			ref.Delete()
			waterBarrels[i].clear()
		endIf
		i += 1
	endwhile
EndFunction

bool Function SetWaterBarrel(ObjectReference ref)
	if ref && IsRunning()
		ObjectReference barrel = ref.PlaceAtMe(WaterBarrelStaticACTI)
		if barrel
			;barrel.MoveTo(ref)
			int i = 0
			while i < waterBarrels.Length
				if !waterBarrels[i].GetReference()
					waterBarrels[i].ForceRefTo(barrel)
					(waterBarrels[i] as _KNNWaterBarrelAlias).ResetWaterAmount()
					if IsLocationDisplayed && !IsObjectiveDisplayed(i)
						SetObjectiveDisplayed(i)
					endIf
					return true
				endIf
				i += 1
			endwhile
		endIf
	endIf
	return false
EndFunction

Function RemoveWaterBarrel(ReferenceAlias barrelAlias)
	if barrelAlias
		int i = 0
		while i < waterBarrels.Length
			if waterBarrels[i] == barrelAlias
				ObjectReference ref = waterBarrels[i].GetReference()
				if ref
					if IsLocationDisplayed && IsObjectiveDisplayed(i)
						SetObjectiveDisplayed(i, false)
					endIf
					ref.Disable()
					ref.Delete()
					waterBarrels[i].clear()
					return
				endIf
			endIf
			i += 1
		endwhile
	endIf
EndFunction

Function PlayerDrinkingAnimation()
	Actor thePlayer = player.GetActorReference()
	if thePlayer && IsPlayAnim(thePlayer)
		bool IsSitting = 0 != thePlayer.GetSitState()
		if !IsSitting && thePlayer.GetAnimationVariableBool("bAnimationDriven")
			return
		endIf
		int type = 13
		if IsSitting
			if 0 == aaaAnimDrinkSitting.GetValueInt()
				return
			endIf
			type = 15
		else
			if 0 == aaaAnimDrinkStanding.GetValueInt()
				return
			endIf
		endIf
		(PreAnimQuest as _KNNPrePlayAnimationQuest).IsStartPlayerAnimation(thePlayer, type, none)
	endIf
EndFunction

bool Function IsPlayAnim(Actor akActor)
	if 0 != akActor.GetSleepState()
		return false
	elseIf akActor.IsWeaponDrawn()
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
	elseIf akActor.IsBleedingOut()
		;Debug.Trace("IsBleedingOut")
		return false
	elseIf 0 != akActor.GetFlyingState()
		return false
	elseIf KNNPlugin_Utility.IsTorchOut(akActor)
		;Debug.Trace("IsTorchOut")
		return false
	elseIf akActor.GetAnimationVariableBool("bInJumpState")
		;Debug.Trace("GetAnimationVariableBool(bInJumpState)")
		return false
	elseIf !akActor.HasKeyword(ActorTypeNPC)
		;Debug.Trace("HasKeyword(ActorTypeNPC)")
		return false
	elseIf akActor.GetCurrentScene()
		return false
	elseIf akActor.GetCurrentPackage()
		return false
	elseIf akActor.GetAnimationVariableFloat("Speed") >= 5.0
		;Debug.Trace("GetAnimationVariableFloat(Speed) : " + akActor.GetAnimationVariableFloat("Speed"))
		return false
	endIf
	return true
EndFunction

bool Function IsShowMessage()
	if 0 != (BasicNeedsQuest as aaaKNNBasicNeedsQuest).aaaKNNIsEnableMessage.GetValueInt()
		return true
	endIf
	return false
EndFunction

Function DisplayedAllBarrelLocations()
	if !IsLocationDisplayed
		int i = 0
		while i < waterBarrels.Length
			if waterBarrels[i].GetReference() && !IsObjectiveDisplayed(i)
				SetObjectiveDisplayed(i)
			endIf
			i += 1
		endwhile
		IsLocationDisplayed = true
	else
		int i = 0
		while i < waterBarrels.Length
			if waterBarrels[i].GetReference() && IsObjectiveDisplayed(i)
				SetObjectiveDisplayed(i, false)
			endIf
			i += 1
		endwhile
		IsLocationDisplayed = false
	endIf
EndFunction