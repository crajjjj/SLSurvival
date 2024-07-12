Scriptname SLV_SuccubusTimer extends Quest  

Function StartSuccubusTimer()
RegisterForSingleUpdateGameTime(24) ; 24h
EndFunction 

Event OnUpdateGameTime()

if SLV_SuccubusQuest.getStage() == 3500
	SLV_SuccubusQuest.SetObjectiveCompleted(3500)
	SLV_SuccubusQuest.setStage(4000)
	return
endif
if SLV_SuccubusQuest.getStage() == 6500
	SLV_SuccubusQuest.SetObjectiveCompleted(6500)
	SLV_SuccubusQuest.setStage(7000)
	return
endif
endEvent

Quest Property SLV_SuccubusQuest Auto


