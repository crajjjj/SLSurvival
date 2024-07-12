;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_SexSlaveTraining4_5 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(2000)
GetOwningQuest().SetStage(2500)

SLV_Dremora1.GetActorRef().enable()
SLV_Dremora2.GetActorRef().enable()

SLV_Dremora1.getActorRef().addItem(SLV_Whip)
SLV_Dremora2.getActorRef().addItem(SLV_Whip)

ActorUtil.ClearPackageOverride(SLV_Ivana.GetActorRef())
SLV_Ivana.GetActorRef().evaluatePackage()

ActorUtil.AddPackageOverride(SLV_Ivana.GetActorRef(), SLV_FollowPlayer ,100)
SLV_Ivana.GetActorRef().evaluatePackage()

ActorUtil.AddPackageOverride(SLV_Dremora.GetActorRef(), SLV_DungeonCenter,100)
SLV_Dremora.GetActorRef().evaluatePackage()
ActorUtil.AddPackageOverride(SLV_Dremora1.GetActorRef(), SLV_DungeonCenter,100)
SLV_Dremora1.GetActorRef().evaluatePackage()
ActorUtil.AddPackageOverride(SLV_Dremora2.GetActorRef(), SLV_DungeonCenter,100)
SLV_Dremora2.GetActorRef().evaluatePackage()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
ReferenceAlias Property SLV_Dremora Auto 
ReferenceAlias Property SLV_Dremora1 Auto 
ReferenceAlias Property SLV_Dremora2 Auto 
ReferenceAlias Property SLV_Ivana Auto 
Package Property SLV_FollowPlayer Auto
Package Property SLV_DungeonCenter Auto
Weapon Property SLV_Whip Auto

