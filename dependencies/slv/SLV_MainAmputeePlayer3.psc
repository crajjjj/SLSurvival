;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_MainAmputeePlayer3 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
ActorUtil.ClearPackageOverride(SLV_Zaid.getactorref())
SLV_Zaid.GetActorRef().evaluatePackage()

ActorUtil.ClearPackageOverride(akSpeaker )
akSpeaker.evaluatePackage()

int bodypart = SLV_AmputeePlayer.getValue() as int

Amputee.SLV_ApplyProstetics(Game.GetPlayer(), bodypart)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
ReferenceAlias Property SLV_Zaid Auto
SLV_Amputee Property Amputee Auto
GlobalVariable Property SLV_AmputeePlayer Auto 