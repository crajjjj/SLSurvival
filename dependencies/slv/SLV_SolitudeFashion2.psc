;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_SolitudeFashion2 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(1000)
getowningquest().setstage(1500)

ActorUtil.ClearPackageOverride(Taarie.getactorref())
Taarie.getactorref().evaluatePackage()

Utility.wait(2.0)

ActorUtil.AddPackageOverride(akSpeaker, SLV_BluePlace ,100)
akSpeaker.evaluatePackage()
ActorUtil.AddPackageOverride(Taarie.getActorRef(), SLV_BluePlace ,100)
Taarie.getActorRef().evaluatePackage()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Package Property SLV_BluePlace Auto
ReferenceAlias Property Taarie Auto 
