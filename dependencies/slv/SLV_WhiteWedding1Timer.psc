Scriptname SLV_WhiteWedding1Timer extends Quest  

Function StartWhiteWedding1Timer(int days)
RegisterForSingleUpdateGameTime(24 * days) ;  24h
EndFunction 

Event OnUpdateGameTime()

if SLV_WhiteWedding1Quest.getStage() == 2000
	SLV_WhiteWedding1Quest.SetObjectiveCompleted(2000)
	SLV_WhiteWedding1Quest.setStage(2200)
	return
endif
if SLV_WhiteWedding1Quest.getStage() == 5000
	SLV_WhiteWedding1Quest.SetObjectiveCompleted(5000)
	SLV_WhiteWedding1Quest.setStage(5200)
	return
endif
if SLV_WhiteWedding1Quest.getStage() == 7000
	SLV_WhiteWedding1Quest.SetObjectiveCompleted(7000)
	SLV_WhiteWedding1Quest.setStage(7200)
	return
endif
endEvent

Quest Property SLV_WhiteWedding1Quest Auto