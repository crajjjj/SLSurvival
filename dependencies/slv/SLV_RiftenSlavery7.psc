;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_RiftenSlavery7 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(2000)
GetOwningQuest().SetStage(2500)

SLV_RiftenTask1.Reset() 
SLV_RiftenTask1.Start() 
SLV_RiftenTask1.SetStage(0)
SLV_RiftenTask1.SetActive(true)

Utility.wait(5.0)

Maul.GetActorRef().moveto(Game.GetPlayer())
ActorUtil.AddPackageOverride(Maul.getActorRef(), followPlayer ,100)
Maul.getActorRef().evaluatePackage()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Quest Property SLV_RiftenTask1 Auto
ReferenceAlias Property Maul Auto 
Package Property followPlayer Auto

