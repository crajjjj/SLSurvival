;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_MainquestSpecial9End Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
ActorUtil.ClearPackageOverride(SLV_Maria.getactorref())
SLV_Maria.GetActorRef().evaluatePackage()
ActorUtil.ClearPackageOverride(SLV_MariaSlave.getactorref())
SLV_MariaSlave.GetActorRef().evaluatePackage()

if SLV_quest.getStage() == 7450
	SLV_quest.SetObjectiveCompleted(7450)
	SLV_quest.SetStage(7500)
endif

if SLV_quest.getStage() < 8350
	SLV_SlaveryEnforcementQuest.SetObjectiveCompleted(10500)
	SLV_SlaveryEnforcementQuest.SetStage(11000)
endif

GetOwningQuest().SetObjectiveCompleted(9500)
GetOwningQuest().SetStage(10000)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Quest Property SLV_quest Auto

ReferenceAlias Property SLV_Maria Auto 
ReferenceAlias Property SLV_MariaSlave Auto 

Quest Property SLV_SlaveryEnforcementQuest Auto