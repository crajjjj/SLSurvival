;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_Abolitionism12 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(5000)
GetOwningQuest().SetStage(5500)

ActorUtil.AddPackageOverride(Draemora.GetActorRef(), IdleNPC,100)
Draemora.GetActorRef().evaluatePackage()
ActorUtil.AddPackageOverride(Thalmor.GetActorRef(), IdleNPC,100)
Thalmor.GetActorRef().evaluatePackage()

Draemora.GetActorRef().moveto(OblivionWayMarker)
Thalmor.GetActorRef().moveto(OblivionWayMarker)
Draemora.GetActorRef().SetAV("Aggression", 2)
Thalmor.GetActorRef().SetAV("Aggression", 2)
Draemora.GetActorRef().SetAV("Confidence", 3)
Thalmor.GetActorRef().SetAV("Confidence", 3)

Thalmor.GetActorRef().getActorBase().setEssential(false)
Thalmor.GetActorRef().getActorBase().setProtected(false)
Draemora.GetActorRef().getActorBase().setEssential(false)
Draemora.GetActorRef().getActorBase().setProtected(false)

TrapDoor.enable()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
ReferenceAlias Property Draemora Auto 
ReferenceAlias Property Thalmor Auto 
ObjectReference Property OblivionWayMarker Auto
Package Property IdleNPC Auto
ObjectReference Property TrapDoor Auto

