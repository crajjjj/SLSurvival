Scriptname	_JSW_SUB_FGNewOrgasm	extends	ActiveMagicEffect

_JSW_SUB_FGReferenceAlias	Property	FMFGQuest	Auto

GlobalVariable				Property	GVVerbose	Auto	;

Actor						Property	PlayerRef	Auto	; reference to the player

Ammo						Property	TokenTrue	Auto	; used in a form[] to represent boolean true

Faction						Property	FGFaction	Auto

quest						Property	FGQuest		Auto	; 

Actor			target		=	none		; the target of this instance of the script
Actor			partner		=	none		; the partner of the target
bool			isFemale	=	false		; is the target female/set as one?
bool			isVaginal	=	false		; if it's a sex type that may result in pregnancy
float		updateInterval	=	2.0			; base amount of time to perform update intervals
int				iterations	=	0			; a safety check against looking for infinite quest progression
int				lastStage	=	0			; the quest stage as set by FG, the previous time we checked
quest			theQuest	=	none		; may be one of five scene quests

event OnEffectStart(Actor akTarget, Actor akCaster)

	target = aktarget
	iterations = 0
	FGQuest.SetCurrentStageID(10)
; long initial wait to give Papyrus time to do all the loading game stuff it needs to do
	RegisterForSingleUpdate(updateInterval * 6.0)

endEvent

event OnEffectFinish(Actor akTarget, Actor akCaster)
	GoToState("Dead")
endEvent

event OnUpdate()

; start off checking to see if the FGReferenceAlias script has the info we need yet
	UnregisterforUpdate()
	if FMFGQuest && (FMFGQuest.FGSceneQs.Length != 0) && (FMFGQuest.FGSceneQs[4] != none)
		GoToState("MostlyIdle")
		RegisterForSingleUpdate(updateInterval)
		return
	endIf
	iterations += 1
	; if we can't get the FG quest info after 24 seconds of trying, we probably never will
	if (iterations > 5)
		playerRef.RemoveFromFaction(FGFaction)
		Debug.Trace("FM+ failed to get reply from FG quest.  Ceasing attempts.", 1)
		return
	endIf
	RegisterForSingleUpdate(updateInterval * 2.0)
	Debug.Trace("FM+: Failure to locate FG quest, attempt " + iterations + " of 6", 0)

endEvent

state MostlyIdle

	event OnUpdate()

		UnregisterforUpdate()
		; FGReferenceAlias script set the rank to 16 if a FG Quest is detected as running
		if playerRef.IsInFaction(FMFGQuest.FGAnimating)
			GoToState("Monitoring")
		endIf
		RegisterForSingleUpdate(updateInterval * 3.0)

	endEvent

endState

state Monitoring

	event OnUpdate()

		UnregisterForUpdate()
		form[] replyForm = FMFGQuest.IsThisOurScene(target)
		if (replyForm[0] == TokenTrue as form)
			;	replyForm[0] = Token if this is the wanted scene or not
			;	replyForm[1] = partner
			;	replyform[2] = isFemale
			;	replyForm[3] = isVaginal 
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

		UnregisterforUpdate()
		int currStage = theQuest.GetCurrentStageID()
		; scene completed
		if (currStage > 17)
			if partner && !isFemale && isVaginal
				FMFGQuest.ProcessClimax(partner, target)
			elseIf partner && GVVerbose.GetValue()
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
		lastStage = 0
		iterations = 0
		theQuest = none

	endEvent

endState

state Dead

	event OnUpdate()
	endEvent

endState
