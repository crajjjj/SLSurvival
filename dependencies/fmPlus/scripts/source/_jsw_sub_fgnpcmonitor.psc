Scriptname _JSW_SUB_FGNPCMonitor extends ActiveMagicEffect  

_JSW_SUB_FGReferenceAlias	Property	FMFGQuest		Auto

GlobalVariable				Property	GVVerbose		Auto	;

Actor						Property	PlayerRef		Auto	; reference to the player

;Faction						Property	FGFaction		Auto

Ammo						Property	TokenTrue		Auto	; used in a form[] to represent boolean true

Spell						Property	FGNPCSpell		Auto	; the spell that applies the ME that runs this script

Actor			target		=	none		; the target of this instance of the script
Actor			partner		=	none		; the partner of the target
bool			isFemale	=	false		; is the target female/set as one?
bool			isVaginal	=	false		; if it's a sex type that may result in pregnancy
faction		FGAnimating
float		updateInterval	=	2.0			; base amount of time to perform update intervals
; 2.12 changed from script variables to function variables
;form[]			replyForm	
;int				currStage	=	0			; the current quest stage as set by FG
int				iterations	=	0			; a safety check against looking for infinite quest progression
int				lastStage	=	0			; the quest stage as set by FG, the previous time we checked
quest			theQuest	=	none		; may be one of five scene quests

event OnEffectStart(Actor akTarget, Actor akCaster)

	target = aktarget
	FGAnimating = FMFGQuest.FGAnimating
	if FGAnimating
		RegisterForSingleUpdate(updateInterval * 4.0)
		return
	endIf
	GoToState("Death")

endEvent

event OnPlayerLoadGame()

	GoToState("Death")

endEvent

event OnUpdate()

; start off checking to see if the FGReferenceAlias script has the info we need
	if (FMFGQuest.FGSceneQs[4] != none)
		GoToState("MostlyIdle")
	endIf
	RegisterForSingleUpdate(updateInterval * 2.0)

endEvent

state MostlyIdle

	event OnUpdate()

		; FGReferenceAlias script set the rank to 16 if a FG Quest is detected as running
		; 2.12 checking if the PC is in the faction should be unnecessary
		if target.IsInFaction(FGAnimating); && (playerRef.GetFactionRank(FGFaction) > 0)
			GoToState("Monitoring")
		endIf
		RegisterForSingleUpdate(updateInterval * 3.0)

	endEvent

endState

state Monitoring

	event OnUpdate()

		form[] replyForm = FMFGQuest.IsThisOurScene(target)
		if (replyForm[0] == TokenTrue as form)
			;	replyForm[0] = Token if this is the wanted scene or not
			;	replyForm[1] = partner
			;	replyform[2] = isFemale token
			;	replyForm[3] = isVaginal token
			;	replyForm[4] = theQuest 
			partner = replyform[1] as actor
			isFemale = (replyForm[2] == TokenTrue as form)
			isVaginal = (isFemale || (replyForm[3] == TokenTrue as form))
			theQuest = replyForm[4] as quest
			iterations = 0
			GoToState("Progressing")
			RegisterForSingleUpdate(updateInterval * 2.0)
		else
			GoToState("DumpValues")
			GoToState("")
			RegisterForSingleUpdate(updateInterval * 4.0)
		endIf

	endEvent

endState

state Progressing

; quest is active, and this actor is a participant

	event OnUpdate()

		int currStage = theQuest.GetCurrentStageID()
		; scene completed
		if (currStage > 17)
			if (!isFemale && isVaginal)
				FMFGQuest.ProcessClimax(partner, target)
			elseIf GVVerbose.GetValue()
				Debug.Notification(target.GetDisplayName() + " had sex with " + partner.GetDisplayName() + "!")
			endIf
			GoToState("DumpValues")
			GoToState("")
			; do the next check for the Quest at a longer interval to give FG time to end this current one
			RegisterForSingleUpdate(updateInterval * 16.0)
			return
		; the below should only happen if the scene is terminated early, or if we're in an infinite loop
		elseIf (currStage < lastStage) || (currStage < 10) || (iterations > 127)
			GoToState("DumpValues")
			GoToState("")
			RegisterForSingleUpdate(updateInterval * 8.0)
			return
		endIf
		; scene still running, check it frequently
		lastStage = currStage
		RegisterForSingleUpdate(updateInterval)
		iterations += 1
			
	endEvent

endState

state DumpValues

	event OnBeginState()

		partner = none
		isFemale = false
		isVaginal = false
;		currStage = 0
		lastStage = 0
		iterations = 0
		theQuest = none

	endEvent

endState

state Death

	event OnBeginState()

		spell thespell = FGNPCSpell
		if theSpell
			actor trget = GetTargetActor()
			if trget
				trget.RemoveSpell(thespell)
			endIf
		endIf

	endEvent

	event OnUpdate()
	endEvent

	event OnEffectStart(Actor akTarget, Actor akCaster)
	endEvent

endState

event OnDying(actor whoCares)

	GoToState("Death")

endEvent

event OnCellDetach()

	GoToState("Death")

endEvent
