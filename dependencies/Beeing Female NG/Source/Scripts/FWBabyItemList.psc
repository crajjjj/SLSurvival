Scriptname FWBabyItemList extends Quest  
FWAddOnManager property Manager auto

MiscObject property FallBack_MaleBabyItem Auto hidden
MiscObject property FallBack_FemaleBabyItem Auto hidden

Armor property FallBack_MaleBabyArmor Auto
Armor property FallBack_FemaleBabyArmor Auto

ActorBase property FallBack_MaleBabyActor Auto
ActorBase property FallBack_FemaleBabyActor Auto

ActorBase property FallBack_MalePlayerBabyActor Auto
ActorBase property FallBack_FemalePlayerBabyActor Auto

string[] property Female_Names auto
string[] property Male_Names auto

; Deprecated: kept for backward compatibility only.
race property LastRace auto hidden

Actor Property PlayerRef Auto
FWSystemConfig property cfg auto

; Resolve parent actor/race for item/armor selection with father-race bias.
; Returns [0]=ParentActor, [1]=ParentRace.
Form[] function ResolveParentActorAndRaceForItemArmor(actor Mother, actor Father, actor ParentActor, race storedFatherRace, string logPrefix)
	Form[] result = new Form[2] ; 0 = ParentActor, 1 = ParentRace
	int myProbRandom = Utility.RandomInt(0, 99)
	int myChildRaceDeterminedByFather = Manager.ActorChildRaceDeterminedByFather(Father, storedFatherRace)
	FW_log.WriteLog(logPrefix + ": ChildRaceDeterminedByFather = " + myChildRaceDeterminedByFather)
	
	if Father == none
		ParentActor = Mother
		string storedFatherRaceStr = ""
		if storedFatherRace
			storedFatherRaceStr = FWUtility.GetStringFromForm(storedFatherRace)
		endif
		if(myProbRandom < myChildRaceDeterminedByFather && storedFatherRace)
			FW_log.WriteLog(logPrefix + ": myProbRandom = " + myProbRandom + ", which is less than the ChildRaceDeterminedByFather. Using stored father race ["+storedFatherRaceStr+"].")
			result[1] = storedFatherRace
		else
			FW_log.WriteLog(logPrefix + ": myProbRandom = " + myProbRandom + ", which is not less than the ChildRaceDeterminedByFather. Child will follow mother's race.")
			result[1] = Mother.GetRace()
		endIf
	else
		If(myProbRandom < myChildRaceDeterminedByFather)
			FW_log.WriteLog(logPrefix + ": myProbRandom = " + myProbRandom + ", which is less than the ChildRaceDeterminedByFather. Child will follow father's race.")
			ParentActor = Father
		Else
			FW_log.WriteLog(logPrefix + ": myProbRandom = " + myProbRandom + ", which is not less than the ChildRaceDeterminedByFather. Child will follow mother's race.")
			ParentActor = Mother
		EndIF
		result[1] = ParentActor.GetRace()
	endIf
	result[0] = ParentActor
	return result
endFunction

; Select baby item and return [0]=MiscObject, [1]=ParentActor, [2]=ParentRace.
Form[] function getBabyItem(actor Mother, actor Father, int sex, Race FatherRace = none)
	;race ParentRace = Father.GetRace()
	;race MotherRace = Mother.GetRace()


	race storedFatherRace = none
	if Father == none
		if FatherRace
			storedFatherRace = FatherRace
		else
			storedFatherRace = FWUtility.GetLastChildFatherRace(Mother)
		endIf
	endIf
	Form[] parentContext = ResolveParentActorAndRaceForItemArmor(Mother, Father, none, storedFatherRace, "FWBabyItemList - getBabyItem")
	Actor ParentActor = parentContext[0] as Actor
	race ParentRace = parentContext[1] as Race
	; no shared state; return context to caller
	
	; Check Forces Babys
	if(StorageUtil.GetIntValue(ParentActor, "FW.AddOn.Female_Force_This_Baby") == 1)
		int mCount=StorageUtil.FormListCount(ParentActor, "FW.AddOn.BabyMesh_Male")
		int fCount=StorageUtil.FormListCount(ParentActor, "FW.AddOn.BabyMesh_Female")
		if mCount>0 && sex==0
			; First, check Random child from list
			MiscObject force_mo_m=StorageUtil.FormListGet(ParentActor, "FW.AddOn.BabyMesh_Male", Utility.RandomInt(0,mCount - 1)) as MiscObject
			if force_mo_m!=none
				return BuildBabyActorResult(force_mo_m, ParentActor, ParentRace)
			endif
			; Random Child was none, go through list
			int i=0
			while i<mCount
				i+=1
				force_mo_m=StorageUtil.FormListGet(ParentActor, "FW.AddOn.BabyMesh_Male", i) as MiscObject
				if force_mo_m!=none
					return BuildBabyActorResult(force_mo_m, ParentActor, ParentRace)
				endif
			endwhile
		elseif fCount>0 && sex==1
			; First, check Random child from list
			MiscObject force_mo_f=StorageUtil.FormListGet(ParentActor, "FW.AddOn.BabyMesh_Female", Utility.RandomInt(0,fCount - 1)) as MiscObject
			if force_mo_f!=none
				return BuildBabyActorResult(force_mo_f, ParentActor, ParentRace)
			endif
			; Random Child was none, go through list
			int i=0
			while i<fCount
				i+=1
				force_mo_f=StorageUtil.FormListGet(ParentActor, "FW.AddOn.BabyMesh_Female", i) as MiscObject
				if force_mo_f!=none
					return BuildBabyActorResult(force_mo_f, ParentActor, ParentRace)
				endif
			endwhile
		endif
	else
		if(StorageUtil.GetIntValue(ParentRace, "FW.AddOn.Female_Force_This_Baby") == 1)
			int mCount=StorageUtil.FormListCount(ParentRace,"FW.AddOn.BabyMesh_Male")
			int fCount=StorageUtil.FormListCount(ParentRace,"FW.AddOn.BabyMesh_Female")
			if mCount>0 && sex==0
				; First, check Random child from list
				MiscObject force_mo_m=StorageUtil.FormListGet(ParentRace,"FW.AddOn.BabyMesh_Male", Utility.RandomInt(0,mCount - 1)) as MiscObject
				if force_mo_m!=none
					return BuildBabyActorResult(force_mo_m, ParentActor, ParentRace)
				endif
				; Random Child was none, go through list
				int i=0
				while i<mCount
					i+=1
					force_mo_m=StorageUtil.FormListGet(ParentRace,"FW.AddOn.BabyMesh_Male", i) as MiscObject
					if force_mo_m!=none
						return BuildBabyActorResult(force_mo_m, ParentActor, ParentRace)
					endif
				endwhile
			elseif fCount>0 && sex==1
				; First, check Random child from list
				MiscObject force_mo_f=StorageUtil.FormListGet(ParentRace,"FW.AddOn.BabyMesh_Female", Utility.RandomInt(0,fCount - 1)) as MiscObject
				if force_mo_f!=none
					return BuildBabyActorResult(force_mo_f, ParentActor, ParentRace)
				endif
				; Random Child was none, go through list
				int i=0
				while i<fCount
					i+=1
					force_mo_f=StorageUtil.FormListGet(ParentRace,"FW.AddOn.BabyMesh_Female", i) as MiscObject
					if force_mo_f!=none
						return BuildBabyActorResult(force_mo_f, ParentActor, ParentRace)
					endif
				endwhile
			endif
		else
			if(StorageUtil.GetIntValue(none, "FW.AddOn.Global_Female_Force_This_Baby") == 1)
				int mCount=StorageUtil.FormListCount(none, "FW.AddOn.Global_BabyMesh_Male")
				int fCount=StorageUtil.FormListCount(none, "FW.AddOn.Global_BabyMesh_Female")
				if mCount>0 && sex==0
					; First, check Random child from list
					MiscObject force_mo_m=StorageUtil.FormListGet(none, "FW.AddOn.Global_BabyMesh_Male", Utility.RandomInt(0,mCount - 1)) as MiscObject
					if force_mo_m!=none
						return BuildBabyActorResult(force_mo_m, ParentActor, ParentRace)
					endif
					; Random Child was none, go through list
					int i=0
					while i<mCount
						i+=1
						force_mo_m=StorageUtil.FormListGet(none, "FW.AddOn.Global_BabyMesh_Male", i) as MiscObject
						if force_mo_m!=none
							return BuildBabyActorResult(force_mo_m, ParentActor, ParentRace)
						endif
					endwhile
				elseif fCount>0 && sex==1
					; First, check Random child from list
					MiscObject force_mo_f=StorageUtil.FormListGet(none, "FW.AddOn.Global_BabyMesh_Female", Utility.RandomInt(0,fCount - 1)) as MiscObject
					if force_mo_f!=none
						return BuildBabyActorResult(force_mo_f, ParentActor, ParentRace)
					endif
					; Random Child was none, go through list
					int i=0
					while i<fCount
						i+=1
						force_mo_f=StorageUtil.FormListGet(none, "FW.AddOn.Global_BabyMesh_Female", i) as MiscObject
						if force_mo_f!=none
							return BuildBabyActorResult(force_mo_f, ParentActor, ParentRace)
						endif
					endwhile
				endif
			endIf
		endIf
	endIf

	
	; No forced Baby found - Use default methode to get the babys race
	if Father == none
		FW_log.WriteLog("BeeingFemale - FWBabyItemList - getBabyItem - Father race cannot be found...")
		if cfg.ShowDebugMessage
			Debug.Messagebox("Father race cannot be found...")
		endIf
	endIf
	
	FW_log.WriteLog("BeeingFemale - FWBabyItemList - getBabyItem - Child Parent Race: " + ParentRace)
	if cfg.ShowDebugMessage
		Debug.Messagebox("Child Parent Race: " + ParentRace)
	endIf
	
	MiscObject b
	if sex==0
		; Male
		b=Manager.GetBabyItem(ParentRace,0)
		if b!=none
			return BuildBabyActorResult(b, ParentActor, ParentRace)
		else
			FW_log.WriteLog("BeeingFemale - FWBabyItemList - getBabyItem - BabyItem cannot be found and thus reverting to FallBack_MaleBabyItem...")
			if cfg.ShowDebugMessage
				Debug.Messagebox("BabyItem cannot be found and thus reverting to FallBack_MaleBabyItem...")
			endIf
			return BuildBabyActorResult(FallBack_MaleBabyItem, ParentActor, ParentRace)
		endif
	else
		; Female
		b=Manager.GetBabyItem(ParentRace,1)
		if b!=none
			return BuildBabyActorResult(b, ParentActor, ParentRace)
		else
			FW_log.WriteLog("BeeingFemale - FWBabyItemList - getBabyItem - BabyItem cannot be found and thus reverting to FallBack_FemaleBabyItem...")
			if cfg.ShowDebugMessage
				Debug.Messagebox("BabyItem cannot be found and thus reverting to FallBack_FemaleBabyItem...")
			endIf
			return BuildBabyActorResult(FallBack_FemaleBabyItem, ParentActor, ParentRace)
		endIf
	endIf
endFunction

; Select baby armor and return [0]=Armor, [1]=ParentActor, [2]=ParentRace.
Form[] function getBabyArmor(actor Mother, actor Father, int sex, Race FatherRace = none)
	;race ParentRace = Father.GetRace()
	;race MotherRace = Mother.GetRace()


	race storedFatherRace = none
	if Father == none
		if FatherRace
			storedFatherRace = FatherRace
		else
			storedFatherRace = FWUtility.GetLastChildFatherRace(Mother)
		endIf
	endIf
	Form[] parentContext = ResolveParentActorAndRaceForItemArmor(Mother, Father, none, storedFatherRace, "FWBabyItemList - getBabyArmor")
	Actor ParentActor = parentContext[0] as Actor
	race ParentRace = parentContext[1] as Race
	; no shared state; return context to caller
	
	; Check Forces Babys
	if(StorageUtil.GetIntValue(ParentActor, "FW.AddOn.Female_Force_This_Baby") == 1)
		int mCount=StorageUtil.FormListCount(ParentActor, "FW.AddOn.BabyArmor_Male")
		int fCount=StorageUtil.FormListCount(ParentActor, "FW.AddOn.BabyArmor_Female")
		if mCount>0 && sex==0
			; First, check Random child from list
			Armor force_mo_m=StorageUtil.FormListGet(ParentActor, "FW.AddOn.BabyArmor_Male", Utility.RandomInt(0,mCount - 1)) as Armor
			if force_mo_m!=none
				return BuildBabyActorResult(force_mo_m, ParentActor, ParentRace)
			endif
			; Random Child was none, go through list
			int i=0
			while i<mCount
				i+=1
				force_mo_m=StorageUtil.FormListGet(ParentActor, "FW.AddOn.BabyArmor_Male", i) as Armor
				if force_mo_m!=none
					return BuildBabyActorResult(force_mo_m, ParentActor, ParentRace)
				endif
			endwhile
		elseif fCount>0 && sex==1
			; First, check Random child from list
			Armor force_mo_f=StorageUtil.FormListGet(ParentActor, "FW.AddOn.BabyArmor_Female", Utility.RandomInt(0,fCount - 1)) as Armor
			if force_mo_f!=none
				return BuildBabyActorResult(force_mo_f, ParentActor, ParentRace)
			endif
			; Random Child was none, go through list
			int i=0
			while i<fCount
				i+=1
				force_mo_f=StorageUtil.FormListGet(ParentActor, "FW.AddOn.BabyArmor_Female", i) as Armor
				if force_mo_f!=none
					return BuildBabyActorResult(force_mo_f, ParentActor, ParentRace)
				endif
			endwhile
		endif
	else
		if(StorageUtil.GetIntValue(ParentRace, "FW.AddOn.Female_Force_This_Baby") == 1)
			int mCount=StorageUtil.FormListCount(ParentRace, "FW.AddOn.BabyArmor_Male")
			int fCount=StorageUtil.FormListCount(ParentRace, "FW.AddOn.BabyArmor_Female")
			if mCount>0 && sex==0
				; First, check Random child from list
				Armor force_mo_m=StorageUtil.FormListGet(ParentRace, "FW.AddOn.BabyArmor_Male", Utility.RandomInt(0,mCount - 1)) as Armor
				if force_mo_m!=none
					return BuildBabyActorResult(force_mo_m, ParentActor, ParentRace)
				endif
				; Random Child was none, go through list
				int i=0
				while i<mCount
					i+=1
					force_mo_m=StorageUtil.FormListGet(ParentRace, "FW.AddOn.BabyArmor_Male", i) as Armor
					if force_mo_m!=none
						return BuildBabyActorResult(force_mo_m, ParentActor, ParentRace)
					endif
				endwhile
			elseif fCount>0 && sex==1
				; First, check Random child from list
				Armor force_mo_f=StorageUtil.FormListGet(ParentRace, "FW.AddOn.BabyArmor_Female", Utility.RandomInt(0,fCount - 1)) as Armor
				if force_mo_f!=none
					return BuildBabyActorResult(force_mo_f, ParentActor, ParentRace)
				endif
				; Random Child was none, go through list
				int i=0
				while i<fCount
					i+=1
					force_mo_f=StorageUtil.FormListGet(ParentRace, "FW.AddOn.BabyArmor_Female", i) as Armor
					if force_mo_f!=none
						return BuildBabyActorResult(force_mo_f, ParentActor, ParentRace)
					endif
				endwhile
			endif
		else
			if(StorageUtil.GetIntValue(none, "FW.AddOn.Global_Female_Force_This_Baby") == 1)
				int mCount=StorageUtil.FormListCount(none, "FW.AddOn.Global_BabyArmor_Male")
				int fCount=StorageUtil.FormListCount(none, "FW.AddOn.Global_BabyArmor_Female")
				if mCount>0 && sex==0
					; First, check Random child from list
					Armor force_mo_m=StorageUtil.FormListGet(none, "FW.AddOn.Global_BabyArmor_Male", Utility.RandomInt(0,mCount - 1)) as Armor
					if force_mo_m!=none
						return BuildBabyActorResult(force_mo_m, ParentActor, ParentRace)
					endif
					; Random Child was none, go through list
					int i=0
					while i<mCount
						i+=1
						force_mo_m=StorageUtil.FormListGet(none, "FW.AddOn.Global_BabyArmor_Male", i) as Armor
						if force_mo_m!=none
							return BuildBabyActorResult(force_mo_m, ParentActor, ParentRace)
						endif
					endwhile
				elseif fCount>0 && sex==1
					; First, check Random child from list
					Armor force_mo_f=StorageUtil.FormListGet(none, "FW.AddOn.Global_BabyArmor_Female", Utility.RandomInt(0,fCount - 1)) as Armor
					if force_mo_f!=none
						return BuildBabyActorResult(force_mo_f, ParentActor, ParentRace)
					endif
					; Random Child was none, go through list
					int i=0
					while i<fCount
						i+=1
						force_mo_f=StorageUtil.FormListGet(none, "FW.AddOn.Global_BabyArmor_Female", i) as Armor
						if force_mo_f!=none
							return BuildBabyActorResult(force_mo_f, ParentActor, ParentRace)
						endif
					endwhile
				endif
			endIf
		endIf
	endif
	
	
	; No forced Baby found - Use default methode to get the babys race
	if Father == none
		FW_log.WriteLog("BeeingFemale - FWBabyItemList - getBabyArmor - Father race cannot be found...")
		if cfg.ShowDebugMessage
			Debug.Messagebox("Father race cannot be found...")
		endIf
	endIf

	FW_log.WriteLog("BeeingFemale - FWBabyItemList - getBabyArmor - Child Parent Race: " + ParentRace)
	if cfg.ShowDebugMessage
		Debug.Messagebox("Child Parent Race: " + ParentRace)
	endIf
	
	Armor b
	if sex==0
		; Male
		b=Manager.GetBabyArmor(ParentRace,0)
		if b!=none
			return BuildBabyActorResult(b, ParentActor, ParentRace)
		else
			FW_log.WriteLog("BeeingFemale - FWBabyItemList - getBabyArmor - BabyArmor cannot be found and thus reverting to FallBack_MaleBabyArmor...")
			if cfg.ShowDebugMessage
				Debug.Messagebox("BabyArmor cannot be found and thus reverting to FallBack_MaleBabyArmor...")
			endIf
			return BuildBabyActorResult(FallBack_MaleBabyArmor, ParentActor, ParentRace)
		endif
	else
		; Female
		b=Manager.GetBabyArmor(ParentRace,1)
		if b!=none
			return BuildBabyActorResult(b, ParentActor, ParentRace)
		else
			FW_log.WriteLog("BeeingFemale - FWBabyItemList - getBabyArmor - BabyArmor cannot be found and thus reverting to FallBack_FemaleBabyArmor...")
			if cfg.ShowDebugMessage
				Debug.Messagebox("BabyArmor cannot be found and thus reverting to FallBack_FemaleBabyArmor...")
			endIf
			return BuildBabyActorResult(FallBack_FemaleBabyArmor, ParentActor, ParentRace)
		endIf
	endIf
endFunction


; my custom edit for Skyrim SE
bool function IsMixWithCopyActorBaseEnabled(actor ParentActor, race ParentRace)
	if(StorageUtil.GetIntValue(ParentActor, "FW.AddOn.MixWithCopyActorBase", 0) > 0)
		return true
	endif
	if(StorageUtil.GetIntValue(ParentRace, "FW.AddOn.MixWithCopyActorBase", 0) > 0)
		return true
	endif
	if(StorageUtil.GetIntValue(none, "FW.AddOn.Global_MixWithCopyActorBase", 0) > 0)
		return true
	endif
	return false
endFunction

bool function ShouldProtectChildActor(actor ParentActor, race ParentRace)
	if(StorageUtil.GetIntValue(ParentActor, "FW.AddOn.ProtectedChildActor", 0) == 1)
		return true
	endif
	if(StorageUtil.GetIntValue(ParentRace, "FW.AddOn.ProtectedChildActor", 0) == 1)
		return true
	endif
	if(StorageUtil.GetIntValue(none, "FW.AddOn.Global_ProtectedChildActor", 0) == 1)
		return true
	endif
	return false
endFunction

ActorBase function GetChildBaseFromManager(actor ParentActor, race ParentRace, int sex, bool isPlayerChild)
	if isPlayerChild
		if sex == 0
			return Manager.GetPlayerBabyActorNew(ParentActor, ParentRace, 0)
		else
			return Manager.GetPlayerBabyActorNew(ParentActor, ParentRace, 1)
		endIf
	else
		if sex == 0
			return Manager.GetBabyActorNew(ParentActor, ParentRace, 0)
		else
			return Manager.GetBabyActorNew(ParentActor, ParentRace, 1)
		endIf
	endIf
endFunction

ActorBase function ResolveConfiguredFallbackChildBase(int sex, bool isPlayerChild)
	if isPlayerChild
		if sex == 0
			if FallBack_MalePlayerBabyActor
				return FallBack_MalePlayerBabyActor
			elseif FallBack_MaleBabyActor
				return FallBack_MaleBabyActor
			endif
		else
			if FallBack_FemalePlayerBabyActor
				return FallBack_FemalePlayerBabyActor
			elseif FallBack_FemaleBabyActor
				return FallBack_FemaleBabyActor
			endif
		endif
	else
		if sex == 0
			if FallBack_MaleBabyActor
				return FallBack_MaleBabyActor
			elseif FallBack_MalePlayerBabyActor
				return FallBack_MalePlayerBabyActor
			endif
		else
			if FallBack_FemaleBabyActor
				return FallBack_FemaleBabyActor
			elseif FallBack_FemalePlayerBabyActor
				return FallBack_FemalePlayerBabyActor
			endif
		endif
	endif
	return none
endFunction

ActorBase function ResolveFallbackChildBase(actor Mother, actor ParentActor, int sex, bool isPlayerChild, string logPrefix)
	ActorBase fallbackBase = ResolveConfiguredFallbackChildBase(sex, isPlayerChild)
	if fallbackBase
		FW_log.WriteLog(logPrefix + " - BabyActor cannot be found. Using configured fallback actor base: " + fallbackBase)
		if cfg.ShowDebugMessage
			Debug.Messagebox("BabyActor cannot be found. Using configured fallback actor base.")
		endIf
		return fallbackBase
	endIf

	if(ParentActor == none)
		FW_log.WriteLog(logPrefix + " - BabyActor cannot be found and thus summoning base NPC of the mother race...")
		if cfg.ShowDebugMessage
			Debug.Messagebox("BabyActor cannot be found and thus summoning base NPC of the mother race...")
		endIf
		return Mother.GetLeveledActorBase()
	else
		FW_log.WriteLog(logPrefix + " - BabyActor cannot be found and thus summoning base NPC of the parent race...")
		if cfg.ShowDebugMessage
			Debug.Messagebox("BabyActor cannot be found and thus summoning base NPC of the parent race...")
		endIf
		return ParentActor.GetLeveledActorBase()
	endIf
endFunction

ActorBase function ResolveChildBase(actor Mother, actor ParentActor, race ParentRace, int sex, bool isPlayerChild, string logPrefix)
	if(IsMixWithCopyActorBaseEnabled(ParentActor, ParentRace))
		FW_log.WriteLog(logPrefix + " - MixWithCopyActorBase is turned on!")
		int myProbChildActor = Manager.RaceProbChildActorBornNew(ParentActor, ParentRace)
		int myProbChildActorRandom = Utility.RandomInt(0, 99)
		if(myProbChildActorRandom < myProbChildActor)
			FW_log.WriteLog(logPrefix + " - Fall in to the ProbChildActorBorn in the AddOn!")
			ActorBase b = GetChildBaseFromManager(ParentActor, ParentRace, sex, isPlayerChild)
			if b
				return b
			endIf
			return ResolveFallbackChildBase(Mother, ParentActor, sex, isPlayerChild, logPrefix)
		else
			FW_log.WriteLog(logPrefix + " - Summoning base NPC of the Parent race due to the AddOn settings...")
			return ParentActor.GetLeveledActorBase()
		endIf
	else
		ActorBase b = GetChildBaseFromManager(ParentActor, ParentRace, sex, isPlayerChild)
		if b
			return b
		endIf
		return ResolveFallbackChildBase(Mother, ParentActor, sex, isPlayerChild, logPrefix)
	endIf
endFunction

ActorBase function ResolveStoredFatherRaceChildBase(actor ParentActor, race ParentRace, race storedFatherRace, int sex, bool isPlayerChild, string logPrefix)
	if !storedFatherRace
		return none
	endif
	if ParentRace == storedFatherRace
		return none
	endif

	FW_log.WriteLog(logPrefix + " - Primary child lookup failed. Trying stored father race: " + storedFatherRace)
	if cfg.ShowDebugMessage
		Debug.Messagebox("Primary child lookup failed. Trying stored father race.")
	endIf
	return GetChildBaseFromManager(ParentActor, storedFatherRace, sex, isPlayerChild)
endFunction

; Check "Female_Force_This_Baby" setting on specific actor
bool function myForcedBabySetting(Actor act, Race act_race)
	if(act)
		if(StorageUtil.GetIntValue(act, "FW.AddOn.Female_Force_This_Baby", 0) == 0)
			race abr = act.GetRace()
			if abr
				if(StorageUtil.GetIntValue(abr, "FW.AddOn.Female_Force_This_Baby", 0) != 0)
					return true
				endIf
			endIf
		else
			return true
		endIf
	elseif(act_race)
		if(StorageUtil.GetIntValue(act_race, "FW.AddOn.Female_Force_This_Baby", 0) != 0)
			return true
		endIf
	endIf
	return false
endFunction

; Resolve parent actor/race for actor-base selection.
; Returns [0]=ParentActor, [1]=ParentRace, [2]=selectedFatherRace (optional).
bool function ShouldUseStoredFatherRace(actor Mother, race storedFatherRace)
	if(myForcedBabySetting(Mother, none))
		FW_log.WriteLog("FWBabyItemList - ShouldUseStoredFatherRace: mother is forcing her own baby model. storedFatherRace = " + storedFatherRace)
		return false
	elseif(myForcedBabySetting(none, storedFatherRace))
		FW_log.WriteLog("FWBabyItemList - ShouldUseStoredFatherRace: stored father race is forcing its baby model. storedFatherRace = " + storedFatherRace)
		return true
	else
		int myProbRandom = Utility.RandomInt(0, 99)
		int myChildRaceDeterminedByFather = Manager.ActorChildRaceDeterminedByFather(none, storedFatherRace)
		FW_log.WriteLog("FWBabyItemList - ShouldUseStoredFatherRace: mother = " + Mother + ", storedFatherRace = " + storedFatherRace + ", myProbRandom = " + myProbRandom + ", ChildRaceDeterminedByFather = " + myChildRaceDeterminedByFather)
		if(myProbRandom < myChildRaceDeterminedByFather)
			FW_log.WriteLog("FWBabyItemList - ShouldUseStoredFatherRace: using stored father race")
			return true
		endif
	endif
	FW_log.WriteLog("FWBabyItemList - ShouldUseStoredFatherRace: using mother race")
	return false
endFunction

bool function ShouldUseFatherActor(actor Mother, actor Father, race storedFatherRace)
	if(myForcedBabySetting(Mother, none))
		return false
	elseif(myForcedBabySetting(Father, none))
		return true
	else
		int myProbRandom = Utility.RandomInt(0, 99)
		int myChildRaceDeterminedByFather = Manager.ActorChildRaceDeterminedByFather(Father, storedFatherRace)
		if(myProbRandom < myChildRaceDeterminedByFather)
			return true
		endif
	endif
	return false
endFunction

Form[] function ResolveParentActorAndRace(actor Mother, actor Father, actor ParentActor, race storedFatherRace)
	Form[] result = new Form[3] ; 0 = ParentActor, 1 = ParentRace, 2 = selectedFatherRace
	if ParentActor == none
		if Father == none
			ParentActor = Mother
			if storedFatherRace
				if(ShouldUseStoredFatherRace(Mother, storedFatherRace))
					result[1] = storedFatherRace
					result[2] = storedFatherRace
				else
					result[1] = Mother.GetRace()
				endif
			else
				result[1] = Mother.GetRace()
			endIf
		else
			if(ShouldUseFatherActor(Mother, Father, storedFatherRace))
				ParentActor = Father
			else
				ParentActor = Mother
			endIf
			result[1] = ParentActor.GetRace()
		endIf
	else
		result[1] = ParentActor.GetRace()
		if Father == none && storedFatherRace
			if(ShouldUseStoredFatherRace(Mother, storedFatherRace))
				result[1] = storedFatherRace
				result[2] = storedFatherRace
			endif
		endIf
	endIf
	result[0] = ParentActor
	return result
endFunction

; Pack the chosen base + parent context for the caller to unpack.
Form[] function BuildBabyActorResult(Form baseForm, Actor parentActor, Race parentRace)
	Form[] result = new Form[3]
	result[0] = baseForm
	result[1] = parentActor
	result[2] = parentRace
	return result
endFunction

; Select baby actor base and return [0]=ActorBase, [1]=ParentActor, [2]=ParentRace.
Form[] function getBabyActorNew(actor Mother, actor Father, int sex, Race FatherRace = none)
	if Mother == PlayerRef || Father == PlayerRef
		return getPlayerBabyActorNew(Mother, Father, sex, FatherRace)
	endif
	
	race storedFatherRace = none
	if Father == none && FatherRace
		storedFatherRace = FatherRace
	endif
	FW_log.WriteLog("FWBabyItemList - getBabyActorNew: Mother = " + Mother + ", Father = " + Father + ", FatherRace arg = " + FatherRace + ", storedFatherRace = " + storedFatherRace)

	Form[] parentContext = ResolveParentActorAndRace(Mother, Father, none, storedFatherRace)
	Actor ParentActor = parentContext[0] as Actor
	race ParentRace = parentContext[1] as Race
	
	if Father == none
		FW_log.WriteLog("BeeingFemale - FWBabyItemList - getBabyActor - Father cannot be found...")
		if cfg.ShowDebugMessage
			Debug.Messagebox("Father cannot be found...")
		endIf
	endIf
	
	FW_log.WriteLog("BeeingFemale - FWBabyItemList - getBabyActor - Child Parent Race: " + ParentRace)
	if cfg.ShowDebugMessage
		Debug.Messagebox("Child Parent Race: " + ParentRace)
	endIf
	ActorBase b = ResolveChildBase(Mother, ParentActor, ParentRace, sex, false, "BeeingFemale - FWBabyItemList - getBabyActor")
	if !b && storedFatherRace
		b = ResolveStoredFatherRaceChildBase(ParentActor, ParentRace, storedFatherRace, sex, false, "BeeingFemale - FWBabyItemList - getBabyActor")
	endIf
	if !b
		FW_log.WriteLog("BeeingFemale - FWBabyItemList - getBabyActor - Failed to resolve child actor base.")
		return BuildBabyActorResult(none, ParentActor, ParentRace)
	endIf
	if(ShouldProtectChildActor(ParentActor, ParentRace))
		b.SetProtected()
	endIf
	return BuildBabyActorResult(b, ParentActor, ParentRace)
endFunction

; Deprecated
ActorBase function getBabyActor(actor Mother, actor Father, int sex)
	FW_log.WriteLog("FWBabyItemList - getBabyActor: deprecated call")
endFunction

; my custom edit for Skyrim SE
; Select player baby actor base and return [0]=ActorBase, [1]=ParentActor, [2]=ParentRace.
Form[] function getPlayerBabyActorNew(actor Mother, actor Father, int sex, Race FatherRace = none)
	race storedFatherRace = none
	if Father == none && FatherRace
		storedFatherRace = FatherRace
	endIf
	FW_log.WriteLog("FWBabyItemList - getPlayerBabyActorNew: Mother = " + Mother + ", Father = " + Father + ", FatherRace arg = " + FatherRace + ", storedFatherRace = " + storedFatherRace)
	Form[] parentContext = ResolveParentActorAndRace(Mother, Father, none, storedFatherRace)
	Actor ParentActor = parentContext[0] as Actor
	race ParentRace = parentContext[1] as Race
	
	if Father == none
		FW_log.WriteLog("BeeingFemale - FWBabyItemList - getPlayerBabyActor - Father cannot be found...")
		if cfg.ShowDebugMessage
			Debug.Messagebox("Father cannot be found...")
		endIf
	endIf
	
	FW_log.WriteLog("BeeingFemale - FWBabyItemList - getPlayerBabyActor - Child Parent Race: " + ParentRace)
	if cfg.ShowDebugMessage
		Debug.Messagebox("Child Parent Race: " + ParentRace)
	endIf
	ActorBase b = ResolveChildBase(Mother, ParentActor, ParentRace, sex, true, "BeeingFemale - FWBabyItemList - getPlayerBabyActor")
	if !b && storedFatherRace
		b = ResolveStoredFatherRaceChildBase(ParentActor, ParentRace, storedFatherRace, sex, true, "BeeingFemale - FWBabyItemList - getPlayerBabyActor")
	endIf
	if !b
		FW_log.WriteLog("BeeingFemale - FWBabyItemList - getPlayerBabyActor - Failed to resolve child actor base.")
		return BuildBabyActorResult(none, ParentActor, ParentRace)
	endIf
	if(ShouldProtectChildActor(ParentActor, ParentRace))
		b.SetProtected()
	endIf
	return BuildBabyActorResult(b, ParentActor, ParentRace)
endFunction

; Deprecated
ActorBase function getPlayerBabyActor(actor Mother, actor Father, int sex)
	FW_log.WriteLog("FWBabyItemList - getPlayerBabyActor - deprecated call")
endFunction


ActorBase function getBabyActorByRace(race RaceID, int sex)
	ActorBase b
	if sex==0
		; Male
		b=Manager.GetBabyActor(RaceID,0)
		if b!=none
			return b
		else
			FW_log.WriteLog("BeeingFemale - FWBabyItemList - getBabyActorByRace - BabyActor cannot be found and thus reverting to FallBack_MaleBabyActor...")
			if cfg.ShowDebugMessage
				Debug.Messagebox("BabyActor cannot be found and thus reverting to FallBack_MaleBabyActor...")
			endIf
			return FallBack_MaleBabyActor
		endif
	else
		; Female
		b=Manager.GetBabyActor(RaceID,1)
		if b!=none
			return b
		else
			FW_log.WriteLog("BeeingFemale - FWBabyItemList - getBabyActorByRace - BabyActor cannot be found and thus reverting to FallBack_FemaleBabyActor...")
			if cfg.ShowDebugMessage
				Debug.Messagebox("BabyActor cannot be found and thus reverting to FallBack_FemaleBabyActor...")
			endIf
			return FallBack_FemaleBabyActor
		endIf
	endIf
endFunction

ActorBase function getPlayerBabyActorByRace(race RaceID, int sex)
	ActorBase b
	if sex==0
		; Male
		b=Manager.GetPlayerBabyActor(RaceID,0)
		if b!=none
			return b
		else
			FW_log.WriteLog("BeeingFemale - FWBabyItemList - getPlayerBabyActorByRace - PlayerBabyActor cannot be found and thus reverting to FallBack_MalePlayerBabyActor...")
			if cfg.ShowDebugMessage
				Debug.Messagebox("PlayerBabyActor cannot be found and thus reverting to FallBack_MalePlayerBabyActor...")
			endIf
			return FallBack_MalePlayerBabyActor
		endif
	else
		; Female
		b=Manager.GetPlayerBabyActor(RaceID,1)
		if b!=none
			return b
		else
			FW_log.WriteLog("BeeingFemale - FWBabyItemList - getPlayerBabyActorByRace - PlayerBabyActor cannot be found and thus reverting to FallBack_FemalePlayerBabyActor...")
			if cfg.ShowDebugMessage
				Debug.Messagebox("PlayerBabyActor cannot be found and thus reverting to FallBack_FemalePlayerBabyActor...")
			endIf
			return FallBack_FemalePlayerBabyActor
		endIf
	endIf
endFunction

