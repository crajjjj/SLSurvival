Scriptname SLV_ColosseumAnimal_Timer extends Quest  

Function StartColosseumAnimalTimer()
RegisterForSingleUpdateGameTime(24) ; 24h
EndFunction 

Event OnUpdateGameTime()

if SLV_ColosseumAnimalQuest.getStage() == 2500
	SLV_ColosseumAnimalQuest.SetObjectiveCompleted(2500)
	SLV_ColosseumAnimalQuest.setStage(3000)
	return
endif
endEvent

Quest Property SLV_ColosseumAnimalQuest Auto