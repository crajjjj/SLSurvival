Scriptname aaaKNNPlayerGoToBedQuest extends Quest

Quest Property PlayAnimCtrl auto
ReferenceAlias Property playerAlias auto
GlobalVariable Property aaaKNNIsHT auto
GlobalVariable Property IsEnableExpression auto
bool IsEnabledExpression = false

Function StartPlayerAI() ; From Self.Scene -> SF_PlayerGoToBedScene_05B7CEFD
	;Debug.Trace("StartPlayerAI")
	IsEnabledExpression = 0 != IsEnableExpression.GetValueInt()
	if IsEnabledExpression
		;Debug.Trace("SetExpressionState")
		KNNPlugin_Utility.SetExpressionState(0x40)
		Utility.Wait(0.2)
		Actor player = playerAlias.GetActorReference()
		MfgConsoleFunc.ResetPhonemeModifier(player)
		player.ClearExpressionOverride()
	endIf
	Game.SetPlayerAIDriven(true)
EndFunction

Function StartScene()
	;Debug.Trace("StartScene")
	SendModEvent("KNNSendSleepAnim") ; jump aaaKNNPlayPerkBedAnimQuest.psc
	Game.DisablePlayerControls(true, true, false, false, false, true, false, false)
	(PlayAnimCtrl as aaaKNNAnimControlQuest).ForceThirdPersonCameraState()
	KNNPlugin_Utility.PlayerUnequipItems((PlayAnimCtrl as aaaKNNAnimControlQuest).GetUnequipArmorSlotMasks(playerAlias.GetActorReference(), true))
	RegisterForMenu("Journal Menu")
	;Game.SetPlayerAIDriven(true)
EndFunction

Function SetShowSleepMenu()
	;Debug.Trace("SetShowSleepMenu")
	Actor player = playerAlias.GetActorReference()
	if !player || 3 != player.GetSleepState()
		Self.Stop()
		return
	endIf
	RegisterForMenu("Sleep/Wait Menu")
	GTB_PluginScript.ShowSleepWaitMenu(true)
	RegisterForControl("Activate")
EndFunction

Function WakeUpScene()
	;Debug.Trace("Phase 3 End : WakeUpScene")
	(PlayAnimCtrl as aaaKNNAnimControlQuest).ResetThirdPersonCameraPosition()
EndFunction

Function CheckScene()
	;Debug.Trace("Phase 2 End : CheckScene")
	if 200 != GetStage()
		if Self.IsRunning()			
			;Self.Stop()
			SetStage(200)
		endIf
	endIf
EndFunction

Function EndScene()
	;int IsHT = aaaKNNIsHT.GetValueInt()
	UnregisterForAllControls()
	UnregisterForAllMenus()
	Game.SetPlayerAIDriven(false)
	Game.EnablePlayerControls()
	(PlayAnimCtrl as aaaKNNAnimControlQuest).ForceReturnCameraState()
	if 0 != aaaKNNIsHT.GetValueInt()
		Actor player = playerAlias.GetActorReference()
		if player && 0 != player.GetAnimationVariableInt("IsNPC")
			player.SetAnimationVariableInt("IsNPC", 0)
		endIf
	endIf
	if IsEnabledExpression
		KNNPlugin_Utility.ClearExpressionState(0x40)
	endIf
	KNNPlugin_Utility.PlayerEquipItems()
	;Debug.Trace("Num of package : " + ActorUtil.CountPackageOverride(Game.GetPlayer()))
EndFunction

Event OnMenuClose(String MenuName)
	if "Sleep/Wait Menu" == MenuName
		;Debug.Trace("OnMenuClose : " + MenuName)
		;if Utility.IsInMenuMode()
		;	return
		;endIf
		;RegisterForControl("Activate")
		UnregisterForAllMenus()
		;RegisterForControl("Run")
		;RegisterForControl("Forward")
		;RegisterForControl("Back")
		;RegisterForControl("Strafe Left")
		;RegisterForControl("Strafe Right")
	elseIf "Journal Menu" == MenuName
		if Self.IsRunning()
			;Debug.Trace("KNN_SLEEPING " + MenuName)
			UnregisterForAllMenus()
			UnregisterForAllControls()
			Self.Stop()
		endIf
	endIf
EndEvent

Event OnControlDown(string control)
	if control == "Activate"; || control == "Run" || control == "Forward" || control == "Back" || control == "Strafe Left" || control == "Strafe Right"		
		if 200 != GetStage()
			UnregisterForAllMenus()
			UnregisterForAllControls()
			SetStage(200)
		endIf
	endIf
EndEvent