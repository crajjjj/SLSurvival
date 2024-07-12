Scriptname	_JSW_SUB_OStim	extends	ActiveMagicEffect

_JSW_SUB_HandlerQuestAliasScript	Property	Handler		Auto	; Independent helper functions

event OnEffectStart(Actor akTarget, Actor akCaster)

	RegisterForModEvent("OStim_Orgasm", "FMProcessOStimOrgasm")

endEvent

event FMProcessOStimOrgasm(string eventName, string string2 = " ", float someFloat = 0.0, form origin)
{event to catch and handle OStim orgasms.  maybe.}

	OsexintegrationMain OStim = origin as OsexIntegrationMain
	Actor firstActor = OStim.getMostRecentOrgasmedActor()
	form secondActor = OStim.GetSexPartner(firstActor) as form
	RegisterForModEvent("OStim_Orgasm", "FMProcessOStimOrgasm")
	if !firstActor || !secondActor
		return
	endIf
	if Handler.Util.GetActorGender(firstActor)
		return
	endIf
	if OStim.IsVaginal()
		int handle = ModEvent.Create("FertilityModeAddSperm")
		if handle
			ModEvent.PushForm(handle, secondActor)
			ModEvent.PushString(handle, (firstActor).GetDisplayName())
			ModEvent.PushForm(handle, firstActor as form)
			ModEvent.Send(handle)
		endIf
	endif

endEvent
