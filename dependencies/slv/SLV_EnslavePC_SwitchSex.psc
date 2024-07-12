;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_EnslavePC_SwitchSex Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
ActorUtil.RemovePackageOverride(SLV_Diamond.GetActorRef(), SLV_Kneeling )
SLV_Diamond.GetActorRef().evaluatePackage()

actor[] sexActors = new actor[1]
sexActors[0] = SLV_Diamond.getActorRef()

myScripts.SLV_PlaySexSynchron(sexActors,"Masturbation,F", false)

ActorUtil.AddPackageOverride(SLV_Diamond.GetActorRef(), SLV_Kneeling )
SLV_Diamond.GetActorRef().evaluatePackage()

debug.SendAnimationEvent(SLV_Diamond.getActorRef(), "ZazAPC058")
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto 
ReferenceAlias Property SLV_Diamond Auto
Package Property SLV_Kneeling Auto


