;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_GladiatorMain_1 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(500)
GetOwningQuest().SetStage(1000)

SLV_GladiatorSubQuest.reset()
SLV_GladiatorSubQuest.start()
SLV_GladiatorSubQuest.setstage(0)
SLV_GladiatorSubQuest.SetActive(true)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Quest Property SLV_GladiatorSubQuest Auto
