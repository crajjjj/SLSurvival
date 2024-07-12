Scriptname SLIF_Scanner extends Quest

ReferenceAlias Property pNearbyActor1 Auto
ReferenceAlias Property pNearbyActor2 Auto
ReferenceAlias Property pNearbyActor3 Auto
ReferenceAlias Property pNearbyActor4 Auto
ReferenceAlias Property pNearbyActor5 Auto
ReferenceAlias Property pNearbyActor6 Auto
ReferenceAlias Property pNearbyActor7 Auto
ReferenceAlias Property pNearbyActor8 Auto
ReferenceAlias Property pNearbyActor9 Auto
ReferenceAlias Property pNearbyActor10 Auto

GlobalVariable Property pScannerRange Auto
GlobalVariable Property UpdateTimer Auto

Function initializeScanner()
	RegisterForSingleUpdate(0.1)
endFunction

Event OnUpdate()
	Reset()
	Stop()
	Start()
	
	bool active        = SLIF_Config.GetPathInt(".scanner", ".active")        as bool
	bool on_load       = SLIF_Config.GetPathInt(".scanner", ".on_load")       as bool
	bool over_time     = SLIF_Config.GetPathInt(".scanner", ".over_time")     as bool
	bool purge_dead    = SLIF_Config.GetPathInt(".scanner", ".purge_dead")    as bool
	bool update_actors = SLIF_Config.GetPathInt(".scanner", ".update_actors") as bool
	
	if (active && (on_load || over_time || purge_dead || update_actors))
		while(StorageUtil.GetIntValue(none, "slif_working") as bool)
			Utility.Wait(1.0)
		endWhile
		if (purge_dead || update_actors)
			PurgeDeadAndUpdateActors(purge_dead, update_actors)
		endIf
		if (over_time || on_load)
			CheckActorsForUpdate()
		endIf
		if (over_time || purge_dead || update_actors)
			RegisterForSingleUpdate(UpdateTimer.GetValue())
		else
			Reset()
			Stop()
		endIf
	endIf
endEvent

Event OnSleepStart(float afSleepStartTime, float afDesiredSleepEndTime)
	UnregisterForUpdate()
endEvent

Event OnSleepStop(bool abSleepInterrupted)
	if (SLIF_Config.GetPathInt(".scanner", ".on_sleep") as bool)
		RegisterForSingleUpdate(0.1)
	endIf
endEvent

bool purge_dead_and_update_actors = false

function PurgeDeadAndUpdateActors(bool purge_dead, bool update_actors)
	if (purge_dead_and_update_actors == false)
		purge_dead_and_update_actors = true
		
		int i = 0
		while(i < StorageUtil.FormListCount(none, "slif_actor_list"))
			Actor kActor = StorageUtil.FormListGet(none, "slif_actor_list", i) as Actor
			if (kActor)
				if (kActor.IsDead() && purge_dead)
					SLIF_Main.unregisterActor(kActor)
				else
					if (update_actors && StorageUtil.HasIntValue(kActor, "slif_scanning_actor") == false)
						SLIF_Main.updateActor(kActor)
					endIf
					i += 1
				endIf
			else
				SLIF_Util.RemoveActor(kActor, "", i)
			endIf
		endWhile
		
		int j = 0
		while(j < StorageUtil.FormListCount(none, "slif_morph_actor_list"))
			Actor kActor = StorageUtil.FormListGet(none, "slif_morph_actor_list", j) as Actor
			if (kActor)
				if (kActor.IsDead() && purge_dead)
					SLIF_Morph.unregisterActor(kActor)
				else
					if (update_actors && StorageUtil.HasIntValue(kActor, "slif_scanning_actor") == false)
						SLIF_Morph.updateActor(kActor)
					endIf
					j += 1
				endIf
			else
				SLIF_Util.RemoveActor(kActor, "", j, "slif_morph_actor")
			endIf
		endWhile
		
		purge_dead_and_update_actors = false
	endIf
endFunction

function CheckActorsForUpdate()
	CheckActor(Game.GetPlayer())
	CheckActor(pNearbyActor1.GetActorReference())
	CheckActor(pNearbyActor2.GetActorReference())
	CheckActor(pNearbyActor3.GetActorReference())
	CheckActor(pNearbyActor4.GetActorReference())
	CheckActor(pNearbyActor5.GetActorReference())
	CheckActor(pNearbyActor6.GetActorReference())
	CheckActor(pNearbyActor7.GetActorReference())
	CheckActor(pNearbyActor8.GetActorReference())
	CheckActor(pNearbyActor9.GetActorReference())
	CheckActor(pNearbyActor10.GetActorReference())
endFunction

function CheckActor(Actor kActor)
	if (kActor)
		if (kActor.Is3DLoaded())
			if (StorageUtil.HasIntValue(kActor, "slif_scanning_actor") == false)
				StorageUtil.SetIntValue(kActor, "slif_scanning_actor", 1)
				if (StorageUtil.FormListHas(none, "slif_actor_list", kActor))
					SLIF_Main.updateActor(kActor)
				endIf
				if (StorageUtil.FormListHas(none, "slif_morph_actor_list", kActor))
					SLIF_Morph.updateActor(kActor)
				endIf
				StorageUtil.UnsetIntValue(kActor, "slif_scanning_actor")
			endIf
		endIf
	endIf
endFunction
