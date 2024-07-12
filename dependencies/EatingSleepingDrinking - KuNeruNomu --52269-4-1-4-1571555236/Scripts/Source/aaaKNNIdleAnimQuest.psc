Scriptname aaaKNNIdleAnimQuest extends Quest

;ObjectReference Property targetMarker auto
;Keyword Property aaaKNNFollowerMealKey auto
;ReferenceAlias Property MarkerTarget auto
Quest Property AnimCtrl auto
Quest Property PreAnim auto
Keyword Property _KNNIdleHotkeyAnimKeyword auto
GlobalVariable Property aaaKNNHotkeyIdleAnim auto
FormList Property _IdleHotkeyAnimIdleMarkerList auto
FormList Property _IdleHotkeyAnimIdleMarkerWithAnimObjetList auto

Function StartUpIdleHotkeyAnim()
	GoToState("BUSY")
	((Self as Quest) as QF_aaaKNNIdleAnimQuest_05254A7D).Alias_Player.GetActorReference().AddSpell(aaaKNNPlayIdleFindMarkerSpell, false)
	RegisterForKey(aaaKNNHotkeyIdleAnim.GetValueInt())
	;Game.DisablePlayerControls(true, true, false, false, false, true, false, false)
	Game.DisablePlayerControls()
	Game.SetPlayerAIDriven(true)
	(AnimCtrl as aaaKNNAnimControlQuest).SetThirdPersonCameraState()	
EndFunction

Function CleanUpQuest()
	ForcedDefaultIdle()
	UnregisterForAllKeys()
	((Self as Quest) as QF_aaaKNNIdleAnimQuest_05254A7D).Alias_Player.GetActorReference().RemoveSpell(aaaKNNPlayIdleFindMarkerSpell)
	Game.SetPlayerAIDriven(false)
	Game.EnablePlayerControls()
	(AnimCtrl as aaaKNNAnimControlQuest).ForceReturnCameraState()
	GoToState("")
EndFunction

Function ShutDownIdleHotkeyAnim()
	CleanUpQuest()
	Stop()
EndFunction

Function ForcedDefaultIdle()
	int type = GetExitAnimType()
	if 1 == type
		Debug.SendAnimationEvent(((Self as Quest) as QF_aaaKNNIdleAnimQuest_05254A7D).Alias_Player.GetReference(), "IdleStop")
		return
	elseIf 2 == type
		Debug.SendAnimationEvent(((Self as Quest) as QF_aaaKNNIdleAnimQuest_05254A7D).Alias_Player.GetReference(), "IdleForceDefaultState")
		return
	elseIf 0 == type
		if 0 == GetStage()
			Debug.SendAnimationEvent(((Self as Quest) as QF_aaaKNNIdleAnimQuest_05254A7D).Alias_Player.GetReference(), "IdleChairExit")			
		endIf
		return
	endIf
	Debug.SendAnimationEvent(((Self as Quest) as QF_aaaKNNIdleAnimQuest_05254A7D).Alias_Player.GetReference(), "IdleStop")
	Debug.SendAnimationEvent(((Self as Quest) as QF_aaaKNNIdleAnimQuest_05254A7D).Alias_Player.GetReference(), "IdleForceDefaultState")
EndFunction

int Function GetExitAnimType()
	Form baseForm = ((Self as Quest) as QF_aaaKNNIdleAnimQuest_05254A7D).Alias_animMarker.GetReference().GetBaseObject()
	;40 furniture
	;47 idle marker
	if baseForm && 40 == baseForm.GetType()
		return 0
	elseif baseForm && 47 == baseForm.GetType()
		if 0 <= _IdleHotkeyAnimIdleMarkerWithAnimObjetList.Find(baseForm)
			return 1
		elseIf 0 <= _IdleHotkeyAnimIdleMarkerList.Find(baseForm)
			return 2
		endIf
	endIf
	return -1
EndFunction

Function StandUp()
	if 0 == GetExitAnimType()
		(AnimCtrl as aaaKNNAnimControlQuest).ResetThirdPersonCameraPosition()
	endIf
	AddPlayerSpellFromMarker()
EndFunction

Event OnKeyDown(Int KeyCode)
	if KeyCode == aaaKNNHotkeyIdleAnim.GetValueInt()	
		SetStage(100)
	endIf
EndEvent

;Spell Property aaaKNNPlayIdleDrinkWaterSpell auto
Event OnPlayerDrinkWater(Actor player, Actor[] followers)
	if !(PreAnim as _KNNPrePlayAnimationQuest).IsStartPlayerAnimation(player, (PreAnim as _KNNPrePlayAnimationQuest).TYPE_DRINKWATER_HANDS, none)
		return
	endIf
	
	int i = 0
	while i < followers.Length
		if followers[i] && followers[i].GetFormID()
			int handle = ModEvent.Create("KNNSendMealAnim")
			if handle
				ModEvent.PushForm(handle, player)
				ModEvent.PushForm(handle, followers[i])
				ModEvent.PushInt(handle, 3)
				ModEvent.PushInt(handle, 0)
				ModEvent.Send(handle)
				endIf
			;bool IsSuccess = aaaKNNFollowerMealKey.SendStoryEventAndWait(none, (follower as ObjectReference), none, 3, 0)
			;Debug.Trace("OnPlayerDrinkWater -> SendStoryEventAndWait : " + IsSuccess)
		endIf
		i += 1
	endWhile
EndEvent

;Spell Property aaaKNNPlayIdleNotFoundMakerSpell auto
;Event OnPlayerIdleNotFoundMarker(Actor player)
;	aaaKNNPlayIdleNotFoundMakerSpell.Cast(player)
;EndEvent

Spell Property aaaKNNPlayIdleFindMarkerSpell auto
Event OnPlayerIdleFindMarker(Actor player, ObjectReference target)
	if !target.IsFurnitureInUse() && _KNNIdleHotkeyAnimKeyword.SendStoryEventAndWait(none, player, target)
		return
	endIf
	(PreAnim as _KNNPrePlayAnimationQuest).StartPlayerAnimation(player, (PreAnim as _KNNPrePlayAnimationQuest).TYPE_IDLEMARKER_NOTFOUND, none)
	;OnPlayerIdleNotFoundMarker(player)
EndEvent

;Spell Property aaaKNNPlayAnimAbsorbDragonSoulSpell auto
Quest property MQkillDragon auto
Faction property MQKillDragonFaction auto
Event OnPlayerAbsorbDragonSoul(Actor player, Actor actorDragon, bool InFaction)
	;Debug.Trace("OnPlayerAbsorbDragonSoul")
	if !(PreAnim as _KNNPrePlayAnimationQuest).IsStartPlayerAnimation(player, (PreAnim as _KNNPrePlayAnimationQuest).TYPE_ABSORB_DRAGONSOUL, none)
		return
	endIf
	if InFaction
		actorDragon.RemoveFromFaction(MQKillDragonFaction)
	endIf
	;aaaKNNPlayAnimAbsorbDragonSoulSpell.Cast(player)
	(MQkillDragon as MQKillDragonScript).DeathSequence(actorDragon, None, false)
EndEvent

State BUSY
	Event OnPlayerDrinkWater(Actor player, Actor[] followers)
	EndEvent

	;Event OnPlayerIdleNotFoundMarker(Actor player)
	;EndEvent

	Event OnPlayerIdleFindMarker(Actor player, ObjectReference target)
	EndEvent

	Event OnPlayerAbsorbDragonSoul(Actor player, Actor actorDragon, bool InFaction)
	EndEvent
EndState

Spell Property aaaKNNIdleShoutTimerSpell auto
Spell Property aaaKNNIdleMagickaRateSpell auto
Spell Property aaaKNNIdleSpeedMultSpell auto
Spell Property aaaKNNIdleWeaponSpeedMultSpell auto
Function AddPlayerSpellFromMarker()
	Form baseForm = ((Self as Quest) as QF_aaaKNNIdleAnimQuest_05254A7D).Alias_animMarker.GetReference().GetBaseObject()
	if baseForm
		int modIndex = Game.GetModByName("Skyrim.esm")
		if 0xFF != modIndex
			int objFormId = baseForm.GetFormID()
			if objFormId == Math.LogicalOr(Math.LeftShift(modIndex, 24), 0x0F688D)
				aaaKNNIdleShoutTimerSpell.Cast(Game.GetPlayer())
			elseIf objFormId == Math.LogicalOr(Math.LeftShift(modIndex, 24), 0x0C482E)
				aaaKNNIdleMagickaRateSpell.Cast(Game.GetPlayer())
			elseIf objFormId == Math.LogicalOr(Math.LeftShift(modIndex, 24), 0x0C4827)
				aaaKNNIdleSpeedMultSpell.Cast(Game.GetPlayer())
			elseIf objFormId == Math.LogicalOr(Math.LeftShift(modIndex, 24), 0x0E8645)
				aaaKNNIdleWeaponSpeedMultSpell.Cast(Game.GetPlayer())
			elseIf objFormId == Math.LogicalOr(Math.LeftShift(modIndex, 24), 0x0E8644)
				aaaKNNIdleWeaponSpeedMultSpell.Cast(Game.GetPlayer())
			elseIf objFormId == Math.LogicalOr(Math.LeftShift(modIndex, 24), 0x04240B)
				aaaKNNIdleWeaponSpeedMultSpell.Cast(Game.GetPlayer())
			endIf
		endIf
	endIf
EndFunction