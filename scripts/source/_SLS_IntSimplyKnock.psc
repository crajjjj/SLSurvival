Scriptname _SLS_IntSimplyKnock Hidden
{Simply Knock's script API for _SLS_Knock. The only SLS script that names Simply Knock's types, so
it is only called when SL Survival - Simply Knock.esp (and so Simply Knock) is installed.}

SimplyKnockMainScript Function Knock() Global
	Return Quest.GetQuest("_SimplyKnockMainQuest") as SimplyKnockMainScript
EndFunction

Actor Function CurrentSpeaker() Global
	SimplyKnockMainScript K = Knock()
	If K
		Return K.CurrentSpeaker
	EndIf
	Return None
EndFunction

ObjectReference Function CurrentDoor() Global
	SimplyKnockMainScript K = Knock()
	If K
		Return K.CurrentDoor
	EndIf
	Return None
EndFunction

Function SetResult_Succeeded() Global
	SimplyKnockMainScript K = Knock()
	If K
		K.SetResult_Succeeded()
	EndIf
EndFunction

Function SetResult_FailedInitial() Global
	SimplyKnockMainScript K = Knock()
	If K
		K.SetResult_FailedInitial()
	EndIf
EndFunction

; The other side of akDoor, from Simply Knock's SKSE plugin (the one it finds houses with).
ObjectReference Function LinkedDoor(ObjectReference akDoor) Global
	Return SimplyKnockSKSE.GetLinkedDoor(akDoor)
EndFunction

; Simply Knock's LinkedDoor alias: SetResult_Succeeded() fills it with the inside door, and its
; script unlocks that door whenever the owner locks it with the player inside.
ReferenceAlias Function LinkedDoorAlias() Global
	SimplyKnockMainScript K = Knock()
	If K
		Return K.DoorAlias
	EndIf
	Return None
EndFunction
