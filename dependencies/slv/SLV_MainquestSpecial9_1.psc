;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_MainquestSpecial9_1 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(0)
GetOwningQuest().SetStage(500)

horseOutside.enable()
SLV_Maria.GetActorRef().enable()
SLV_Maria.GetActorRef().moveto(horseOutside)

SLV_MariaSlave.GetActorRef().enable()
SLV_MariaSlave.GetActorRef().moveto(horseOutside)

ActorUtil.AddPackageOverride(SLV_Maria.GetActorRef(), SLV_DoNothing ,100)
SLV_Maria.GetActorRef().evaluatePackage()
ActorUtil.AddPackageOverride(SLV_MariaSlave.GetActorRef(), SLV_DoNothing ,100)
SLV_MariaSlave.GetActorRef().evaluatePackage()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
ReferenceAlias Property SLV_Maria Auto 
ReferenceAlias Property SLV_MariaSlave Auto 
Package Property SLV_DoNothing Auto
Actor Property horseOutside auto
