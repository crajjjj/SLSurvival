;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_RiverwoodSlavery11 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
SLV_quest.SetObjectiveCompleted(1800)
SLV_quest.SetStage(2000)

myUtilities.SLV_miniLevelUp()

GetOwningQuest().SetObjectiveCompleted(3000)
GetOwningQuest().SetStage(3500)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myUtilities auto
Quest Property SLV_quest Auto

