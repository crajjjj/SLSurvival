;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname SLV_TrainingEnd1 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
myScripts.SlaveName(Game.GetPlayer())

Debug.MessageBox("Your slave name is now " + Game.GetPlayer().GetActorbase().getName())

SLV_PlayerHasToReport.setvalue(1)
periodicReporting.StartPeriodicReportingTimer()

GetOwningQuest().SetObjectiveCompleted(9000)
GetOwningQuest().SetStage(9500)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_HeadShaving Property myScripts auto
SLV_PeriodicReporting Property periodicReporting Auto
GlobalVariable Property SLV_PlayerHasToReport Auto 
