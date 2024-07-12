;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_RavenRockTaskFrea4 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(1000)
GetOwningQuest().SetStage(1500)

ActorUtil.ClearPackageOverride(SLV_Fanari.getactorref())
SLV_Fanari.GetActorRef().evaluatePackage()

ActorUtil.AddPackageOverride(SLV_Fanari.GetActorRef(), SLV_IdleSilent,100)
SLV_Fanari.GetActorRef().evaluatePackage()

SLV_DrunkenSkaal.GetActorRef().enable()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
ReferenceAlias Property SLV_Fanari Auto 
ReferenceAlias Property SLV_DrunkenSkaal Auto 

Package Property SLV_IdleSilent Auto
