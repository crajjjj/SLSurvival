Scriptname SLV_CatchingJasmin_Timer extends Quest  

Function CatchingJasminTimer()
RegisterForSingleUpdateGameTime(24) ;  24h
EndFunction 

Event OnUpdateGameTime()

if SLV_CatchingJasminQuest.getStage() == 4750
	SLV_CatchingJasminQuest.SetObjectiveCompleted(4750)
	SLV_CatchingJasminQuest.SetStage(5000)
	return
endif
if SLV_CatchingJasminQuest.getStage() == 8000
	SLV_CatchingJasminQuest.SetObjectiveCompleted(8000)
	SLV_CatchingJasminQuest.SetStage(8500)
	return
endif
endEvent

Quest Property SLV_CatchingJasminQuest Auto



