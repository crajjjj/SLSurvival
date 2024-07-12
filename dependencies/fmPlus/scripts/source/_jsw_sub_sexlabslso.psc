Scriptname _JSW_SUB_SexLabSLSO extends ActiveMagicEffect

_JSW_SUB_HandlerQuestAliasScript	Property	Handler		Auto		; Independent helper functions
_JSW_SUB_GVAlias					Property	GVAlias		Auto		; Storage data helper

Faction	Property	_JSW_SUB_SexLabSLSOFaction	Auto

Keyword	Property	ActorTypeCreature			Auto	; Keyword for identifying creature types

event OnEffectStart(Actor akTarget, Actor akCaster)

	GoToState("")
	UnregisterForAllModEvents()
	if (Game.GetModByName("SLSO.esp") != 255)
		GoToState("SLSOInstalled")
		Debug.Trace("FM+ Info: Registered for SLSO orgasm event", 0)
		RegisterForModEvent("SexLabOrgasmSeparate", "FMSLSOEvent")
	elseIf (Game.GetModByName("SexLab.esm") != 255)
		GoToState("SexLabInstalled")
		Debug.Trace("FM+ Info: Registered for SexLab orgasm event", 0)
		RegisterForModEvent("OrgasmStart", "FMSexLabOrgasmEvent")
	else
		Debug.Trace("FM+ Info: Neither SexLab nor SLSO detected.", 0)
		GoToState("")
		akTarget.RemoveFromFaction(_JSW_SUB_SexLabSLSOFaction)
	endIf

endEvent

event FMSexLabOrgasmEvent(string maleName = "", string argString = "", float argNum = 0.0, form sender = none)
endEvent

event FMSLSOEvent(Form actorRef = none, int recycleInt = -42)
endEvent

State SLSOInstalled

	event FMSLSOEvent(Form actorRef = none, int recycleInt = -42)
	{Catch relevant orgasm events from SexLab Separate Orgasm if it's installed}

		RegisterForModEvent("SexLabOrgasmSeparate", "FMSLSOEvent")
		; 1.57 exit if invalid params passed
		if ((actorRef == none) || (recycleInt == -42))
			return
		endIf
		; 2.14 function moved to GVHolder in 2.13
;		SexLabFramework SexLab = Handler.Util.GetMeMyForm(0x000D62, "SexLab.esm") as SexLabFramework
		SexLabFramework SexLab = GVAlias.GVHolder.GetMeMyForm(0x000D62, "SexLab.esm") as SexLabFramework
		String recycleString = recycleInt as String
		Actor maleTarget = actorRef as Actor
		Actor femaleTarget = none
		recycleInt = Handler.Util.GetActorGender(maleTarget)
		if recycleInt != 0
			return
		endIf

		Actor[] actorList = SexLab.HookActors(recycleString)

		if ((actorList.Length > 1) && (maleTarget != actorList[0]))
		; future todo: this forces secondactor to be female, later code allows either
			if (actorList[0] && (Handler.Util.GetActorGender(actorList[0]) == 1))
				femaleTarget = actorList[0]
			endIf
		endIf

		if (!femaleTarget || !maleTarget)
			; Must have both a male and a female
			; why?  We allow F-F events elsewhere!
			; because they're arbitrary terms that don't necessarily refer to gender in this context
			return
		endIf

		if (!GVAlias.GVHolder.AllowCreatures && maleTarget.HasKeyword(ActorTypeCreature))
			; Exclude creature insemination if disabled
			return
		endIf

		sslBaseAnimation animation = SexLab.HookAnimation(recycleString)
		recycleString = maleTarget.GetDisplayName()
		bool fireEvent = false

		; Extremely simple check, but functional for the most part
		if (animation.HasTag("Vaginal") || animation.HasTag("Creampie") || animation.HasTag("VaginalCum"))
			fireEvent = true
		elseIf (animation.HasTag("Anal") || animation.HasTag("AnalCreampie") || animation.HasTag("AnalCum"))
			; Perform a low percentage check for anal animations
			if !Utility.RandomInt()
				fireEvent = true
			endIf
		endIf
		if fireEvent
			recycleInt = ModEvent.Create("FertilityModeAddSperm")
			if recycleInt
				ModEvent.PushForm(recycleInt, femaleTarget as form)
				ModEvent.PushString(recycleInt, recycleString)
				ModEvent.PushForm(recycleInt, maleTarget as form)
				ModEvent.Send(recycleInt)
			endIf
		endIf
	endEvent

	
endState

State SexLabInstalled

	event FMSexLabOrgasmEvent(string maleName = "", string argString = "", float argNum = 0.0, form sender = none)
	{Catch relevant orgasm events from SexLab if it's installed}

		RegisterForModEvent("OrgasmStart", "FMSexLabOrgasmEvent")
		; 1.57 exit if invalid argString
		if (argString == "")
			return
		endIf
		; 2.14 function moved to GVHolder in 2.13
;		SexLabFramework SexLab = Handler.Util.GetMeMyForm(0x000D62, "SexLab.esm") as SexLabFramework
		SexLabFramework SexLab = GVAlias.GVHolder.GetMeMyForm(0x000D62, "SexLab.esm") as SexLabFramework
		Actor[] actorList = SexLab.HookActors(argString)
		form femaleTarget = none
		Actor maleTarget = none
		int index = 0
		int actorGender = -1

		; 1.50 stop searching if we have both a male and a female
		while ((index < actorList.Length) && (!maleTarget || !femaleTarget))
			actorGender = Handler.Util.GetActorGender(actorList[index])
			if (!femaleTarget && actorList[index] && actorGender == 1)
				femaleTarget = actorList[index]
			elseIf (!maleTarget && actorList[index] && actorGender == 0)
				maleTarget = actorList[index]
			endIf
			actorGender = -1

			index += 1
		endWhile

		if (!femaleTarget || !maleTarget)
			; Must have both a male and a female
			return
		endIf

		if (!GVAlias.GVHolder.AllowCreatures && maleTarget.HasKeyword(ActorTypeCreature))
			; Exclude creature insemination if disabled
			return
		endIf

		sslBaseAnimation animation = SexLab.HookAnimation(argString)
		maleName = ""
		maleName = maleTarget.GetDisplayName()
		bool fireEvent = false

		; Extremely simple check, but functional for the most part
		if (animation.HasTag("Vaginal") || animation.HasTag("Creampie") || animation.HasTag("VaginalCum"))
			fireEvent = true
		elseIf (animation.HasTag("Anal") || animation.HasTag("AnalCreampie") || animation.HasTag("AnalCum"))
			; Perform a low percentage check for anal animations
			if !Utility.RandomInt()
				fireEvent = true
			endIf
		endIf
		if fireEvent
			index = ModEvent.Create("FertilityModeAddSperm")
			if index
				ModEvent.PushForm(index, femaleTarget as form)
				ModEvent.PushString(index, maleName)
				ModEvent.PushForm(index, maleTarget as form)
				ModEvent.Send(index)
			endIf
		endIf
	endEvent

endState
