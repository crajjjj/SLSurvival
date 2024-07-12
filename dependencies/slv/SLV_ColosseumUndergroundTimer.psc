Scriptname SLV_ColosseumUndergroundTimer extends Quest  

Function StartColosseumUndergroundTimer(int days)
RegisterForSingleUpdateGameTime(days*24) ; 7 * 24h
EndFunction 

Event OnUpdateGameTime()

if SLV_ColosseumUndergroundQuest.getStage() == 5600
	SLV_ColosseumUndergroundQuest.SetObjectiveCompleted(5600)
	SLV_ColosseumUndergroundQuest.setStage(5700)
	return
elseif SLV_ColosseumUndergroundQuest.getStage() == 7500
	SLV_ColosseumUndergroundQuest.SetObjectiveCompleted(7500)
	SLV_ColosseumUndergroundQuest.setStage(8000)
	outsidebuilding.enable()
	return
endif
endEvent

Quest Property SLV_ColosseumUndergroundQuest Auto
ObjectReference Property outsidebuilding Auto