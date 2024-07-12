;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_CatchingJane2_12 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(5500)
getowningquest().setstage(6000)

ActorUtil.ClearPackageOverride(akSpeaker)
akSpeaker.evaluatePackage()

ActorUtil.ClearPackageOverride(SLV_Igor.getactorref())
SLV_Igor.GetActorRef().evaluatePackage()

ActorUtil.ClearPackageOverride(SLV_Fang.getactorref())
SLV_Fang.GetActorRef().evaluatePackage()

ActorUtil.ClearPackageOverride(SLV_Jane.getactorref())
SLV_Jane.GetActorRef().evaluatePackage()

ActorUtil.AddPackageOverride(SLV_Jane.GetActorRef(), SLV_JaneUseCross ,100)
SLV_Jane.GetActorRef().evaluatePackage()

ActorUtil.AddPackageOverride(SLV_Jane.GetActorRef(), SLV_JaneWalkToCross ,60)
SLV_Jane.GetActorRef().evaluatePackage()

actor[] sexActors = new actor[2]
sexActors[0] = Game.GetPlayer()
sexActors[1] = akSpeaker

myScripts.SLV_PlaySexAnimation(sexActors,"Leito Kissing","Kissing", true)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
ReferenceAlias Property SLV_Jane Auto 
Package Property SLV_JaneWalkToCross Auto
Package Property SLV_JaneUseCross Auto
ReferenceAlias Property SLV_Igor Auto 
ReferenceAlias Property SLV_Fang Auto 
