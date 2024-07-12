;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 0
Scriptname SLV_Cheat12 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_2
Function Fragment_2(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(GetOwningQuest().getStage())
GetOwningQuest().SetStage(10000)

if MCMMenu.SlaveReNaming
	myScripts.SlaveName(Game.GetPlayer())
endif

SLV_PlayerHasToReport.setvalue(1)
periodicReporting.StartPeriodicReportingTimer()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_PeriodicReporting Property periodicReporting Auto
GlobalVariable Property SLV_PlayerHasToReport Auto 
SLV_HeadShaving Property myScripts auto
SLV_MCMMenu Property MCMMenu Auto

