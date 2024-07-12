Scriptname SLV_ArenaGladiatorProgression extends Quest  

Function SLV_ArenaFightWon()
int arenawon = SLV_ColosseumFightsWon.getValue() as int
int maxtask = SLV_MaxTask.getValue() as int
arenawon = arenawon + 1
SLV_ColosseumFightsWon.setValue(arenawon)

myScripts.SLV_DisplayInformation("arenawon:" + arenawon)
myScripts.SLV_DisplayInformation("maxtask :" + maxtask ) 

if arenawon >= (maxtask * 9)

elseif arenawon >= (maxtask * 8) && SLV_ArenaGladiatorQuest.getstage() < 9500
	SLV_ArenaGladiatorQuest.SetObjectiveCompleted(SLV_ArenaGladiatorQuest.getStage())
	SLV_ArenaGladiatorQuest.setstage(9500)
elseif arenawon >= (maxtask * 7) && SLV_ArenaGladiatorQuest.getstage() < 4000
	SLV_ArenaGladiatorQuest.SetObjectiveCompleted(SLV_ArenaGladiatorQuest.getStage())
	SLV_ArenaGladiatorQuest.setstage(4000)
elseif arenawon >= (maxtask * 6) && SLV_ArenaGladiatorQuest.getstage() < 3500
	SLV_ArenaGladiatorQuest.SetObjectiveCompleted(SLV_ArenaGladiatorQuest.getStage())
	SLV_ArenaGladiatorQuest.setstage(3500)
elseif arenawon >= (maxtask * 5) && SLV_ArenaGladiatorQuest.getstage() < 3000
	SLV_ArenaGladiatorQuest.SetObjectiveCompleted(SLV_ArenaGladiatorQuest.getStage())
	SLV_ArenaGladiatorQuest.setstage(3000)
elseif arenawon >= (maxtask * 4) && SLV_ArenaGladiatorQuest.getstage() < 2500
	SLV_ArenaGladiatorQuest.SetObjectiveCompleted(SLV_ArenaGladiatorQuest.getStage())
	SLV_ArenaGladiatorQuest.setstage(2500)
elseif arenawon >= (maxtask * 3) && SLV_ArenaGladiatorQuest.getstage() < 2000
	SLV_ArenaGladiatorQuest.SetObjectiveCompleted(SLV_ArenaGladiatorQuest.getStage())
	SLV_ArenaGladiatorQuest.setstage(2000)
elseif arenawon >= (maxtask * 2) && SLV_ArenaGladiatorQuest.getstage() < 1500
	SLV_ArenaGladiatorQuest.SetObjectiveCompleted(SLV_ArenaGladiatorQuest.getStage())
	SLV_ArenaGladiatorQuest.setstage(1500)
elseif arenawon >= (maxtask * 1) && SLV_ArenaGladiatorQuest.getstage() < 1000
	SLV_ArenaGladiatorQuest.SetObjectiveCompleted(SLV_ArenaGladiatorQuest.getStage())
	SLV_ArenaGladiatorQuest.setstage(1000)
elseif SLV_ArenaGladiatorQuest.getstage() < 500
	SLV_ArenaGladiatorQuest.SetObjectiveCompleted(SLV_ArenaGladiatorQuest.getStage())
	SLV_ArenaGladiatorQuest.setstage(500)
endif

EndFunction
SLV_Utilities Property myScripts auto
GlobalVariable Property SLV_MaxTask Auto
GlobalVariable Property SLV_ColosseumFightsWon Auto
Quest Property SLV_ArenaGladiatorQuest Auto