Scriptname		_JSW_SUB_DailyActorUpdt		Extends		ActiveMagicEffect

_JSW_BB_Storage						Property	Storage				Auto	; Storage data helper
_JSW_SUB_GVAlias					Property	GVAlias				Auto	; 
;_JSW_SUB_HandlerQuestAliasScript	Property	FMHandler			Auto	;

Faction			Property	FMDailyActorUpdtFact	Auto	; 

Keyword			Property	ActorTypeCreature	Auto		; Keyword for identifying creature types

Quest			Property	RhiadaQuest			Auto		; quest that temp. makes Rhaida persistent while I need her to be
; 2.18 replace previous hard-coded couples values with flexible formlists
formList		Property	ParentsFemale		Auto		;	
formList		Property	ParentsMale			Auto		;	
formList		Property	ConfirmMessage		Auto		;	

event	OnEffectStart(Actor akTarget, Actor akCaster)

	FertilityModeActorMaint()
	; 2.18
	CheckCouples()
	RhiadaQuest.SetCurrentStageID(20)
	GetTargetActor().SetFactionRank(FMDailyActorUpdtFact, 0)

endEvent
; 2.18
function	CheckCouples()

	int howMany = ParentsFemale.GetSize()
;	debug.trace("FM+: defined couples female "+ howMany + " male " + ParentsMale.GetSize() + " message " + ConfirmMessage.GetSize())
	if (howMany > 0) && (howMany == ParentsMale.GetSize()) && (howMany == ConfirmMessage.GetSize())
		while howMany > Storage.CouplesQuestions.Length
			Storage.CouplesQuestions = Utility.ResizeIntArray(Storage.CouplesQuestions, (Storage.CouplesQuestions.Length + 1), 2)
		endWhile
	else
	; the three formLists *have to be* the same length, else GTFO
		return
	endIf
	int count = 0
	while (count < howMany)
		if Storage.CouplesQuestions[count] == 2
			Storage.CouplesQuestions[count] = AskPlayerQuestion(ParentsFemale.GetAt(count), ParentsMale.GetAt(count), ConfirmMessage.GetAt(count))
			;/	why an int array?   1) I don't trust bool arrays, I've had them malfunction in the past and the ck wiki
				discussion page has the same reported by someone else.   2) in case I or some other mod in the future 
				wants to know how the player answered the question, we can find out	/;
				;/	2 = question not asked
					1 = question asked, answered in the affirmative
					0 = question asked, answered negative /;
		endIf
		count += 1
	endWhile

endFunction

int	function	AskPlayerQuestion(form her, form him, form theMessage)

	int index = Storage.TrackedActors.Find(her)
	if (index != -1) && (Storage.TrackedFathers.Find(him) != -1)
	; 2.18
		if (Storage.LastConception[index] != 0.0) && (Storage.CurrentFatherForm[index] == him)
			return 1
		endIf
		if !(theMessage as message) || ((theMessage as message).Show() == 0)
			MakePregnant(her as actor, him, index)
			return 1
		endIf
		return 0
	endIf
	return 2

endFunction

function	MakePregnant(actor mother, form father, int index)

	float today = Utility.GetCurrentGameTime()
;	float triHalf = (Storage.FMValues[0] as float / 2.0)
	float triHalf = (GVAlias.GVHolder.PregnancyDuration as float / 6.0)
	Storage.LastInsemination[index] = 0.0
	Storage.SpermCount[index] = 0
	Storage.LastOvulation[index] = 0.0
	Storage.CurrentFatherForm[index] = father
	if today > triHalf
		Storage.LastConception[index] = (today - triHalf)
	else
		Storage.LastConception[index] = 0.01
	endIf
	; 2.20
	; send modevent for FA or any other listening mods
	((Storage as quest) as _JSW_BB_Utility).SendDetailedTrackingEvent("FertilityModeConception", mother as form, mother.GetDisplayName(), (Storage.CurrentFatherForm[index] as actor).GetDisplayName(), index)
	((Storage as quest) as _JSW_BB_Utility).UpdateNPCFactions(mother, index)

endFunction

function	FertilityModeActorMaint()
{daily Tracked Actor Update}

		; removes dead actors from tracking
		; and tries to update the locations of the remaining live actors

    if GVAlias.GVHolder.VerboseMode
        Debug.Notification("FM Daily Actor Maint started.")
    endIf

    form thisActor = none
    int mIndex = Math.LogicalAnd(Storage.TrackedActors.Length, 0x00000FFF)
    int deaders = 0
	string locName = ""
	Location where = none
	bool _allowCreatures = GVAlias.GVHolder.AllowCreatures
	; 2.24
	form		parentLoc	=	none
	int			anInt

    while (mIndex)
        mIndex -= 1
        thisActor = (Storage.TrackedActors[mIndex])
				;  this is the slow shit.   Everything above here can run on 500+ actors
				;  in under a second, these two take at least one frame *each* to respond
				;  which limits us to processing (FPS/2) actors/second.  This is my
				;  reasoning behind not doing these checks on every update.  The upside is
				;  that by repeatedly losing focus, this puts almost no strain on Papyrus.
		if thisActor

			; 2.17 add blacklist check
			if !(thisActor as actor) || ((Storage.ActorBlackList.Find(thisActor) != -1) || (thisActor as Actor).IsDead() || \
				(Storage.BlackListByName.Find((thisActor as objectReference).GetDisplayName()) != -1))

				Storage.TrackedActorRemove(mIndex, false)	; I no longer see dead people
				deaders += 1
			else
				where = (thisActor as actor).GetCurrentLocation()
				if where
					locName = where.GetName()
					if locName == ""
						locName = "Skyrim"
					endIf
					; 2.24
					if (GVAlias.HabitationLocs.Find(where) != -1)
						parentLoc = where
					else
						anInt = GVAlias.ChildLocs.Find(where)
						if anInt != -1
							parentLoc = GVAlias.HabitationLocs[anInt]
						endIf
					endIf
				else
					locName = "Tamriel"
				endIf
				Storage.LastMotherLocation[mIndex] = locName
				; 1.62
				Storage.ActorLocation[mIndex] = where as form
				; 2.24
				Storage.ActorLocParent[mIndex] = parentLoc
				parentLoc = none
				locName = ""
				where = none
			endIf
        thisActor = none
		endIf
    endWhile

	mIndex = Math.LogicalAnd(Storage.TrackedFathers.Length, 0x00000FFF)
	locName = ""
	thisActor = none
	while (mIndex)
        mIndex -= 1
        thisActor = (Storage.TrackedFathers[mIndex])
		if thisActor
			if !(thisActor as actor) || ((Storage.ActorBlackList.Find(thisActor) != -1) || (thisActor as Actor).IsDead() || \
				(Storage.BlackListByName.Find((thisActor as objectReference).GetDisplayName()) != -1) || \
				(!_allowCreatures && (thisActor as Actor).GetRace().HasKeyword(ActorTypeCreature)))

				Storage.TrackedFatherRemove(mIndex, false)
				deaders += 1
			else
				where = (thisActor as Actor).GetCurrentLocation()
					if where
						locName = where.GetName()
						if locName == ""
							locName = "Skyrim"
						endIf
						; 2.24
						if (GVAlias.HabitationLocs.Find(where) != -1)
							parentLoc = where
						else
							anInt = GVAlias.ChildLocs.Find(where)
							if anInt != -1
								parentLoc = GVAlias.HabitationLocs[anInt]
							endIf
						endIf
					else
						locName = "Tamriel"
					endIf
				Storage.LastFatherLocation[mIndex] = locName
				; 1.62
				Storage.FatherLocation[mIndex] = where as form
				; 2.24
				Storage.FatherLocParent[mIndex] = parentLoc
				parentLoc = none
				locName = ""
					where = none
			endIf
			; new for 1.4, removes negative values and caps max positive at 31
			Storage.RefractoryPeriod[mIndex] = Math.LogicalAnd(Storage.RefractoryPeriod[mIndex], 0x0000001F)
        thisActor = none
		endIf
    endWhile
	
    if GVAlias.GVHolder.VerboseMode
        if (deaders != 0)
            Debug.Notification(deaders + " dead or blocked people removed from tracking.")
		endIf
		Debug.Notification("FM Actor Maint finished. " + Storage.TrackedActors.Length + " F, " + Storage.TrackedFathers.Length + " M")
    endIf
endFunction
