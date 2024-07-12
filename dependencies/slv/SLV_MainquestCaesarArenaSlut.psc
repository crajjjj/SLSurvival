;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_MainquestCaesarArenaSlut Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
SLV_ArenaSlutTask.Reset() 
SLV_ArenaSlutTask.Start() 
SLV_ArenaSlutTask.SetActive(true) 

SLV_ArenaSlutCount.setValue(0)
if !SLV_ArenaSlutTask.UpdateCurrentInstanceGlobal(SLV_ArenaSlutCount)
  Debug.notification("Failed to update SLV_ArenaSlutTask value for quest")
endif

SLV_ArenaSlutTask.SetStage(0)
;END CODE
EndFunction
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
GlobalVariable Property SLV_ArenaSlutCount Auto
Quest Property SLV_ArenaSlutTask Auto

