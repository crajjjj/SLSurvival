;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_Mainquest2_End Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
if ThisMenu.SleepingSlavery
	sendModEvent("SlaverunReloaded_ResetSlavery")
else
	sendModEvent("SlaverunReloaded_EndEnslavement")
endif

GetOwningQuest().SetObjectiveCompleted(12000)
GetOwningQuest().SetStage(50000)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_MCMMenu Property ThisMenu auto