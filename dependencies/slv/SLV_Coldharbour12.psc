;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_Coldharbour12 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(5500)
GetOwningQuest().SetStage(6000)

actor[] sexActors = new actor[5]
sexActors[0] = Game.GetPlayer()
sexActors[1] = SLV_FuckSlave1.getActorRef()
sexActors[2] = SLV_FuckSlave2.getActorRef()
sexActors[3] = SLV_FuckSlave3.getActorRef()
sexActors[4] = SLV_FuckSlave4.getActorRef()

myScripts.SLV_decreaseWeight()
myScripts.SLV_Gangbang(sexActors)
myScripts.SLV_decreaseWeight()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
ReferenceAlias Property SLV_FuckSlave1 Auto
ReferenceAlias Property SLV_FuckSlave2 Auto
ReferenceAlias Property SLV_FuckSlave3 Auto
ReferenceAlias Property SLV_FuckSlave4 Auto
