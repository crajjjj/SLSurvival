;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_WhiterunExecuteSlave1 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(0)
getowningquest().setstage(500)

Slave.GetActorRef().enable()
Slave.GetActorRef().moveto(Game.GetPlayer())

Utility.wait(2.0)
ActorUtil.AddPackageOverride(Slave.GetActorRef(), followPlayer ,100)
Slave.GetActorRef().evaluatePackage()

Executer.GetActorRef().enable()
Slave2.enable()
Slave3.enable()
ActorUtil.AddPackageOverride(Slave2, crucified ,100)
Slave2.evaluatePackage()
ActorUtil.AddPackageOverride(Slave3, crucified ,100)
Slave3.evaluatePackage()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
ReferenceAlias Property Slave Auto 
ReferenceAlias Property Executer Auto 
Actor Property Slave2  Auto  
Actor Property Slave3  Auto  
Package Property followPlayer Auto
Package Property crucified Auto
