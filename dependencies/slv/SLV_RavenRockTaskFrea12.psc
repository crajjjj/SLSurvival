;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_RavenRockTaskFrea12 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
ravenrockmain.SetObjectiveCompleted(1500)
ravenrockmain.setStage(2000)

GetOwningQuest().SetObjectiveCompleted(9500)
GetOwningQuest().SetStage(10000)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Quest Property ravenrockmain Auto
