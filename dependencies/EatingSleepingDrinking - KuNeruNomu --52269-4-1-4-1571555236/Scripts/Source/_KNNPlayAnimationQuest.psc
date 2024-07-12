scriptName _KNNPlayAnimationQuest extends Quest

_KNNPrePlayAnimationQuest Property Anim auto
Quest Property AnimCtrl auto
ReferenceAlias Property playerAlias auto

Function StartupQuest()
	Actor player = playerAlias.GetActorReference()
	RegisterForAnimationEvent(player, "JumpDown")
	int type = Anim.AnimType
	;Debug.Trace("[ESD debug log] PlayAnimationQuest -> StartupQuest -> type : " + type + ", event name : " + Anim.animData[0] + ", duration : " + Anim.animData[1])
	if Anim.TYPE_EATING_FOODS == type || Anim.TYPE_EATING_FOODS_SITTING == type
		StartEating(type, player)
	elseIf Anim.TYPE_DRINKING_DRINKS == type || Anim.TYPE_DRINKING_DRINKS_MOVING == type || Anim.TYPE_DRINKING_DRINKS_SITTING == type
		StartDrinking(type, player)
	elseIf Anim.TYPE_WASHING_BODY == type || Anim.TYPE_PEEPED_WASHING_BODY == type
		StartWashingBody(type, player)
	elseIf Anim.TYPE_REDING_BOOKS == type
		StartReadingBook(Anim.AnimType, player)
	elseIf Anim.TYPE_DRINKWATER_HANDS == type|| Anim.TYPE_FILLED_WATER == type || Anim.TYPE_TAKE_POTIONS == type || Anim.TYPE_FORETASTE_INGREDIENTS == type \
		|| Anim.TYPE_KNITTING_TOWELS == type || Anim.TYPE_KEEP_JOURNAL == type || Anim.TYPE_REGISTER_POTIONS == type || Anim.TYPE_IDLEMARKER_NOTFOUND == type \
		|| Anim.TYPE_ABSORB_DRAGONSOUL == type
		StartTakePotion(player)
	endIf
	;Game.DisablePlayerControls(abMovement = false, abFighting = true, abCamSwitch = false, abLooking = false, abSneaking = false, abMenu = true, abActivate = true, abJournalTabs = false, aiDisablePOVType = 0)
	Game.DisablePlayerControls(false, true, false, false, false, false, true, false, 0)
EndFunction
Function CleanupQuest()
	Cleanup()
EndFunction
Function ForcedQuestStop(Actor player, bool IsOnHitRoot)
	UnregisterForUpdate()
	;Utility.Wait(1.0)
	if IsOnHitRoot
		if Anim.TYPE_DRINKING_DRINKS_MOVING == Anim.AnimType
			if !player.GetAnimationVariableBool("bInJumpState") && !player.IsWeaponDrawn()
				Debug.SendAnimationEvent(player, "OffsetStop")
			endIf
		else
			if player.GetAnimationVariableBool("bAnimationDriven")
				Debug.SendAnimationEvent(player, "idleStop")
			endIf
		endIf
	endIf
	Cleanup()
EndFunction
Function Cleanup()
	;Debug.Trace("[ESD debug log] GetState : " + GetState())
	Game.EnablePlayerControls()
	int type = Anim.AnimType
	if Anim.TYPE_EATING_FOODS == type || Anim.TYPE_EATING_FOODS_SITTING == type
		FinishEating()
	elseIf Anim.TYPE_DRINKING_DRINKS == type || Anim.TYPE_DRINKING_DRINKS_MOVING == type || Anim.TYPE_DRINKING_DRINKS_SITTING == type
		FinishDrinking(type)
	elseIf Anim.TYPE_WASHING_BODY == type || Anim.TYPE_PEEPED_WASHING_BODY == type
		FinishWashingBody(type)
	elseIf Anim.TYPE_REDING_BOOKS == type
		FinishReadingBook()
	elseIf Anim.TYPE_DRINKWATER_HANDS == type|| Anim.TYPE_FILLED_WATER == type || Anim.TYPE_TAKE_POTIONS == type || Anim.TYPE_FORETASTE_INGREDIENTS == type || Anim.TYPE_KNITTING_TOWELS == type || Anim.TYPE_KEEP_JOURNAL == type || Anim.TYPE_REGISTER_POTIONS == type \
		|| Anim.TYPE_IDLEMARKER_NOTFOUND == type || Anim.TYPE_ABSORB_DRAGONSOUL == type
		FinishTakePotion()
	endIf
	Anim.Cleanup()
	Stop()
EndFunction

Event OnUpdate()
	SetStage(255)
EndEvent

Function SetDuration(float duration)
	;if 0.0 >= duration
	;	duration = 10.0
	if 60.0 < duration
		duration = 60.0
	endIf
	RegisterForSingleUpdate(duration)
EndFunction
Function StartWashingBody(int animtype, Actor player)
	(AnimCtrl as aaaKNNAnimControlQuest).SetThirdPersonCameraState()
	KNNPlugin_Utility.PlayerUnequipItems((AnimCtrl as aaaKNNAnimControlQuest).GetUnequipArmorSlotMasks(player, false))
	Utility.wait(1.0)
	if Anim.TYPE_PEEPED_WASHING_BODY == animtype
		Anim.Msg.ShowMessage(Anim.aaaKNNMsgPeepedSomeone)
		;if Anim.something && Anim.something as Actor
		;	actor act = Anim.something as Actor
		;	Debug.Trace(act.GetBaseObject().GetName() + " is peeping the player")
		;endIf
		if Anim.IsPCFemale
			KNNPlugin_Utility.SetExpressionState(0x10)
		else
			KNNPlugin_Utility.SetExpressionState(0x04)
		endIf
	else
		RegisterForAnimationEvent(player, "KNNEnterWashingBody")
	endIf
	Debug.SendAnimationEvent(player, Anim.animData[0])
	SetDuration(Anim.animData[1] as float)
EndFunction
Function FinishWashingBody(int animtype)
	if Anim.TYPE_PEEPED_WASHING_BODY == animtype
		if Anim.IsPCFemale
			KNNPlugin_Utility.ClearExpressionState(0x10)
		else
			KNNPlugin_Utility.ClearExpressionState(0x04)
		endIf
	else
		int handle = ModEvent.Create("CallOnPlayAnimCustomFunction")
		if handle
			ModEvent.PushString(handle, "")
			ModEvent.PushString(handle, "")
			ModEvent.PushFloat(handle, 0.0)
			ModEvent.PushForm(handle, none)
			ModEvent.Send(handle)
		endIf
	endIf
	(AnimCtrl as aaaKNNAnimControlQuest).ReturnCameraState()
	if 9 == Game.GetCameraState()
		Utility.Wait(1.0)
	endIf
	KNNPlugin_Utility.PlayerEquipItems()
EndFunction

Function StartReadingBook(int animtype, Actor player)
	int cameraState = (AnimCtrl as aaaKNNAnimControlQuest).SetThirdPersonCameraStateForBook()
	if -1 == cameraState
		SetStage(500)
		;Debug.Trace("[ESD debug log] couldn't get camera state")
		return
	elseIf 7 == cameraState
		GoToState("BOOK_READING")
		;Debug.Trace("[ESD debug log] RegisterForMenu")
		return
	endIf
	PlayReadingBook(animtype, player)
EndFunction
Function PlayReadingBook(int animtype, Actor player)
	(AnimCtrl as aaaKNNAnimControlQuest).UnequipShield(player)
	Utility.wait(0.1)
	Debug.SendAnimationEvent(player, Anim.animData[0])
	SetDuration(Anim.animData[1] as float)
EndFunction
State BOOK_READING
	Event OnBeginState()
		RegisterForCameraState()
		;Debug.Trace("[ESD debug log] RegisterForCameraState")
	EndEvent
	Event OnPlayerCameraState(int oldState, int newState)
		if (7 == oldState && 9 == newState) || (7 == oldState && 0 == newState)
			if 0 == newState
				GoToState("BOOK_SET_CAMERA_STATE")
			endIf
			UnRegisterForCameraState()
			;Debug.Trace("[ESD debug log] OnPlayerCameraState")
			if 0 == Game.GetCameraState()
				Game.forceThirdPerson()
				Utility.Wait(0.5)
			endIf
			PlayReadingBook(Anim.AnimType, playerAlias.GetActorReference())
		endIf
	EndEvent
EndState
State BOOK_SET_CAMERA_STATE
	Function FinishReadingBook()
		CleanupReadingBook(true)
	EndFunction
EndState
Function FinishReadingBook()
	CleanupReadingBook(false)
EndFunction
Function CleanupReadingBook(bool IsForcedCameraState)
	Actor player = playerAlias.GetActorReference()
	float time = 0.5
	if 0 != player.GetSitState() && player.GetAnimationVariableBool("bAnimationDriven")
		Debug.SendAnimationEvent(player, "idleStop")
		time = 1.0
	elseIf Anim.something && 0.0 < Anim.something.GetWeight()
		Debug.SendAnimationEvent(player, "KNNIdlebookReadExit")
		time = 2.0
	endIf
	Utility.Wait(time)
	if IsForcedCameraState
		Game.ForceFirstPerson()
	else
		(AnimCtrl as aaaKNNAnimControlQuest).ReturnCameraStateForBook()
	endIf
	(AnimCtrl as aaaKNNAnimControlQuest).EquipShield(player, none)
EndFunction

Function StartTakePotion(Actor player)
	(AnimCtrl as aaaKNNAnimControlQuest).UnequipShield(player)
	(AnimCtrl as aaaKNNAnimControlQuest).SetThirdPersonCameraState()
	Debug.SendAnimationEvent(player, Anim.animData[0])
	SetDuration(Anim.animData[1] as float)
EndFunction
Function FinishTakePotion()
	(AnimCtrl as aaaKNNAnimControlQuest).ReturnCameraState()
	(AnimCtrl as aaaKNNAnimControlQuest).EquipShield(playerAlias.GetActorReference(), none)
EndFunction

Function StartEating(int animtype, Actor player)
	if (AnimCtrl as aaaKNNAnimControlQuest).IsPlayMouthAnimWhileEating()
		RegisterForModEvent("CallPlayLipAnim", "OnPlayLipAnim")
		RegisterForAnimationEvent(player, "KNNPlayLipEatingAnim")
	endIf	
	int handle = ModEvent.Create("KNNSendMealAnim")
	if handle
		ModEvent.PushForm(handle, player)
		ModEvent.PushForm(handle, none)
		ModEvent.PushInt(handle, 1)
		ModEvent.PushInt(handle, 0)
		ModEvent.Send(handle)
	endIf
	(AnimCtrl as aaaKNNAnimControlQuest).UnequipShield(player)
	(AnimCtrl as aaaKNNAnimControlQuest).SetThirdPersonCameraState()
	Utility.wait(0.1)
	Debug.SendAnimationEvent(player, Anim.animData[0])
	SetDuration(Anim.animData[1] as float)
EndFunction
Function FinishEating()
	if "idleEatingStandingStart" == Anim.animData[0] || "ChairEatingStart" == Anim.animData[0]
		Debug.SendAnimationEvent(playerAlias.GetActorReference(), "idleStop")
	endIf
	(AnimCtrl as aaaKNNAnimControlQuest).ReturnCameraState()
	(AnimCtrl as aaaKNNAnimControlQuest).EquipShield(playerAlias.GetActorReference(), none)
EndFunction

Function StartDrinking(int animtype, Actor player)	
	int handle = ModEvent.Create("KNNSendMealAnim")
	if handle
		ModEvent.PushForm(handle, player)
		ModEvent.PushForm(handle, none)
		ModEvent.PushInt(handle, 2)
		ModEvent.PushInt(handle, 0)
		ModEvent.Send(handle)
	endIf
	(AnimCtrl as aaaKNNAnimControlQuest).UnequipShield(player)
	(AnimCtrl as aaaKNNAnimControlQuest).SetThirdPersonCameraState()
	Utility.wait(0.1)
	Debug.SendAnimationEvent(player, Anim.animData[0])
	SetDuration(Anim.animData[1] as float)
EndFunction
Function FinishDrinking(int animtype)
	if "idleDrinkingStandingStart" == Anim.animData[0] || "ChairDrinkingStart" == Anim.animData[0]
		Debug.SendAnimationEvent(playerAlias.GetActorReference(), "idleStop")
	elseIf Anim.TYPE_DRINKING_DRINKS_MOVING == animtype
		Debug.SendAnimationEvent(playerAlias.GetActorReference(), "OffsetStop")
	endIf
	(AnimCtrl as aaaKNNAnimControlQuest).ReturnCameraState()
	(AnimCtrl as aaaKNNAnimControlQuest).EquipShield(playerAlias.GetActorReference(), none)
EndFunction

Event OnAnimationEvent(ObjectReference akSource, string asEventName)
	if akSource != playerAlias.GetReference()
		return
	endIf
	if "KNNPlayLipEatingAnim" == asEventName; || "SoundPlay.NPCHumanEat" == asEventName
		;SendModEvent("CallPlayMouthAnim")
		int handle = ModEvent.Create("CallPlayLipAnim")
		if handle
			ModEvent.PushString(handle, "CallPlayLipAnim")
			ModEvent.PushString(handle, "")
			ModEvent.PushFloat(handle, 0.0)
			ModEvent.PushForm(handle, akSource)
			ModEvent.Send(handle)
		endIf
	elseIf "KNNEnterWashingBody" == asEventName
		RegisterForModEvent("CallOnPlayAnimCustomFunction", "OnPlayAnimCustomFunction")
		Actor player = akSource as Actor
		KNNPlugin_Utility.SetExpressionState(0x80000000)
		Utility.Wait(0.25)
		player.SetExpressionOverride(10, 20)
		MfgConsoleFunc.SetModifier(player, 0, 10)
		MfgConsoleFunc.SetModifier(player, 1, 10)
		MfgConsoleFunc.SetModifier(player, 8, 50)
		MfgConsoleFunc.SetPhoneme(player, 11, 10)
	elseIf "JumpDown" == asEventName
		ForcedQuestStop(akSource as Actor, false)
	endIf
EndEvent

Event OnPlayLipAnim(string eventName, string strArg, float numArg, Form sender)
	;Debug.Trace("sender : " + sender)
	Actor akTarget = sender as Actor
	if akTarget
		int[] mpIndex = new int[2]
		mpIndex[0] = 0
		mpIndex[1] = 6
		int[] mpGloaVal = new int[2]
		mpGloaVal[0] = MfgConsoleFunc.GetPhoneme(akTarget, 0)
		mpGloaVal[1] = MfgConsoleFunc.GetPhoneme(akTarget, 6)
		int[] mpCurrentVal = new int[2]
		mpCurrentVal[0] = mpGloaVal[0]
		mpCurrentVal[1] = mpGloaVal[1]
		int max = 70
		int min = 0
		int interval = 10
		while (mpCurrentVal[0] < max || mpCurrentVal[1] < max)
			int i = 0
			while i < mpCurrentVal.Length
				if max > mpCurrentVal[i]
					mpCurrentVal[i] = mpCurrentVal[i] + interval
					if max < mpCurrentVal[i]
						mpCurrentVal[i] = max
					endIf
					MfgConsoleFunc.SetPhoneme(akTarget, mpIndex[i], mpCurrentVal[i])
					;debug.trace("SetPhoneme [" + mpIndex[i] + "] : " + mpCurrentVal[i])
				endIf
				i += 1
			endwhile
		endwhile
		Utility.Wait(0.1)
		while (min < mpCurrentVal[0] || min < mpCurrentVal[1])
			int i = 0
			while i < mpCurrentVal.Length
				if min < mpCurrentVal[i]
					mpCurrentVal[i] = mpCurrentVal[i] - interval
					if min > mpCurrentVal[i]
						mpCurrentVal[i] = min
					endIf
					MfgConsoleFunc.SetPhoneme(akTarget, mpIndex[i], mpCurrentVal[i])
					;debug.trace("SetPhoneme [" + mpIndex[i] + "] : " + mpCurrentVal[i])
				endIf
				i += 1
			endwhile
		endwhile
		int exState = KNNPlugin_Utility.GetExpressionState()
		if 0 < exState
			if 0 < mpGloaVal[0] + mpGloaVal[1]
				Utility.Wait(0.1)
				int i = 0
				while i < mpGloaVal.Length
					if 0 < mpGloaVal[i]
						MfgConsoleFunc.SetPhoneme(akTarget, mpIndex[i], mpGloaVal[i])
						;debug.trace("SetPhoneme [" + mpIndex[i] + "] : " + mpGloaVal[i])
					endIf
					i += 1
				endwhile
			endIf
		endIf
	endIf
EndEvent

Event OnPlayAnimCustomFunction(string eventName, string strArg, float numArg, Form sender)
	Actor player = playerAlias.GetActorReference()
	if player
		MfgConsoleFunc.ResetPhonemeModifier(player)
		player.ClearExpressionOverride()
	endIf
	KNNPlugin_Utility.ClearExpressionState(0x80000000)
EndEvent