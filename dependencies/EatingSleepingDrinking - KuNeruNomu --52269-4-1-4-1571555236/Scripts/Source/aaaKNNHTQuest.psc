Scriptname aaaKNNHTQuest extends Quest

;aaaKNN_mfg_Script Property MFG auto
Quest Property ExpressionQuest auto
;GlobalVariable Property aaaKNNHTPriority auto
;GlobalVariable Property aaaKNNHTInterVal auto
;Actor Property thePlayer auto

;Spell Property aaaKNNPlayIdleAnimSpell auto
;float HTInterval = 0.0
;int HTPriority = 1

;Event OnInit()
	;GoToState("")
	;UpdateValue()
;EndEvent

;Function UpdateValue()					;from MCM
	;HTPriority = aaaKNNHTPriority.GetValueInt()
	;HTInterVal = aaaKNNHTInterVal.GetValue()
;EndFunction

;Function StartHeadTrack()					;from MCM
	;if HTPriority == 0
	;	if GetState() != "HUD"
	;		GoToState("HUD")
	;	endIf
	;elseIf HTPriority == 1
	;	if GetState() != "SpeakerHUD"
	;		GoToState("SpeakerHUD")
			;Debug.Notification("GoToState : PrioritySpeaker")
	;	endIf
	;elseIf HTPriority == 2
	;	if GetState() != "Speaker"
	;		GoToState("Speaker")
	;	endIf
	;else
		;if GetState() != ""
		;	GoToState("")
		;endIf
	;endIf
	;if thePlayer.GetAnimationVariableBool("bHeadTrackSpine")
	;	thePlayer.SetAnimationVariableBool("bHeadTrackSpine", true)
	;endIf
	;if thePlayer.GetAnimationVariableInt("IsNPC") != 1
	;	thePlayer.SetAnimationVariableInt("IsNPC", 1)
	;endIf
;EndFunction

Function EndHeadTrack()					;from MCM
	;if GetState() != ""
	;	GoToState("")
	;endIf
	;MFG.ExState = 0
	Actor player = Game.GetPlayer()
	if !player
		return
	endIf
	player.SetLookAt(player)
	player.ClearLookAt()
	player.SetHeadTracking(false)
	player.SetAnimationVariableInt("IsNPC", 0)
	if !player.GetAnimationVariableBool("bHeadTrackSpine")
		player.SetAnimationVariableBool("bHeadTrackSpine", true)
	endIf
	;thePlayer.ResetExpressionOverrides()
	(ExpressionQuest as aaaKNNExpressionClearQuest).RemovePlayerExpressionOverride(player)
EndFunction

;State HUD
	;Event OnUpdate()
	;	ObjectReference realTarget = KNNPlugin_Utility.GetPlayerHeadingTargetRef()
	;	if realTarget
	;		if realTarget == Game.GetCurrentCrosshairRef()
	;			if 0.0 < HTInterval
	;				RegisterForSingleUpdate(HTInterval)
	;			endIf
	;		else
	;			OnUpdateLookAtTarget()
	;		endIf
	;	endIf
	;EndEvent
;EndState

;State Speaker
	;Event OnUpdate()
	;	ObjectReference realTarget = KNNPlugin_Utility.GetPlayerHeadingTargetRef()
	;	if realTarget as Actor
	;		Actor speaker = realTarget as Actor
	;		if KNNPlugin_Utility.IsInDialoueWithPlayer(speaker)
	;			if 0.0 < HTInterval
	;				RegisterForSingleUpdate(HTInterval)
	;			endIf
	;		else
	;			if KNNPlugin_Utility.IsCloseWithPlayer(speaker) && KNNPlugin_Utility.GetIsActorTalking(speaker)
	;				if 0.0 < HTInterval
	;					RegisterForSingleUpdate(HTInterval)
	;				endIf
	;			else
	;				OnUpdateLookAtTarget()
	;			endIf
	;		endIf
	;	endIf
	;EndEvent
;EndState

;State SpeakerHUD
	;Event OnUpdate()
	;	ObjectReference realTarget = KNNPlugin_Utility.GetPlayerHeadingTargetRef()
	;	if realTarget
	;		if realTarget as Actor
	;			Actor speaker = realTarget as Actor
	;			if KNNPlugin_Utility.IsCloseWithPlayer(speaker) && KNNPlugin_Utility.GetIsActorTalking(speaker) && 0.0 < HTInterval
	;				RegisterForSingleUpdate(HTInterval)
	;			elseIf realTarget == Game.GetCurrentCrosshairRef() && 0.0 < HTInterval
	;				RegisterForSingleUpdate(HTInterval)
	;			else
	;				OnUpdateLookAtTarget()
	;			endIf				
	;		else
	;			if realTarget != Game.GetCurrentCrosshairRef()
	;				OnUpdateLookAtTarget()
	;			else
	;				if 0.0 < HTInterval
	;					RegisterForSingleUpdate(HTInterval)
	;				endIf
	;			endIf
	;		endIf
	;	endIf
	;EndEvent
;EndState

Event OnPlayerLookTargetRef(Actor player, objectreference akTarget)
	;Debug.Trace("OnPlayerLookTargetRef")
	if !player || !akTarget
		return
	endIf
	Player.SetHeadTracking(true)
	player.SetLookAt(akTarget, false)
	;if 0.0 < HTInterval
	;	RegisterForSingleUpdate(HTInterval)
	;endIf
EndEvent

;Event OnPlayerClearTargetRef(actor akPlayer)
;	;Debug.Notification("OnPlayerClearTargetRef")
;	UnregisterForUpdate()
;	thePlayer.SetLookAt(thePlayer)
;	thePlayer.SetAnimationVariableBool("bHeadTrackSpine", false)
;EndEvent

;Function OnUpdateLookAtTarget()
;	UnregisterForUpdate()
;	thePlayer.SetLookAt(thePlayer)
;	thePlayer.SetAnimationVariableBool("bHeadTrackSpine", false)
	;if !KNNPlugin_Utility.IsSkipExpression()
		;int currentBasicNeedsState = KNNPlugin_Utility.GetBasicNeedsState()
		;int KNNBasicNeedsState = 3
;		int currentExstate = KNNPlugin_Utility.GetExpressionState()
;		if 0 != Math.LogicalAnd(currentExstate, 0x04 + 0x10 + 0x20 + 0x80000000)
;			return
;		elseIf 0 < thePlayer.GetSleepState()
;			if 0 != Math.LogicalAnd(currentExstate, 0x08)
				;Debug.Trace("ClearExpressionState")
;				KNNPlugin_Utility.ClearExpressionState(0x40)
;			endIf
;			return
;		endIf
;		MfgConsoleFunc.ResetPhonemeModifier(thePlayer)
;		thePlayer.SetExpressionOverride(7, 50)
	;endIf
;EndFunction

;Event OnDisableHeadTracking()
;	;Debug.Notification("OnDisableHeadTracking")
;	UnregisterForUpdate()
;	thePlayer.SetLookAt(thePlayer)
;	thePlayer.SetAnimationVariableBool("bHeadTrackSpine", false)
;	(ExpressionQuest as aaaKNNExpressionQuestScript).ClearExpressionValues()
;	thePlayer.SetAnimationVariableInt("IsNPC", 0)
;EndEvent

Spell Property aaaKNNHTPlayIdleSpell auto
Event OnPlayIdleAnim(Actor g_thePlayer)
	aaaKNNHTPlayIdleSpell.Cast(g_thePlayer)
EndEvent
