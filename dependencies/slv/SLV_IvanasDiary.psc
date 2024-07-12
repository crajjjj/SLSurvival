Scriptname SLV_IvanasDiary extends ObjectReference  

Event OnRead()
if SLV_CatchingJuliaQuest.getstage() == 1500
	SLV_CatchingJuliaQuest.SetObjectiveCompleted(1500)
	SLV_CatchingJuliaQuest.setstage(2000)
endif
endEvent

Quest Property SLV_CatchingJuliaQuest Auto