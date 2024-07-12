;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_MainquestSpecial8_10b Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(4500)
GetOwningQuest().SetStage(7500)

Slave.GetActorRef().enable()
Slave.GetActorRef().moveto(Game.GetPlayer())
ActorUtil.AddPackageOverride(Slave.GetActorRef(), followPlayer ,100)
Slave.GetActorRef().evaluatePackage()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
ReferenceAlias Property Slave Auto 
Package Property followPlayer Auto