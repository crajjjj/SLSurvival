;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_SolitudeBardsCollege22 Extends TopicInfo Hidden

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

ActorUtil.AddPackageOverride(Jarl.getActorRef(), SLV_DoNothing ,100)
Jarl.getActorRef().evaluatePackage()

Dog.getActorRef().enable()
Horse.getActorRef().enable()

Cross1.enable()
Cross2.enable()

SLV_UseFollowerSex.setValue(1)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Package Property bardstage Auto
Package Property SLV_DoNothing Auto

ReferenceAlias Property Jarl Auto 
ObjectReference Property Cross1 Auto
ObjectReference Property Cross2 Auto

ObjectReference Property BardsMarker Auto

ReferenceAlias Property Dog Auto 
ReferenceAlias Property Horse Auto
GlobalVariable Property SLV_UseFollowerSex Auto 


