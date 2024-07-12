Scriptname SLV_CatchingJane_Timer extends Quest  

Function StartCatchingJaneTimer()
RegisterForSingleUpdateGameTime(120) ;  5*24h
EndFunction 

Event OnUpdateGameTime()

if SLV_CatchingJaneQuest.getStage() == 2000
	SLV_CatchingJaneQuest.SetObjectiveCompleted(2000)
	SLV_CatchingJaneQuest.setStage(2500)
	return
endif
endEvent

Quest Property SLV_CatchingJaneQuest Auto