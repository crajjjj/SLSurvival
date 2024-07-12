Scriptname _JSW_BB_ConfigQuestScript extends SKI_ConfigBase

Actor Property PlayerRef  Auto                          ; Reference to the player. Game.GetPlayer() is slow

_JSW_BB_HandlerQuestAliasScript Property Handler  Auto  ; The primary tracking script
_JSW_BB_Utility Property Util  Auto                     ; Independent helper functions
_JSW_BB_Storage Property Storage  Auto                  ; Storage data helper
_JSW_BB_WidgetCycle Property WidgetCycle  Auto          ; The female player widget for cycles and pregnancy

GlobalVariable Property Enabled  Auto                   ; Whether the mod is actively running or not
GlobalVariable Property PollingInterval  Auto           ; How often we run the update loop
GlobalVariable Property VerboseMode  Auto               ; Show verbose notification messages
GlobalVariable Property PlayerOnly  Auto                ; Tracking only includes the player and relevant NPCs
GlobalVariable Property ForceGender  Auto               ; For the player to be the specified gender

GlobalVariable Property AutoInseminateNpc  Auto         ; Randomly tries to inseminate tracked actors
GlobalVariable Property AutoInseminatePc  Auto          ; Includes the player in random insemination
GlobalVariable Property AutoInseminatePcSleep  Auto     ; Limits PC automatic insemination to sleep events only
GlobalVariable Property AutoInseminateChance  Auto      ; Probability of random insemination (eg. 20%)
GlobalVariable Property SpouseInseminateChance  Auto    ; Probability of insemination when sleeping with a spouse
GlobalVariable Property SpermLife  Auto                 ; Time before sperm is removed, eg. 5 days
GlobalVariable Property AllowCreatures  Auto            ; Allow insemination from creatures
GlobalVariable Property UniqueWomenOnly  Auto           ; Only track women with the IsUnique flag enabled
GlobalVariable Property UniqueMenOnly  Auto             ; Only track men with the IsUnique flag enabled

GlobalVariable Property PregnancyDuration  Auto         ; Full duration of a pregnancy, eg. 30 days
GlobalVariable Property RecoveryDuration  Auto          ; Full duration of recovery from a pregnancy before becoming fertile, eg. 10 days
GlobalVariable Property CycleDuration  Auto             ; Full duration of the menstrual cycle, eg. 28 days
GlobalVariable Property MenstruationBegin  Auto         ; Starting day of menstruation, eg. day 0
GlobalVariable Property MenstruationEnd  Auto           ; Ending day of menstruation, eg. day 7
GlobalVariable Property OvulationBegin  Auto            ; Starting day of ovulation, eg. day 8
GlobalVariable Property OvulationEnd  Auto              ; Ending day of ovulation, eg. day 16
GlobalVariable Property EggLife  Auto                   ; The age an egg can reach before it is no longer viable, eg 1.0 days
GlobalVariable Property ScalingMethod  Auto             ; The scaling method for bellies and breasts
GlobalVariable Property BellyScaleMax  Auto             ; The maximum belly size for NiOverride (breasts piggy back on it)
GlobalVariable Property BellyScaleMult  Auto            ; The amount of breast scaling relative to belly scaling
GlobalVariable Property BreastScaleMult  Auto           ; The amount of breast scaling relative to belly scaling
GlobalVariable Property ConceptionChance  Auto          ; Maximum percentage for fertility calculations
GlobalVariable Property PMSStaminaReduction  Auto       ; The percentage of stamina to reduce during PMS
GlobalVariable Property PMSMagickaReduction  Auto       ; The percentage of magicka to reduce during PMS
GlobalVariable Property OvulationStaminaBonus  Auto     ; The percentage of stamina to add during ovulation
GlobalVariable Property OvulationMagickaBonus  Auto     ; The percentage of magicka to add during ovulation

MagicEffect Property EffectFertility  Auto              ; Magic effect for increased fertility
MagicEffect Property EffectContraception  Auto          ; Magic effect for decreased fertility

GlobalVariable Property BirthType  Auto                 ; The action taken upon birth (eg. nothing, soul gem, baby item)
GlobalVariable Property BirthRace  Auto                 ; The race inheritance of the baby (mother = 0, father = 1, random = 2, specific = 3)
GlobalVariable Property BirthRaceSpecific  Auto         ; The specific unconditional race of the child
GlobalVariable Property MiscarriageEnabled  Auto        ; Whether baby health calculations are performed
GlobalVariable Property LaborEnabled  Auto              ; Whether labor animations are played or not
GlobalVariable Property SpawnEnabled  Auto              ; Whether babies grow into children
GlobalVariable Property LaborDuration  Auto             ; The number of seconds labor takes to complete
GlobalVariable Property BabyDuration  Auto              ; The duration of a baby item before growing into a spawned NPC
GlobalVariable Property AdoptionEnabled  Auto           ; Whether Hearthfire adoption is attempted before or instead of training
GlobalVariable Property TrainingEnabled  Auto           ; Whether spawns are sent to training unconditionally or if adoption fails
GlobalVariable Property SoundVolume  Auto               ; Specifies a [0.0,1.0] clamped volume for sounds (eg. labor and baby)

GlobalVariable Property WidgetShown  Auto               ; True if the widget is visible, false if not
GlobalVariable Property WidgetTop  Auto                 ; The Y position of the widget in pixels
GlobalVariable Property WidgetLeft  Auto                ; The X position of the widget in pixels
GlobalVariable Property WidgetHotKey  Auto              ; Hot key code for showing and hiding the widget

GlobalVariable Property InseminateSpellAdded  Auto      ; Adds or removes a spell to force insemination
GlobalVariable Property ImpregnateSpellAdded  Auto      ; Adds or removes a spell to force pregnancy
GlobalVariable Property BirthSpellAdded  Auto           ; Adds or removes a spell to induce birth
GlobalVariable Property AbortSpellAdded  Auto           ; Adds or removes a spell to induce abortion

Keyword Property SpawnedChild  Auto                     ; Keyword for identifying Fertility Mode spawned child NPCs

Quest Property RelationshipAdoptable  Auto
Quest Property RelationshipAdoption  Auto

Spell Property DetectFertility  Auto
Spell Property InseminateSpell  Auto
Spell Property ImpregnateSpell  Auto
Spell Property BirthSpell  Auto
Spell Property AbortSpell  Auto

string[] Property BirthTypeMenu  Auto

string[] _genderMenu
string[] _birthRaceMenu
string[] _birthRaceSpecificMenu
string[] _scaleTypeMenu
string[] _trackingFilter

int _playerFatherIndex
int _npcFatherIndex
int _summonIndex = 0
int _trackingFilterIndex = 0
int _trackingFilterPage = 0
int _trainingFilterIndex = 0
int _trainingFilterPage = 0
int _actorsPerPage = 10
int _childrenPerPage = 10

int function GetVersion()
    return 2
endFunction

event OnPageReset(string page)
    if (page == "")
        LoadCustomContent("FertilityMode/Logo.dds", 180, 30)
    else
        UnloadCustomContent()
        
        int index = Pages.Find(page)
        
        if (index == 0)
            ResetPageSettings()
        elseIf (index == 1)
            ResetPageTracking()
        elseIf (index == 2)
        	ResetPageChildren()
        elseIf (index == 3)
            ResetPageDebug()
        endIf
    endIf
endEvent

function ResetPageSettings()
	_genderMenu = new String[3]
    _genderMenu[0] = "Automatic"
    _genderMenu[1] = "Female"
    _genderMenu[2] = "Male"
    
    _scaleTypeMenu = new String[4]
    _scaleTypeMenu[0] = "BodyMorph"
    _scaleTypeMenu[1] = "NetImmerse"
    _scaleTypeMenu[2] = "NiOverride"
    _scaleTypeMenu[3] = "SLIF"
    
    _birthRaceMenu = new String[4]
    _birthRaceMenu[0] = "Mother"
    _birthRaceMenu[1] = "Father"
    _birthRaceMenu[2] = "Random"
    _birthRaceMenu[3] = "Specific"
    
    _birthRaceSpecificMenu = Utility.CreateStringArray(Storage.BirthMotherRace.Length)
    
    int i = 0
    
    while (i < _birthRaceSpecificMenu.Length)
        _birthRaceSpecificMenu[i] = Storage.BirthMotherRace[i].GetName()
        
        if (Storage.BirthMotherRace[i].HasKeywordString("Vampire"))
        	_birthRaceSpecificMenu[i] = _birthRaceSpecificMenu[i] + " (Vampire)"
        endIf
        
        i += 1
    endWhile
    
    SetCursorFillMode(TOP_TO_BOTTOM)
    
    AddToggleOptionST("ENABLED_TOGGLE", "Enabled", Enabled.GetValueInt())
    AddSliderOptionST("POLLING_SLIDER", "Polling Interval", PollingInterval.GetValue(), "{0} hour(s)")
    AddMenuOptionST("FORCE_GENDER_MENU", "Force Gender", _genderMenu[ForceGender.GetValueInt()])
    AddToggleOptionST("PLAYER_ONLY_TOGGLE", "Player Only", PlayerOnly.GetValueInt())
    AddToggleOptionST("UNIQUE_WOMEN_ONLY_TOGGLE", "Unique Women Only", UniqueWomenOnly.GetValueInt())
    AddToggleOptionST("UNIQUE_MEN_ONLY_TOGGLE", "Unique Men Only", UniqueMenOnly.GetValueInt())
    
    AddHeaderOption("Menstrual Cycle")
    AddSliderOptionST("CYCLE_DURATION_SLIDER", "Cycle Duration", CycleDuration.GetValueInt(), "{0} days")
    AddSliderOptionST("PMS_STAMINA_SLIDER", "PMS Stamina Debuff", PMSStaminaReduction.GetValue(), "-{2}")
    AddSliderOptionST("PMS_MAGICKA_SLIDER", "PMS Magicka Debuff", PMSMagickaReduction.GetValue(), "-{2}")
    AddSliderOptionST("OVULATION_STAMINA_SLIDER", "Ovulation Stamina Buff", OvulationStaminaBonus.GetValue(), "+{2}")
    AddSliderOptionST("OVULATION_MAGICKA_SLIDER", "Ovulation Magicka Buff", OvulationMagickaBonus.GetValue(), "+{2}")
    
    AddHeaderOption("Birth")
    AddMenuOptionST("BIRTH_TYPE_MENU", "Birth Type", BirthTypeMenu[BirthType.GetValueInt()])
    AddMenuOptionST("BIRTH_RACE_MENU", "Birth Race", _birthRaceMenu[BirthRace.GetValueInt()])
    
    if (BirthRace.GetValueInt() == 3)
        AddMenuOptionST("BIRTH_RACE_SPECIFIC_MENU", "\tSpecific Race", _birthRaceSpecificMenu[BirthRaceSpecific.GetValueInt()])
    endIf
    
    AddToggleOptionST("MISCARRIAGE_ENABLED_TOGGLE", "Miscarriage Enabled", MiscarriageEnabled.GetValueInt())
    AddSliderOptionST("SOUND_VOLUME_SLIDER", "Sound Volume", SoundVolume.GetValue(), "{1}x")
    AddToggleOptionST("LABOR_ENABLED_TOGGLE", "Labor Enabled", LaborEnabled.GetValueInt())
    AddSliderOptionST("LABOR_DURATION_SLIDER", "Labor Duration", LaborDuration.GetValueInt(), "{0} second(s)")
    
    if (BirthType.GetValueInt() == 2)
        AddToggleOptionST("SPAWN_ENABLED_TOGGLE", "Spawn Enabled", SpawnEnabled.GetValueInt())
        
        if (SpawnEnabled.GetValueInt())
            AddSliderOptionST("BIRTH_BABY_DURATION_SLIDER", "\tBaby Duration", BabyDuration.GetValueInt(), "{0} day(s)")
            AddToggleOptionST("BIRTH_BABY_ADOPTION_TOGGLE", "\tAdoption Enabled", AdoptionEnabled.GetValueInt())
            AddToggleOptionST("BIRTH_BABY_TRAINING_TOGGLE", "\tTraining Enabled", TrainingEnabled.GetValueInt())
        endIf
    endIf
    
    SetCursorPosition(1)
    
    AddHeaderOption("Conception")
    AddSliderOptionST("CONCEPTION_CHANCE_SLIDER", "Maximum Conception Chance", ConceptionChance.GetValueInt(), "{0}%")
    AddToggleOptionST("ALLOW_CREATURES_TOGGLE", "Allow Creatures", AllowCreatures.GetValueInt())
    AddSliderOptionST("PREGNANCY_DURATION_SLIDER", "Pregnancy Duration", PregnancyDuration.GetValueInt(), "{0} day(s)")
    AddSliderOptionST("RECOVERY_DURATION_SLIDER", "Recovery Duration", RecoveryDuration.GetValueInt(), "{0} day(s)")
    AddMenuOptionST("SCALING_METHOD_MENU", "Scaling Method", _scaleTypeMenu[ScalingMethod.GetValueInt()])
    
    if (ScalingMethod.GetValueInt() == 1 || ScalingMethod.GetValueInt() == 2)
        AddSliderOptionST("BELLY_SCALE_MAX_SLIDER", "\tBelly Scale Maximum", BellyScaleMax.GetValue(), "{0}x")
    endIf
    
    AddSliderOptionST("BELLY_SCALE_MULT_SLIDER", "Belly Scale Multiplier", BellyScaleMult.GetValue(), "{1}")
    AddSliderOptionST("BREAST_SCALE_MULT_SLIDER", "Breast Scale Multiplier", BreastScaleMult.GetValue(), "{1}")
    
    AddHeaderOption("Automation")
    AddSliderOptionST("SPOUSE_INSEMINATE_SLIDER", "Spouse Insemination Probability", SpouseInseminateChance.GetValueInt(), "{0}%")
    AddToggleOptionST("AUTO_INSEMINATE_TOGGLE", "Randomly Inseminate NPCs", AutoInseminateNpc.GetValueInt())
    AddToggleOptionST("AUTO_INSEMINATE_PC_TOGGLE", "Randomly Inseminate PC", AutoInseminatePc.GetValueInt())
    
    if (AutoInseminatePC.GetValueInt())
    	AddToggleOptionST("AUTO_INSEMINATE_PC_SLEEP_TOGGLE", "\tOnly On Sleep", AutoInseminatePcSleep.GetValueInt())
    endIf
    
    AddSliderOptionST("AUTO_INSEMINATE_CHANCE_SLIDER", "Insemination Probability", AutoInseminateChance.GetValueInt(), "{0}%")
    
    AddHeaderOption("Information")
    AddToggleOptionST("DETECT_SPELL_TOGGLE", "Detect Fertility Spell", PlayerRef.HasSpell(DetectFertility))
    AddToggleOptionST("VERBOSE_TOGGLE", "Show Verbose Messages", VerboseMode.GetValueInt())
    AddToggleOptionST("WIDGET_SHOWN_TOGGLE", "Show Cycle Widget", WidgetShown.GetValueInt())
    AddSliderOptionST("WIDGET_TOP_SLIDER", "Widget Top", WidgetTop.GetValueInt(), "{0}px")
    AddSliderOptionST("WIDGET_LEFT_SLIDER", "Widget Left", WidgetLeft.GetValueInt(), "{0}px")
    AddKeyMapOptionST("WIDGET_HOTKEY_MAP", "Widget Hotkey", WidgetHotKey.GetValueInt())
endFunction

function ResetPageTracking()
	_trackingFilter = new String[5]
	_trackingFilter[0] = "All Unique"
    _trackingFilter[1] = "All Non-Unique"
    _trackingFilter[2] = "Ovulating"
    _trackingFilter[3] = "Pregnant"
    _trackingFilter[4] = "Player Only"
    
    int nActors = 0
    int i = Storage.TrackedActors.Length
    
    while (i)
    	i -= 1
    	
    	if (Storage.TrackedActors[i])
    		nActors += 1
    	endIf
    endWhile
    
    SetCursorFillMode(LEFT_TO_RIGHT)
    
    SetCursorPosition(0)
    AddMenuOptionST("PLAYER_ONLY_FILTER_MENU", "Filter", _trackingFilter[_trackingFilterIndex])
    AddTextOption("Tracked Actors: " + nActors, "")
    
    if (_trackingFilterPage > 0)
    	AddTextOptionST("TRACKING_PREV_PAGE", "Previous Page [" + (_trackingFilterPage - 1) + "]", "")
    else
    	AddEmptyOption()
    endIf
    
    if (_trackingFilterPage < (Storage.TrackedActors.Length / _actorsPerPage))
    	AddTextOptionST("TRACKING_NEXT_PAGE", "Next Page [" + (_trackingFilterPage + 1) + "]", "")
    else
    	AddEmptyOption()
    endIf
    
    AddHeaderOption("Tracked Women (most recent)")
    AddHeaderOption("Current Fathers (most recent)")
    
    float now = Utility.GetCurrentGameTime()
    int actorIndex = _actorsPerPage * _trackingFilterPage
    int nListed = 0
    
    while (actorIndex < Storage.TrackedActors.Length && nListed < _actorsPerPage)
        Actor trackedActor = Storage.TrackedActorGet(actorIndex)
        
        if (trackedActor && (_trackingFilterIndex == 1 || trackedActor.GetLeveledActorBase().IsUnique()))
            if (_trackingFilterIndex != 4 || \
            	(_trackingFilterIndex == 4 && Storage.CurrentFather[actorIndex] == PlayerRef.GetDisplayName()) || \
            	(_trackingFilterIndex == 4 && trackedActor == PlayerRef))
            	
                int cycleDay = Math.Ceiling(Storage.LastGameHours[actorIndex] + Storage.LastGameHoursDelta[actorIndex]) % (CycleDuration.GetValueInt() + 1)
                int spermDay = (now - Storage.LastInsemination[actorIndex]) as int
                int pregnantDay = (now - Storage.LastConception[actorIndex]) as int
                int birthDay = (now - Storage.LastBirth[actorIndex]) as int
                string added = ""
                bool isOvulating = false
                bool isPregnant = false
                
                if (Storage.LastOvulation[actorIndex] > 0.0 && Storage.LastOvulation[actorIndex] <= EggLife.GetValue())
                    added = "(*)"
                    isOvulating = true
                endIf
                
                if (Storage.LastConception[actorIndex] > 0.0)
                	isPregnant = true
                endIf
                
                if (trackedActor.HasMagicEffect(EffectContraception))
                    added += "(-)"
                elseIf (trackedActor.HasMagicEffect(EffectFertility))
                    added += "(+)"
                endIf
                
                if (Storage.ActorBlackList.Find(trackedActor) == -1)
	                if (isPregnant && _trackingFilterIndex != 2)
	                    AddTextOption("[Pregnant Day " + pregnantDay + "] " + trackedActor.GetDisplayName() + "(" + Storage.LastMotherLocation[actorIndex] + ")", "")
	                    AddTextOption(Storage.CurrentFather[actorIndex], "")
	                elseIf (Storage.LastBirth[actorIndex] != 0.0 && birthDay < RecoveryDuration.GetValueInt() && (_trackingFilterIndex < 2 || _trackingFilterIndex == 4))
	                    AddTextOption("[Recovery Day " + birthDay + "] " + trackedActor.GetDisplayName() + "(" + Storage.LastMotherLocation[actorIndex] + ")", "")
	                    AddTextOption(Storage.CurrentFather[actorIndex], "")
	                elseIf (Storage.LastInsemination[actorIndex] > 0.0 && (_trackingFilterIndex < 2 || _trackingFilterIndex == 4 || (_trackingFilterIndex == 2 && isOvulating && !isPregnant)))
	                    AddTextOption("[Day " + cycleDay + "]" + added + "(!) " + trackedActor.GetDisplayName() + "(" + Storage.LastMotherLocation[actorIndex] + ")", "")
	                    AddTextOption(Storage.CurrentFather[actorIndex], "")
	                elseIf (_trackingFilterIndex < 2 || _trackingFilterIndex == 4 || (_trackingFilterIndex == 2 && isOvulating && !isPregnant))
	                    AddTextOption("[Day " + cycleDay + "]" + added + trackedActor.GetDisplayName() + "(" + Storage.LastMotherLocation[actorIndex] + ")", "")
	                    AddTextOption(Storage.CurrentFather[actorIndex], "")
	                endIf
                else
                	AddTextOption("[BLOCKED]" + trackedActor.GetDisplayName() + "(" + Storage.LastMotherLocation[actorIndex] + ")", "")
                	AddTextOption(Storage.CurrentFather[actorIndex], "")
                endIf
            endIf
        endIf
        
        actorIndex += 1
        nListed += 1
    endWhile
endFunction

function ResetPageChildren()
	int nChildren = Storage.PlayerChildName.Length
    
    SetCursorFillMode(LEFT_TO_RIGHT)
    
    SetCursorPosition(0)
    AddTextOption("Trained Children: " + nChildren, "")
    
    if (nChildren > 0)
	    if (Storage.CurrentFollowerIndex == -1)
	    	AddMenuOptionST("PLAYER_CHILD_SUMMON_MENU", "Summon Child", Storage.PlayerChildName[_summonIndex])
	    else
	    	AddTextOptionST("PLAYER_CHILD_DISMISS_TEXT", "Dismiss " + Storage.PlayerChildName[Storage.CurrentFollowerIndex], "")
	    endIf
    else
    	AddEmptyOption()
    endIf
    
    if (_trainingFilterPage > 0)
    	AddTextOptionST("TRAINING_PREV_PAGE", "Previous Page [" + (_trainingFilterPage - 1) + "]", "")
    else
    	AddEmptyOption()
    endIf
    
    if (_trainingFilterPage < (Storage.PlayerChildName.Length / _childrenPerPage))
    	AddTextOptionST("TRAINING_NEXT_PAGE", "Next Page [" + (_trainingFilterPage + 1) + "]", "")
    else
    	AddEmptyOption()
    endIf
    
    AddHeaderOption("Trained Children")
    AddEmptyOption()
    
    int childIndex = _childrenPerPage * _trainingFilterPage
    int nListed = 0
    
    while (childIndex < Storage.PlayerChildName.Length && nListed < _childrenPerPage)
		string genderMsg = "[M " + Storage.PlayerChildRace[childIndex] + " " + Storage.PlayerChildClass[childIndex] + "] "
		
		if (Storage.PlayerChildGender[childIndex] == 1)
			genderMsg = "[F " + Storage.PlayerChildRace[childIndex] + " " + Storage.PlayerChildClass[childIndex] + "] ";
		endIf
		
		AddTextOption(genderMsg + Storage.PlayerChildName[childIndex], "")
		
		childIndex += 1
        nListed += 1
    endWhile
endFunction

function ResetPageDebug()
    SetCursorFillMode(TOP_TO_BOTTOM)
    
    SetCursorPosition(0)
    
    AddHeaderOption("Global")
    AddTextOptionST("DEBUG_CLEAR_TRACKING", "Clear Tracking List", "")
    
    Actor kActor = Game.GetCurrentCrosshairRef() as Actor
    int playerIndex = Storage.TrackedActors.Find(PlayerRef)
    Armor baby = none
    int n
    
    if (playerIndex == -1)
        AddHeaderOption(PlayerRef.GetDisplayName() + " is not tracked")
    else
        int cycleDay = Math.Ceiling(Storage.LastGameHours[playerIndex] + Storage.LastGameHoursDelta[playerIndex]) % (CycleDuration.GetValueInt() + 1)
        string fatherName = "Unknown"
        
        _playerFatherIndex = 0
        
        if (Storage.CurrentFather[playerIndex] != "")
            fatherName = Storage.CurrentFather[playerIndex]
            _playerFatherIndex = playerIndex
        endIf
        
        AddHeaderOption(PlayerRef.GetDisplayName())
        
        AddTextOption("Current Time", Utility.GetCurrentGameTime())
        AddTextOption("Last Ovulation", Storage.LastOvulation[playerIndex])
        AddTextOption("Last Insemination", Storage.LastInsemination[playerIndex])
        AddTextOption("Last Conception", Storage.LastConception[playerIndex])
        AddTextOption("Last Birth", Storage.LastBirth[playerIndex])
        
        if (Storage.LastConception[playerIndex] != 0.0)
            AddTextOptionST("PLAYER_FATHER", "Father: " + fatherName, "")
        elseIf (Storage.LastInsemination[playerIndex] != 0.0)
            AddTextOptionST("PLAYER_DAY", "Cycle Day: " + cycleDay, "")
            AddTextOptionST("PLAYER_SPERM", "Sperm Count: " + Storage.SpermCount[playerIndex], "")
            
            if (Storage.LastOvulation[playerIndex] > 0.0)
                AddTextOptionST("PLAYER_EGG", "Egg Age: " + Storage.LastOvulation[playerIndex], "")
            endIf
            
            AddTextOptionST("PLAYER_FATHER", "Potential Father: " + fatherName, "")
        else
            AddTextOptionST("PLAYER_DAY", "Cycle Day: " + cycleDay, "")
            AddTextOptionST("PLAYER_SPERM", "Sperm Count: " + Storage.SpermCount[playerIndex], "")
            
            if (Storage.LastOvulation[playerIndex] > 0.0)
                AddTextOptionST("PLAYER_EGG", "Egg Age: " + Storage.LastOvulation[playerIndex], "")
            endIf
        endIf
        
        if (Storage.LastConception[playerIndex] == 0.0)
            if (Storage.LastOvulation[playerIndex] == 0.0 && (cycleDay < MenstruationBegin.GetValueInt() || cycleDay > MenstruationEnd.GetValueInt()))
                AddTextOptionST("PLAYER_OVULATE", "Force Ovulation", "")
            endIf
            
            AddTextOptionST("PLAYER_ADD_SPERM", "Add Sperm", "")
            
            if (Storage.LastInsemination[playerIndex] != 0.0)
                AddTextOptionST("PLAYER_REMOVE_SPERM", "Remove Sperm", "")
            endIf
        endIf
        
        if (Storage.LastConception[playerIndex] == 0.0)
            AddTextOptionST("PLAYER_IMPREGNATE", "Impregnate", "")
        else
            AddTextOptionST("PLAYER_BIRTH", "Give Birth", "")
            AddTextOptionST("PLAYER_ABORT", "Abort", "")
        endIf
        
        n = Storage.BirthBabyRace.Length
        
        while (n)
	        n -= 1
	        
	        if (PlayerRef.GetItemCount(Storage.BirthBabyRace[n]) > 0)
	            baby = Storage.BirthBabyRace[n]
	        endIf
    	endWhile
    	
    	if (SpawnEnabled.GetValueInt() && Storage.BabyAdded[playerIndex] != 0.0 && baby)
	        AddTextOptionST("PLAYER_GROWTH", "Force Baby Growth", "")
        endIf
    endIf
    
    AddHeaderOption("Child NPCs")
    
    BYOHRelationshipAdoptionScript adoptHookScript = (RelationshipAdoption as BYOHRelationshipAdoptionScript)
    
    AddTextOptionST("ADOPTED_CHILDREN", "Adopted Children: " + adoptHookScript.numChildrenAdopted, "")
    AddTextOptionST("SPAWN_CHILD_PLAYER_MALE", "Spawn Child (Male)", "")
    AddTextOptionST("SPAWN_CHILD_PLAYER_FEMALE", "Spawn Child (Female)", "")
    AddTextOptionST("SPAWN_CHILD_PLAYER_ALL", "Spawn All Supported Children", "")
    
    if (kActor && kActor.HasKeyword(SpawnedChild))
        AddHeaderOption("Active Child")
        AddTextOptionST("RENAME_CHILD_PLAYER", "Rename Child", "")
        AddTextOptionST("ADOPT_CHILD_PLAYER", "Adopt Child", "")
        AddTextOptionST("DESPAWN_CHILD_PLAYER", "Despawn Child", "")
    else
        AddHeaderOption("No child selected")
    endIf
    
    SetCursorPosition(1)
    
    AddHeaderOption("Global")
    AddTextOptionST("DEBUG_CLEAR_NPC_TRACKING", "Clear Tracked NPCs", "")
    
    if (!kActor)
        AddHeaderOption("No actor selected")
    else
        int npcIndex = Storage.TrackedActors.Find(kActor)
        int blockedIndex = Storage.ActorBlackList.Find(kActor)
        
        if (npcIndex == -1)
            AddHeaderOption(kActor.GetDisplayName() + " is not tracked")
            AddTextOptionST("NPC_TRACK", "Add to Tracking", "")
        else
            int cycleDay = Math.Ceiling(Storage.LastGameHours[npcIndex] + Storage.LastGameHoursDelta[npcIndex]) % (CycleDuration.GetValueInt() + 1)
            string fatherName = "Unknown"
            
            _npcFatherIndex = 0
            
            if (Storage.CurrentFather[npcIndex] != "")
                fatherName = Storage.CurrentFather[npcIndex]
                _npcFatherIndex = npcIndex
            endIf
            
            if (blockedIndex == -1)
            	AddHeaderOption(kActor.GetDisplayName())
            	AddTextOptionST("NPC_BLOCK", "Block", "")
            else
            	AddHeaderOption(kActor.GetDisplayName() + " (BLOCKED)")
            	AddTextOptionST("NPC_UNBLOCK", "Unblock", "")
            endIf
            
            AddTextOption("Current Time", Utility.GetCurrentGameTime())
            AddTextOption("Last Ovulation", Storage.LastOvulation[npcIndex])
            AddTextOption("Last Insemination", Storage.LastInsemination[npcIndex])
            AddTextOption("Last Conception", Storage.LastConception[npcIndex])
            AddTextOption("Last Birth", Storage.LastBirth[npcIndex])
            
            if (Storage.LastConception[npcIndex] != 0.0)
                AddTextOptionST("NPC_FATHER", "Father: " + fatherName, "")
            elseIf (Storage.LastInsemination[npcIndex] != 0.0)
                AddTextOptionST("NPC_DAY", "Cycle Day: " + cycleDay, "")
                AddTextOptionST("NPC_SPERM", "Sperm Count: " + Storage.SpermCount[npcIndex], "")
                
                if (Storage.LastOvulation[npcIndex] > 0.0)
                    AddTextOptionST("NPC_EGG", "Egg Age: " + Storage.LastOvulation[npcIndex], "")
                endIf
                
                AddTextOptionST("NPC_FATHER", "Potential Father: " + fatherName, "")
            else
                AddTextOptionST("NPC_DAY", "Cycle Day: " + cycleDay, "")
                AddTextOptionST("NPC_SPERM", "Sperm Count: " + Storage.SpermCount[npcIndex], "")
                
                if (Storage.LastOvulation[npcIndex] > 0.0)
                    AddTextOptionST("NPC_EGG", "Egg Age: " + Storage.LastOvulation[npcIndex], "")
                endIf
            endIf
            
            if (Storage.LastConception[npcIndex] == 0.0)
                if (Storage.LastOvulation[npcIndex] == 0.0 && (cycleDay < MenstruationBegin.GetValueInt() || cycleDay > MenstruationEnd.GetValueInt()))
                    AddTextOptionST("NPC_OVULATE", "Force Ovulation", "")
                endIf
                
                AddTextOptionST("NPC_ADD_SPERM", "Add Sperm", "")
                
                if (Storage.LastInsemination[npcIndex] != 0.0)
                    AddTextOptionST("NPC_REMOVE_SPERM", "Remove Sperm", "")
                endIf
            endIf
            
            if (Storage.LastConception[npcIndex] == 0.0)
                AddTextOptionST("NPC_IMPREGNATE", "Impregnate", "")
            else
                AddTextOptionST("NPC_BIRTH", "Give Birth", "")
                AddTextOptionST("NPC_ABORT", "Abort", "")
            endIf
            
            n = Storage.BirthBabyRace.Length
        
	        while (n)
		        n -= 1
		        
		        if (kActor.GetItemCount(Storage.BirthBabyRace[n]) > 0)
		            baby = Storage.BirthBabyRace[n]
		        endIf
	    	endWhile
	    	
	    	if (SpawnEnabled.GetValueInt() && Storage.BabyAdded[npcIndex] != 0.0 && baby)
		    	if (Storage.LastFather[npcIndex] == PlayerRef.GetDisplayName())
		        	AddTextOptionST("NPC_GROWTH", "Force Baby Growth", "")
		        endIf
	        endIf
        endIf
    endIf
    
    AddHeaderOption("Debug Spells")
    AddToggleOptionST("INSEMINATE_SPELL_TOGGLE", "Inseminate Spell", InseminateSpellAdded.GetValueInt())
    AddToggleOptionST("IMPREGNATE_SPELL_TOGGLE", "Impregnate Spell", ImpregnateSpellAdded.GetValueInt())
    AddToggleOptionST("BIRTH_SPELL_TOGGLE", "Give Birth Spell", BirthSpellAdded.GetValueInt())
    AddToggleOptionST("ABORT_SPELL_TOGGLE", "Abort Pregnancy Spell", AbortSpellAdded.GetValueInt())
    
endFunction

state PLAYER_CHILD_SUMMON_MENU
	event OnMenuOpenST()
		SetMenuDialogStartIndex(0)
		SetMenuDialogDefaultIndex(0)
		SetMenuDialogOptions(Storage.PlayerChildName)
	endEvent
	
	event OnMenuAcceptST(int index)
		ActorBase childBase = Storage.AdultChildren[Storage.PlayerChildActorIndex[index]]
		
		if (childBase)
			childBase.SetHairColor(PlayerRef.GetActorBase().GetHairColor())
		
			Actor child = PlayerRef.PlaceAtMe(childBase) as Actor
			
			child.SetDisplayName(Storage.PlayerChildName[index])
			child.SetRelationshipRank(PlayerRef, 3)
			PlayerRef.SetRelationshipRank(child, 3)
			
			child.SetPlayerTeammate()
			
			Storage.CurrentFollower = child
			Storage.CurrentFollowerIndex = index
		else
			Debug.MessageBox(Storage.PlayerChildName[index] + " could not be summoned")
		endIf
		
		ForcePageReset()
	endEvent
	
	event OnDefaultST()
		SetMenuOptionValueST(Storage.PlayerChildName[0])
	endEvent
	
	event OnHighlightST()
		SetInfoText("Select a child to summon")
	endEvent
endState

state PLAYER_CHILD_DISMISS_TEXT
	event OnSelectST()
		Debug.MessageBox("Please exit all menus to complete dismissal...")
		
		Storage.CurrentFollower.Disable(true)
		Storage.CurrentFollower.Delete()
		Storage.CurrentFollower = none
		Storage.CurrentFollowerIndex = -1
	
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("Dismiss the currently summoned child")
	endEvent
endState

state ENABLED_TOGGLE
    event OnSelectST()
        if (Enabled.GetValueInt() == 0)
            Enabled.SetValueInt(1)
            Handler.UpdateStatusAll()
        else
            Enabled.SetValueInt(0)
            Handler.UpdateStatusAll(false)
        endIf
        
        SetToggleOptionValueST(Enabled.GetValueInt())
        ForcePageReset()
    endEvent
    
    event OnDefaultST()
        SetToggleOptionValueST(Enabled.GetValueInt())
    endEvent
    
    event OnHighlightST()
        SetInfoText("Enables or disables the mod")
    endEvent
endState

state VERBOSE_TOGGLE
    event OnSelectST()
        if (VerboseMode.GetValueInt() == 0)
            VerboseMode.SetValueInt(1)
        else
            VerboseMode.SetValueInt(0)
        endIf
        
        SetToggleOptionValueST(VerboseMode.GetValueInt())
    endEvent
    
    event OnDefaultST()
        SetToggleOptionValueST(VerboseMode.GetValueInt())
    endEvent
    
    event OnHighlightST()
        SetInfoText("Enables or disables verbose notification messages")
    endEvent
endState

state POLLING_SLIDER
    event OnSliderOpenST()
        SetSliderDialogStartValue(PollingInterval.GetValueInt())
        SetSliderDialogRange(1, 24)
        SetSliderDialogInterval(1)
    endEvent
    
    event OnSliderAcceptST(float value)
        PollingInterval.SetValueInt(value as int)
        SetSliderOptionValueST(value as int, "{0} hour(s)")
    endEvent
    
    event OnHighlightST()
        SetInfoText("Specifies how often tracked actors will be updated in game time (default: 1 hour)")
    endEvent
endState

state FORCE_GENDER_MENU
    event OnMenuOpenST()
        SetMenuDialogStartIndex(ForceGender.GetValueInt())
        SetMenuDialogDefaultIndex(0)
        SetMenuDialogOptions(_genderMenu)
    endEvent
    
    event OnMenuAcceptST(int index)
    	if (index == 0 && ForceGender.GetValueInt() != 0)
    		; Reset to the automatic gender
    		int sex = Util.GetActorGender(PlayerRef)
    		int i = Storage.TrackedActors.Find(PlayerRef)
            
            if (i != -1)
                Storage.TrackedActorRemove(i)
            endIf
            
    		i = Storage.TrackedFathers.Find(PlayerRef)
        	
        	if (i != -1)
        		Storage.TrackedFatherRemove(i)
        	endIf
            
            if (sex == 0)
            	Storage.TrackedActorAdd(PlayerRef)
            else
            	Storage.TrackedFatherAdd(PlayerRef)
            endIf
    		
    		Debug.MessageBox("The player will be recognized as the given Creation Kit setting\nIf SexLab and the SexLab patch are installed, the player will be recognized as the SexLab gender")
    	elseIf (index == 1 && ForceGender.GetValueInt() != 1)
    		; Set to female
    		int i = Storage.TrackedFathers.Find(PlayerRef)
        	
        	if (i != -1)
        		Storage.TrackedFatherRemove(i)
        	endIf
        	
            ; Sex changed to female
            Storage.TrackedActorAdd(PlayerRef)
            
            Debug.MessageBox("The player will be recognized as female")
    	elseIf (index == 2 && ForceGender.GetValueInt() != 2)
    		; Set to male
    		int i = Storage.TrackedActors.Find(PlayerRef)
            
            if (i != -1)
                Storage.TrackedActorRemove(i)
            endIf
            
			; Sex changed to male            
            Storage.TrackedFatherAdd(PlayerRef)
            
            Debug.MessageBox("The player will be recognized as male")
    	endIf
    	
        ForceGender.SetValueInt(index)
        SetMenuOptionValueST(_genderMenu[ForceGender.GetValueInt()])
        Handler.UpdateStatusAll(false)
        WidgetCycle.UpdateContent()
        ForcePageReset()
    endEvent
    
    event OnDefaultST()
        SetMenuOptionValueST(_genderMenu[ForceGender.GetValueInt()])
    endEvent
    
    event OnHighlightST()
        ; 0: "Automatic"
        ; 1: "Female"
        ; 2: "Male"
        if (ForceGender.GetValueInt() == 0)
            SetInfoText("Select the player's preferred gender\nAutomatic identifies gender from the Creation Kit setting\nIf SexLab and the SexLab patch are installed, the SexLab gender setting is used")
        elseIf (ForceGender.GetValueInt() == 1)
            SetInfoText("Select the player's preferred gender\nForce the player to be identified as female")
        elseIf (ForceGender.GetValueInt() == 2)
            SetInfoText("Select the player's preferred gender\nForce the player to be identified as male")
        endIf
    endEvent
endState

state PLAYER_ONLY_TOGGLE
    event OnSelectST()
        if (PlayerOnly.GetValueInt() == 0)
            PlayerOnly.SetValueInt(1)
            
            int n = Storage.TrackedActors.Length
    		
    		; Remove all women who are not the player
    		while (n)
    			n -= 1
    			
    			if (Storage.TrackedActors[n] != PlayerRef)
    				Storage.TrackedActorRemove(n)
    			endIf
    		endWhile
        else
            PlayerOnly.SetValueInt(0)
        endIf
        
        SetToggleOptionValueST(PlayerOnly.GetValueInt())
    endEvent
    
    event OnDefaultST()
        SetToggleOptionValueST(PlayerOnly.GetValueInt())
    endEvent
    
    event OnHighlightST()
        SetInfoText("When enabled, only the player and currently relevant NPCs for insemination and conception will be tracked")
    endEvent
endState

state UNIQUE_WOMEN_ONLY_TOGGLE
    event OnSelectST()
        if (UniqueWomenOnly.GetValueInt() == 0)
            UniqueWomenOnly.SetValueInt(1)
        else
            UniqueWomenOnly.SetValueInt(0)
        endIf
        
        SetToggleOptionValueST(UniqueWomenOnly.GetValueInt())
        ForcePageReset()
    endEvent
    
    event OnDefaultST()
        SetToggleOptionValueST(UniqueWomenOnly.GetValueInt())
    endEvent
    
    event OnHighlightST()
        SetInfoText("Enables or disables whether non-unique NPCs are tracked")
    endEvent
endState

state UNIQUE_MEN_ONLY_TOGGLE
    event OnSelectST()
        if (UniqueMenOnly.GetValueInt() == 0)
            UniqueMenOnly.SetValueInt(1)
        else
            UniqueMenOnly.SetValueInt(0)
        endIf
        
        SetToggleOptionValueST(UniqueMenOnly.GetValueInt())
        ForcePageReset()
    endEvent
    
    event OnDefaultST()
        SetToggleOptionValueST(UniqueMenOnly.GetValueInt())
    endEvent
    
    event OnHighlightST()
        SetInfoText("Enables or disables whether non-unique NPCs are tracked")
    endEvent
endState

state CYCLE_DURATION_SLIDER
    event OnSliderOpenST()
        SetSliderDialogStartValue(CycleDuration.GetValueInt())
        SetSliderDialogRange(7, 28)
        SetSliderDialogInterval(7)
    endEvent
    
    event OnSliderAcceptST(float value)
        CycleDuration.SetValueInt(value as int)
        
        if ((value as int) == 7)
            SpermLife.SetValueInt(2)
            EggLife.SetValueInt(2)
            MenstruationBegin.SetValueInt(0)
            MenstruationEnd.SetValueInt(1)
            OvulationBegin.SetValueInt(2)
            OvulationEnd.SetValueInt(5)
        elseIf ((value as int) == 14)
            SpermLife.SetValueInt(4)
            EggLife.SetValueInt(2)
            MenstruationBegin.SetValueInt(0)
            MenstruationEnd.SetValueInt(3)
            OvulationBegin.SetValueInt(4)
            OvulationEnd.SetValueInt(9)
        elseIf ((value as int) == 21)
            SpermLife.SetValueInt(4)
            EggLife.SetValueInt(2)
            MenstruationBegin.SetValueInt(0)
            MenstruationEnd.SetValueInt(6)
            OvulationBegin.SetValueInt(7)
            OvulationEnd.SetValueInt(13)
        else
            ; Assume anything else should be 28 days
            SpermLife.SetValueInt(4)
            EggLife.SetValueInt(2)
            MenstruationBegin.SetValueInt(0)
            MenstruationEnd.SetValueInt(6)
            OvulationBegin.SetValueInt(7)
            OvulationEnd.SetValueInt(13)
        endIf
        
        SetSliderOptionValueST(value as int, "{0} days")
        ForcePageReset()
    endEvent
    
    event OnHighlightST()
        SetInfoText("Specifies the length of the menstrual cycle (default: 28 days)")
    endEvent
endState

state PMS_STAMINA_SLIDER
    event OnSliderOpenST()
        SetSliderDialogStartValue(PMSStaminaReduction.GetValue())
        SetSliderDialogRange(0.0, 1.0)
        SetSliderDialogInterval(0.01)
    endEvent
    
    event OnSliderAcceptST(float value)
        PMSStaminaReduction.SetValue(value)
        SetSliderOptionValueST(value, "-{2}")
        ForcePageReset()
    endEvent
    
    event OnHighlightST()
        SetInfoText("Specifies the percentage stamina will be reduced during PMS (default: 10%)")
    endEvent
endState

state PMS_MAGICKA_SLIDER
    event OnSliderOpenST()
        SetSliderDialogStartValue(PMSMagickaReduction.GetValue())
        SetSliderDialogRange(0.0, 1.0)
        SetSliderDialogInterval(0.01)
    endEvent
    
    event OnSliderAcceptST(float value)
        PMSMagickaReduction.SetValue(value)
        SetSliderOptionValueST(value, "-{2}")
        ForcePageReset()
    endEvent
    
    event OnHighlightST()
        SetInfoText("Specifies the percentage magicka will be reduced during PMS (default: 10%)")
    endEvent
endState

state OVULATION_STAMINA_SLIDER
    event OnSliderOpenST()
        SetSliderDialogStartValue(OvulationStaminaBonus.GetValue())
        SetSliderDialogRange(0.0, 1.0)
        SetSliderDialogInterval(0.01)
    endEvent
    
    event OnSliderAcceptST(float value)
        OvulationStaminaBonus.SetValue(value)
        SetSliderOptionValueST(value, "+{2}")
        ForcePageReset()
    endEvent
    
    event OnHighlightST()
        SetInfoText("Specifies the percentage stamina will be increased when fertile (default: 10%)")
    endEvent
endState

state OVULATION_MAGICKA_SLIDER
    event OnSliderOpenST()
        SetSliderDialogStartValue(OvulationMagickaBonus.GetValue())
        SetSliderDialogRange(0.0, 1.0)
        SetSliderDialogInterval(0.01)
    endEvent
    
    event OnSliderAcceptST(float value)
        OvulationMagickaBonus.SetValue(value)
        SetSliderOptionValueST(value, "+{2}")
        ForcePageReset()
    endEvent
    
    event OnHighlightST()
        SetInfoText("Specifies the percentage magicka will be increased when fertile (default: 10%)")
    endEvent
endState

state DETECT_SPELL_TOGGLE
    event OnSelectST()
        if (PlayerRef.HasSpell(DetectFertility))
            PlayerRef.RemoveSpell(DetectFertility)
        else
            PlayerRef.AddSpell(DetectFertility)
        endIf

        SetToggleOptionValueST(PlayerRef.HasSpell(DetectFertility))
    endEvent

    event OnDefaultST()
        SetToggleOptionValueST(PlayerRef.HasSpell(DetectFertility))
    endEvent

    event OnHighlightST()
        SetInfoText("Toggles an alteration spell for detecting fertility\nBlue means ovulating or may ovulate, red means pregnant")
    endEvent
endState

state WIDGET_SHOWN_TOGGLE
    event OnSelectST()
        if (WidgetShown.GetValueInt() == 0)
            WidgetCycle.Alpha = 100.0
            WidgetShown.SetValueInt(1)
        else
            WidgetCycle.Alpha = 0.0
            WidgetShown.SetValueInt(0)
        endIf
        
        SetToggleOptionValueST(WidgetShown.GetValueInt())
        ForcePageReset()
    endEvent
    
    event OnDefaultST()
        SetToggleOptionValueST(WidgetShown.GetValueInt())
    endEvent
    
    event OnHighlightST()
        SetInfoText("Shows a cycle widget for female players")
    endEvent
endState

state WIDGET_TOP_SLIDER
    event OnSliderOpenST()
        SetSliderDialogStartValue(WidgetTop.GetValueInt())
        SetSliderDialogRange(0.0, 4320.0) ; 8K UHD overkill?
        SetSliderDialogInterval(1)
    endEvent
    
    event OnSliderAcceptST(float value)
        WidgetTop.SetValueInt(value as int)
        WidgetCycle.Y = value as int
        SetSliderOptionValueST(value as int, "{0}px")
        ForcePageReset()
    endEvent
    
    event OnHighlightST()
        SetInfoText("Specifies the topmost pixel position of the widget")
    endEvent
endState

state WIDGET_LEFT_SLIDER
    event OnSliderOpenST()
        SetSliderDialogStartValue(WidgetLeft.GetValueInt())
        SetSliderDialogRange(0.0, 7680.0) ; 8K UHD overkill?
        SetSliderDialogInterval(1)
    endEvent
    
    event OnSliderAcceptST(float value)
        WidgetLeft.SetValueInt(value as int)
        WidgetCycle.X = value as int
        SetSliderOptionValueST(value as int, "{0}px")
        ForcePageReset()
    endEvent
    
    event OnHighlightST()
        SetInfoText("Specifies the leftmost pixel position of the widget")
    endEvent
endState

state WIDGET_HOTKEY_MAP
    event OnKeyMapChangeST(int newCode, string conflictControl, string conflictName)
        bool doMap = true
        
        if (conflictControl != "")
            doMap = ShowMessage("The key is already mapped to '" + conflictControl + "'. Continue?")
        endIf
        
        if (doMap)
            WidgetHotKey.SetValueInt(newCode)
            SetKeyMapOptionValueST(WidgetHotKey.GetValueInt())
        endIf
    endEvent
    
    event OnDefaultST()
        WidgetHotKey.SetValueInt(10)
        SetKeyMapOptionValueST(WidgetHotKey.GetValueInt())
    endEvent
    
    event OnHighlightST()
        SetInfoText("Maps the fertility status check hotkey (default '9')")
    endEvent
endState

state CONCEPTION_CHANCE_SLIDER
    event OnSliderOpenST()
        SetSliderDialogStartValue(ConceptionChance.GetValue())
        SetSliderDialogRange(0, 100)
        SetSliderDialogInterval(1)
    endEvent
    
    event OnSliderAcceptST(float value)
        ConceptionChance.SetValueInt(value as int)
        SetSliderOptionValueST(value, "{0}%")
    endEvent
    
    event OnHighlightST()
        SetInfoText("Specifies the maximum conception chance during ovulation (default 33%)")
    endEvent
endState

state ALLOW_CREATURES_TOGGLE
    event OnSelectST()
        if (AllowCreatures.GetValueInt() == 0)
            AllowCreatures.SetValueInt(1)
        else
            AllowCreatures.SetValueInt(0)
        endIf
        
        SetToggleOptionValueST(AllowCreatures.GetValueInt())
    endEvent
    
    event OnDefaultST()
        SetToggleOptionValueST(AllowCreatures.GetValueInt())
    endEvent
    
    event OnHighlightST()
        SetInfoText("Enables or disables insemination from creatures")
    endEvent
endState

state PREGNANCY_DURATION_SLIDER
    event OnSliderOpenST()
        SetSliderDialogStartValue(PregnancyDuration.GetValueInt())
        SetSliderDialogRange(1, 365)
        SetSliderDialogInterval(1)
    endEvent
    
    event OnSliderAcceptST(float value)
        PregnancyDuration.SetValueInt(value as int)
        SetSliderOptionValueST(value as int, "{0} day(s)")
    endEvent
    
    event OnHighlightST()
        SetInfoText("Specifies the length of a full term pregnancy (default: 10 days)")
    endEvent
endState

state RECOVERY_DURATION_SLIDER
    event OnSliderOpenST()
        SetSliderDialogStartValue(RecoveryDuration.GetValueInt())
        SetSliderDialogRange(1, 365)
        SetSliderDialogInterval(1)
    endEvent
    
    event OnSliderAcceptST(float value)
        RecoveryDuration.SetValueInt(value as int)
        SetSliderOptionValueST(value as int, "{0} day(s)")
    endEvent
    
    event OnHighlightST()
        SetInfoText("Specifies the length of recovery after giving birth (default: 10 days)\nFertility will be 0% during this time")
    endEvent
endState

state SCALING_METHOD_MENU
    event OnMenuOpenST()
        SetMenuDialogStartIndex(ScalingMethod.GetValueInt())
        SetMenuDialogDefaultIndex(0)
        SetMenuDialogOptions(_scaleTypeMenu)
    endEvent
    
    event OnMenuAcceptST(int index)
        int n = Storage.TrackedActors.Length
        
        while (n)
            n -= 1
            
            if (Storage.TrackedActors[n] == PlayerRef || (Storage.TrackedActors[n] as Actor).Is3DLoaded())
                Util.ClearBellyBreastScale(Storage.TrackedActors[n] as Actor)
            endIf
        endWhile
        
        ScalingMethod.SetValueInt(index)
        SetMenuOptionValueST(_scaleTypeMenu[ScalingMethod.GetValueInt()])
        Handler.UpdateStatusAll(false)
        ForcePageReset()
    endEvent
    
    event OnDefaultST()
        SetMenuOptionValueST(_scaleTypeMenu[ScalingMethod.GetValueInt()])
    endEvent
    
    event OnHighlightST()
        ; Type 0: "BodyMorph"
        ; Type 1: "NetImmerse"
        ; Type 2: "NiOverride"
        ; Type 3: "SLIF"
        if (ScalingMethod.GetValueInt() == 0)
            SetInfoText("Select the belly/breast scaling method\nBodyMorph uses morphs from RaceMenu/BodySlide. This is generally the best looking method")
        elseIf (ScalingMethod.GetValueInt() == 1)
            SetInfoText("Select the belly/breast scaling method\nNetImmerse is the most widely compatible. Belly and breast nodes are required")
        elseIf (ScalingMethod.GetValueInt() == 2)
            SetInfoText("Select the belly/breast scaling method\nNiOverride is an extension onto SKSE. Belly and breast nodes are required")
        elseIf (ScalingMethod.GetValueInt() == 3)
            SetInfoText("Select the belly/breast scaling method\nSexLab Inflation Framework is a general scaling utility that uses tools currently installed\nThis option is recommended when using multiple mods that scale the same features")
        endIf
    endEvent
endState

state BELLY_SCALE_MAX_SLIDER
    event OnSliderOpenST()
        SetSliderDialogStartValue(BellyScaleMax.GetValue())
        SetSliderDialogRange(1, 12)
        SetSliderDialogInterval(1)
    endEvent

    event OnSliderAcceptST(float value)
        BellyScaleMax.SetValue(value)
        SetSliderOptionValueST(value, "{0}x")
    endEvent

    event OnHighlightST()
        SetInfoText("Specifies the maximum size for pregnant bellies with node scaling\nThis also relatively affects breast scaling")
    endEvent
endState

state BELLY_SCALE_MULT_SLIDER
    event OnSliderOpenST()
        SetSliderDialogStartValue(BellyScaleMult.GetValue())
        SetSliderDialogRange(0.1, 10.0)
        SetSliderDialogInterval(0.1)
    endEvent
    
    event OnSliderAcceptST(float value)
        BellyScaleMult.SetValue(value)
        SetSliderOptionValueST(value, "{1}")
    endEvent
    
    event OnHighlightST()
        SetInfoText("Specifies the belly scale adjustment (default: 1.0)\nThe belly scales uniformly over the duration of a pregnancy")
    endEvent
endState

state BREAST_SCALE_MULT_SLIDER
    event OnSliderOpenST()
        SetSliderDialogStartValue(BreastScaleMult.GetValue())
        SetSliderDialogRange(0.1, 10.0)
        SetSliderDialogInterval(0.1)
    endEvent
    
    event OnSliderAcceptST(float value)
        BreastScaleMult.SetValue(value)
        SetSliderOptionValueST(value, "{1}")
    endEvent
    
    event OnHighlightST()
        SetInfoText("Specifies the breast scale adjustment (default: 0.5)\nBreasts scale relative to the belly")
    endEvent
endState

state BIRTH_TYPE_MENU
    event OnMenuOpenST()
        SetMenuDialogOptions(BirthTypeMenu)
        SetMenuDialogStartIndex(BirthType.GetValueInt())
        SetMenuDialogDefaultIndex(0)
    endEvent
    
    event OnMenuAcceptST(int index)
        BirthType.SetValueInt(index)
        SetMenuOptionValueST(BirthTypeMenu[index])
        ForcePageReset()
    endEvent
    
    event OnHighlightST()
        ; Type 0: "None"
        ; Type 1: "Soul Gem"
        ; Type 2: "Baby Item"
        if (BirthType.GetValueInt() == 0)
            SetInfoText("Select the result of pregnancy\nNo effect. Pregnancy simply ends")
        elseIf (BirthType.GetValueInt() == 1)
            SetInfoText("Select the result of pregnancy\nA filled black soul gem is added to the actor's inventory")
        elseIf (BirthType.GetValueInt() == 2)
            SetInfoText("Select the result of pregnancy\nA baby item is added to the actor's inventory and equipped\nThe player's babies may grow into child NPCs")
        endIf
    endEvent
endState

state BIRTH_RACE_MENU
    event OnMenuOpenST()
        SetMenuDialogOptions(_birthRaceMenu)
        SetMenuDialogStartIndex(BirthRace.GetValueInt())
        SetMenuDialogDefaultIndex(0)
    endEvent
    
    event OnMenuAcceptST(int index)
        BirthRace.SetValueInt(index)
        SetMenuOptionValueST(_birthRaceMenu[index])
        ForcePageReset()
    endEvent
    
    event OnHighlightST()
        ; Type 0: "Mother"
        ; Type 1: "Father"
        ; Type 2: "Random"
        if (BirthRace.GetValueInt() == 0)
            SetInfoText("Select the inherited race of children\nBased on the mother")
        elseIf (BirthRace.GetValueInt() == 1)
            SetInfoText("Select the inherited race of children\nBased on the father\nDefaults to the mother if the father cannot be identified")
        elseIf (BirthRace.GetValueInt() == 2)
            SetInfoText("Select the inherited race of children\nBased on a random choice between mother and father\nDefaults to the mother if the father cannot be identified")
        endIf
    endEvent
endState

state BIRTH_RACE_SPECIFIC_MENU
    event OnMenuOpenST()
        SetMenuDialogOptions(_birthRaceSpecificMenu)
        SetMenuDialogStartIndex(BirthRaceSpecific.GetValueInt())
        SetMenuDialogDefaultIndex(0)
    endEvent
    
    event OnMenuAcceptST(int index)
        BirthRaceSpecific.SetValueInt(index)
        SetMenuOptionValueST(_birthRaceSpecificMenu[index])
        ForcePageReset()
    endEvent
    
    event OnHighlightST()
        SetInfoText("Select the inherited race of the player's children\nThis race is unconditional, all of the player's children will be the selected race")
    endEvent
endState

state MISCARRIAGE_ENABLED_TOGGLE
    event OnSelectST()
        if (MiscarriageEnabled.GetValueInt() == 0)
            MiscarriageEnabled.SetValueInt(1)
        else
            MiscarriageEnabled.SetValueInt(0)
        endIf
        
        SetToggleOptionValueST(MiscarriageEnabled.GetValueInt())
        ForcePageReset()
    endEvent
    
    event OnDefaultST()
        SetToggleOptionValueST(MiscarriageEnabled.GetValueInt())
    endEvent
    
    event OnHighlightST()
        SetInfoText("Enables or disables baby health and possible miscarriage\nThe baby's health reduces by 1% every hour after a day of no sleep")
    endEvent
endState

state SOUND_VOLUME_SLIDER
    event OnSliderOpenST()
        SetSliderDialogStartValue(SoundVolume.GetValue())
        SetSliderDialogRange(0.0, 1.0)
        SetSliderDialogInterval(0.1)
    endEvent
    
    event OnSliderAcceptST(float value)
        SoundVolume.SetValue(value)
        SetSliderOptionValueST(value, "{1}x")
    endEvent
    
    event OnHighlightST()
        SetInfoText("Specifies the volume multiplier for labor and baby sounds (default: 1.0x)")
    endEvent
endState

state LABOR_ENABLED_TOGGLE
    event OnSelectST()
        if (LaborEnabled.GetValueInt() == 0)
            LaborEnabled.SetValueInt(1)
        else
            LaborEnabled.SetValueInt(0)
        endIf
        
        SetToggleOptionValueST(LaborEnabled.GetValueInt())
        ForcePageReset()
    endEvent
    
    event OnDefaultST()
        SetToggleOptionValueST(LaborEnabled.GetValueInt())
    endEvent
    
    event OnHighlightST()
        SetInfoText("Enables or disables labor animations\nWarning: A player giving birth will lose control during this time")
    endEvent
endState

state SPAWN_ENABLED_TOGGLE
    event OnSelectST()
        if (SpawnEnabled.GetValueInt() == 0)
            SpawnEnabled.SetValueInt(1)
        else
            SpawnEnabled.SetValueInt(0)
        endIf
        
        SetToggleOptionValueST(SpawnEnabled.GetValueInt())
        ForcePageReset()
    endEvent
    
    event OnDefaultST()
        SetToggleOptionValueST(SpawnEnabled.GetValueInt())
    endEvent
    
    event OnHighlightST()
        SetInfoText("Enables or disables baby growth into adopted children or for training into adult followers")
    endEvent
endState

state BIRTH_BABY_ADOPTION_TOGGLE
    event OnSelectST()
        if (AdoptionEnabled.GetValueInt() == 0)
            AdoptionEnabled.SetValueInt(1)
        else
            AdoptionEnabled.SetValueInt(0)
        endIf
        
        SetToggleOptionValueST(AdoptionEnabled.GetValueInt())
        ForcePageReset()
    endEvent
    
    event OnDefaultST()
        SetToggleOptionValueST(AdoptionEnabled.GetValueInt())
    endEvent
    
    event OnHighlightST()
        SetInfoText("Enables or disables baby growth into Hearthfire adopted children\nAdoption may fail if prerequisites are not met\nIf adoption fails and training is enabled, the child will be sent to training")
    endEvent
endState

state BIRTH_BABY_TRAINING_TOGGLE
    event OnSelectST()
        if (TrainingEnabled.GetValueInt() == 0)
            TrainingEnabled.SetValueInt(1)
        else
            TrainingEnabled.SetValueInt(0)
        endIf
        
        SetToggleOptionValueST(TrainingEnabled.GetValueInt())
        ForcePageReset()
    endEvent
    
    event OnDefaultST()
        SetToggleOptionValueST(TrainingEnabled.GetValueInt())
    endEvent
    
    event OnHighlightST()
        SetInfoText("Enables or disables baby growth into adult followers\nAdult followers can be summoned and dismissed from the MCM, then asked to follow")
    endEvent
endState

state LABOR_DURATION_SLIDER
    event OnSliderOpenST()
        SetSliderDialogStartValue(LaborDuration.GetValueInt())
        SetSliderDialogRange(1, 365)
        SetSliderDialogInterval(1)
    endEvent
    
    event OnSliderAcceptST(float value)
        LaborDuration.SetValueInt(value as int)
        SetSliderOptionValueST(value as int, "{0}s")
    endEvent
    
    event OnHighlightST()
        SetInfoText("Specifies the time it takes for labor to complete\nWarning: A player giving birth will lose control during this time")
    endEvent
endState

state BIRTH_BABY_DURATION_SLIDER
    event OnSliderOpenST()
        SetSliderDialogStartValue(BabyDuration.GetValueInt())
        SetSliderDialogRange(1, 365)
        SetSliderDialogInterval(1)
    endEvent
    
    event OnSliderAcceptST(float value)
        BabyDuration.SetValueInt(value as int)
        SetSliderOptionValueST(value as int, "{0} day(s)")
    endEvent
    
    event OnHighlightST()
        SetInfoText("Specifies the time a baby takes to grow up (default: 10 days)")
    endEvent
endState

state SPOUSE_INSEMINATE_SLIDER
    event OnSliderOpenST()
        SetSliderDialogStartValue(SpouseInseminateChance.GetValueInt())
        SetSliderDialogRange(0, 100)
        SetSliderDialogInterval(1)
    endEvent
    
    event OnSliderAcceptST(float value)
        SpouseInseminateChance.SetValueInt(value as int)
        SetSliderOptionValueST(value as int, "{0}%")
    endEvent
    
    event OnHighlightST()
        SetInfoText("Specifies the probability of insemination when sleeping with a spouse (default: 100%)")
    endEvent
endState

state AUTO_INSEMINATE_TOGGLE
    event OnSelectST()
        if (AutoInseminateNpc.GetValueInt() == 0)
            AutoInseminateNpc.SetValueInt(1)
        else
            AutoInseminateNpc.SetValueInt(0)
        endIf
        
        SetToggleOptionValueST(AutoInseminateNpc.GetValueInt())
        ForcePageReset()
    endEvent
    
    event OnDefaultST()
        SetToggleOptionValueST(AutoInseminateNpc.GetValueInt())
    endEvent
    
    event OnHighlightST()
        SetInfoText("Enables or disables random insemination for NPCs\nIf disabled, automatic PC insemination is also disabled")
    endEvent
endState

state AUTO_INSEMINATE_PC_TOGGLE
    event OnSelectST()
        if (AutoInseminatePc.GetValueInt() == 0)
            AutoInseminatePc.SetValueInt(1)
        else
            AutoInseminatePc.SetValueInt(0)
        endIf
        
        SetToggleOptionValueST(AutoInseminatePc.GetValueInt())
    endEvent
    
    event OnDefaultST()
        SetToggleOptionValueST(AutoInseminatePc.GetValueInt())
    endEvent
    
    event OnHighlightST()
        SetInfoText("Enables or disables random insemination for the player\nIf male: the player can automatically inseminate NPCs\nIf female: the player can be automatically inseminated")
    endEvent
endState

state AUTO_INSEMINATE_PC_SLEEP_TOGGLE
    event OnSelectST()
        if (AutoInseminatePcSleep.GetValueInt() == 0)
            AutoInseminatePcSleep.SetValueInt(1)
        else
            AutoInseminatePcSleep.SetValueInt(0)
        endIf
        
        SetToggleOptionValueST(AutoInseminatePcSleep.GetValueInt())
    endEvent
    
    event OnDefaultST()
        SetToggleOptionValueST(AutoInseminatePcSleep.GetValueInt())
    endEvent
    
    event OnHighlightST()
        SetInfoText("Limits automatic insemination when the player is involved to sleep events only")
    endEvent
endState

state AUTO_INSEMINATE_CHANCE_SLIDER
    event OnSliderOpenST()
        SetSliderDialogStartValue(AutoInseminateChance.GetValueInt())
        SetSliderDialogRange(0, 100)
        SetSliderDialogInterval(1)
    endEvent
    
    event OnSliderAcceptST(float value)
        AutoInseminateChance.SetValueInt(value as int)
        SetSliderOptionValueST(value as int, "{0}%")
    endEvent

    event OnHighlightST()
        SetInfoText("Specifies the probability of random insemination during polls (default: 5%)")
    endEvent
endState

state PLAYER_ONLY_FILTER_MENU
    event OnMenuOpenST()
        SetMenuDialogOptions(_trackingFilter)
        SetMenuDialogStartIndex(_trackingFilterIndex)
        SetMenuDialogDefaultIndex(0)
    endEvent
    
    event OnMenuAcceptST(int index)
        _trackingFilterIndex = index
        _trackingFilterPage = 0
        SetMenuOptionValueST(_trackingFilter[index])
        ForcePageReset()
    endEvent
    
    event OnHighlightST()
        ; 0: All Unique
        ; 1: All Non-Unique
        ; 2: Ovulating
        ; 3: Pregnant
        ; 4: Player Only
        if (_trackingFilterIndex == 0)
            SetInfoText("Filters the tracking list to all unique actors")
        elseIf (_trackingFilterIndex == 1)
        	SetInfoText("Filters the tracking list to all actors including non-uniques")
        elseIf (_trackingFilterIndex == 2)
            SetInfoText("Filters the tracking list to ovulating actors")
        elseIf (_trackingFilterIndex == 3)
            SetInfoText("Filters the tracking list to pregnant actors")
        elseIf (_trackingFilterIndex == 4)
        	SetInfoText("Filters the tracking list to those where the player is involved in the relationship")
        endIf
    endEvent
endState

state TRACKING_PREV_PAGE
	event OnSelectST()
		_trackingFilterPage -= 1
        ForcePageReset()
    endEvent
    
    event OnHighlightST()
        SetInfoText("View the previous page of tracked actors")
    endEvent
endState

state TRACKING_NEXT_PAGE
	event OnSelectST()
		_trackingFilterPage += 1
        ForcePageReset()
    endEvent
    
    event OnHighlightST()
        SetInfoText("View the next page of tracked actors")
    endEvent
endState

state TRAINING_PREV_PAGE
	event OnSelectST()
		_trainingFilterPage -= 1
        ForcePageReset()
    endEvent
    
    event OnHighlightST()
        SetInfoText("View the previous page of trained children")
    endEvent
endState

state TRAINING_NEXT_PAGE
	event OnSelectST()
		_trainingFilterPage += 1
        ForcePageReset()
    endEvent
    
    event OnHighlightST()
        SetInfoText("View the next page of trained children")
    endEvent
endState

state DEBUG_CLEAR_TRACKING
    event OnSelectST()
        int i = Storage.TrackedActors.Length
        
        while (i)
            i -= 1
            Storage.TrackedActorRemove(i)
        endWhile
        
        i = Storage.TrackedFathers.Length
        
        while (i)
            i -= 1
            Storage.TrackedFatherRemove(i)
        endWhile
        
        Handler.Util.AddActor(PlayerRef) ; Attempt to track the player
        Handler.UpdateStatusAll(false) ; Force an out of band update for widgets and morphs
        
        ForcePageReset()
    endEvent
    
    event OnHighlightST()
        SetInfoText("Removes all tracked actors and resets the player (if female)")
    endEvent
endState

state DEBUG_CLEAR_NPC_TRACKING
    event OnSelectST()
        int i = Storage.TrackedActors.Length
        
        while (i)
            i -= 1
            
            if (Storage.TrackedActors[i] != PlayerRef)
                Storage.TrackedActorRemove(i)
            endIf
        endWhile
        
        i = Storage.TrackedFathers.Length
        
        while (i)
            i -= 1
            Storage.TrackedFatherRemove(i)
        endWhile
        
        Handler.UpdateStatusAll(false) ; Force an out of band update for widgets and morphs
        
        ForcePageReset()
    endEvent
    
    event OnHighlightST()
        SetInfoText("Removes all tracked actors and without resetting the player (if female)")
    endEvent
endState

state PLAYER_ADD_SPERM
    event OnSelectST()
        int index = Storage.TrackedActors.Find(PlayerRef)
        int spermCount = Utility.RandomInt(0, 300)
        
        Storage.LastInsemination[index] = Utility.GetCurrentGameTime()
        
        if (Storage.CurrentFather[index] == "")
        	Storage.CurrentFather[index] = "Unknown"
        endIf
        
        Storage.SpermCount[index] = Storage.SpermCount[index] + spermCount
        
        WidgetCycle.UpdateContent()

        ForcePageReset()
    endEvent
    
    event OnHighlightST()
        SetInfoText("Adds sperm to the player")
    endEvent
endState

state PLAYER_OVULATE
    event OnSelectST()
        int index = Storage.TrackedActors.Find(PlayerRef)
        
        Storage.LastOvulation[index] = 0.001
        WidgetCycle.UpdateContent()

        ForcePageReset()
    endEvent
    
    event OnHighlightST()
        SetInfoText("Forces the player to ovulate if not currently menstruating")
    endEvent
endState

state PLAYER_REMOVE_SPERM
    event OnSelectST()
        int index = Storage.TrackedActors.Find(PlayerRef)
        
        Storage.LastInsemination[index] = 0.0
        Storage.SpermCount[index] = 0.0
        Storage.CurrentFather[index] = ""
        WidgetCycle.UpdateContent()

        ForcePageReset()
    endEvent
    
    event OnHighlightST()
        SetInfoText("Removes all sperm from the player")
    endEvent
endState

state PLAYER_IMPREGNATE
    event OnSelectST()
        int index = Storage.TrackedActors.Find(PlayerRef)
        
        Storage.LastInsemination[index] = 0.0
        Storage.SpermCount[index] = 0.0
        Storage.LastConception[index] = Utility.GetCurrentGameTime()
        Storage.LastBirth[index] = 0.0
        
        if (Storage.CurrentFather[index] == "")
        	Storage.CurrentFather[index] = "Unknown"
        endIf
        
        Storage.BabyHealth = 100
        Storage.LastSleep = Utility.GetCurrentGameTime()
        WidgetCycle.UpdateContent()

        ForcePageReset()
    endEvent
    
    event OnHighlightST()
        SetInfoText("Makes the player pregnant")
    endEvent
endState

state PLAYER_BIRTH
    event OnSelectST()
        int index = Storage.TrackedActors.Find(PlayerRef)
        
        Handler.GiveBirth(PlayerRef, index)
        Util.ClearBellyBreastScale(PlayerRef)
        Storage.LastConception[index] = 0.0
        Storage.LastBirth[index] = Utility.GetCurrentGameTime()
        Storage.LastFather[index] = Storage.CurrentFather[index]
        Storage.CurrentFather[index] = ""
        WidgetCycle.UpdateContent()

        ForcePageReset()
    endEvent
    
    event OnHighlightST()
        SetInfoText("Forces the player to give birth")
    endEvent
endState

state PLAYER_ABORT
    event OnSelectST()
        int index = Storage.TrackedActors.Find(PlayerRef)
        
        Util.ClearBellyBreastScale(PlayerRef)
        Storage.LastConception[index] = 0.0
        Storage.LastBirth[index] = 0.0
        Storage.LastFather[index] = ""
        Storage.CurrentFather[index] = ""
        Storage.BabyHealth = 100
        WidgetCycle.UpdateContent()

        ForcePageReset()
    endEvent
    
    event OnHighlightST()
        SetInfoText("Aborts the player's pregnancy")
    endEvent
endState

state PLAYER_GROWTH
    event OnSelectST()
    	int n = Storage.BirthBabyRace.Length
    	Armor baby = none
        
        while (n)
	        n -= 1
	        
	        if (PlayerRef.GetItemCount(Storage.BirthBabyRace[n]) > 0)
	            baby = Storage.BirthBabyRace[n]
	        endIf
    	endWhile
	    
        int index = Storage.TrackedActors.Find(PlayerRef)
		Actor child = Util.TrySpawnChildAdopt(PlayerRef)
        
        if (child)
            PlayerRef.RemoveItem(baby, 1)
            Storage.LastFather[index] = ""
            Storage.BabyAdded[index] = 0.0
            Storage.BabyHealth = 100
            Util.RenameChild(child)
        endIf
        
        ForcePageReset()
    endEvent
    
    event OnHighlightST()
        SetInfoText("Forces baby growth into a child actor")
    endEvent
endState

state SPAWN_CHILD_PLAYER_MALE
    event OnSelectST()
        int raceIndex
		
		if (BirthRace.GetValueInt() != 3)
		    raceIndex = Storage.BirthMotherRace.Find(PlayerRef.GetLeveledActorBase().GetRace())
	    else
	    	raceIndex = BirthRaceSpecific.GetValueInt()
	    endIf
        
        if (raceIndex != -1)
            ActorBase childBase = Storage.Children[2 * raceIndex]
            
            ; Match hair color to the parent
            childBase.SetHairColor(PlayerRef.GetActorBase().GetHairColor())
            
            Actor child = PlayerRef.PlaceActorAtMe(childBase) as Actor
            
            child.EvaluatePackage()
            child.MoveToPackageLocation()
            
            ShowMessage("Spawn completed")
        else
            ShowMessage("Unable to spawn. Unsupported mother race")
        endIf
    endEvent

    event OnHighlightST()
        SetInfoText("Spawn a male child matching the player's race")
    endEvent
endState

state SPAWN_CHILD_PLAYER_FEMALE
    event OnSelectST()
        int raceIndex
		
		if (BirthRace.GetValueInt() != 3)
		    raceIndex = Storage.BirthMotherRace.Find(PlayerRef.GetLeveledActorBase().GetRace())
	    else
	    	raceIndex = BirthRaceSpecific.GetValueInt()
	    endIf
        
        if (raceIndex != -1)
            ActorBase childBase = Storage.Children[2 * raceIndex + 1]
            
            ; Match hair color to the parent
            childBase.SetHairColor(PlayerRef.GetActorBase().GetHairColor())
            
            Actor child = PlayerRef.PlaceActorAtMe(childBase) as Actor
            
            child.EvaluatePackage()
            child.MoveToPackageLocation()
            
            ShowMessage("Spawn completed")
        else
            ShowMessage("Unable to spawn. Unsupported mother race")
        endIf
    endEvent

    event OnHighlightST()
        SetInfoText("Spawn a female child matching the player's race")
    endEvent
endState

state SPAWN_CHILD_PLAYER_ALL
    event OnSelectST()
        int n = Storage.Children.Length
        
        while (n)
            n -= 1
            PlayerRef.PlaceActorAtMe(Storage.Children[n])
        endWhile
        
        ShowMessage("Spawn completed")
    endEvent

    event OnHighlightST()
        SetInfoText("Spawns all supported child NPC races and sexes\nRecommended ONLY for development purposes")
    endEvent
endState

state RENAME_CHILD_PLAYER
    event OnSelectST()
        Actor kActor = Game.GetCurrentCrosshairRef() as Actor
        
        Util.RenameChild(kActor)
        
        ShowMessage("Naming completed")
    endEvent

    event OnHighlightST()
        SetInfoText("Rename the selected child")
    endEvent
endState

state DESPAWN_CHILD_PLAYER
    event OnSelectST()
        Actor kActor = Game.GetCurrentCrosshairRef() as Actor
        
        kActor.Disable()
        kActor.Delete()
        
        ShowMessage("Despawn completed")
    endEvent

    event OnHighlightST()
        SetInfoText("Despawn the selected child")
    endEvent
endState

state ADOPT_CHILD_PLAYER
    event OnSelectST()
        Actor kActor = Game.GetCurrentCrosshairRef() as Actor
        string result = Util.TryAdoptChildMcm(kActor)
        
        ShowMessage(result)
    endEvent

    event OnHighlightST()
        SetInfoText("Adopt the selected spawned child")
    endEvent
endState

state NPC_TRACK
    event OnSelectST()
        Actor kActor = Game.GetCurrentCrosshairRef() as Actor
        
        Util.AddActor(kActor)
        ForcePageReset()
    endEvent
    
    event OnHighlightST()
        SetInfoText("Adds the target actor to the tracking list")
    endEvent
endState

state NPC_BLOCK
    event OnSelectST()
        Actor kActor = Game.GetCurrentCrosshairRef() as Actor
        
        Storage.TrackedActorBlock(kActor)
        ForcePageReset()
    endEvent
    
    event OnHighlightST()
        SetInfoText("Blocks the target actor from tracking updates")
    endEvent
endState

state NPC_UNBLOCK
    event OnSelectST()
        Actor kActor = Game.GetCurrentCrosshairRef() as Actor
        
        Storage.TrackedActorUnblock(kActor)
        ForcePageReset()
    endEvent
    
    event OnHighlightST()
        SetInfoText("Restores the target actor's tracking updates")
    endEvent
endState

state NPC_OVULATE
    event OnSelectST()
        Actor kActor = Game.GetCurrentCrosshairRef() as Actor
        int index = Storage.TrackedActors.Find(kActor)
        
        Storage.LastOvulation[index] = 0.001
        WidgetCycle.UpdateContent()

        ForcePageReset()
    endEvent
    
    event OnHighlightST()
        SetInfoText("Forces the target actor to ovulate if not currently menstruating")
    endEvent
endState

state NPC_ADD_SPERM
    event OnSelectST()
        Actor kActor = Game.GetCurrentCrosshairRef() as Actor
        int index = Storage.TrackedActors.Find(kActor)
        int spermCount = Utility.RandomInt(0, 300)
        
        Storage.LastInsemination[index] = Utility.GetCurrentGameTime()
        
        if (Storage.TrackedActors.Find(PlayerRef) == -1)
        	; The player is male, force him to be the father
        	Storage.CurrentFather[index] = PlayerRef.GetDisplayName()
        elseIf (Storage.CurrentFather[index] == "")
        	; The player is female, use an existing father or set to unknown if there isn't an existing father
        	Storage.CurrentFather[index] = "Unknown"
        endIf
        
        Storage.SpermCount[index] = Storage.SpermCount[index] + spermCount

        ForcePageReset()
    endEvent
    
    event OnHighlightST()
        SetInfoText("Adds sperm to the target actor")
    endEvent
endState

state NPC_REMOVE_SPERM
    event OnSelectST()
        Actor kActor = Game.GetCurrentCrosshairRef() as Actor
        int index = Storage.TrackedActors.Find(kActor)
        
        Storage.LastInsemination[index] = 0.0
        Storage.SpermCount[index] = 0.0
        Storage.CurrentFather[index] = ""

        ForcePageReset()
    endEvent
    
    event OnHighlightST()
        SetInfoText("Removes all sperm from the target actor")
    endEvent
endState

state NPC_IMPREGNATE
    event OnSelectST()
        Actor kActor = Game.GetCurrentCrosshairRef() as Actor
        int index = Storage.TrackedActors.Find(kActor)
        
        Storage.LastInsemination[index] = 0.0
        Storage.SpermCount[index] = 0.0
        Storage.LastConception[index] = Utility.GetCurrentGameTime()
        Storage.LastBirth[index] = 0.0
        
        if (Storage.TrackedActors.Find(PlayerRef) == -1)
        	; The player is male, force him to be the father
        	Storage.CurrentFather[index] = PlayerRef.GetDisplayName()
        elseIf (Storage.CurrentFather[index] == "")
        	; The player is female, use an existing father or set to unknown if there isn't an existing father
        	Storage.CurrentFather[index] = "Unknown"
        endIf

        ForcePageReset()
    endEvent
    
    event OnHighlightST()
        SetInfoText("Makes the target actor pregnant")
    endEvent
endState

state NPC_BIRTH
    event OnSelectST()
        Actor kActor = Game.GetCurrentCrosshairRef() as Actor
        int index = Storage.TrackedActors.Find(kActor)
        
        Handler.GiveBirth(kActor, index)
        Util.ClearBellyBreastScale(kActor)
        Storage.LastConception[index] = 0.0
        Storage.LastBirth[index] = Utility.GetCurrentGameTime()
        Storage.LastFather[index] = Storage.CurrentFather[index]
        Storage.CurrentFather[index] = ""

        ForcePageReset()
    endEvent
    
    event OnHighlightST()
        SetInfoText("Forces the target actor to give birth")
    endEvent
endState

state NPC_ABORT
    event OnSelectST()
        Actor kActor = Game.GetCurrentCrosshairRef() as Actor
        int index = Storage.TrackedActors.Find(kActor)
        
        Util.ClearBellyBreastScale(kActor)
        Storage.LastConception[index] = 0.0
        Storage.LastBirth[index] = 0.0
        Storage.LastFather[index] = ""
        Storage.CurrentFather[index] = ""

        ForcePageReset()
    endEvent
    
    event OnHighlightST()
        SetInfoText("Aborts the target actor's pregnancy")
    endEvent
endState

state NPC_GROWTH
    event OnSelectST()
        Actor kActor = Game.GetCurrentCrosshairRef() as Actor
        
        int n = Storage.BirthBabyRace.Length
    	Armor baby = none
        
        while (n)
	        n -= 1
	        
	        if (kActor.GetItemCount(Storage.BirthBabyRace[n]) > 0)
	            baby = Storage.BirthBabyRace[n]
	        endIf
    	endWhile
    	
        int index = Storage.TrackedActors.Find(kActor)
		Actor child = Util.TrySpawnChildAdopt(kActor)
        
        if (child)
            kActor.RemoveItem(baby, 1)
            Storage.LastFather[index] = ""
            Storage.BabyAdded[index] = 0.0
            Storage.BabyHealth = 100
            Util.RenameChild(child)
        endIf
        
        ForcePageReset()
    endEvent
    
    event OnHighlightST()
        SetInfoText("Forces baby growth into a child actor")
    endEvent
endState

state INSEMINATE_SPELL_TOGGLE
    event OnSelectST()
        if (InseminateSpellAdded.GetValueInt() == 0)
            InseminateSpellAdded.SetValueInt(1)
            PlayerRef.AddSpell(InseminateSpell)
        else
            InseminateSpellAdded.SetValueInt(0)
            PlayerRef.RemoveSpell(InseminateSpell)
        endIf
        
        SetToggleOptionValueST(InseminateSpellAdded.GetValueInt())
        ForcePageReset()
    endEvent
    
    event OnDefaultST()
        SetToggleOptionValueST(InseminateSpellAdded.GetValueInt())
    endEvent
    
    event OnHighlightST()
        SetInfoText("Toggles a spell that inseminates the target")
    endEvent
endState

state IMPREGNATE_SPELL_TOGGLE
    event OnSelectST()
        if (ImpregnateSpellAdded.GetValueInt() == 0)
            ImpregnateSpellAdded.SetValueInt(1)
            PlayerRef.AddSpell(ImpregnateSpell)
        else
            ImpregnateSpellAdded.SetValueInt(0)
            PlayerRef.RemoveSpell(ImpregnateSpell)
        endIf
        
        SetToggleOptionValueST(ImpregnateSpellAdded.GetValueInt())
        ForcePageReset()
    endEvent
    
    event OnDefaultST()
        SetToggleOptionValueST(ImpregnateSpellAdded.GetValueInt())
    endEvent
    
    event OnHighlightST()
        SetInfoText("Toggles a spell that impregnates the target")
    endEvent
endState

state BIRTH_SPELL_TOGGLE
    event OnSelectST()
        if (BirthSpellAdded.GetValueInt() == 0)
            BirthSpellAdded.SetValueInt(1)
            PlayerRef.AddSpell(BirthSpell)
        else
            BirthSpellAdded.SetValueInt(0)
            PlayerRef.RemoveSpell(BirthSpell)
        endIf
        
        SetToggleOptionValueST(BirthSpellAdded.GetValueInt())
        ForcePageReset()
    endEvent
    
    event OnDefaultST()
        SetToggleOptionValueST(BirthSpellAdded.GetValueInt())
    endEvent
    
    event OnHighlightST()
        SetInfoText("Toggles a spell that induces the pregnant target to give birth")
    endEvent
endState

state ABORT_SPELL_TOGGLE
    event OnSelectST()
        if (AbortSpellAdded.GetValueInt() == 0)
            AbortSpellAdded.SetValueInt(1)
            PlayerRef.AddSpell(AbortSpell)
        else
            AbortSpellAdded.SetValueInt(0)
            PlayerRef.RemoveSpell(AbortSpell)
        endIf
        
        SetToggleOptionValueST(AbortSpellAdded.GetValueInt())
        ForcePageReset()
    endEvent
    
    event OnDefaultST()
        SetToggleOptionValueST(AbortSpellAdded.GetValueInt())
    endEvent
    
    event OnHighlightST()
        SetInfoText("Toggles a spell that induces the pregnant target to abort")
    endEvent
endState