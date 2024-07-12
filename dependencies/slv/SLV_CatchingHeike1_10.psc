;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_CatchingHeike1_10 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(5000)
getowningquest().setstage(5500)

ActorUtil.ClearPackageOverride(akSpeaker)
akSpeaker.evaluatePackage()

ActorUtil.AddPackageOverride(akSpeaker, SLV_WalkToWindhelmInn,100)
akSpeaker.evaluatePackage()

ActorUtil.ClearPackageOverride(SLV_Igor.getactorref())
SLV_Igor.GetActorRef().evaluatePackage()
;SLV_Igor.GetActorRef().moveto(dragonsreachMarker)

waittimer.StartCatchingHeikeTimer()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_CatchingHeike_Timer  Property waittimer auto
Package Property SLV_WalkToWindhelmInn Auto
ReferenceAlias Property SLV_Igor Auto 
ObjectReference Property dragonsreachMarker Auto
