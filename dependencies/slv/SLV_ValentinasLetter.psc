Scriptname SLV_ValentinasLetter extends ObjectReference  

Event OnRead()
if SLV_CatchingHeikeQuest.getstage() == 1500
	SLV_CatchingHeikeQuest.SetObjectiveCompleted(1500)
	SLV_CatchingHeikeQuest.setstage(2000)
endif
endEvent

Quest Property SLV_CatchingHeikeQuest Auto