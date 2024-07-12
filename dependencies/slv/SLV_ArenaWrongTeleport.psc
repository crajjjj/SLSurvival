Scriptname SLV_ArenaWrongTeleport extends ObjectReference  


Event OnTriggerEnter(ObjectReference akActionRef)
If akActionRef == Game.GetPlayer() ; This condition ensures that only the player will trigger this code
	 doPlayerCheck(true)
EndIf
EndEvent

Event OnTriggerLeave(ObjectReference akActionRef)
If akActionRef == Game.GetPlayer() ; This condition ensures that only the player will trigger this code
	 doPlayerCheck(false)
EndIf
EndEvent

function doPlayerCheck(bool enter)
if SLV_ArenaFightQuest.getstage() == 1000 || SLV_ArenaShowQuest.getstage() == 1000
	if enter
		myScripts.SLV_DisplayInformation("Arena trigger entered")
	else		
		myScripts.SLV_DisplayInformation("Arena trigger left")
	endif
	myScripts.SLV_PlayerMoveTo(arenaDoor)
EndIf
endfunction

Quest Property SLV_ArenaFightQuest auto
Quest Property SLV_ArenaShowQuest auto
ObjectReference Property arenaDoor auto
SLV_Utilities Property myScripts Auto