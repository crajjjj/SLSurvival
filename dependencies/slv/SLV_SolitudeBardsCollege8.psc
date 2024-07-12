;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_SolitudeBardsCollege8 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(3500)
GetOwningQuest().SetStage(4000)

ActorUtil.ClearPackageOverride(akSpeaker)
akSpeaker.evaluatePackage()
ActorUtil.ClearPackageOverride(Jarl.getActorRef())
Jarl.getActorRef().evaluatePackage()

ActorUtil.AddPackageOverride(akSpeaker, bardstage ,100)
akSpeaker.evaluatePackage()
akSpeaker.moveto(BardsMarker)

ActorUtil.AddPackageOverride(Jarl.getActorRef(), bardstage ,100)
Jarl.getActorRef().evaluatePackage()
Jarl.getActorRef().moveto(BardsMarker)

Dog.getActorRef().enable()
Horse.getActorRef().enable()

Cross1.enable()
Cross2.enable()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Package Property bardstage Auto
ReferenceAlias Property Jarl Auto 
ObjectReference Property Cross1 Auto
ObjectReference Property Cross2 Auto

ObjectReference Property BardsMarker Auto

ReferenceAlias Property Dog Auto 
ReferenceAlias Property Horse Auto


