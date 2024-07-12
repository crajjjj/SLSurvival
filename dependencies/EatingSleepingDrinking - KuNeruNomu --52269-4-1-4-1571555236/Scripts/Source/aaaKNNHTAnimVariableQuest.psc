Scriptname aaaKNNHTAnimVariableQuest extends Quest

Event OnPlayerSetAnimVariable(Actor player)
	;Debug.Trace("OnPlayerSetAnimVariable")
	if !player.GetAnimationVariableBool("bHeadTrackSpine")
		player.SetAnimationVariableBool("bHeadTrackSpine", true)
	endIf
	if 1 != player.GetAnimationVariableInt("IsNPC")
		player.SetAnimationVariableInt("IsNPC", 1)
	endIf
EndEvent