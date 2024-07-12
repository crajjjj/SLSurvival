;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_MainquestSpecial10Sex3 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
ActorUtil.ClearPackageOverride(akSpeaker )
akSpeaker.evaluatePackage()

ActorUtil.ClearPackageOverride(SLV_Maul.GetActorRef())
SLV_Maul.GetActorRef().evaluatePackage()

ActorUtil.ClearPackageOverride(SLV_Saul.GetActorRef())
SLV_Saul.GetActorRef().evaluatePackage()

ActorUtil.ClearPackageOverride(SLV_Brynjolf.GetActorRef())
SLV_Brynjolf.GetActorRef().evaluatePackage()

ActorUtil.ClearPackageOverride(SLV_Hemming.GetActorRef())
SLV_Hemming.GetActorRef().evaluatePackage()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
ReferenceAlias Property SLV_Maul Auto 
ReferenceAlias Property SLV_Saul Auto 
ReferenceAlias Property SLV_Brynjolf Auto 
ReferenceAlias Property SLV_Hemming Auto 
