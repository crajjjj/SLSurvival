;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_WhiteWedding1_7 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(2200)
GetOwningQuest().SetStage(2500)

horseOutside.enable()
SLV_Marcus.GetActorRef().enable()
SLV_Marcus.GetActorRef().moveto(horseOutside)

SLV_Abigale.GetActorRef().enable()
SLV_Abigale.GetActorRef().moveto(horseOutside)

ActorUtil.AddPackageOverride(SLV_Marcus.GetActorRef(), SLV_DoNothing ,100)
SLV_Marcus.GetActorRef().evaluatePackage()
ActorUtil.AddPackageOverride(SLV_Abigale.GetActorRef(), SLV_DoNothing ,100)
SLV_Abigale.GetActorRef().evaluatePackage()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
ReferenceAlias Property SLV_Marcus Auto 
ReferenceAlias Property SLV_Abigale Auto 
Package Property SLV_DoNothing Auto
Actor Property horseOutside auto
