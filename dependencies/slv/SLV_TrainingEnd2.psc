;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname SLV_TrainingEnd2 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
SLV_PlayerHasToReport.setvalue(1)

periodicReporting.StartPeriodicReportingTimer()

GetOwningQuest().SetObjectiveCompleted(9100)
GetOwningQuest().SetStage(9500)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_PeriodicReporting Property periodicReporting Auto
GlobalVariable Property SLV_PlayerHasToReport Auto 

