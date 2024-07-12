;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_MainquestSlaverTraining2 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
getOwningquest().SetObjectiveCompleted(1400)
getOwningquest().SetStage(1430)

SLV_SexTraining.Reset() 
SLV_SexTraining.Start() 
SLV_SexTraining.SetActive(true) 
SLV_SexTraining.SetStage(0)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Quest Property SLV_SexTraining Auto
