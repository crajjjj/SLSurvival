;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_SlaveCertification1_Whips Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
SLV_Ivana.getActorRef().addItem(SLV_Whip)
SLV_Diamond.getActorRef().addItem(SLV_Whip)

debug.SendAnimationEvent(SLV_Ivana.getActorRef(), "IdleForceDefaultState")
debug.SendAnimationEvent(SLV_Diamond.getActorRef(), "IdleForceDefaultState")
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
ReferenceAlias Property SLV_Ivana Auto
ReferenceAlias Property SLV_Diamond Auto
Weapon Property SLV_Whip Auto