;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_CatchingJasmin17 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(7500)
GetOwningQuest().SetStage(8000)

ActorUtil.ClearPackageOverride(SLV_Jasmin.getactorref())
SLV_Jasmin.GetActorRef().evaluatePackage()

ActorUtil.AddPackageOverride(SLV_Jasmin.GetActorRef(), SLV_DoNothing ,100)
SLV_Jasmin.GetActorRef().evaluatePackage()

waittimer.CatchingJasminTimer()
myScripts.SLV_Play2Sex(SLV_Jasmin.GetActorRef(),akSpeaker, "Blowjob", true)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_CatchingJasmin_Timer Property waittimer auto
ReferenceAlias Property SLV_Jasmin Auto 
Package Property SLV_DoNothing Auto
SLV_Utilities Property myScripts auto