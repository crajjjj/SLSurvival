;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_MenuSoftEvent7 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
;Int Handle = ModEvent.Create("MME_AddMilkSlave")
Int Handle = ModEvent.Create("SlaveToggle")

If (Handle)
	ModEvent.PushForm(Handle, Game.GetPlayer())
	ModEvent.Send(Handle)
	;Debug.notification("Event send")
else
	Debug.notification("Event failed")
EndIf
myScripts.SLV_GetMoreSubmissive(true,1)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto 
