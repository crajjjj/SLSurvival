;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_MainquestSpecial10Endb Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
SLV_quest.SetObjectiveCompleted(10250)
SLV_quest.SetStage(10300)

myUtilities.SLV_miniLevelUp()

GetOwningQuest().SetObjectiveCompleted(9500)
GetOwningQuest().SetStage(10000)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myUtilities auto
Quest Property SLV_quest Auto
