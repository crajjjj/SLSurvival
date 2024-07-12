Scriptname SLV_CatchingHeike_Timer extends Quest  

Function StartCatchingHeikeTimer()
RegisterForSingleUpdateGameTime(24) ; 24h
EndFunction 

Event OnUpdateGameTime()

if SLV_CatchingHeikeQuest.getStage() == 5500
	SLV_CatchingHeikeQuest.SetObjectiveCompleted(5500)
	SLV_CatchingHeikeQuest.setStage(5800)
	return
endif
endEvent

Quest Property SLV_CatchingHeikeQuest Auto