;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_WhiteWedding1_26 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(9000)
GetOwningQuest().SetStage(9500)

ActorUtil.ClearPackageOverride(SLV_Abigale.GetActorRef())
SLV_Abigale.GetActorRef().evaluatePackage()
ActorUtil.ClearPackageOverride(SLV_Marcus.GetActorRef())
SLV_Marcus.GetActorRef().evaluatePackage()

myScripts.SLV_Play2Sex(SLV_Abigale.GetActorRef(),akSpeaker,"Sex", true)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
ReferenceAlias Property SLV_Abigale Auto 
ReferenceAlias Property SLV_Marcus Auto 

