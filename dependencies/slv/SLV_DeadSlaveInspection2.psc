;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_DeadSlaveInspection2 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Int Handle = ModEvent.Create("SlaverunReloaded_EscapedSlave")
If (Handle)
	ModEvent.PushForm(Handle, akSpeaker )
	ModEvent.Send(Handle)
EndIf
Game.getPlayer().removeFromFaction(SLV_FactionEscapedSlave)
if SLV_SlaveHunterQuest.isRunning()
	SLV_SlaveHunterQuest.SetObjectiveCompleted(SLV_SlaveHunterQuest.getstage())
	SLV_SlaveHunterQuest.setstage(10000)
endif
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Quest Property SLV_SlaveHunterQuest Auto
Faction Property SLV_FactionEscapedSlave auto
