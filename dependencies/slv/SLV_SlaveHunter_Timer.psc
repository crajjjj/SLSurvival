Scriptname SLV_SlaveHunter_Timer extends Quest  

Function StartSlaveHunterTimer()
RegisterForSingleUpdateGameTime(0.5) ; 0.5h
EndFunction 

Function StartSlaveHunterWalkTimer()

int delay = Utility.RandomInt(0,200)
float fdelay = delay / 200 ; 0-0.5

RegisterForSingleUpdateGameTime(1.0 + fdelay) ; 0.5h
EndFunction 

Event OnUpdateGameTime()

if SLV_SlaveHunterQuest.getStage() == 0
	SLV_SlaveHunterQuest.SetObjectiveCompleted(0)
	SLV_SlaveHunterQuest.setStage(500)
	RegisterForSingleUpdateGameTime(1) ; 1h

	myScripts2.SLV_DisplayInformation("Hunter stage 500")
	return

elseif SLV_SlaveHunterQuest.getStage() == 500	
	SLV_SlaveHunterQuest.SetObjectiveCompleted(500)
	SLV_SlaveHunterQuest.setStage(1000)
	RegisterForSingleUpdateGameTime(0.5) ; 0.5h

	myScripts2.SLV_DisplayInformation("Hunter stage 1000")
	return

elseif SLV_SlaveHunterQuest.getStage() == 1000	
	SLV_SlaveHunterQuest.SetObjectiveCompleted(1000)
	SLV_SlaveHunterQuest.setStage(1500)

	myScripts2.SLV_DisplayInformation("Hunter stage 1500")

elseif SLV_SlaveHunterQuest.getStage() > 2500	
	myScripts2.SLV_DisplayInformation("we reached slaverun already")

elseif PlayerRef.GetCurrentScene() == walkingWithHunter
	myScripts2.SLV_DisplayInformation("Hunter walking scene stopping...")
	walkingWithHunter.stop()
	;myScripts2.SLV_StartWhipping(PlayerRef )
	;Utility.wait(3.0)

	myScripts2.SLV_DisplayInformation("Hunter start fun scene")
	funWithHunter.forcestart()


	if walkingWithHunter.isPlaying()	
		myScripts2.SLV_DisplayInformation("walkingWithHunter is still running")
		walkingWithHunter.stop()
	endif

	if walkingWithHunter.isPlaying()
		myScripts2.SLV_DisplayInformation("walkingWithHunter is still running")
		walkingWithHunter.stop()
	endif

	if walkingWithHunter.isPlaying()
		myScripts2.SLV_DisplayInformation("walkingWithHunter is still running")
		walkingWithHunter.stop()
	endif

	RegisterForSingleUpdateGameTime(1) ; 0.5h

elseif PlayerRef.GetCurrentScene() == funWithHunter 
	RegisterForSingleUpdateGameTime(1) ; 0.5h

	myScripts2.SLV_DisplayInformation("Hunter continue fun scene")
	if walkingWithHunter.isPlaying()
		walkingWithHunter.stop()
	endif

else
	myScripts2.SLV_DisplayInformation("Hunter else -> nothing")
endif
endEvent

Quest Property SLV_SlaveHunterQuest Auto
Scene Property walkingWithHunter Auto
Scene Property funWithHunter Auto

Actor Property PlayerRef Auto
SLV_Utilities Property myScripts2 auto

