;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_DeadSlaveWalking4a Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(1500)
getowningquest().setstage(2500)

akSpeaker.addToFaction(slaveMaster)

SLV_SexSlaveCertification2Quest.Reset() 
SLV_SexSlaveCertification2Quest.Start() 
SLV_SexSlaveCertification2Quest.SetStage(0)
SLV_SexSlaveCertification2Quest.SetActive(true)

myScripts.SLV_BrutusMoodChange(false,1)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
Faction Property slaveMaster Auto
Quest Property SLV_SexSlaveCertification2Quest Auto
