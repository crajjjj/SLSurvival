;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname SLV_DailyTaskFreeFuck Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
SLV_WhiterunFreeFuck.setValue(0)
if !SLV_WhiterunTask.UpdateCurrentInstanceGlobal(SLV_WhiterunFreeFuck)
  Debug.notification("Failed to update SLV_WhiterunFreeFuck value for quest")
endif

SLV_WhiterunTask.Reset() 
SLV_WhiterunTask.Start() 
SLV_WhiterunTask.SetActive(true) 
SLV_WhiterunTask.SetStage(0)
SLV_WhiterunFreeFuck.setValue(0)
if !SLV_WhiterunTask.UpdateCurrentInstanceGlobal(SLV_WhiterunFreeFuck)
  Debug.notification("Failed to update SLV_WhiterunFreeFuck value for quest")
endif

SLV_WhiterunTask.SetStage(0)
;END CODE
EndFunction
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Quest Property SLV_WhiterunTask Auto
GlobalVariable Property SLV_WhiterunFreeFuck Auto
