;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_RiftenSlavery11 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(4500)
GetOwningQuest().SetStage(5000)

SLV_RiftenTask2.Reset() 
SLV_RiftenTask2.Start() 
SLV_RiftenViagrixCount .setValue(0)
if !SLV_RiftenTask2.UpdateCurrentInstanceGlobal(SLV_RiftenViagrixCount )
  Debug.notification("Failed to update SLV_RiftenViagrixCount value for quest")
endif
SLV_RiftenTask2.SetStage(0)
SLV_RiftenTask2.SetActive(true)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Quest Property SLV_RiftenTask2 Auto
GlobalVariable Property SLV_RiftenViagrixCount Auto
