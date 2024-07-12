;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_DeadSlaveInspection3 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
periodicReporting.StartPeriodicReportingTimer()

SLV_SlaveOnTheRun.setvalue(0)

myScripts.SLV_removeReportingitems(Game.getPlayer())
Game.getPlayer().removeFromFaction(SLV_FactionEscapedSlave)
if SLV_SlaveHunterQuest.isRunning()
	if SLV_SlaveHunterQuest.getStage() == 3000
		SLV_SlaveHunterQuest.SetObjectiveCompleted(SLV_SlaveHunterQuest.getstage())
		SLV_SlaveHunterQuest.setstage(3500)
	else
		SLV_SlaveHunterQuest.SetObjectiveCompleted(SLV_SlaveHunterQuest.getstage())
		SLV_SlaveHunterQuest.setstage(10000)
	endif
endif
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Quest Property SLV_SlaveHunterQuest Auto
Faction Property SLV_FactionEscapedSlave auto
SLV_Utilities Property myScripts auto
SLV_PeriodicReporting Property periodicReporting Auto
GlobalVariable Property SLV_SlaveOnTheRun Auto
