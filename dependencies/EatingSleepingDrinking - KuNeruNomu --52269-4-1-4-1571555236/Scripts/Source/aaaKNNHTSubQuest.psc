Scriptname aaaKNNHTSubQuest extends Quest

Event OnPlayerClearTargetRef(actor Player)
	;Debug.Trace("OnPlayerClearTargetRef")
	Player.SetLookAt(Player)
	;Player.ClearLookAt()
	Player.SetHeadTracking(false)

	;if 0 != Player.GetAnimationVariableInt("IsNPC")
	;	Player.SetAnimationVariableInt("IsNPC", 0)
	;endIf
	;if !IsOnlyLook
	;	Player.SetAnimationVariableBool("bHeadTrackSpine", false)
	;	Player.SetAnimationVariableInt("IsNPC", 0)
	;endIf
EndEvent

;Event OnDisableHeadTracking(actor Player)
	;Debug.Notification("OnDisableHeadTracking")
;	UnregisterForUpdate()
;	Player.SetLookAt(Player)
	;Player.SetAnimationVariableBool("bHeadTrackSpine", false)
	;(ExpressionQuest as aaaKNNExpressionQuestScript).ClearExpressionValues()
	;Player.SetAnimationVariableInt("IsNPC", 0)
;EndEvent