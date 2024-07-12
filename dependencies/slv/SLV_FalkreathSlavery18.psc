;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_FalkreathSlavery18 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
SLV_quest.SetObjectiveCompleted(2800)
SLV_quest.SetStage(3000)

myUtilities.SLV_PikeMoodChange(true,1)
myUtilities.SLV_miniLevelUp()

GetOwningQuest().SetObjectiveCompleted(5500)
GetOwningQuest().SetStage(6000)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myUtilities auto
Quest Property SLV_quest Auto
