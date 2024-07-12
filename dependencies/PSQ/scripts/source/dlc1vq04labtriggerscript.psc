Scriptname DLC1VQ04LabTriggerScript extends ObjectReference  Conditional

Quest Property pDLC1VQ04  Auto  
int Property pTriggered Auto
ReferenceAlias Property pDLC1VQ04RNPCAlias  Auto  
Keyword Property pVampire Auto
DLC1VQ04QuestScript Property pDLC1VQ04QS Auto
GlobalVariable Property pDLC1VQ04SoulTrapped Auto

Event OnTrigger(ObjectReference akActionRef)

	if pTriggered == 0
		if akActionRef == pDLC1VQ04RNPCAlias.GetActorRef()
			if pDLC1VQ04.GetStage() == 35
				pDLC1VQ04.SetStage(40)
				pTriggered = 1
			endif
		endif
	endif

endEvent

Event OnTriggerEnter(ObjectReference akActionRef)

	if pDLC1VQ04.GetStage() >= 90
		if Game.GetPlayer().HasKeyword(pVampire) == 0 && pDLC1VQ04SoulTrapped.GetValue() == 0 && StorageUtil.GetIntValue(Game.GetPlayer(), "PSQ_PlayerIsSuccubus") == 0
			pDLC1VQ04QS.NoLongerAVamp()
		elseif Game.GetPlayer().HasKeyword(pVampire) == 1
			pDLC1VQ04QS.IAmVampAgain()
		endif
	endif

endEvent