;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_WhiteWedding3_8 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(3000)
GetOwningQuest().SetStage(3500)

ActorUtil.ClearPackageOverride(SLV_Bellamy.GetActorRef())
SLV_Bellamy.GetActorRef().evaluatePackage()
ActorUtil.AddPackageOverride(SLV_Bellamy.GetActorRef(), SLV_FollowPlayer ,100)
SLV_Bellamy.GetActorRef().evaluatePackage()

ActorUtil.ClearPackageOverride(SLV_Murphy.GetActorRef())
SLV_Murphy.GetActorRef().evaluatePackage()
ActorUtil.AddPackageOverride(SLV_Murphy.GetActorRef(), SLV_FollowPlayer ,100)
SLV_Murphy.GetActorRef().evaluatePackage()

ActorUtil.ClearPackageOverride(SLV_JarlWhiterun.GetActorRef())
SLV_JarlWhiterun.GetActorRef().evaluatePackage()
ActorUtil.AddPackageOverride(SLV_JarlWhiterun.GetActorRef(), SLV_DragonsreachWeddingJarl ,100)
SLV_JarlWhiterun.GetActorRef().evaluatePackage()

myScripts.SLV_PlaySexKissingSynchron(Game.GetPlayer(),akSpeaker)
;myScripts.SLV_PlaySexAnimation(sexActors,"Leito Kissing","Kissing", true)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
ReferenceAlias Property SLV_Bellamy Auto 
ReferenceAlias Property SLV_Murphy Auto 

Package Property SLV_FollowPlayer Auto

ReferenceAlias Property SLV_JarlWhiterun Auto 
Package Property SLV_DragonsreachWeddingJarl Auto

