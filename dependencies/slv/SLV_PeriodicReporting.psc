Scriptname SLV_PeriodicReporting extends Quest  


Function StartPeriodicReportingTimer()

;if !Game.GetPlayer().IsInFaction(zbf_Slave) || !MCMMenu.ForceReporting
if !MCMMenu.ForceReporting
	return
endif

int hasToReport = SLV_PlayerHasToReport.getvalue() as int
if hasToReport != 1
	return
endif

Float Time = Utility.GetCurrentGameTime()
MiscUtil.PrintConsole("Current Time:" + Time)

; Just tell us when x hours have passed in game
if MCMMenu.ReportingTime
	int reportingtime = MCMMenu.ReportingTime
	if reportingtime < 1
		reportingtime = 1
	endif
	RegisterForSingleUpdateGameTime(reportingtime * 24 ) ; 24 * 1
	Time = Time + reportingtime ;* 24
else
	 RegisterForSingleUpdateGameTime(168) ; 24 * 7
	Time = Time + 7 ;168
endif
StorageUtil.SetFloatValue(None, "SLV_ReportBackHours", Time )
MiscUtil.PrintConsole("Reporting Time:" + Time)
EndFunction 

Event OnUpdateGameTime()
;if !Game.GetPlayer().IsInFaction(zbf_Slave) || !MCMMenu.ForceReporting
if !MCMMenu.ForceReporting
	return
endif

int hasToReport = SLV_PlayerHasToReport.getvalue() as int
if hasToReport != 1
	return
endif

if Game.GetPlayer().IsInFaction(zbf_Slave)
	Game.getPlayer().addtofaction(SLV_FactionEscapedSlave)
	SLV_SlaveOnTheRun.setvalue(1)
else	
	Game.getPlayer().addtofaction(SLV_FactionEscapedSlave)
	SLV_PlayerOnTheRun.setvalue(1)
endif

if MCMMenu.reportsendSlaverPatrol
	SLV_SlaveHunterQuest.reset()
	SLV_SlaveHunterQuest.start()
	SLV_SlaveHunterQuest.setstage(0)
else
	if Game.GetPlayer().IsInFaction(zbf_Slave)
		Debug.MessageBox("You failed to report back to Bellamy in time and are now an escaped slave. Every loyal citicen who obeys slavery law is ordered to catch you.")
	else
		Debug.MessageBox("You failed to report back to Slave Master Pike in time and he might be angry at you.")
	endif
endif

endEvent
Faction Property zbf_Slave Auto
SLV_MCMMenu Property MCMMenu Auto
GlobalVariable Property SLV_SlaveOnTheRun Auto
GlobalVariable Property SLV_PlayerOnTheRun auto
GlobalVariable Property GameHour Auto
GlobalVariable Property SLV_PlayerHasToReport Auto 


Faction Property SLV_FactionEscapedSlave auto
Quest Property SLV_SlaveHunterQuest Auto
