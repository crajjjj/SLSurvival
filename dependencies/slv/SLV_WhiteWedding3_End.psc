;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_WhiteWedding3_End Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
SLV_Bellamy.getActorRef().setFactionRank(PotentialFollowerFaction,0)
SLV_Bellamy.getActorRef().setFactionRank(CurrentlFollowerFaction ,-1)

if SLV_DeadSlaveWalkingQuest.getStage() >= 6000 && SLV_DeadSlaveWalkingQuest.getStage() <= 7000 
	SLV_DeadSlaveWalkingQuest.SetObjectiveCompleted(SLV_DeadSlaveWalkingQuest.getStage())
	SLV_DeadSlaveWalkingQuest.SetStage(7500)
endif

if SLV_CelebrateSlaveryquest.isrunning()
	SLV_CelebrateSlaveryquest.FailAllObjectives()
	SLV_CelebrateSlaveryquest.SetStage(9500)
endif

GetOwningQuest().SetObjectiveCompleted(9500)
GetOwningQuest().SetStage(10000)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Quest Property SLV_CelebrateSlaveryQuest Auto 
Quest Property SLV_DeadSlaveWalkingQuest Auto 

Faction Property PotentialFollowerFaction auto
Faction Property CurrentlFollowerFaction auto

ReferenceAlias Property SLV_Bellamy Auto
