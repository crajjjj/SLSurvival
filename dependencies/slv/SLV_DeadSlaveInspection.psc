;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_DeadSlaveInspection Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
periodicReporting.StartPeriodicReportingTimer()

int money = SLV_ReportingGold.getValue() as int
Game.GetPlayer().RemoveItem(Gold, money )
SLV_SlaveOnTheRun.setvalue(0)

Game.getPlayer().removeFromFaction(SLV_FactionEscapedSlave)
if SLV_SlaveHunterQuest.isRunning()
	if SLV_SlaveHunterQuest.getStage() == 2500
		SLV_SlaveHunterQuest.SetObjectiveCompleted(SLV_SlaveHunterQuest.getstage())
		SLV_SlaveHunterQuest.setstage(3000)
	else
		SLV_SlaveHunterQuest.SetObjectiveCompleted(SLV_SlaveHunterQuest.getstage())
		SLV_SlaveHunterQuest.setstage(10000)
	endif
endif
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
MiscObject Property Gold  Auto  
SLV_PeriodicReporting Property periodicReporting Auto
GlobalVariable Property SLV_SlaveOnTheRun Auto
GlobalVariable Property SLV_ReportingGold Auto

Quest Property SLV_SlaveHunterQuest Auto
Faction Property SLV_FactionEscapedSlave auto

