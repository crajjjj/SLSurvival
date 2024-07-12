Scriptname _MA_Pah extends Quest  

Int Function IF_GetSubThreshold(Quest PahQuest)
	PAH_MCM PahScript = PahQuest as PAH_MCM
	Return PahScript.runAwayValue
EndFunction