;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_WhiteWedding2_2 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(500)
GetOwningQuest().SetStage(800)

horseOutside.enable()
SLV_Aden.GetActorRef().enable()
SLV_Aden.GetActorRef().moveto(horseOutside)

SLV_Raven.GetActorRef().enable()
SLV_Raven.GetActorRef().moveto(horseOutside)

SLV_Octavia.GetActorRef().enable()
SLV_Octavia.GetActorRef().moveto(horseOutside)

ActorUtil.AddPackageOverride(SLV_Aden.GetActorRef(), SLV_DoNothing ,100)
SLV_Aden.GetActorRef().evaluatePackage()
ActorUtil.AddPackageOverride(SLV_Raven.GetActorRef(), SLV_DoNothing ,100)
SLV_Raven.GetActorRef().evaluatePackage()
ActorUtil.AddPackageOverride(SLV_Octavia.GetActorRef(), SLV_DoNothing ,100)
SLV_Octavia.GetActorRef().evaluatePackage()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
ReferenceAlias Property SLV_Aden Auto 
ReferenceAlias Property SLV_Raven Auto 
ReferenceAlias Property SLV_Octavia Auto 

Package Property SLV_DoNothing Auto
Actor Property horseOutside auto
