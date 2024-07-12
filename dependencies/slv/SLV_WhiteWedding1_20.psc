;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_WhiteWedding1_20 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(6500)
GetOwningQuest().SetStage(7000)

ActorUtil.ClearPackageOverride(SLV_Abigale.GetActorRef())
SLV_Abigale.GetActorRef().evaluatePackage()

myScripts.SLV_Play2Sex(SLV_Abigale.GetActorRef(),akSpeaker,"Blowjob", true)

timer.StartWhiteWedding1Timer(3)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_WhiteWedding1Timer Property timer Auto
SLV_Utilities Property myScripts auto
ReferenceAlias Property SLV_Abigale Auto 
