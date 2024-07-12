Scriptname _KNNHipbagQuest extends Quest

Quest Property AnimCtrl auto
ReferenceAlias Property strage auto
ReferenceAlias Property player auto
;Spell Property HipBagSpell auto
bool IsHipbagAnim = false
bool IsPlayerFemale = true

Function RegisterEvent(Actor g_thePlayer)
	RegisterForMenu("ContainerMenu")
	;RegisterForControl("Forward")
	;RegisterForControl("Back")
	;RegisterForControl("Strafe Left")
	;RegisterForControl("Strafe Right")
	;RegisterForControl("Move")
	;RegisterForAnimationEvent(g_thePlayer, "JumpDown")
EndFunction

Form[] Function GetStrageItems()
	Form[] arr = new form[2]
	arr[0] = Game.GetFormFromFile(0x000E812F, "EatingSleepingDrinking.esp")	;Hipbag
	arr[1] = Game.GetFormFromFile(0x000E812D, "EatingSleepingDrinking.esp")	;Sack
	return arr
EndFunction

Function StartUp()
	Actor g_thePlayer = player.GetActorReference()	
	Form[] strageArray = GetStrageItems()
	(strage as _KNNHipbagAlias).StartUp(strageArray)	
	string eventName = ""
	IsPlayerFemale = (AnimCtrl as aaaKNNAnimControlQuest).GetGender(g_thePlayer)	
	if 0 < strageArray.Length && strageArray[0] && strageArray[0] as Armor && g_thePlayer.IsEquipped(strageArray[0])
		IsHipbagAnim = true
		if !IsPlayerFemale
			eventName = "KNNActivateHipBagEnter_M"
		else
			eventName = "KNNActivateHipBagEnter"
		endIf
	else
		if !IsPlayerFemale
			eventName = "KNNActivateBagEnterA_M"
		else
			eventName = "KNNActivateBagEnterA"
		endIf
	endIf
	RegisterEvent(g_thePlayer)
	;HipBagSpell.Cast(g_thePlayer)
	(AnimCtrl as aaaKNNAnimControlQuest).ForceThirdPersonCameraState()
	Debug.SendAnimationEvent(g_thePlayer, eventName)
	Utility.wait(2.0)
	strage.GetReference().Activate(g_thePlayer, true)
EndFunction

Function CleanUp()
	;UnregisterForAllControls()	
	UnregisterForAllMenus()
	;player.GetActorReference().DispelSpell(HipBagSpell)
	(strage as _KNNHipbagAlias).CleanUp()
	self.Stop()
EndFunction

Event OnMenuClose(String MenuName)
	if MenuName == "ContainerMenu"
		Utility.wait(0.5)
		string eventName = ""
		float waitTime = 0.0
		if IsHipbagAnim
			if !IsPlayerFemale
				eventName = "KNNActivateHipBagExit_M"
			else
				eventName = "KNNActivateHipBagExit"
			endIf
			waitTime = 1.07
		else
			if !IsPlayerFemale
				eventName = "KNNActivateBagExitA_M"
			else
				eventName = "KNNActivateBagExitA"
			endIf
			waitTime = 1.86
		endIf
		Debug.SendAnimationEvent(player.GetReference(), eventName)
		Utility.wait(waitTime)
		(AnimCtrl as aaaKNNAnimControlQuest).ForceReturnCameraState()
		CleanUp()
	endIf
EndEvent

;Event OnAnimationEvent(ObjectReference akSource, string asEventName)
;	if player.GetReference() != akSource
;		return
;	endIf
;	if asEventName == "JumpDown"
;		;Debug.Notification("OnAnimationEvent : KNNDrinkExit or KNNDrinkMeadEnd")
;		CleanUp()
;	endIf
;EndEvent

;Event OnControlDown(string control)
;	If control == "Forward" || control == "Back" || control == "Strafe Left" || control == "Strafe Right" || control == "Move"
;		;Debug.Notification("OnControlDown")
;		Debug.SendAnimationEvent(player.GetReference(), "IdleForceDefaultState")
;		CleanUp()
;	EndIf
;EndEvent

ObjectReference[] Property ContainerList auto
;Spell Property aaaKNNPlayActiHipbagSpell auto
;ObjectReference Property ActivateContainer auto
;int Property  BagType auto
Keyword Property _KNNActivateHipBagKey auto
;強制アニメーション
;containerType
;1 : Hipbag
;2 : sack
Event OnActivateHipBag(Actor g_thePlayer, int containerType, bool IsSecondaryContainer)
	int index = -1
	if 2 == containerType
		if !IsSecondaryContainer
			index = 2
		else
			index = 3
		endIf
	elseif 1 == containerType
		if !IsSecondaryContainer
			index = 0
		else
			index = 1
		endIf
	endIf
	if 0 <= index && index < ContainerList.Length && ContainerList[index] && ContainerList[index].GetBaseObject() as Container && g_thePlayer
		;_KNNActivateHipBagKey.SendStoryEventAndWait(none, g_thePlayer, ContainerList[index], 0, 0)
		_KNNActivateHipBagKey.SendStoryEvent(none, g_thePlayer, ContainerList[index], 0, 0)
	endIf
EndEvent