Scriptname SLV_WhiteWedding2Timer extends Quest  

Function StartWhiteWedding2Timer(int days)
RegisterForSingleUpdateGameTime(24 * days) ;  24h
EndFunction 

Event OnUpdateGameTime()

if SLV_WhiteWedding2Quest.getStage() == 300
	SLV_WhiteWedding2Quest.SetObjectiveCompleted(300)
	SLV_WhiteWedding2Quest.setStage(500)
	return
endif
endEvent

Quest Property SLV_WhiteWedding2Quest Auto