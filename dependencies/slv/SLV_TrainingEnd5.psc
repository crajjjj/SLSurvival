;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_TrainingEnd5 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
headshaving.NextProgressiveSlaveTats(game.getplayer())

SLV_SexTraining1.Reset() 
SLV_SexTraining1.Start() 
SLV_SexTraining1.SetActive(true) 
SLV_SexTraining1.SetStage(0)

GetOwningQuest().SetObjectiveCompleted(10500)
GetOwningQuest().SetStage(11000)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Quest Property SLV_SexTraining1 Auto
SLV_HeadShaving Property headshaving auto
