Scriptname SLV_EnslavingProgress extends Quest  


Function StartProgressForFreeWoman()

if Game.GetPlayer().IsInFaction(zbf_Slave) || Game.GetPlayer().IsInFaction(zbf_Slaver)
	setNextTimer("")
	return
endif

Float Time = Utility.GetCurrentGameTime()
;MiscUtil.PrintConsole("Current Time:" + Time)

; Just tell us when x hours have passed in game
if MCMMenu.CityEnslavingTime 
	int  slavetime = MCMMenu.CityEnslavingTime 
	if slavetime < 1
		slavetime = 1
	endif
	RegisterForSingleUpdateGameTime(slavetime * 24 ) ; 24 * 1

	Time = Time + slavetime
else
	 RegisterForSingleUpdateGameTime(168) ; 24 * 7

	Time = Time + 7
endif

StorageUtil.SetFloatValue(None, "SLV_EnslavingHours", Time )
;MiscUtil.PrintConsole("Enslaving Time:" + Time)
EndFunction 

Event OnUpdateGameTime()
if Game.GetPlayer().IsInFaction(zbf_Slave) || Game.GetPlayer().IsInFaction(zbf_Slaver)
	setNextTimer("")
	return
endif

if !MCMMenu.autoprogression || SlaverunQuest.getStage() == 10
	setNextTimer("")
	return
endif


SlaverunQuest.SetObjectiveCompleted(SlaverunQuest.getStage())

if SlaverunQuest.getStage() >= 11000
	SlaverunQuest.setStage(31000)
	return
endif

if SlaverunQuest.getStage() >= 10000
	SlaverunQuest.setStage(11000)
	setNextTimer("Skyrim")
	return
endif
if SlaverunQuest.getStage() >= 9000
	SlaverunQuest.setStage(10000)
	setNextTimer("Solitude")
	return
endif
if SlaverunQuest.getStage() >= 8000
	SlaverunQuest.setStage(9000)
	setNextTimer("Windhelm")
	return
endif
if SlaverunQuest.getStage() >= 7000
	SlaverunQuest.setStage(8000)
	setNextTimer("Winterhold")
	return
endif
if SlaverunQuest.getStage() >= 6000
	SlaverunQuest.setStage(7000)
	setNextTimer("Morthal")
	return
endif
if SlaverunQuest.getStage() >= 5000
	SlaverunQuest.setStage(6000)
	setNextTimer("Riften")

	if !Game.getPlayer().IsInFaction(zbf_Slave) && !Game.getPlayer().IsInFaction(zbf_Slaver)
		SLV_EnslaveQ.setstage(20)
	endif
	return
endif
if SlaverunQuest.getStage() >= 4000
	SlaverunQuest.setStage(5000)
	setNextTimer("Markath")
	return
endif
if SlaverunQuest.getStage() >= 3000
	SlaverunQuest.setStage(4000)
	setNextTimer("Dawnstar")
	return
endif
if SlaverunQuest.getStage() >= 2000
	SlaverunQuest.setStage(3000)
	setNextTimer("Falkreath")
	return
endif
if SlaverunQuest.getStage() >= 1000
	SlaverunQuest.setStage(2000)
	setNextTimer("Riverwood")
	return
endif

SlaverunQuest.setStage(1100)
setNextTimer("Whiterun")
endEvent

function setNextTimer(String town)
if town !=""
	Debug.MessageBox("There are rumors that " + town + " has fallen now under Slaverun slavery laws.")
endif

Float Time = Utility.GetCurrentGameTime()
;MiscUtil.PrintConsole("Current Time:" + Time)

if MCMMenu.CityEnslavingTime 
	float slavetime = MCMMenu.CityEnslavingTime 
	if slavetime < 1.0
		slavetime = 1.0
	endif
	RegisterForSingleUpdateGameTime(slavetime * 24 ) ; 24 * 1
	Time = Time + slavetime
else
	 RegisterForSingleUpdateGameTime(168) ; 24 * 7
	Time = Time + 7
endif

StorageUtil.SetFloatValue(None, "SLV_EnslavingHours", Time )
;MiscUtil.PrintConsole("Enslaving Time:" + Time)
EndFunction

Faction Property zbf_Slave Auto
Faction Property zbf_Slaver Auto
Quest Property SlaverunQuest Auto
Quest Property SLV_EnslaveQ Auto

SLV_MCMMenu Property MCMMenu Auto