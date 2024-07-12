;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_CatchingIvana_Sex1 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
ActorUtil.RemovePackageOverride(SLV_Diamond.GetActorRef(), SLV_Kneeling )
SLV_Diamond.GetActorRef().evaluatePackage()

myScripts.SLV_PlaySex3Synchron(SLV_Diamond.getActorRef(), akSpeaker, SLV_Murphy.getActorRef(), "Blowjob, Anal", true)
SLV_SexIsRunning.setvalue(0)

ActorUtil.AddPackageOverride(SLV_Diamond.GetActorRef(), SLV_Kneeling )
SLV_Diamond.GetActorRef().evaluatePackage()

debug.SendAnimationEvent(SLV_Diamond.getActorRef(), "ZazAPC058")
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
GlobalVariable Property SLV_SexIsRunning Auto 
ReferenceAlias Property SLV_Diamond Auto 
ReferenceAlias Property SLV_Murphy Auto
Package Property SLV_Kneeling Auto

