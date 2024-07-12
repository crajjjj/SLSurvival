;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_EnslaveFemaleSlaver2 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
ActorUtil.ClearPackageOverride(SLV_Zaid.getactorref())
SLV_Zaid.GetActorRef().evaluatePackage()

ActorUtil.ClearPackageOverride(SLV_Eric.getactorref())
SLV_Eric.GetActorRef().evaluatePackage()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
ReferenceAlias Property SLV_Zaid Auto 
ReferenceAlias Property SLV_Eric Auto 
