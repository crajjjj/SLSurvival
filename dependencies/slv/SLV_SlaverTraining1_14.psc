;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_SlaverTraining1_14 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
ActorUtil.ClearPackageOverride(akSpeaker)
akSpeaker.evaluatePackage()

ActorUtil.AddPackageOverride(akSpeaker , SLV_SlaveFollowPlayer ,100)
akSpeaker.evaluatePackage()

GetOwningQuest().SetObjectiveCompleted(5500)
getowningquest().setstage(6000)

myScripts.SLV_enslavementNPC(akSpeaker)
slaveManager.SLV_AddNewSlave(akSpeaker)

myScripts.SLV_enslavementChains(akSpeaker)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Package Property SLV_SlaveFollowPlayer Auto
SLV_Utilities Property myScripts auto
SLV_SlaveManager Property slaveManager auto
