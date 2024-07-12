;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_EnslaveFemaleSlaver1 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
ActorUtil.ClearPackageOverride(SLV_Brutus.getactorref())
SLV_Brutus.GetActorRef().evaluatePackage()

ActorUtil.ClearPackageOverride(SLV_Sven.getactorref())
SLV_Sven.GetActorRef().evaluatePackage()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
ReferenceAlias Property SLV_Brutus Auto 
ReferenceAlias Property SLV_Sven Auto 

