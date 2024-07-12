Scriptname	_JSW_SUB_HandlerQuestAliasScript	extends	ReferenceAlias
; scripts on this quest
_JSW_BB_Utility				Property	Util				Auto	; Independent helper functions
_JSW_BB_Storage				Property	Storage				Auto	; Storage data helper
_JSW_SUB_EventHandler		Property	FMEventHandler		Auto	;
_JSW_SUB_ScheduledUpdater	Property	ScheduledUpdater	Auto	;
_JSW_SUB_SpellHandler		Property 	FMSpellHandler		Auto	;
; scripts on other quests
_JSW_SUB_GVHolderScript		Property	GVHolder			Auto	;
_JSW_SUB_MiscUtilQuest		Property	FMMiscUtil			Auto	; script to calculate conception chance and stuff

Actor						Property	PlayerRef			Auto	; Reference to the player. Game.GetPlayer() is slow

Faction						Property	CycleBuffFaction	Auto	; 10% buff/debuff

Message						Property	InitMessage			Auto	; Introduction and enabling message after "Unbound" is complete

ReferenceAlias				Property	LoveInterest		Auto	; The actor reference of the player's spouse

Spell						Property	CellScanSpell		Auto	; 
Spell						Property	CompactArraySpell	Auto	; 
Spell						Property	ScriptRollCall		Auto	; 

bool	Property	_initMessageShown	=	false	Auto	Hidden	; Flag for ensuring the init message is only displayed once
bool			_newDay					=	false	; Flag for when the game day rolls over
int				_lastDay				=	0		; Storage for the last recorded day
form			playerRefForm						; playerRef as form
string			_playerName				=	""		; player display name

event	OnInit()
{Perform initialization on a new game}

	if (GVHolder == none) || !(Storage as quest).IsRunning()
		return
	endIf
	Storage.FMValues		=	Utility.ResizeIntArray(Storage.FMValues, 24)
	Storage.FMValues[5]		=	1
	Storage.FMValues[11]	=	8
	; 2.05
	PlayerRef.SetFactionRank(CycleBuffFaction, GVHolder.CycleBuffDebuff)
	OnPlayerLoadGame()

endEvent

; 1.62
function	RegisterFMForModEvents()
{registers for the modevents handled by this script}

    ; Apply event registrations
    RegisterForMenu("RaceSex Menu")
    RegisterForSleep()
	Storage.FMValues[4] = (Game.GetModByName("SexLab Inflation Framework.esp") != 255) as int

endFunction

; 1.59
function	ResetVariables()
{why duplicate 3x what can be only once}

	Storage.FMValues[1] = Math.RightShift((GVHolder.OvulationBegin + GVHolder.OvulationEnd), 1)
	_playerName = PlayerRef.GetDisplayName()
	playerRefForm = playerRef as form

endFunction

event	OnPlayerLoadGame()
{Perform initialization on game load}

	UnregisterForUpdate()
	UnregisterForUpdateGameTime()
	playerRef.RemoveSpell(ScriptRollCall)
	Storage.InitializeStorage()
	Storage.UpdateStorage()
	UnregisterForAllModEvents()
	UnregisterForAllMenus()
	UnregisterForAllKeys()
	
	RegisterFMForModEvents(); this detects SLIF which must be done before rollcall
	playerRef.AddSpell(ScriptRollCall, false)
	ResetVariables()

	if GVHolder.Enabled
		_initMessageShown = true
		ScheduledUpdater.RefreshRandoms()
		ModEvent.Send(ModEvent.Create("FMPUpdateWidgetContent"))
		ModEvent.Send(ModEvent.Create("FMPPlayerFactStat"))
	endIf
    RegisterForSingleUpdate(30.0)

endEvent

event	OnUpdate()

	if ((ScheduledUpdater.GetState() == "Busy") || playerRef.HasSpell(CellScanSpell as form) || playerRef.HasSpell(CompactArraySpell as form))
		RegisterForSingleUpdate(1.0)
		return
	else
		UnregisterForUpdateGameTime()
		OnUpdateGameTime()
	endIf

endEvent

event	OnUpdateGameTime()
{Timed cycle update loop}

	if ((ScheduledUpdater.GetState() == "Busy") || playerRef.HasSpell(CellScanSpell as form) || playerRef.HasSpell(CompactArraySpell as form))
		RegisterForSingleUpdate(1.0)
		return
	endIf

	if GVHolder.Enabled
		float startTime = Utility.GetCurrentRealTime()
		ResetVariables()
		int today = GVHolder.GVGameDaysPassed.GetValue() as int
		_newDay = (today > _lastDay)
		if _newDay
			_lastDay = today
		endIf
        ScheduledUpdater.UpdateStatusAll(true, _newDay)
		if GVHolder.VerboseMode
			Debug.Notification("FM+ Update Time: " + (Utility.GetCurrentRealTime() - startTime) as int + "s")
		endIf
    endIf

	if (!GVHolder.Enabled && !_initMessageShown)
		if Game.IsFightingControlsEnabled()
			; Wait until Unbound is largely completed manually or through alternate starts
			; because that quest is script heavy and could break with more lag. We also 
			; don't care to track the majority of NPCs from that quest who will be dead 
			; before it completes.
			if (InitMessage.Show() == 0)
				; 1.50
				GVHolder.Enabled = true
				GVHolder.UpdateGVs()
			endIf
			_initMessageShown = true
		endIf
		RegisterForSingleUpdateGameTime(0.05)
		return
	endIf

    RegisterForSingleUpdateGameTime(GVHolder.PollingInterval)

endEvent

event	OnLocationChange(Location akOldLoc, Location akNewLoc)
{Run out of band updates when the player zones. used for enforcing current belly/breast scales}

	ResetVariables()
	if GVHolder.Enabled
		ScheduledUpdater.RefreshRandoms()
	endIf

endEvent

event	OnMenuClose(string menuName)
{Update tracking status after showracemenu is closed}

	Util.FMUtilCacheVariables()
	int		gender	=	Util.GetActorGender(PlayerRef)
	_playerName		=	PlayerRef.GetDisplayName()
	if (gender == 0)
		Storage.TrackedActorRemove(Storage.TrackedActors.Find(PlayerRefForm), false)
	else
		Storage.TrackedFatherRemove(Storage.TrackedFathers.Find(PlayerRefForm), false)
	endIf
	if GVHolder.VerboseMode
		string text = "FM: Player base gender detected as "
		if (gender == 1)
			text += "fe"
		endIf
		Debug.Notification(text + "male.")
	endIf
;	Util.AddToTracking(playerRef, gender)
	if GVHolder.Enabled
		; Run a full update to ensure the player is completely
		; tracked or untracked. A race change should be
		; exceptionally rare, so it's reasonably safe.
		ScheduledUpdater.UpdateStatusAll(false, _newDay)
	else
		RegisterForSingleUpdate(3.0)
	endIf
	FMMiscUtil.UpdateCyclePerks(gender == 1)
	ModEvent.Send(ModEvent.Create("FMPUpdateWidgetContent"))
	ModEvent.Send(ModEvent.Create("FMPPlayerFactStat"))
	ResetVariables()

endEvent

event	OnSleepStop(bool abInterrupted)
{Add relevant sperm when sleeping, reset baby health when pregnant}

    if !GVHolder.Enabled
		RegisterForSleep()
        return
    endIf
	_playerName		=	PlayerRef.GetDisplayName()
    float	now		=	GVHolder.GVGameDaysPassed.GetValue()
    int		index	=	Storage.TrackedActors.Find(PlayerRefForm)
   
    Storage.LastSleep = now
    if ((index != -1) && (Storage.LastConception[index] != 0.0))
        ; Sleeping restores the baby's health
		; 1.57 set max babyhealth to 105
        Storage.BabyHealth = 105
    endIf
	; 2.18
;    if (GVHolder.SpouseInseminateChance != 0)	; fail fast, fail early.   Hope to never have to do the randomint
	Actor spouse = LoveInterest.GetReference() as Actor
    if spouse && GVHolder.AutoInseminatePc && GVHolder.AutoInseminatePcSleep
		if (ScheduledUpdater.FetchRandom() < GVHolder.SpouseInseminateChance) && (spouse.IsInLocation(PlayerRef.GetCurrentLocation()))
			; 1.50
			int spouseSex = spouse.GetLeveledActorBase().GetSex()
			; changes here for 1.42 gender
			if ((spouseSex != 1) && (index != -1))
				; Spouse is male, we're female; add sperm to us
				FMEventHandler.FMAddSpermEvent((PlayerRefForm), spouse.GetDisplayName(), spouse as form)
			elseIf ((spouseSex == 1) && (index == -1))
				; Spouse is female, we're male; add sperm to them
				FMEventHandler.FMAddSpermEvent((spouse as form), _playerName, playerRefForm)
			elseIf ((spouseSex == 1) && (index != -1))
				; Both parties are female. Special case, inseminate one of them randomly
				; I don't believe that's biologically possible.  However, I would like to 
				; watch.  Purely in the interest of science.
				if (ScheduledUpdater.FetchRandom() < 50)
					FMEventHandler.FMAddSpermEvent((spouse as form), _playerName, playerRefForm)
				else
					FMEventHandler.FMAddSpermEvent(PlayerRefForm, spouse.GetDisplayName(), spouse as form)
				endIf
			endIf
		endIf
    elseIf ((GVHolder.AutoInseminatePc && GVHolder.AutoInseminatePcSleep) && GVHolder.AutoInseminateChance)

    	if (ScheduledUpdater.FetchRandom() < GVHolder.AutoInseminateChance)
			; 1.43 allow it to happen even if the PC is pregnant
	    	if (index != -1)
	    		; The player is female, identify men in the same cell for insemination
				; 2.24 changed
;	    		int		fatherIndex	=	(GetOwningQuest() as _JSW_SUB_MatchMaker).FindRandomFather(index, playerRef)
;	    		int		fatherIndex	=	(GetOwningQuest() as _JSW_SUB_MatchMaker).FindSexPartner(index, playerRef, false)
	    		int		fatherIndex	=	(GetOwningQuest() as _JSW_SUB_MatchMaker).FindSexPartner(index, playerRef, GVHolder.SpouseInseminateChance, ScheduledUpdater.FetchRandom())
	        	actor	father		=	none
	        	if (fatherIndex != -1)
	        		father = Storage.TrackedFathers[fatherIndex] as actor
	        	endIf
				; 2.21 checking for the keyword should be unnecessary, as tracking now obeys this setting
;	            if (father && (GVHolder.AllowCreatures || !father.HasKeyword(ActorTypeCreature)))
	            if father
					FMEventHandler.FMAddSpermEvent(PlayerRefForm, father.GetDisplayName(), father as form)
				endIf
			else
				; The player is male, identify women in the same cell for insemination
				int fatherIndex = Storage.TrackedFathers.Find(PlayerRefForm)
				
				if (fatherIndex != -1)
					int motherIndex = (GetOwningQuest() as _JSW_SUB_MatchMaker).FindRandomMother(fatherIndex)
					
					if (motherIndex != -1)
						FMEventHandler.FMAddSpermEvent(Storage.TrackedActors[motherIndex], _playerName, playerRefForm)
					endIf
				endIf
			endIf
		endIf
    endIf
    RegisterForSleep()
	ModEvent.Send(ModEvent.Create("FMPUpdateWidgetContent"))
	ModEvent.Send(ModEvent.Create("FMPPlayerFactStat"))

endEvent
