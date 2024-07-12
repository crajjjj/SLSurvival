Scriptname	_JSW_SUB_LaborScript	extends	ReferenceAlias

_JSW_BB_Storage				Property	Storage				Auto	; Storage data helper

GlobalVariable				Property	BirthType			Auto	; 
GlobalVariable				Property	LaborDuration		Auto	; 
GlobalVariable				Property	LaborEnabled		Auto	; 
GlobalVariable				Property	VerboseMode			Auto	; 

Actor						Property	playerRef			Auto	;
; 2.21
FormList					Property	ParentsFemale		Auto	; list of mothers who will have babies regardless of BirthType setting

ImageSpaceModifier			Property	FadeToBlack			Auto	; Visual effect for fading to black f756d
ImageSpaceModifier			Property	HoldBlack			Auto	; Visual effect for retaining the black screen f756e
ImageSpaceModifier			Property	FadeFromBlack		Auto	; Visual effect for fading back from black f756f

Perk						Property	DARHook				Auto	; fe000802

SoulGem						Property	BabyGem				Auto	; Filled black soul gem 0002e504

Spell						Property	LaborSpell			Auto	; spell that has the ME with the birth animation

actor	thisActor		=	none
bool	cameraState		=	false
int		actorIndex		=	0

; Event lock codes
int	_eventNone	=	0
int	_eventLabor	=	1
;int _eventSpawn = 2

event	OnPlayerLoadGame()

	if (GetReference() == none)
		GetOwningQuest().SetcurrentStageID(20)
	endIf

endEvent

event	OnInit()

	thisActor = GetReference() as actor
	if thisActor
		actorIndex = Storage.TrackedActors.Find(thisActor as form)
		if ((actorIndex != -1) && (Storage.EventLock[actorIndex] == _eventNone))
			Storage.EventLock[actorIndex] = _eventLabor
			if LaborEnabled.GetValue()
				thisActor.AddPerk(DARHook) ;Empty Perk in CK that DAR can detect
				if (thisActor == playerRef)
					GoToState("PlayerLabor1")
				elseIf thisActor.IsAIEnabled()
					GoToState("Labor1")
				else
					GoToState("LaborNoAI1")
				endIf
			else
				if (thisActor == playerRef)
					GoToState("PlayerNoLabor1")
				else
					GoToState("NoLabor1")
				endIf
			endIf
			RegisterForSingleUpdate(1.0)
			return
		endIf
	endIf
	GetOwningQuest().SetCurrentStageID(20)

endEvent

state	PlayerLabor1

	event	OnUpdate()
		thisActor.AddSpell(LaborSpell, false)
		cameraState = Game.GetCameraState() as bool
		Game.DisablePlayerControls(false, false, false, false, false, true, true, true)
		Game.ForceThirdPerson()
		GoToState("PlayerLabor2")
		RegisterForSingleUpdate(LaborDuration.GetValue())
	endEvent

endState

state	PlayerLabor2

	event	OnUpdate()
		GiveBirth()
		GoToState("PlayerLabor3")
		RegisterForSingleUpdate(2.0)
	endEvent

endState

state	PlayerLabor3

	event	OnUpdate()
		if !cameraState
			Game.ForceFirstPerson()
		endIf
		Game.EnablePlayerControls()
		GoToState("CommonEnd")
		RegisterForSingleUpdate(1.0)
	endEvent

endState

state	PlayerNoLabor1

	event	OnUpdate()
		FadeToBlack.Apply()
		GoToState("PlayerNoLabor2")
		RegisterForSingleupdate(2.0)
	endEvent

endState

state	PlayerNoLabor2

	event	OnUpdate()
		FadeToBlack.PopTo(HoldBlack)
		GoToState("PlayerNoLabor3")
		RegisterForSingleUpdate(5.0)
	endEvent

endState

state	PlayerNoLabor3

	event	OnUpdate()
		HoldBlack.PopTo(FadeFromBlack)
		HoldBlack.Remove()
		GiveBirth()
		GoToState("CommonEnd")
		RegisterForSingleUpdate(1.0)
	endEvent

endState

state	Labor1

	event	OnUpdate()
		thisActor.AddSpell(LaborSpell, false)
		GoToState("Labor2")
		RegisterForSingleUpdate(LaborDuration.GetValue())
	endEvent

endState

state	Labor2

	event	OnUpdate()
		GiveBirth()
		GoToState("CommonEnd")
		RegisterforSingleUpdate(2.0)
	endEvent

endState

state	LaborNoAI1

	event	OnUpdate()
		GoToState("NoLabor1")
		RegisterForSingleUpdate(LaborDuration.GetValue())
	endEvent

endState

state	NoLabor1

	event	OnUpdate()
		GiveBirth()
		GoToState("CommonEnd")
		RegisterForSingleUpdate(1.0)
	endEvent

endState

state	CommonEnd

	event	OnUpdate()
		thisActor.RemovePerk(DARHook) ;Empty Perk in CK that DAR can detect
		if VerboseMode.GetValue()
			Debug.Notification(thisActor.GetDisplayName() + " gave birth to " + (Storage.LastFatherForm[actorIndex] as actor).GetDisplayName() + "'s child")
		endIf
		Storage.EventLock[actorIndex] = _eventNone
		GetOwningQuest().SetCurrentStageID(20)
		; 2.08
		thisActor.RemoveSpell(LaborSpell)
	endEvent

endState

function	GiveBirth()
{Perform birth logic for the given actor}

	float now = Utility.GetCurrentGameTime()
    Storage.LastConception[actorIndex] = 0.0
    Storage.LastBirth[actorIndex] = now
	; 2.08
	Storage.LastFatherForm[actorIndex] = Storage.CurrentFatherForm[actorIndex]
	form daddy = Storage.CurrentFatherForm[actorIndex]
	if daddy
		Storage.CurrentFatherForm[actorIndex] = none
		int daddyIndex = Storage.TrackedFathers.Find(daddy)
		if (daddyIndex != -1)
			Storage.ChildrenFathered[daddyIndex] = Storage.ChildrenFathered[daddyIndex] + 1
		endIf
	endIf
	Storage.TimesDelivered[actorIndex] = Storage.TimesDelivered[actorIndex] + 1
	Storage.OvulationBlock[actorIndex] = 1

	float _birthType = BirthType.GetValue()
	; 2.21 change order of operations
	bool forceBaby = (ParentsFemale.GetSize() > 0) && (ParentsFemale.Find(thisActor as form) != -1)
	if forceBaby || (_birthType == 2.0)
        int raceIndex = Storage.GetRaceIndex(thisActor, actorIndex)
;        Armor babyArmor = BabyDefault
		; 2.21
        Armor babyArmor = Storage.BirthBabyRace[1] as armor
        
        if (raceIndex != -1)
            babyArmor = Storage.BirthBabyRace[raceIndex] as armor
        endIf
        
        if (thisActor.GetItemCount(babyArmor) == 0)
			bool isNPC = (thisActor != playerRef)
            ; Limit the number of baby items for any actor to one. This
            ; ensures that we can better control child spawning in the
            ; average cases. Not perfect, but it *is* simple
			thisActor.AddItem(babyArmor, 1, isNPC)
			thisActor.EquipItem(babyArmor, isNPC, isNPC)
            Storage.BabyAdded[actorIndex] = now
        endIf
    elseIf (_birthType == 0.0)
        ; Do a whole lot of nothing, as stated in the MCM. :)
    else; (_birthType == 1.0)
        ; Add a filled black soul gem to the actor's inventory
		thisActor.Additem(BabyGem, 1, (thisActor != playerRef))
    endIf
	_JSW_BB_Utility Util = ((Storage as quest) as _JSW_BB_Utility)
	Util.ClearBellyBreastScale(thisActor)
	Util.UpdateNPCFactions(thisActor, actorIndex)
	; informs FA, or any other listening mod, of the event
	Util.SendTrackingEvent("FertilityModeLabor", thisActor as form, actorIndex)

endFunction
