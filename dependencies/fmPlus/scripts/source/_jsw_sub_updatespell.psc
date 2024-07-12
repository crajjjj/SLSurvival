Scriptname		_JSW_SUB_UpdateSpell		Extends		ActiveMagicEffect

_JSW_BB_Storage					Property	Storage				Auto	; Storage data helper
; 1.11
_JSW_SUB_ScheduledUpdater		Property	SchedUpdatr			Auto	; Scheduled Updater script for RNG array

Spell 							Property	FMUpdateSpell		Auto	; the spell that applies this ME


; the next will vary based on exactly what needs to be updated

;		---- begin 2.09 ----
;Quest			Property		FGQuest				Auto
;Quest			Property		MiscUtilQ			Auto
;Quest			Property		UpdHlpQ				Auto
;Quest			Property		AdoptQ				Auto
;		----  end 2.09  ----
;		---- begin 2.11 ----
FormList		Property		ActorBlackFormList	Auto	; formlist copied to form[] on storage script NEVER STOP!
;		----  end 2.11  ----
;		---- begin 2.21 ----
Faction			Property		TrackedMaleFaction	Auto	; faction for tracked males
;		----  end 2.21  ----
;		---- begin 2.24 ----
Formlist		Property		ExcludeAT			Auto	; associations used for eliminating random inseminators
;		----  end 2.24  ----

event	OnEffectStart(Actor akTarget, Actor akCaster)

	; ----   Common   ----
	int index = 1024
	if (SchedUpdatr.RandomIntArray.Length != 1024)
		SchedUpdatr.RandomIntArray = Utility.ResizeIntArray(SchedUpdatr.RandomIntArray, 1024, -1)
;		int index = 1024
		while (index > 0)
			index -= 1
			SchedUpdatr.RandomIntArray[index] = Utility.RandomInt(0, 99)
		endWhile
		Debug.Trace("FM+ Info: Random Int Array Initialized", 0)
	endIf
	index = 6
	while (index > 0)
		index -= 1
		Storage.LaborRefs[index].GetOwningQuest().Reset()
		Storage.LaborRefs[index].GetOwningQuest().Stop()
	endWhile
	; ---- end Common ----
	; ---- begin 2.09 ----
;/	MiscUtilQ.Reset()
	MiscUtilQ.Stop()
	MiscUtilQ.SetCurrentStageID(10)
	UpdHlpQ.Reset()
	UpdHlpQ.Stop()
	AdoptQ.Reset()
	AdoptQ.Stop()
	FGQuest.Reset()
	if FGQuest.IsRunning()
		FGQuest.Stop()
		FGQuest.SetCurrentStageID(10)
	endIf/;
	; ----  end 2.09  ----
	; ---- begin 2.10 ----
;	Storage.Fidelity	=	Utility.ResizeIntArray(Storage.Fidelity, Math.LogicalAnd(Storage.TrackedActors.Length, 0x00000FFF))
	; ----  end 2.10  ----
	; ---- begin 2.11 ----
	if !Storage.FormListToForm
		Storage.ActorBlackList = ActorBlackFormList.ToArray()
		Storage.FormListToForm = true
		debug.trace("FM+ info: ActorBlackList = " + Storage.ActorBlackList.Length)
	endIf
;/	if (Storage.BlacklistByName.Find("ghost") == -1)
		Storage.BlacklistByName = Utility.ResizeStringArray(Storage.BlacklistByName, Math.LogicalAnd((Storage.BlacklistByName.Length + 1), 0x00000FFF), "ghost")
		Debug.Trace("FM+ : ghost added to blacklist")
	endIf/;
	if Storage.PlayerChildRace.Length < Storage.PlayerChildName.Length
		Storage.PlayerChildRace = Utility.ResizeFormArray(Storage.PlayerChildRace, Math.LogicalAnd(Storage.PlayerChildName.Length, 0x00000FFF))
	endIf
	if Storage.LastFatherForm.Length < Storage.TrackedActors.Length
		Storage.LastFatherForm = Utility.ResizeFormArray(Storage.LastFatherForm, Math.LogicalAnd(Storage.TrackedActors.Length, 0x00000FFF))
	endIf
	; ----  end 2.11  ----
	; ---- begin 2.13 ----
	; as of 2.20, this array is dropped
;	Storage.LastFather = Utility.ResizeStringArray(Storage.LastFather, 0)
	; ---- end 2.13  ----
	; ---- begin 2.15 ----
	; moved to storage UpdateStorage due to timing
;/	index = Math.LogicalAnd(Storage.TrackedActors.Length, 0x00000FFF)
	if index != Storage.CurrentFatherRace.Length
		if index == Storage.FatherRaceID.Length
			Storage.CurrentFatherRace = Utility.ResizeFormArray(Storage.CurrentFatherRace, index)
			int fatherRace
			while (index > 0)
				index -= 1
				fatherRace = Storage.FatherRaceID[index]
				if fatherRace != -1
					Storage.CurrentFatherRace[index] = Game.GetForm(fatherRace)
					fatherRace = -1
				endIf
			endWhile
			Storage.FatherRaceID = Utility.ResizeIntArray(Storage.FatherRaceID, 0)
		endif
	endIf/;
	; ----  end 2.15  ----
	; ---- begin 2.21 ----
	index = Storage.TrackedFathers.Length
	actor him
	while index > 0
		index -= 1
		him = Storage.TrackedFathers[index] as actor
		if him
			him.SetFactionRank(TrackedMaleFaction, -1)
			him = none
		endIf
	endWhile
	; ----  end 2.21  ----
	; ---- begin 2.24 ----
; 	0xFFFFFFFF	=	not unique actor - added 2.25 ( -1 )
;	0x00000001	=	has family relationship
;	0x00000002	=	has sibling
;	0x00000004	=	has Parent/Child
;	0x00000008	=	has Aunt/Uncle
;	0x00000010	=	has Grandparent/Grandchild
	index = Storage.TrackedActors.Length
	if Storage.ActorLocParent.Length != index
		Storage.ActorLocParent = Utility.ResizeFormArray(Storage.ActorLocParent, index, none)
	endIf
	int flags = 0
	int FLLength = ExcludeAT.GetSize()
	Storage.ATFlags = Utility.ResizeIntArray(Storage.ATFlags, index, 0)
	actor thisActor
	int theCount = 0
	while (index > 0)
		index -= 1
		thisActor = Storage.TrackedActors[index] as actor
		if thisActor && (Storage.ATFlags[index] == 0)
			if !thisActor.GetLeveledActorBase().IsUnique()
				flags = -1
			elseIf thisActor.HasFamilyRelationship()
				flags = 0x01
				theCount = 0
				while (theCount < FLLength)
					if thisActor.HasAssociation(ExcludeAT.GetAt(theCount) as AssociationType)
						flags = Math.LogicalOR(flags, Math.LeftShift(0x01, (theCount + 1)))
					endIf
					theCount += 1
				endWhile
			endIf
			Storage.ATFlags[index] = flags
			; 2.25
			flags = 0
			thisActor = none
		endIf
	endWhile
	index = Storage.TrackedFathers.Length
	if Storage.FatherLocParent.Length != index
		Storage.FatherLocParent = Utility.ResizeFormArray(Storage.FatherLocParent, index, none)
	endIf
	; ----  end 2.24  ----
	; ---- begin 2.25 ----
	Storage.ATFlagsMale = Utility.ResizeIntArray(Storage.ATFlagsMale, index, 0)
	flags = 0
	thisActor = none
	theCount = 0
	while (index > 0)
		index -= 1
		thisActor = Storage.TrackedFathers[index] as actor
		if thisActor && (Storage.ATFlagsMale[index] == 0)
			if !thisActor.GetLeveledActorBase().IsUnique()
				flags = -1
			elseIf thisActor.HasFamilyRelationship()
				flags = 0x01
				theCount = 0
				while (theCount < FLLength)
					if thisActor.HasAssociation(ExcludeAT.GetAt(theCount) as AssociationType)
						flags = Math.LogicalOR(flags, Math.LeftShift(0x01, (theCount + 1)))
					endIf
					theCount += 1
				endWhile
			endIf
			Storage.ATFlagsMale[index] = flags
			flags = 0
			thisActor = none
		endIf
	endWhile
	; ----  end 2.25  ----
	debug.trace("FM+ Successfully updated to v" + Storage.FMValues[9] + "." + Storage.FMValues[10])
	akTarget.RemoveSpell(FMUpdateSpell)

endEvent
