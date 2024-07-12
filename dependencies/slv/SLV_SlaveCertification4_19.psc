;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_SlaveCertification4_19 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
if SLV_Main.getStage() == 8450
	SLV_Main.SetObjectiveCompleted(8450)
	SLV_Main.SetStage(8500)
endif

SLV_SlaveryEnforcementQuest.SetObjectiveCompleted(12500)
SLV_SlaveryEnforcementQuest.SetStage(13000)

GetOwningQuest().SetObjectiveCompleted(9500)
getowningquest().setstage(10000)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Quest Property SLV_SlaveryEnforcementQuest Auto
Quest Property SLV_Main Auto
