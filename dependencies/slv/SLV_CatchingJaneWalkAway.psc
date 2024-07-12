;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_CatchingJaneWalkAway Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
ActorUtil.ClearPackageOverride(SLV_Jane.getactorref())
SLV_Jane.GetActorRef().evaluatePackage()

ActorUtil.ClearPackageOverride(SLV_Constantine.getactorref())
SLV_Constantine.GetActorRef().evaluatePackage()

Utility.wait(10.0)

SLV_Jane.getactorref().disable()
SLV_Constantine.getactorref().disable()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
ReferenceAlias Property SLV_Jane Auto 
ReferenceAlias Property SLV_Constantine Auto 

