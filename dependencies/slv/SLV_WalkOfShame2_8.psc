;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_WalkOfShame2_8 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
if ThisMenu.SkipScenes
	GetOwningQuest().SetObjectiveCompleted(3500)
	GetOwningQuest().SetStage(4000)
	return
endif

ActorUtil.ClearPackageOverride(akSpeaker)
akSpeaker.evaluatePackage()
ActorUtil.ClearPackageOverride(SLV_Murphy.GetActorRef())
SLV_Murphy.GetActorRef().evaluatePackage()

ActorUtil.AddPackageOverride(akSpeaker,  SLV_FollowPlayer,100)
akSpeaker.evaluatePackage()
ActorUtil.AddPackageOverride(SLV_Murphy.GetActorRef(),  SLV_FollowPlayer,100)
akSpeaker.evaluatePackage()


SLV_EnforcerIgnorePC.setValue(1)
myScripts.SLV_PlayScene(PunishScene)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_MCMMenu Property ThisMenu auto
SLV_Utilities Property myScripts auto
Scene Property PunishScene  Auto 
ReferenceAlias Property SLV_Murphy Auto
GlobalVariable Property SLV_EnforcerIgnorePC  Auto  
Package Property SLV_FollowPlayer Auto
