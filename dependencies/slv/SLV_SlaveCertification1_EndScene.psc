;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_SlaveCertification1_EndScene Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Game.getplayer().additem(SLV_SlaveCertificate.getReference())

ActorUtil.ClearPackageOverride(SLV_JarlWhiterun.GetActorRef())
SLV_JarlWhiterun.GetActorRef().evaluatePackage()
ActorUtil.ClearPackageOverride(SLV_Amren.GetActorRef())
SLV_Amren.GetActorRef().evaluatePackage()
ActorUtil.ClearPackageOverride(SLV_Nazeem.GetActorRef())
SLV_Nazeem.GetActorRef().evaluatePackage()
ActorUtil.ClearPackageOverride(SLV_Pike.GetActorRef())
SLV_Pike.GetActorRef().evaluatePackage()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
;DEVIOUS DEVICES PROPERTIES
Book Property SLV_Certificate  Auto  
ReferenceAlias Property SLV_SlaveCertificate Auto

ReferenceAlias Property SLV_JarlWhiterun Auto 
ReferenceAlias Property SLV_Pike Auto 
ReferenceAlias Property SLV_Amren Auto
ReferenceAlias Property SLV_Nazeem Auto 
