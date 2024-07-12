Scriptname PAF_ToiletHouseFurnitureScript extends ObjectReference

bool property IsBucket auto

Event OnActivate(ObjectReference a_actor)	

	if (Game.GetPlayer() == a_actor as Actor)		
		PAF_MainQuestScript paf = PAF_MainQuestScript.GetApi()
		Utility.Wait(5)
		if (paf.GetToiletState() != 0)		
			paf.SetToiletState(0)
		else
			if (IsBucket)
				paf.SetToiletState(1)
			else
				paf.SetToiletState(2)
			endif
		endif
	endif
	
EndEvent