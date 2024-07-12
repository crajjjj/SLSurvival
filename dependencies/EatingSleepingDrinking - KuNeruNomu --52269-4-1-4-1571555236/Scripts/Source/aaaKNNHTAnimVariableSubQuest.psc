Scriptname aaaKNNHTAnimVariableSubQuest extends Quest

Event OnPlayerClearAnimVariable(actor Player, bool IsOnlyFaceTarget)
	;Debug.Trace("OnPlayerClearAnimVariable")
	if Player.GetAnimationVariableBool("bHeadTrackSpine")
		Player.SetAnimationVariableBool("bHeadTrackSpine", false)
	endIf
	if !IsOnlyFaceTarget
		if Player.GetAnimationVariableInt("IsNPC")
			Player.SetAnimationVariableInt("IsNPC", 0)
		endIf
	endIf
EndEvent