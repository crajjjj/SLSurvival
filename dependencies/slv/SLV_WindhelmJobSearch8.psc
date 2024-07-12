;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_WindhelmJobSearch8 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
WindhelmSlavery.SetObjectiveCompleted(1500)
WindhelmSlavery.setStage(2000)

myScripts.SLV_Play2Sex(Game.GetPlayer(),akSpeaker, "Sex", true)

GetOwningQuest().SetObjectiveCompleted(3500)
GetOwningQuest().SetStage(4000)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
Quest Property WindhelmSlavery Auto

