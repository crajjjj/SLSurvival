;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_SlaveHunter2 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
ActorUtil.ClearPackageOverride(SLV_BountyHunter1.getActorRef())
SLV_BountyHunter1.getActorRef().evaluatePackage()

ActorUtil.AddPackageOverride(SLV_BountyHunter1.getActorRef(), SLV_FollowPlayer ,100)
SLV_BountyHunter1.getActorRef().evaluatePackage()

ActorUtil.ClearPackageOverride(SLV_BountyHunter2.getActorRef())
SLV_BountyHunter2.getActorRef().evaluatePackage()

ActorUtil.AddPackageOverride(SLV_BountyHunter2.getActorRef(), SLV_FollowPlayer ,100)
SLV_BountyHunter2.getActorRef().evaluatePackage()

if ThisMenu.SkipScenes
	GetOwningQuest().SetObjectiveCompleted(1500)
	GetOwningQuest().SetStage(2000)
	return
endif
;myScripts.SLV_DeviousUnEquipActor2(PlayerRef ,false,false,false,false,false,false,true,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false)

myScripts.SLV_PlayScene(PunishScene)

;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Actor Property PlayerRef auto
Package Property SLV_FollowPlayer Auto
ReferenceAlias Property SLV_BountyHunter1 Auto
ReferenceAlias Property SLV_BountyHunter2 Auto
SLV_MCMMenu Property ThisMenu auto
SLV_Utilities Property myScripts auto
Scene Property PunishScene  Auto 
