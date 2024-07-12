;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_WhiterunEnslaveFollower1 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
myScripts.SLV_enslavementNPC(akSpeaker)
slaveManager.SLV_AddNewSlave(akSpeaker)

myScripts.SLV_enslavementChains(akSpeaker)

GetOwningQuest().SetObjectiveCompleted(0)
GetOwningQuest().SetStage(1000)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
SLV_SlaveManager Property slaveManager auto
