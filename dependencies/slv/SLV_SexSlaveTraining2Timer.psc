Scriptname SLV_SexSlaveTraining2Timer extends Quest  

Function StartSexSlaveTraining2Timer()
RegisterForSingleUpdateGameTime(72) ; 3 * 24h
EndFunction 

Event OnUpdateGameTime()

if SLV_SexSlaveTraining2Quest .getStage() == 4500
	SLV_SexSlaveTraining2Quest .SetObjectiveCompleted(4500)
	SLV_SexSlaveTraining2Quest .setStage(5000)
	return
endif
endEvent

Quest Property SLV_SexSlaveTraining2Quest Auto