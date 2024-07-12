;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_MundusTask13 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
SLV_WhiterunTask.Reset() 
SLV_WhiterunTask.Start() 
SLV_WhiterunTask.SetActive(true) 
SLV_WhiterunPissPotCounter.setValue(0)
if !SLV_WhiterunTask.UpdateCurrentInstanceGlobal(SLV_WhiterunPissPotCounter)
  Debug.notification("Failed to update SLV_WhiterunPissPotCounter value for quest")
endif

SLV_WhiterunTask.SetStage(0)

myScripts.SLV_GetMoreSubmissive(true,1)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
Quest Property SLV_WhiterunTask Auto
GlobalVariable Property SLV_WhiterunPissPotCounter auto
