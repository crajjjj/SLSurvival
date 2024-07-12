;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_FinnTraining15 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetStage(2800)

finnTimer.StartFinnTrainingTimer()
myScripts.SLV_GetMoreSubmissive(true,1)

Int Handle = ModEvent.Create("SlaverunReloaded_ManipulateDD")

If (Handle)
	ModEvent.PushForm(Handle, Self)
	ModEvent.PushForm(Handle, Game.getPlayer())
	ModEvent.PushBool(Handle, true)
	ModEvent.PushBool(Handle, false)
	ModEvent.PushBool(Handle, false)
	ModEvent.PushBool(Handle, false)
	ModEvent.PushBool(Handle, false)
	ModEvent.PushBool(Handle, false)
	ModEvent.PushBool(Handle, false)
	ModEvent.PushBool(Handle, false)
	ModEvent.PushBool(Handle, false)
	ModEvent.PushBool(Handle, false)
	ModEvent.PushBool(Handle, false)
	ModEvent.PushBool(Handle, false)
	ModEvent.PushBool(Handle, false)
	ModEvent.PushBool(Handle, false)
	ModEvent.PushBool(Handle, false)
	ModEvent.PushBool(Handle, true)
	ModEvent.PushBool(Handle, false)
	ModEvent.PushBool(Handle, false)
	ModEvent.PushBool(Handle, false)
	ModEvent.PushBool(Handle, false)
	ModEvent.PushBool(Handle, false)
	ModEvent.PushBool(Handle, false)
	ModEvent.PushBool(Handle, false)
	ModEvent.PushBool(Handle, false)
	ModEvent.PushBool(Handle, false)
	ModEvent.PushBool(Handle, false)
	ModEvent.Send(Handle)
EndIf

;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
SLV_FinnTraining_Timer Property finnTimer Auto
