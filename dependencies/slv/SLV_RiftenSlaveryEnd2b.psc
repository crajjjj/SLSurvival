;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_RiftenSlaveryEnd2b Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
SLV_quest.SetObjectiveCompleted(5800)
SLV_quest.SetStage(6000)

myScripts.SLV_miniLevelUp()
myScripts.SLV_PikeMoodChange(false,1)

GetOwningQuest().SetObjectiveCompleted(8500)
GetOwningQuest().SetStage(9500)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
Quest Property SLV_quest Auto


