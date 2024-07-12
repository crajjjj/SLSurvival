;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_ColosseumMain_17 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(8000)
GetOwningQuest().SetStage(8500)

ActorUtil.ClearPackageOverride(akSpeaker)
akSpeaker.evaluatePackage()
ActorUtil.AddPackageOverride(akSpeaker, SLV_FollowPlayer ,100)
akSpeaker.evaluatePackage()

ActorUtil.ClearPackageOverride(SLV_Michelangela.getActorRef())
SLV_Michelangela.getActorRef().evaluatePackage()
ActorUtil.AddPackageOverride(SLV_Michelangela.getActorRef(), SLV_FollowPlayer ,100)
SLV_Michelangela.getActorRef().evaluatePackage()
myScripts.SLV_IvanaMoodChange(true,1) 

myScripts.SLV_Play2Sex(Game.GetPlayer(),akSpeaker,"Anal", true)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
Package Property SLV_FollowPlayer Auto
ReferenceAlias Property SLV_Michelangela Auto
