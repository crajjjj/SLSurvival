Scriptname SLV_Mainquest_Timer extends Quest  

Function StartMainquestTimer()
RegisterForSingleUpdateGameTime(72) ; 3* 24h
EndFunction 

Event OnUpdateGameTime()

if SLV_MainquestQuest.getStage() == 29000
	SLV_MainquestQuest.SetObjectiveCompleted(29000)
	SLV_MainquestQuest.setStage(29200)
	return
elseif SLV_MainquestQuest.getStage() == 30000
	SLV_MainquestQuest.SetObjectiveCompleted(30000)
	SLV_MainquestQuest.setStage(30200)
	return
elseif SLV_MainquestQuest.getStage() == 31000
	SLV_MainquestQuest.SetObjectiveCompleted(31000) 
	SLV_MainquestQuest.setStage(31200)
	return
elseif SLV_MainquestQuest.getStage() == 10
	SLV_MainquestQuest.SetObjectiveCompleted(10)
	SLV_MainquestQuest.setStage(25)
	return
endif
endEvent

Quest Property SLV_MainquestQuest Auto
