Scriptname aaaKNNPlayPerkAnimUtilityQuest extends Quest

float Function GetOffsetPosZ(ObjectReference akTargetRef, Actor akActor)
	float PosZ = akTargetRef.GetPositionZ() - akActor.GetPositionZ()
	return PosZ
EndFunction

float Function GetActorHeight(Actor akActor)
	return akActor.GetHeight() * akActor.GetScale()
EndFunction

Function SetActorAngle(ObjectReference akTargetRef, Actor akActor)
	if akActor != Game.GetPlayer()
		return
	endIf
	float offsetAng = akActor.GetHeadingAngle(akTargetRef)
	;float marginAng
	;if offsetAng < 0
	;	marginAng = -offsetAng - 22.5
	;else
	;	marginAng = offsetAng - 22.5
	;endIf
	if offsetAng > 22.5 || -22.5 > offsetAng
		KNNPlugin_Utility.SetPlayerAngleZ(offsetAng)
		;akActor.SetAngle(0.0, 0.0, akActor.GetAngleZ() + offsetAng)
	endIf
EndFunction