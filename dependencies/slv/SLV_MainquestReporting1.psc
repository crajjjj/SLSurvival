;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_MainquestReporting1 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
periodicReporting.StartPeriodicReportingTimer()

SLV_PlayerOnTheRun.setvalue(0)

if MCMMenu.reportConfiscateGold
	int goldcount = (PlayerRef.getItemCount(gold001 ) / 10) as int
	if goldcount > 0
		PlayerRef.removeItem(gold001 ,goldcount ,true, akSpeaker)
	endif
endif

PlayerRef.removeFromFaction(SLV_FactionEscapedSlave)
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
GlobalVariable Property SLV_PlayerOnTheRun Auto

Actor Property PlayerRef auto
SLV_MCMMenu Property MCMMenu Auto
MiscObject Property gold001 auto
