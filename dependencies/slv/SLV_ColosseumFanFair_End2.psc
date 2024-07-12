;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_ColosseumFanFair_End2 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
slaveGroup1.enable()
slaveGroup2.enable()
slaveGroup3.enable()
visitorGroup1.enable()

myScripts.SLV_Play2Sex(SLV_Michelangela.GetActorRef(),akSpeaker,"Boobjob", true)

SLV_ColosseumMainQuest.SetObjectiveCompleted(5000)
SLV_ColosseumMainQuest.SetStage(5500)

GetOwningQuest().SetObjectiveCompleted(9500)
GetOwningQuest().SetStage(10000)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
Quest Property SLV_ColosseumMainQuest Auto
ReferenceAlias Property SLV_Michelangela Auto

ObjectReference Property slaveGroup1 Auto
ObjectReference Property slaveGroup2 Auto
ObjectReference Property slaveGroup3 Auto
ObjectReference Property visitorGroup1 Auto

