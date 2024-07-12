;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_Cheat47 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(0)
GetOwningQuest().SetStage(2000)

SLV_Bellamy.getActorRef().addToFaction(slaveMaster)

if SLV_quest.getstage() == 6450
	SLV_quest.SetObjectiveCompleted(6450)
	SLV_quest.SetStage(6500)
else
	GetOwningQuest().SetObjectiveCompleted(2000)
	GetOwningQuest().SetStage(2500)

	SLV_SlaveCertification2Quest.Reset() 
	SLV_SlaveCertification2Quest.Start() 
	SLV_SlaveCertification2Quest.SetStage(0)
	SLV_SlaveCertification2Quest.SetActive(true)
endif
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
Quest Property SLV_quest Auto
Faction Property slaveMaster Auto
ReferenceAlias Property SLV_Bellamy Auto
Quest Property SLV_SlaveCertification2Quest Auto