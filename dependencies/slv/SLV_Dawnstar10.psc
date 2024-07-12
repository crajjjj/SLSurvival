;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname SLV_Dawnstar10 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
SLV_quest.SetObjectiveCompleted(3800)
SLV_quest.SetStage(4000)

myUtilities.SLV_miniLevelUp()
myUtilities.SLV_PikeMoodChange(false,1)

GetOwningQuest().SetObjectiveCompleted(3000)
GetOwningQuest().SetStage(3500)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myUtilities auto
Quest Property SLV_quest Auto

