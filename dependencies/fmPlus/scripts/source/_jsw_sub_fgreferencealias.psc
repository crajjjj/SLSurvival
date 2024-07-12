Scriptname _JSW_SUB_FGReferenceAlias extends ReferenceAlias  

_JSW_SUB_GVHolderScript		Property	GVHolder	Auto		; holds variables used by the other scripts

Actor				Property	PlayerRef			Auto		; reference to the player

Faction				Property	FGFaction			Auto

Ammo				Property	TokenTrue			Auto		; used in a form[] to represent boolean true

Faction				Property	FGAnimating			Auto	Hidden	; faction FG adds animated actors to
Form[]				Property	FGSceneQs			Auto	Hidden	; array of FG scene quests
Form[]				Property	VaginalTokens		Auto	Hidden	; array of FG "ammo" indicating sex type

; note: the index between parts and partActors is shared
Actor[]				partActors									; array of active actors in FG quests
ReferenceAlias[]	parts										; array of active quest referencealiases

Float				updateInterval		=		2.0

Int					index				=		3

event OnInit()

	GoToState("FillForms")
	RegisterForSingleUpdate(updateInterval)

endEvent

event OnPlayerLoadGame()

	GoToState("Dead")
	GetOwningQuest().SetCurrentStageID(20)

endEvent


event	OnUpdate()

	int number = 0
	bool running = false
	int anInt = 0
	while (number < 5)
		; kissing scenes have < 10 stages, and orgasm occurs around 20
		; this will return true if the stage is >=8 and <= 24
		; this would evaluate as true for millions of larger values,
		; but since FG max quest stage is 100 it works here
		if ((FGSceneQs[number] != none) && Math.LogicalAnd((FGSceneQs[number] as quest).GetCurrentStageID(), 0x18) as bool)
			running = true
			while (anInt < 3)
				parts[((number * 3) + anInt)] = (FGSceneQs[number] as quest).GetAlias(anInt) as referenceAlias
				anInt += 1
			endWhile
		else
			while (anInt < 3)
				parts[((number * 3) + anInt)] = none
				anInt += 1
			endWhile
		endIf
		anInt = 0
		number += 1
	endWhile
	if running
		number = 0
		while (number < 15)
			if (parts[number] != none)
				partActors[number] = parts[number].GetReference() as actor
			else
				partActors[number] = none
			endIf
			number += 1
		endWhile
	endIf
	; this script checks for running scenes once, then the other scripts look to the
	; faction rank to get the answer
	playerRef.SetFactionRank(FGFaction, (16 * running as int))
	RegisterForSingleUpdate(updateInterval * 3.0)

endEvent

function ProcessClimax(actor femActor, actor maleActor, int handle = 0)

	handle = ModEvent.Create("FertilityModeAddSperm")
	if (handle != 0)
		ModEvent.PushForm(handle, femActor as form)
		ModEvent.PushString(handle, maleActor.GetDisplayName())
		ModEvent.PushForm(handle, maleActor as form)
		ModEvent.Send(handle)
	endIf

endFunction

form[] function IsThisOurScene(actor target)
{checks if this actor is in a running FG scene}

		; 2.12
		form[] replyForm = new form[5]
		int numparts = 0
		int i = 0
		int aIndex = partActors.Find(target)

		replyForm[0] = none
		index = ((aIndex / 3) as int * 3)
		if (aIndex == -1)
			return replyForm
		else
			while (i < 3)
				numparts += (parts[(index + i)] != none) as int
				i += 1
			endWhile
		endIf
		if (numparts < 2)
			return replyForm
		endIf
		ReferenceAlias Ref1 = parts[aIndex]
		ReferenceAlias Ref2 = parts[index + ((index == aIndex) as int)]

		if ((parts[aIndex] != none) && Ref2)
			replyForm[0] = TokenTrue
			numparts = parts.Find(Ref2)
			replyForm[1] = partActors[numparts]
			;/	replyForm[0] = Token True/False if this is the wanted scene or not
				replyForm[1] = partner
				replyform[2] = isFemale
				replyForm[3] = isVaginal
				replyForm[4] = theQuest /;
			if (VaginalTokens.Find((Ref1 as dxAliasActor).SexType) != -1)
			; if the target actor is getting penerated vaginally, it's pretty safe to say they're female
				replyForm[2] = TokenTrue
			else
				replyForm[2] = none
			endIf
			if (replyForm[2] == TokenTrue) || (VaginalTokens.Find((Ref2 as dxAliasActor).SexType) != -1)
				replyForm[3] = TokenTrue
			; the above, or the partner is getting penetrated vaginally.  Only used to determine if,
			; at the conclusion, we inseminate or just display a message that they had sex
			else
				replyForm[3] = none
			endIf
			replyForm[4] = FGSceneQs[index / 3]
			Ref1 = none
			Ref2 = none
			return replyForm
		endIf
		Ref1 = none
		Ref2 = none
		return replyForm

endFunction

form function GetMeMyForm(int formNumber, string pluginName)
	return none
endFunction

state FillForms

	event OnUpdate()

		VaginalTokens = new Form[11]
		VaginalTokens[0]	=	GVHolder.GetMeMyForm(0x00FAB8, "FlowerGirls SE.esm") as ammo	; female cowgirl
		VaginalTokens[1]	=	GVHolder.GetMeMyForm(0x00FADE, "FlowerGirls SE.esm") as ammo	; female doggy
		VaginalTokens[2]	=	GVHolder.GetMeMyForm(0x010063, "FlowerGirls SE.esm") as ammo	; female missionary
		VaginalTokens[3]	=	GVHolder.GetMeMyForm(0x00FAD8, "FlowerGirls SE.esm") as ammo	; female standing
		; 2.21 note: misleading naimng on the next 2.   The second actor, not the third, is the male.
		VaginalTokens[4]	=	GVHolder.GetMeMyForm(0x03AF70, "FlowerGirls SE.esm") as ammo	; FFM actor 1
		VaginalTokens[5]	=	GVHolder.GetMeMyForm(0x03AF71, "FlowerGirls SE.esm") as ammo	; FFM actor 2
		VaginalTokens[6]	=	GVHolder.GetMeMyForm(0x03AF75, "FlowerGirls SE.esm") as ammo	; MMF actor 3
		VaginalTokens[7]	=	GVHolder.GetMeMyForm(0x4EF5D6, "FlowerGirls SE.esm") as ammo	; FFF actor 1
		VaginalTokens[8]	=	GVHolder.GetMeMyForm(0x4EF5D7, "FlowerGirls SE.esm") as ammo	; FFF actor 2
		VaginalTokens[9]	=	GVHolder.GetMeMyForm(0x4EF5D8, "FlowerGirls SE.esm") as ammo	; FFF actor 3
		VaginalTokens[10]	=	GVHolder.GetMeMyForm(0x07DD3B, "FlowerGirls SE.esm") as ammo	; lesbian position female

		FGSceneQs = new Form[5]
		FGSceneQs[0]		=	GVHolder.GetMeMyForm(0x5BEF2F, "FlowerGirls SE.esm") as quest	; the five FG scene quests: 01
		FGSceneQs[1]		=	GVHolder.GetMeMyForm(0x5C41DD, "FlowerGirls SE.esm") as quest	; 02
		FGSceneQs[2]		=	GVHolder.GetMeMyForm(0x5F1C9B, "FlowerGirls SE.esm") as quest	; 03
		FGSceneQs[3]		=	GVHolder.GetMeMyForm(0x5F1C9C, "FlowerGirls SE.esm") as quest	; 04
		FGSceneQs[4]		=	GVHolder.GetMeMyForm(0x5F1C9D, "FlowerGirls SE.esm") as quest	; 05

		FGAnimating			=	GVHolder.GetMeMyForm(0x5BEF2C, "FlowerGirls SE.esm") as faction	; dxAnimatingFaction
		parts = new ReferenceAlias[15]
		partActors = new Actor[15]

		GoToState("")
		RegisterForSingleUpdate(updateInterval * 2.0)

	endEvent

endState

state Dead

	event	OnUpdate()
	endEvent

	event	OnEndState()

		UnregisterForUpdate()
		if GetState() != "Dead"
			GoToState("Dead")
		endIf

	endEvent

endState
