;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_SolitudeSlavery8 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(4000)
getowningquest().setstage(4500)

SLV_SolitudeTask1.Reset() 
SLV_SolitudeTask1.Start() 
SLV_SolitudeTask1.SetStage(0)
SLV_SolitudeTask1.SetActive(true)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Quest Property SLV_SolitudeTask1 Auto
