Scriptname	_JSW_SUB_AdoptionScript	Extends	Quest

_JSW_BB_Storage				Property	Storage				Auto	; Storage data helper

_JSW_SUB_GVHolderScript		Property	GVHolder			Auto	;

Actor			Property	PlayerRef				Auto	; Reference to the player. Game.GetPlayer() is slow

Keyword			Property	SpawnedChild			Auto	; Keyword for identifying Fertility Mode children

Quest			Property	RelationshipAdoptable	Auto
Quest			Property	RelationshipAdoption	Auto

event OnInit()

	if (Game.GetModByName("HearthfireMultiKid.esp") != 255)
		GoToState("HMADetected")
	else
		GoToState("")
	endIf

endEvent

state HMADetected

	string function TryAdoptChildMcm(Actor child)
	{Debug function for spawning and adopting a child in the MCM}

		RegisterForSingleUpdate(10.0)
		if (!child.HasKeyword(SpawnedChild))
			return "Invalid actor selected"
		endIf
	
		BYOHRelationshipAdoptableScript adoptData = (RelationshipAdoptable as BYOHRelationshipAdoptableScript)
		BYOHRelationshipAdoptionScript adoptHookScript = (RelationshipAdoption as BYOHRelationshipAdoptionScript)
		quest HMACustomHomeManager = Quest.GetQuest("PHX_CustomHomeManager")
		locationalias HMALocAlias = HMACustomHomeManager.GetAlias(1) as locationalias
		if !HMACustomHomeManager || !HMALocAlias
			GoToState("")
			return TryAdoptChildMCM(child)
		endIf
		if (adoptHookScript.numChildrenAdopted > 5) ; changed from == 6 just in case somehow it exceeds 6
			; Adopted children maxed out with Hearthfire Multiple Adoptions
			return "Maximum adoptions reached"
		endIf
		
		; Make sure that the current status of house ownership is available
		adoptData.UpdateHouseStatus()
		int destination = adoptData.ValidateMoveDestination(9, 0)
		location targetLocation = HMALocAlias.GetLocation()
		bool inTargetLocation = (PlayerRef.GetCurrentLocation() == targetLocation)
		
		if (destination != 0 && !inTargetLocation)
			; The target house is stored in variable07 on the child actor by Hearthfire, so we'll do the same
			child.SetActorValue("Variable07", destination)
			; Adopt and go!
			RelationshipAdoption.SetCurrentStageID(10)
			adoptHookScript.AdoptChild(child)
			return "Adopting for target location: " + targetLocation.GetName()
		else
			return "No valid available houses"
		endIf
	endFunction

	Actor function TrySpawnChildAdopt(Actor akActor)
	{Attempt to spawn a child actor through the Hearthfire adoption system}

		int raceIndex = Storage.GetRaceIndex(akActor)
		
		if (raceIndex != -1)
			BYOHRelationshipAdoptableScript adoptData = (RelationshipAdoptable as BYOHRelationshipAdoptableScript)
			BYOHRelationshipAdoptionScript adoptHookScript = (RelationshipAdoption as BYOHRelationshipAdoptionScript)
			quest HMACustomHomeManager = Quest.GetQuest("PHX_CustomHomeManager")
			locationalias HMALocAlias = HMACustomHomeManager.GetAlias(1) as locationalias
			if !HMACustomHomeManager || !HMALocAlias
				GoToState("")
				return TrySpawnChildAdopt(akActor)
			endIf
			if (adoptHookScript.numChildrenAdopted > 5) ; changed from == 6 in case somehow it exceeds 6
				; Adopted children maxed out with Hearthfire Multiple Adoptions
				RegisterForSingleUpdate(10.0)
				return none
			endIf

			; Make sure that the current status of house ownership is available
			adoptData.UpdateHouseStatus()
			int destination = adoptData.ValidateMoveDestination(9, 0)
			location targetLocation = HMALocAlias.GetLocation()
			bool inTargetLocation = (PlayerRef.GetCurrentLocation() == targetLocation)

			if (destination != 0 && !inTargetLocation)
				ActorBase childBase = Storage.Children[2 * raceIndex + Utility.RandomInt(0, 1)] as actorbase
				; Match hair color to the parent
				childBase.SetHairColor(akActor.GetActorBase().GetHairColor())
				Actor child = PlayerRef.PlaceActorAtMe(childBase) as Actor
				; The target house is stored in variable07 on the child actor by Hearthfire, so we'll do the same
				child.SetActorValue("Variable07", destination)
				; Adopt and go!
				RelationshipAdoption.SetCurrentStageID(10)
				adoptHookScript.AdoptChild(child)
				if GVHolder.VerboseMode
					Debug.Notification("Mother '" + akActor.GetDisplayName() + "': New child sent to " + targetLocation.GetName())
				endIf

				RegisterForSingleUpdate(10.0)
				return child
			else
				if GVHolder.VerboseMode
					if (destination == 0)
						Debug.Notification("Mother '" + akActor.GetDisplayName() + "': No available homes for child growth")
					endIf
					
					if (inTargetLocation)
						Debug.Notification("Mother '" + akActor.GetDisplayName() + "': Player cannot be in the target home for child growth")
					endIf
				endIf
			endIf
		else
			; The actor's race is unsupported
			if GVHolder.VerboseMode
				Debug.Notification("Mother '" + akActor.GetDisplayName() + "': Unsupported race for child growth")
			endIf
		endIf
		RegisterForSingleUpdate(10.0)
		return none
	endFunction

endState

string function TryAdoptChildMcm(Actor child)
{Debug function for spawning and adopting a child in the MCM}

	RegisterForSingleUpdate(10.0)
    if (!child.HasKeyword(SpawnedChild))
        return "Invalid actor selected"
    endIf

    BYOHRelationshipAdoptableScript adoptData = (RelationshipAdoptable as BYOHRelationshipAdoptableScript)
    BYOHRelationshipAdoptionScript adoptHookScript = (RelationshipAdoption as BYOHRelationshipAdoptionScript)

    if (adoptHookScript.numChildrenAdopted > 1) ; changed from == 2
        ; Adopted children maxed out with vanilla Hearthfire
        return "Maximum adoptions reached"
    endIf

    ; Make sure that the current status of house ownership is available
    adoptData.UpdateHouseStatus()

	; Fall back to default behavior (vanilla homes)
	int destination = adoptData.ValidateMoveDestination(0, 0)
	location targetLocation = adoptHookScript.TranslateHouseIntToInteriorLoc(destination)
	bool inTargetLocation = (PlayerRef.GetCurrentLocation() == targetLocation)

    if (destination != 0 && !inTargetLocation)
        ; The target house is stored in variable07 on the child actor by Hearthfire, so we'll do the same
        child.SetActorValue("Variable07", destination)
        ; Adopt and go!
        RelationshipAdoption.SetCurrentStageID(10)
        adoptHookScript.AdoptChild(child)
        return "Adopting for target location: " + targetLocation.GetName()
    else
        return "No valid available houses"
    endIf

endFunction

Actor function TrySpawnChildAdopt(Actor akActor)
{Attempt to spawn a child actor through the Hearthfire adoption system}

    int raceIndex = Storage.GetRaceIndex(akActor)

    if (raceIndex != -1)
        BYOHRelationshipAdoptableScript adoptData = (RelationshipAdoptable as BYOHRelationshipAdoptableScript)
        BYOHRelationshipAdoptionScript adoptHookScript = (RelationshipAdoption as BYOHRelationshipAdoptionScript)

		if (adoptHookScript.numChildrenAdopted > 1) ; changed from == 2
            ; Adopted children maxed out with vanilla Hearthfire
			RegisterForSingleUpdate(10.0)
            return none
        endIf

        ; Make sure that the current status of house ownership is available
        adoptData.UpdateHouseStatus()

		; Fall back to default behavior (vanilla homes)
		int destination = adoptData.ValidateMoveDestination(0, 0)
		location targetLocation = adoptHookScript.TranslateHouseIntToInteriorLoc(destination)
		bool inTargetLocation = (PlayerRef.GetCurrentLocation() == targetLocation)

        if (destination != 0 && !inTargetLocation)

            ActorBase childBase = Storage.Children[2 * raceIndex + Utility.RandomInt(0, 1)] as actorbase

            ; Match hair color to the parent
            childBase.SetHairColor(akActor.GetActorBase().GetHairColor())

            Actor child = PlayerRef.PlaceActorAtMe(childBase) as Actor

            ; The target house is stored in variable07 on the child actor and must be present before HF adoption quest is invoked
            child.SetActorValue("Variable07", destination)
            ; Adopt and go!
            RelationshipAdoption.SetCurrentStageID(10)
            adoptHookScript.AdoptChild(child)

            if GVHolder.VerboseMode
                Debug.Notification("Mother '" + akActor.GetDisplayName() + "': New child sent to " + targetLocation.GetName())
            endIf

			RegisterForSingleUpdate(10.0)
            return child
        else
            if GVHolder.VerboseMode
                if (destination == 0)
                    Debug.Notification("Mother '" + akActor.GetDisplayName() + "': No available homes for child growth")
                endIf

                if (inTargetLocation)
                    Debug.Notification("Mother '" + akActor.GetDisplayName() + "': Player cannot be in the target home for child growth")
                endIf
            endIf
        endIf
    else
        ; The actor's race is unsupported
        if GVHolder.VerboseMode
            Debug.Notification("Mother '" + akActor.GetDisplayName() + "': Unsupported race for child growth")
        endIf
    endIf
	RegisterForSingleUpdate(10.0)
    return none

endFunction

Actor function TrySpawnChild(Actor akActor, int raceIndex)
{Attempt to spawn a child actor and send to the package location}

    ActorBase childBase = Storage.Children[2 * raceIndex + Utility.RandomInt(0, 1)] as actorbase

    ; Match hair color to the parent
    childBase.SetHairColor(akActor.GetActorBase().GetHairColor())

	RegisterForSingleUpdate(10.0)
    return PlayerRef.PlaceActorAtMe(childBase) as Actor

endFunction

string function GenerateName(string msg)

	string theString = ((self as Form) as UILIB_1).ShowTextInput(msg, "")
	RegisterForSingleUpdate(10.0)
	return theString

endFunction

function RenameChild(Actor akActor)
{Renames the specified child}

    if (!akActor.HasKeyword(SpawnedChild))
		RegisterForSingleUpdate(10.0)
        return
    endIf

    string theString = "Name your child: "
	theString = ((self as Form) as UILIB_1).ShowTextInput(theString, "")
	int anInt = ModEvent.Create("FMChildRenamed")
	if anInt
		ModEvent.PushForm(anInt, akActor as form)
		ModEvent.PushString(anInt, theString)
		ModEvent.Send(anInt)
	endIf
	RegisterForSingleUpdate(10.0)

endFunction

event	OnUpdate()

	SetCurrentStageID(20)

endEvent
