;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_CatchingJane3 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(500)
getowningquest().setstage(750)

SLV_Jane.GetActorRef().enable()
SLV_Jane.GetActorRef().moveto(whiterunMarker)
SLV_Constantine.GetActorRef().enable()
SLV_Constantine.GetActorRef().moveto(whiterunMarker)

ActorUtil.AddPackageOverride(SLV_Jane.GetActorRef(), SLV_DoNothing ,100)
SLV_Jane.GetActorRef().evaluatePackage()
ActorUtil.AddPackageOverride(SLV_Constantine.GetActorRef(), SLV_DoNothing ,100)
SLV_Constantine.GetActorRef().evaluatePackage()

myScripts.SLV_Play2Sex(Game.GetPlayer(),akSpeaker, "Anal", true)
SLV_Jane.GetActorRef().moveto(whiterunMarker)
SLV_Constantine.GetActorRef().moveto(whiterunMarker)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
ReferenceAlias Property SLV_Jane Auto 
ReferenceAlias Property SLV_Constantine Auto 

Package Property SLV_DoNothing Auto
ObjectReference Property whiterunMarker auto
SLV_Utilities Property myScripts auto
