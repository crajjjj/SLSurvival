Scriptname SLV_FinnTraining_Timer extends Quest  

Function StartFinnTrainingTimer()
RegisterForSingleUpdateGameTime(6) ; 24h
EndFunction 

Event OnUpdateGameTime()

if SLV_FinnTrainingQuest.getStage() == 1000
	SLV_FinnTrainingQuest.setStage(1100)
elseif SLV_FinnTrainingQuest.getStage() == 1200
	SLV_FinnTrainingQuest.setStage(1300)

elseif SLV_FinnTrainingQuest.getStage() == 1400
	SLV_FinnTrainingQuest.setStage(1500)

elseif SLV_FinnTrainingQuest.getStage() == 1600
	SLV_FinnTrainingQuest.setStage(1700)

elseif SLV_FinnTrainingQuest.getStage() == 1800
	SLV_FinnTrainingQuest.setStage(1900)

elseif SLV_FinnTrainingQuest.getStage() == 2000
	SLV_FinnTrainingQuest.setStage(2100)

elseif SLV_FinnTrainingQuest.getStage() == 2200
	SLV_FinnTrainingQuest.setStage(2300)

elseif SLV_FinnTrainingQuest.getStage() == 2400
	SLV_FinnTrainingQuest.setStage(2500)

elseif SLV_FinnTrainingQuest.getStage() == 2600
	SLV_FinnTrainingQuest.setStage(2700)

elseif SLV_FinnTrainingQuest.getStage() == 2800
	SLV_FinnTrainingQuest.setStage(2900)

elseif SLV_FinnTrainingQuest.getStage() == 3000
	SLV_FinnTrainingQuest.setStage(3100)

elseif SLV_FinnTrainingQuest.getStage() == 3200
	SLV_FinnTrainingQuest.setStage(3300)

elseif SLV_FinnTrainingQuest.getStage() == 3400
	SLV_FinnTrainingQuest.setStage(3500)

elseif SLV_FinnTrainingQuest.getStage() == 3600
	SLV_FinnTrainingQuest.setStage(3700)

elseif SLV_FinnTrainingQuest.getStage() == 3800
	SLV_FinnTrainingQuest.setStage(3900)

elseif SLV_FinnTrainingQuest.getStage() == 4000
	SLV_FinnTrainingQuest.setStage(4100)

elseif SLV_FinnTrainingQuest.getStage() == 4200
	SLV_FinnTrainingQuest.setStage(4300)

elseif SLV_FinnTrainingQuest.getStage() == 4400
	SLV_FinnTrainingQuest.setStage(4500)

elseif SLV_FinnTrainingQuest.getStage() == 4600
	SLV_FinnTrainingQuest.setStage(4700)

elseif SLV_FinnTrainingQuest.getStage() == 4800
	SLV_FinnTrainingQuest.setStage(4900)

elseif SLV_FinnTrainingQuest.getStage() == 5000
	SLV_FinnTrainingQuest.setStage(5100)

elseif SLV_FinnTrainingQuest.getStage() == 5200
	SLV_FinnTrainingQuest.setStage(5300)

elseif SLV_FinnTrainingQuest.getStage() == 5400
	SLV_FinnTrainingQuest.setStage(5500)

endif

RegisterForSingleUpdateGameTime(24) ; 24h
endEvent

Quest Property SLV_FinnTrainingQuest Auto