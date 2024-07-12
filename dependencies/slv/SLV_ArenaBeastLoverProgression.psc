Scriptname SLV_ArenaBeastLoverProgression extends Quest  

Function SLV_ArenaShowDone()
int arenashowdone = SLV_ColosseumShowsDone.getValue() as int
int maxtask = SLV_MaxTask.getValue() as int
arenashowdone = arenashowdone + 1
SLV_ColosseumShowsDone.setValue(arenashowdone)

myScripts.SLV_DisplayInformation("arenashowdone:" + arenashowdone)
myScripts.SLV_DisplayInformation("maxtask :" + maxtask )

if arenashowdone >=  (maxtask * 10)

elseif arenashowdone >= (maxtask * 9) && SLV_ArenaBeastLoverQuest.getstage() < 9500
	SLV_ArenaBeastLoverQuest.SetObjectiveCompleted(SLV_ArenaBeastLoverQuest.getStage())
	SLV_ArenaBeastLoverQuest.setstage(9500)
elseif arenashowdone >=  (maxtask * 8) && SLV_ArenaBeastLoverQuest.getstage() < 4500
	SLV_ArenaBeastLoverQuest.SetObjectiveCompleted(SLV_ArenaBeastLoverQuest.getStage())
	SLV_ArenaBeastLoverQuest.setstage(4500)
elseif arenashowdone >=  (maxtask * 7) && SLV_ArenaBeastLoverQuest.getstage() < 4000
	SLV_ArenaBeastLoverQuest.SetObjectiveCompleted(SLV_ArenaBeastLoverQuest.getStage())
	SLV_ArenaBeastLoverQuest.setstage(4000)
elseif arenashowdone >=  (maxtask * 6) && SLV_ArenaBeastLoverQuest.getstage() < 3500
	SLV_ArenaBeastLoverQuest.SetObjectiveCompleted(SLV_ArenaBeastLoverQuest.getStage())
	SLV_ArenaBeastLoverQuest.setstage(3500)
elseif arenashowdone >=  (maxtask * 5) && SLV_ArenaBeastLoverQuest.getstage() < 3000
	SLV_ArenaBeastLoverQuest.SetObjectiveCompleted(SLV_ArenaBeastLoverQuest.getStage())
	SLV_ArenaBeastLoverQuest.setstage(3000)
elseif arenashowdone >=  (maxtask * 4) && SLV_ArenaBeastLoverQuest.getstage() < 2500
	SLV_ArenaBeastLoverQuest.SetObjectiveCompleted(SLV_ArenaBeastLoverQuest.getStage())
	SLV_ArenaBeastLoverQuest.setstage(2500)
elseif arenashowdone >=  (maxtask * 3) && SLV_ArenaBeastLoverQuest.getstage() < 2000
	SLV_ArenaBeastLoverQuest.SetObjectiveCompleted(SLV_ArenaBeastLoverQuest.getStage())
	SLV_ArenaBeastLoverQuest.setstage(2000)
elseif arenashowdone >=  (maxtask * 2) && SLV_ArenaBeastLoverQuest.getstage() < 1500
	SLV_ArenaBeastLoverQuest.SetObjectiveCompleted(SLV_ArenaBeastLoverQuest.getStage())
	SLV_ArenaBeastLoverQuest.setstage(1500)
elseif arenashowdone >= (maxtask * 1) && SLV_ArenaBeastLoverQuest.getstage() < 1000
	SLV_ArenaBeastLoverQuest.SetObjectiveCompleted(SLV_ArenaBeastLoverQuest.getStage())
	SLV_ArenaBeastLoverQuest.setstage(1000)
elseif  SLV_ArenaBeastLoverQuest.getstage() < 500
	SLV_ArenaBeastLoverQuest.SetObjectiveCompleted(SLV_ArenaBeastLoverQuest.getStage())
	SLV_ArenaBeastLoverQuest.setstage(500)
endif

EndFunction
SLV_Utilities Property myScripts auto
GlobalVariable Property SLV_MaxTask Auto
GlobalVariable Property SLV_ColosseumShowsDone Auto
Quest Property SLV_ArenaBeastLoverQuest Auto