;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_CatchingIvana1 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(0)
GetOwningQuest().SetStage(500)

myScripts.SLV_IvanaMoodChange(false,1)

SLV_Ivana.GetActorRef().enable()
ActorUtil.ClearPackageOverride(SLV_Ivana.getactorref())
SLV_Ivana.GetActorRef().evaluatePackage()

ActorUtil.AddPackageOverride(SLV_Ivana.GetActorRef(), SLV_FollowPlayer ,100)
SLV_Ivana.GetActorRef().evaluatePackage()

SLV_Slaver.ForceRefTo(akSpeaker)
;Debug.notification("New Slaver= " + SLV_Slaver.getActorRef().getActorBase().getName())

myScripts.SLV_PlayScene(PunishScene)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Scene Property PunishScene  Auto
SLV_Utilities Property myScripts auto
ReferenceAlias Property SLV_Ivana Auto 
Package Property SLV_FollowPlayer Auto
ReferenceAlias Property SLV_Slaver Auto