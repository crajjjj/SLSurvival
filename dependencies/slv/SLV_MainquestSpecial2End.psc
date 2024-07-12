;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname SLV_MainquestSpecial2End Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
ActorUtil.ClearPackageOverride( SLV_Brutus.getActorRef())
SLV_Brutus.getActorRef().evaluatePackage()

SLV_quest.SetObjectiveCompleted(3250)
SLV_quest.SetStage(3300)

if ThisMenu.SkipScenes
	myScripts.SLV_miniLevelUp()
else
	myScripts.SLV_RewardPlayer(SLV_Zaid, SLV_Brutus)
endif

GetOwningQuest().SetObjectiveCompleted(6500)
GetOwningQuest().SetStage(7000)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
SLV_MCMMenu Property ThisMenu Auto
Quest Property SLV_quest Auto
ReferenceAlias Property SLV_Zaid Auto 
ReferenceAlias Property SLV_Brutus Auto 