;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_SexSlaveTraining3_End Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
SLV_Main.SetObjectiveCompleted(2450)
SLV_Main.SetStage(2500)

ActorUtil.ClearPackageOverride(SLV_Ivana.getactorref())
SLV_Ivana.GetActorRef().evaluatePackage()

GetOwningQuest().SetObjectiveCompleted(9500)
getowningquest().setstage(10000)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Quest Property SLV_Main Auto
ReferenceAlias Property SLV_Ivana Auto 
