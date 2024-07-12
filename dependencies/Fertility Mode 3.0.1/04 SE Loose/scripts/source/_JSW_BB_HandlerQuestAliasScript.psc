Scriptname _JSW_BB_HandlerQuestAliasScript extends ReferenceAlias

Actor Property PlayerRef  Auto                          ; Reference to the player. Game.GetPlayer() is slow

_JSW_BB_Utility Property Util  Auto                     ; Independent helper functions
_JSW_BB_Storage Property Storage  Auto                  ; Storage data helper
_JSW_BB_WidgetCycle Property WidgetCycle  Auto          ; The female player widget for cycles and pregnancy

GlobalVariable Property Enabled  Auto                   ; Whether the mod is actively running or not
GlobalVariable Property PollingInterval  Auto           ; How often we run the update loop
GlobalVariable Property VerboseMode  Auto               ; Show verbose notification messages
GlobalVariable Property PlayerOnly  Auto                ; Tracking only includes the player and relevant NPCs

GlobalVariable Property AutoInseminateNpc  Auto         ; Randomly tries to inseminate tracked actors
GlobalVariable Property AutoInseminatePc  Auto          ; Includes the player in random insemination
GlobalVariable Property AutoInseminatePcSleep  Auto     ; Limits PC automatic insemination to sleep events only
GlobalVariable Property AutoInseminateChance  Auto      ; Probability of random insemination (eg. 20%)
GlobalVariable Property SpouseInseminateChance  Auto    ; Probability of insemination when sleeping with a spouse
GlobalVariable Property SpermLife  Auto                 ; Time before sperm is removed, eg. 5 days
GlobalVariable Property AllowCreatures  Auto            ; Allow insemination from creatures

GlobalVariable Property PregnancyDuration  Auto         ; Full duration of a pregnancy, eg. 30 days
GlobalVariable Property RecoveryDuration  Auto          ; Full duration of recovery from a pregnancy before becoming fertile, eg. 10 days
GlobalVariable Property CycleDuration  Auto             ; Full duration of the menstrual cycle, eg. 28 days
GlobalVariable Property MenstruationBegin  Auto         ; Starting day of menstruation, eg. day 0
GlobalVariable Property MenstruationEnd  Auto           ; Ending day of menstruation, eg. day 7
GlobalVariable Property OvulationBegin  Auto            ; Starting day of ovulation, eg. day 8
GlobalVariable Property OvulationEnd  Auto              ; Ending day of ovulation, eg. day 16

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

Keyword Property ActorTypeCreature  Auto                ; Keyword for identifying creature types

Idle Property IdleBirth  Auto                           ; Idle animation for labor (IdleCowering)
Idle Property IdleStop_Loose  Auto                      ; Termination stage for the idle animation

LeveledItem Property LeveledList  Auto                  ; Supported leveled list for potions

Potion Property PotionAbort  Auto                       ; Potion object for inducing abortion
Potion Property PotionWashout  Auto                     ; Potion object for removing sperm
Potion Property PotionFertility  Auto                   ; Potion object for inducing increased fertility
Potion Property PotionContraception  Auto               ; Potion object for inducing reduced fertility
Potion Property BreastMilk  Auto                        ; "Jug of Milk"

Armor Property BabyDefault  Auto                        ; The "default" human baby item
SoulGem Property BabyGem  Auto                          ; Filled black soul gem

Quest Property MQ101  Auto                              ; The "Unbound" tutorial quest

Message Property InitMessage  Auto                      ; Introduction and enabling message after "Unbound" is complete
Message Property AbortMessage  Auto                     ; Notification when a pregnancy is aborted

ReferenceAlias Property LoveInterest  Auto              ; The actor reference of the player's spouse

Sound[] Property LaborSound  Auto
Sound[] Property BabyCry  Auto
Sound[] Property BabyGiggle  Auto
Sound[] Property BabyAmused  Auto
Sound[] Property BabyLaugh  Auto
Sound[] Property BabySneeze  Auto

bool _initMessageShown = false                          ; Flag for ensuring the init message is only displayed once
bool _newDay = false                                    ; Flag for when the game day rolls over
int _lastDay = -1                                       ; Storage for the last recorded day

; Change these variables at your own risk; you have been warned.
int _weatherPleasant = 0 ; const
int _weatherCloudy = 1 ; const
int _weatherRainy = 2 ; const
int _weatherSnow = 3 ; const

; Event lock codes
int _eventNone = 0
int _eventLabor = 1
int _eventSpawn = 2

event OnInit()
{Perform initialization on a new game}
    Storage.UpdateStorage()
    
    Util.AddActor(PlayerRef) ; Try to automatically track the player

    ; Apply event registrations
    RegisterForMenu("RaceSex Menu")
    RegisterForSleep()
    RegisterForKey(WidgetHotKey.GetValueInt())
    RegisterForModEvent("OrgasmStart", "OnSexLabOrgasm")
    RegisterForModEvent("SexLabOrgasmSeparate", "OnSexLabOrgasmSeparate")
    RegisterForModEvent("FertilityModeModSperm", "OnFertilityModeModSperm")
    RegisterForModEvent("FertilityModeAddSperm", "OnFertilityModeAddSperm")
    RegisterForModEvent("FertilityModeImpregnate", "OnFertilityModeImpregnate")
    RegisterForModEvent("FertilityModeLabor", "OnFertilityModeLabor")
    RegisterForModEvent("FertilityModeConception", "OnFertilityModeConception")
    
    UpdateLeveledLists()
    
    if (Enabled.GetValueInt())
        ; Ensure scaling is properly applied immediately on load
        UpdateStatusAll(false)
    endIf
    
    RegisterForSingleUpdateGameTime(0.1)
endEvent

event OnPlayerLoadGame()
{Perform initialization on game load}
    Storage.UpdateStorage()
    
    Util.AddActor(PlayerRef) ; Try to automatically track the player
    
    ; Apply event registrations
    RegisterForMenu("RaceSex Menu")
    RegisterForSleep()
    RegisterForKey(WidgetHotKey.GetValueInt())
    RegisterForModEvent("OrgasmStart", "OnSexLabOrgasm")
    RegisterForModEvent("SexLabOrgasmSeparate", "OnSexLabOrgasmSeparate")
    RegisterForModEvent("FertilityModeModSperm", "OnFertilityModeModSperm")
    RegisterForModEvent("FertilityModeAddSperm", "OnFertilityModeAddSperm")
    RegisterForModEvent("FertilityModeImpregnate", "OnFertilityModeImpregnate")
    RegisterForModEvent("FertilityModeLabor", "OnFertilityModeLabor")
    RegisterForModEvent("FertilityModeConception", "OnFertilityModeConception")
    
    UpdateLeveledLists()
    
    if (Enabled.GetValueInt())
        ; Ensure scaling is properly applied immediately on load
        UpdateStatusAll(false)
    endIf
    
    RegisterForSingleUpdateGameTime(0.1)
endEvent

event OnUpdateGameTime()
{Timed cycle update loop}
	int today = Utility.GetCurrentGameTime() as int
    float start = Utility.GetCurrentRealTime()
    
    if (today > _lastDay)
    	_newDay = true
    	_lastDay = today
    else
    	_newDay = false
    endIf
    
    if (!Enabled.GetValueInt() && !_initMessageShown)
        if (MQ101.GetStage() >= 900 && Game.IsFightingControlsEnabled())
            ; Wait until Unbound is largely completed manually or through alternate starts
            ; because that quest is script heavy and could break with more lag. We also 
            ; don't care to track the majority of NPCs from that quest who will be dead 
            ; before it completes.
            int result = InitMessage.Show()
            
            if (result == 0)
                Enabled.SetValueInt(1)
            endIf
            
            _initMessageShown = true
        endIf
    endIf
    
    if (Enabled.GetValueInt())
        UpdateStatusAll()
    endIf
    
    if (VerboseMode.GetValueInt())
        Debug.Notification("Fertility Mode Update Time: " + (Utility.GetCurrentRealTime() - start) + "s")
    endIf
    
    ; Regardless of being enabled or not, we still poll and act 
    ; accordingly, for simplicity. The script engine hit is negligible
    RegisterForSingleUpdateGameTime(PollingInterval.GetValue())
endEvent

event OnLocationChange(Location akOldLoc, Location akNewLoc)
{Run out of band updates when the player zones; used for enforcing current belly/breast scales}
    if (!Enabled.GetValueInt())
        return
    endIf
    
    UpdateStatusAll(false)
endEvent

event OnMenuClose(string menuName)
{Update tracking status after showracemenu is closed}
    if (menuName == "RaceSex Menu")
        int sex = Util.GetActorGender(PlayerRef)
        
        if (sex == 0)
            int index = Storage.TrackedActors.Find(PlayerRef)
            
            if (index != -1)
                Storage.TrackedActorRemove(index)
            endIf
            
			; Sex changed to male            
            Storage.TrackedFatherAdd(PlayerRef)
            
            if (VerboseMode.GetValueInt())
                Debug.Notification("Player base gender changed to male")
            endIf
        elseIf (sex == 1)
        	int index = Storage.TrackedFathers.Find(PlayerRef)
        	
        	if (index != -1)
        		Storage.TrackedFatherRemove(index)
        	endIf
        	
            ; Sex changed to female
            Storage.TrackedActorAdd(PlayerRef)
            
            if (VerboseMode.GetValueInt())
                Debug.Notification("Player base gender changed to female")
            endIf
        endIf
        
        if (Enabled.GetValueInt())
            ; Run a full update to ensure the player is completely
            ; tracked or untracked. A race change should be
            ; exceptionally rare, so it's reasonably safe.
            UpdateStatusAll()
        endIf
    endIf
endEvent

event OnSleepStop(bool abInterrupted)
{Add relevant sperm when sleeping, reset baby health when pregnant}
    if (!Enabled.GetValueInt())
        return
    endIf
    
    float now = Utility.GetCurrentGameTime()
    int index = Storage.TrackedActors.Find(PlayerRef)
    
    Storage.LastSleep = now
    
    if (index != -1 && Storage.LastConception[index] > 0.0)
        ; Sleeping restores the baby's health
        Storage.BabyHealth = 100
    endIf
    
    if (SpouseInseminateChance.GetValueInt() && Utility.RandomInt(1, 100) > SpouseInseminateChance.GetValueInt() && \
    	LoveInterest.GetActorRef() && LoveInterest.GetActorRef().GetCurrentLocation() == PlayerRef.GetCurrentLocation())
    	
        Actor spouse = LoveInterest.GetActorRef()
        int spouseSex = Util.GetActorGender(spouse)
        
        if (spouseSex == 0 && index != -1 && Storage.ActorBlackList.Find(PlayerRef) == -1)
            ; Spouse is male, we're female; add sperm to us
            
            if (Storage.LastConception[index] != 0.0)
                ; We're already pregnant
                return
            endIf
            
            Storage.LastInsemination[index] = now
            Storage.CurrentFather[index] = spouse.GetDisplayName()
            Storage.FatherRaceId[index] = spouse.GetRace().GetFormID()
            
            if (VerboseMode.GetValueInt())
                Debug.Notification(spouse.GetDisplayName() + " came inside " + PlayerRef.GetDisplayName())
            endIf
        elseIf (spouseSex == 1 && index == -1 && Storage.ActorBlackList.Find(spouse) == -1)
            ; Spouse is female, we're male; add sperm to them
            int indexSpouse = Storage.TrackedActors.Find(spouse)
            
            if (Storage.LastConception[index] != 0.0)
                ; Spouse is already pregnant
                return
            endIf
            
            Storage.LastInsemination[indexSpouse] = now
            Storage.CurrentFather[index] = PlayerRef.GetDisplayName()
            Storage.FatherRaceId[index] = PlayerRef.GetRace().GetFormID()
            
            if (VerboseMode.GetValueInt())
                Debug.Notification(PlayerRef.GetDisplayName() + " came inside " + spouse.GetDisplayName())
            endIf
        elseIf (spouseSex == 1 && index != -1)
            ; Both parties are female. Special case, inseminate one of them randomly
            if (Utility.RandomInt(1, 100) < 50 && Storage.ActorBlackList.Find(spouse) == -1)
                int indexSpouse = Storage.TrackedActors.Find(spouse)
                
                if (Storage.LastConception[index] != 0.0)
                    ; Spouse is already pregnant
                    return
                endIf
                
                Storage.LastInsemination[indexSpouse] = now
                Storage.CurrentFather[indexSpouse] = PlayerRef.GetDisplayName()
                Storage.FatherRaceId[index] = PlayerRef.GetRace().GetFormID()
                
                if (VerboseMode.GetValueInt())
                    Debug.Notification(PlayerRef.GetDisplayName() + " came inside " + spouse.GetDisplayName())
                endIf
            elseIf (Storage.ActorBlackList.Find(PlayerRef) == -1)
                if (Storage.LastConception[index] != 0.0)
                    ; We're already pregnant
                    return
                endIf
                
                Storage.LastInsemination[index] = now
                Storage.CurrentFather[index] = spouse.GetDisplayName()
                Storage.FatherRaceId[index] = spouse.GetRace().GetFormID()
                
                if (VerboseMode.GetValueInt())
                    Debug.Notification(spouse.GetDisplayName() + " came inside " + PlayerRef.GetDisplayName())
                endIf
            endIf
        endIf
    elseIf (AutoInseminatePc.GetValueInt() && AutoInseminatePcSleep.GetValueInt())
    	int spermChance = Utility.RandomInt(1, 100)
    	int spermCount = Utility.RandomInt(0, 300)
    	
    	if (spermChance <= AutoInseminateChance.GetValueInt())
	    	if (index != -1 && Storage.LastConception[index] == 0.0)
	    		; The player is female, identify men in the same cell for insemination
	    		int fatherIndex = FindRandomFather(index)
	        	Form father = none
	        	
	        	if (fatherIndex != -1)
	        		father = Storage.TrackedFathers[fatherIndex]
	        	endIf
	            
	            if (father && (AllowCreatures.GetValueInt() || !father.HasKeyword(ActorTypeCreature)))
	                if ((father as Actor).IsDead())
	                    ; The tracked father is dead, so we'll stop tracking them
	                    Storage.TrackedFatherRemove(fatherIndex)
		            else
						Storage.LastInsemination[index] = now
						
						if (Storage.SpermCount[index] <= spermCount)
							Storage.CurrentFather[index] = (father as Actor).GetDisplayName()
							Storage.FatherRaceId[index] = (father as Actor).GetRace().GetFormID()
						endIf
						
						Storage.SpermCount[index] = Storage.SpermCount[index] + spermCount
						
						if (VerboseMode.GetValueInt())
							Debug.Notification(PlayerRef.GetDisplayName() + " inseminated by " + (father as Actor).GetDisplayName() + "(" + spermCount + ")")
						endIf
					endIf
				endIf
			else
				; The player is male, identify women in the same cell for insemination
				int fatherIndex = Storage.TrackedFathers.Find(PlayerRef)
				
				if (fatherIndex != -1)
					int motherIndex = FindRandomMother(fatherIndex)
					
					if (motherIndex != -1)
						if ((Storage.TrackedActors[motherIndex] as Actor).IsDead())
		                    ; The tracked mother is dead, so we'll stop tracking them
		                    Storage.TrackedActorRemove(motherIndex)
			            else
							Storage.LastInsemination[motherIndex] = now
							
							if (Storage.SpermCount[motherIndex] <= spermCount)
								Storage.CurrentFather[motherIndex] = PlayerRef.GetDisplayName()
								Storage.FatherRaceId[motherIndex] = PlayerRef.GetRace().GetFormID()
							endIf
							
							Storage.SpermCount[motherIndex] = Storage.SpermCount[motherIndex] + spermCount
							
							if (VerboseMode.GetValueInt())
								Debug.Notification((Storage.TrackedActors[motherIndex] as Actor).GetDisplayName() + " inseminated by " + PlayerRef.GetDisplayName() + "(" + spermCount + ")")
							endIf
						endIf
					endIf
				endIf
			endIf
		endIf
    endIf
endEvent

event OnObjectEquipped(Form akBaseObject, ObjectReference akReference)
{Lazy version of potion consumption checks, because I want to limit the number of script files...}
    if (!Enabled.GetValueInt())
        return
    endIf
    
    int actorIndex = Storage.TrackedActors.Find(PlayerRef)
    
    if (akBaseObject as Potion && actorIndex != -1)
        if (akBaseObject == PotionAbort)
            Storage.LastConception[actorIndex] = 0.0
            WidgetCycle.UpdateContent()
        elseIf (akBaseObject == PotionWashout)
            Storage.LastInsemination[actorIndex] = 0.0
            Storage.SpermCount[actorIndex] = 0.0
            Storage.CurrentFather[actorIndex] = ""
            Storage.FatherRaceId[actorIndex] = -1
            WidgetCycle.UpdateContent()
        elseIf (akBaseObject == PotionFertility || akBaseObject == PotionContraception)
            WidgetCycle.UpdateContent()
        endIf
    endIf
endEvent

event OnKeyDown(int keyCode)
{Handles the status widget hotkey}
    if (!Enabled.GetValueInt())
        return
    endIf
    
    if (keyCode == WidgetHotKey.GetValueInt() && !Utility.IsInMenuMode())
        if (WidgetShown.GetValueInt())
            WidgetShown.SetValueInt(0)
        else
            WidgetShown.SetValueInt(1)
        endIf
        
        WidgetCycle.UpdateContent()
    endIf
endEvent

event OnSexLabOrgasm(string hookName, string argString, float argNum, Form sender)
{Catch relevant orgasm events from SexLab if it's installed}
    if (!Enabled.GetValueInt())
        return
    endIf
    
    if (Game.GetModByName("SLSO.esp") != 255)
        ; Defer to SexLab Separate Orgasm if installed to avoid double insemination
        return
    endIf
    
    Util.SexLabOrgasm(hookName, argString, argNum, sender)
    WidgetCycle.UpdateContent()
endEvent

event OnSexLabOrgasmSeparate(Form actorRef, int thread)
{Catch relevant orgasm events from SexLab Separate Orgasm if it's installed}
    if (!Enabled.GetValueInt())
        return
    endIf
    
    Util.SexLabSeparateOrgasm(actorRef, thread)
    WidgetCycle.UpdateContent()
endEvent

event OnFertilityModeModSperm(Form akTarget, int amount)
	if (!(akTarget as Actor))
		return
	endIf
	
	Actor kActor = akTarget as Actor
	
	if (!Enabled.GetValueInt())
        return
    else
        Util.AddActor(kActor)
        
        int index = Storage.TrackedActors.Find(kActor)
        
        if (index != -1)
            Storage.SpermCount[index] = Storage.SpermCount[index] + amount
            WidgetCycle.UpdateContent()
        endIf
    endIf
endEvent

event OnFertilityModeAddSperm(Form akTarget, string fatherName)
{Mod handler for external insemination requests}
    if (!(akTarget as Actor))
        return
    endIf
    
    Actor kActor = akTarget as Actor
    
    if (!Enabled.GetValueInt())
        return
    else
        Util.AddActor(kActor)
        
        int index = Storage.TrackedActors.Find(kActor)
        
        if (index != -1 && Storage.LastConception[index] == 0.0)
            Storage.LastInsemination[index] = Utility.GetCurrentGameTime()
            Storage.SpermCount[index] = Storage.SpermCount[index] + Utility.RandomInt(0, 300)
            Storage.CurrentFather[index] = fatherName
            WidgetCycle.UpdateContent()
        endIf
    endIf
endEvent

event OnFertilityModeImpregnate(Form akTarget, string fatherName)
{Mod handler for external impregnation requests}
    if (!(akTarget as Actor))
        return
    endIf
    
    Actor kActor = akTarget as Actor
    
    if (!Enabled.GetValueInt())
        return
    else
        Util.AddActor(kActor)
        
        int index = Storage.TrackedActors.Find(kActor)
        
        if (index != -1)
            Storage.LastConception[index] = Utility.GetCurrentGameTime()
            Storage.LastBirth[index] = 0.0
            Storage.CurrentFather[index] = fatherName
            WidgetCycle.UpdateContent()
        endIf
    endIf
endEvent

event OnFertilityModeLabor(string eventName, Form sender, int actorIndex)
{Threaded handler for labor/birth events}
    if (Storage.EventLock[actorIndex] != _eventNone)
        return
    endIf
    
    Storage.EventLock[actorIndex] = _eventLabor
    
    Storage.LastConception[actorIndex] = 0.0
    Storage.LastBirth[actorIndex] = Utility.GetCurrentGameTime()
    Storage.LastFather[actorIndex] = Storage.CurrentFather[actorIndex]
    Storage.CurrentFather[actorIndex] = ""
    
    ; Since we're performing wait calls, this process must be run as an event
    ; to avoid pausing the rest of the actor updates. An event ensures that
    ; labor runs in a threaded call queue rather than the main script thread
    Actor akActor = sender as Actor
    
    if (akActor == PlayerRef)
        if (LaborEnabled.GetValueInt())
            int cameraState = Game.GetCameraState()
            
            Game.DisablePlayerControls(false, false, false, false, false, true, true, true)
            Game.ForceThirdPerson()
            
            akActor.PlayIdle(IdleBirth)
            Utility.Wait(LaborDuration.GetValueInt())
            GiveBirth(akActor, actorIndex)
            akActor.PlayIdle(IdleStop_Loose)
            Utility.Wait(2)
            
            if (cameraState == 0)
                Game.ForceFirstPerson()
            endIf
            
            Game.EnablePlayerControls()
        else
            Util.FadeEffect()
            GiveBirth(akActor, actorIndex)
        endIf
    else
        if (LaborEnabled.GetValueInt())
            akActor.PlayIdle(IdleBirth)
            Utility.Wait(LaborDuration.GetValueInt())
            GiveBirth(akActor, actorIndex)
            akActor.PlayIdle(IdleStop_Loose)
            Utility.Wait(2)
        else
            GiveBirth(akActor, actorIndex)
        endIf
    endIf
    
    if (VerboseMode.GetValueInt())
        Debug.Notification(akActor.GetDisplayName() + " gave birth to " + Storage.LastFather[actorIndex] + "'s child")
    endIf
    
    Storage.EventLock[actorIndex] = _eventNone
endEvent

event OnFertilityModeConception(string eventName, Form akSender, string motherName, string fatherName, int iTrackingIndex)
{Stub for if I ever want to handle this event}
endEvent

function UpdateStatusAll(bool isRegularPoll = true)
{Check for new actors and update all current tracked actors}
	bool isPlayerFemale = (Util.GetActorGender(PlayerRef) == 1)
    Form[] actors = Util.GetAllCellActors()
    int n
    
    if (PlayerOnly.GetValueInt())
    	; Clear tracking lists of all actors not "related" to the player
    	if (isPlayerFemale)
    		n = Storage.TrackedActors.Length
    		
    		; Remove all women who are not the player
    		while (n)
    			n -= 1
    			
    			if (Storage.TrackedActors[n] != PlayerRef)
    				Storage.TrackedActorRemove(n)
    			endIf
    		endWhile
    		
    		; Father forms are only used for name and race at insemination time.
			; We can clear the list completely and let any potential new fathers
			; get a chance with the current cell scan.
    		Storage.TrackedFatherClear()
    	else
    		; The player is male
    		n = Storage.TrackedActors.Length
    		
    		while (n)
    			n -= 1
    			
    			; Remove women who are not currently inseminated or pregnant by the
    			; player, and women who have not previously had the player's child.
    			if (Storage.CurrentFather[n] != PlayerRef.GetDisplayName() && Storage.LastFather[n] != PlayerRef.GetDisplayName())
    				Storage.TrackedActorRemove(n)
    			endIf
    		endWhile
    		
    		; The player will be added back shortly
    		Storage.TrackedFatherClear()
    	endIf
    endIf
    
    if (AutoInseminateNpc.GetValueInt())
    	if (!PlayerOnly.GetValueInt() || isPlayerFemale)
	        n = actors.Length
	        
	        ; Add any new men to the father tracking list
	        while (n)
	            n -= 1
	            
	            if (Storage.TrackedFathers.Find(actors[n]) == -1)
	                Util.AddFather(actors[n] as Actor)
	            endIf
	            
	            if (Storage.TrackedFathers.Find(actors[n]) != -1)
	                Storage.LastFatherLocation[Storage.TrackedFathers.Find(actors[n])] = (actors[n] as Actor).GetCurrentLocation().GetName()
	            endIf
	        endWhile
	    elseIf (!isPlayerFemale)
	    	; Ensure the player is tracked as a valid father for automation
	    	Util.AddFather(PlayerRef)
        endIf
    endIf
    
    if (!PlayerOnly.GetValueInt() || !isPlayerFemale)
	    n = actors.Length
	    
	    ; Add any new women to the tracking list
	    while (n)
	        n -= 1
	        
	        if (Storage.TrackedActors.Find(actors[n]) == -1)
	            Util.AddActor(actors[n] as Actor)
	        endIf
	        
	        if (Storage.TrackedActors.Find(actors[n]) != -1)
	            Storage.LastMotherLocation[Storage.TrackedActors.Find(actors[n])] = (actors[n] as Actor).GetCurrentLocation().GetName()
	        endIf
	    endWhile
	endIf
	
	; Reset the insemination locks for a new polling cycle
	n = Storage.TrackedFathers.Length
	
	while (n)
		n -= 1
		Storage.FatherInseminationLock[n] = false
	endWhile

    int index = 0
    
    ; Update the status for all tracked actors. Run [0,n) so the player
    ; is always updated first for better widget perceived performance
    while (index < Storage.TrackedActors.Length)
        Actor trackedActor = Storage.TrackedActorGet(index)
        
        if (trackedActor != none && Storage.ActorBlackList.Find(trackedActor) == -1)
            UpdateStatusSingle(trackedActor, index, isRegularPoll)
        endIf
        
        index += 1
    endWhile
endFunction

function UpdateStatusSingle(Actor akActor, int actorIndex, bool isRegularPoll = true)
{Update the selected tracked actor}
    if (akActor.IsDead())
        ; The tracked actor is dead, so we'll stop tracking them
        Storage.TrackedActorRemove(actorIndex)
        return
    endIf
    
    float now = Utility.GetCurrentGameTime()
    
    if (isRegularPoll)
        int spermChance = Utility.RandomInt(1, 100)
        int birthDay = (now - Storage.LastBirth[actorIndex]) as int
        
        if (_newDay && Storage.LastBirth[actorIndex] != 0.0 && birthDay < RecoveryDuration.GetValueInt())
        	; Give the actor daily milk during recovery
        	if (akActor != PlayerRef)
        		akActor.AddItem(BreastMilk, 1, false)
        	else
        		akActor.AddItem(BreastMilk, 1, true)
        	endIf
        endIf
        
        if (Storage.LastBirth[actorIndex] == 0.0 || birthDay >= RecoveryDuration.GetValueInt())
            Util.UpdateOvulationStatus(akActor, actorIndex)
            
            ; Give sperm and egg a few hours to meet up
            if (Storage.LastInsemination[actorIndex] > 0.125 && Storage.LastOvulation[actorIndex] > 0.125)
                if (Util.IsConceptionPossible(akActor, actorIndex))
                    Storage.LastInsemination[actorIndex] = 0.0
                    Storage.SpermCount[actorIndex] = 0.0
                    Storage.LastConception[actorIndex] = now
                    
                    if (akActor == PlayerRef)
                        ; Safety op: Reset baby health metrics to 100% to avoid an immediate miscarriage
                        Storage.BabyHealth = 100
                        Storage.LastSleep = now
                    endIf
                    
                    if (VerboseMode.GetValueInt())
                        Debug.Notification(akActor.GetDisplayName() + " is pregnant with " + Storage.CurrentFather[actorIndex] + "'s child")
                    endIf
                    
                    Util.SendDetailedTrackingEvent("FertilityModeConception", akActor, akActor.GetDisplayName(), Storage.CurrentFather[actorIndex], actorIndex)
                endIf
            endIf
            
            ; Perform automation for new sperm if enabled
            if (Storage.LastConception[actorIndex] == 0.0 && spermChance <= AutoInseminateChance.GetValueInt())
                if (Storage.TrackedFathers.Length > 0 && akActor != LoveInterest.GetActorRef())
                	int fatherIndex = FindRandomFather(actorIndex)
                	Form father = none
                	
                	if (fatherIndex != -1)
                		father = Storage.TrackedFathers[fatherIndex]
                	endIf
                    
                    if (father && (AllowCreatures.GetValueInt() || !father.HasKeyword(ActorTypeCreature)))
                        if ((father as Actor).IsDead())
                            ; The tracked father is dead, so we'll stop tracking them
                            Storage.TrackedFatherRemove(fatherIndex)
                        elseIf (!Storage.FatherInseminationLock[fatherIndex])
                            int spermCount = Utility.RandomInt(0, 300)
                            
                            if (AutoInseminateNpc.GetValueInt() && akActor != PlayerRef)
                                if ((father != PlayerRef || (AutoInseminatePc.GetValueInt() && !AutoInseminatePcSleep.GetValueInt())))
                                    Storage.LastInsemination[actorIndex] = now
                                    
                                    if (Storage.SpermCount[actorIndex] <= spermCount)
                                        Storage.CurrentFather[actorIndex] = (father as Actor).GetDisplayName()
                                        Storage.FatherRaceId[actorIndex] = (father as Actor).GetRace().GetFormID()
                                    endIf
                                    
                                    Storage.SpermCount[actorIndex] = Storage.SpermCount[actorIndex] + spermCount
                                    Storage.FatherInseminationLock[fatherIndex] = true
                                    
                                    if (VerboseMode.GetValueInt())
                                        Debug.Notification(akActor.GetDisplayName() + " inseminated by " + (father as Actor).GetDisplayName() + "(" + spermCount + ")")
                                    endIf
                                endIf
                            elseIf (AutoInseminatePc.GetValueInt() && akActor == PlayerRef && !AutoInseminatePcSleep.GetValueInt())
                                Storage.LastInsemination[actorIndex] = now
                                
                                if (Storage.SpermCount[actorIndex] <= spermCount)
                                    Storage.CurrentFather[actorIndex] = (father as Actor).GetDisplayName()
                                    Storage.FatherRaceId[actorIndex] = (father as Actor).GetRace().GetFormID()
                                endIf
                                
                                Storage.SpermCount[actorIndex] = Storage.SpermCount[actorIndex] + spermCount
                                Storage.FatherInseminationLock[fatherIndex] = true
                                
                                if (VerboseMode.GetValueInt())
                                    Debug.Notification(akActor.GetDisplayName() + " inseminated by " + (father as Actor).GetDisplayName() + "(" + spermCount + ")")
                                endIf
                            endIf
                        endIf
                    endIf
                endIf
            endIf
            
            ; Update existing sperm
            if (Storage.LastInsemination[actorIndex] > 0.0)
                if ((now - Storage.LastInsemination[actorIndex] as int) >= SpermLife.GetValueInt() || Storage.SpermCount[actorIndex] <= 0.0)
                    Storage.LastInsemination[actorIndex] = 0.0
                    Storage.SpermCount[actorIndex] = 0.0
                    Storage.CurrentFather[actorIndex] = ""
                    Storage.FatherRaceId[actorIndex] = -1
                elseIf (Storage.SpermCount[actorIndex] > 0.0)
                    ; Arbitrary choice: reduce sperm every hour by a random amount in the range of [2M, 10M].
                    ; This ensures that the first partner is not guaranteed to be the father of a pregnancy
                    Storage.SpermCount[actorIndex] = Storage.SpermCount[actorIndex] - Utility.RandomInt(2, 10)
                    
                    if (Storage.SpermCount[actorIndex] < 0.0)
                        ; Negative sperm makes no sense
                        Storage.SpermCount[actorIndex] = 0.0
                    endIf
                endIf
            endIf
            
            ; Run the pregnancy update check last, just in case the actor conceived during the update
            if (Storage.LastConception[actorIndex] > 0.0)
                UpdatePregnancy(akActor, actorIndex)
            endIf
        endIf
        
        Storage.LastGameHours[actorIndex] = now
    endIf
    
    ; Avoid papyrus errors for tracked actors that aren't currently loaded
    if (akActor == PlayerRef || akActor.Is3DLoaded())
        ; Update belly/breast scaling
        Util.BellyBreastScale(akActor, actorIndex)
    endIf
    
    if (akActor == PlayerRef)
        WidgetCycle.UpdateContent()
    endIf
    
    ; Check for baby growth
    if (SpawnEnabled.GetValueInt() && Storage.BabyAdded[actorIndex] != 0.0)
        CheckBabyGrowth(akActor, actorIndex)
    endIf
    
    ; Check for baby sounds
    if (akActor == PlayerRef)
        bool hasBaby = false
        int n = Storage.BirthBabyRace.Length
        
        while (n)
            n -= 1
            
            if (akActor.GetItemCount(Storage.BirthBabyRace[n]) > 0)
                hasBaby = true
                n = 0
            endIf
        endWhile
        
        if (hasBaby)
            PlayBabySound(akActor)
        endIf
    endIf
endFunction

function UpdatePregnancy(Actor akActor, int actorIndex)
{Update or complete the current pregnancy}
    float now = Utility.GetCurrentGameTime()
    int pregnantDay = (now - Storage.LastConception[actorIndex]) as int
    int trimesterDuration = Math.Ceiling(PregnancyDuration.GetValueInt() / 3)
	
	if (pregnantDay >= trimesterDuration && pregnantDay < trimesterDuration * 2 && pregnantDay < PregnancyDuration.GetValueInt() - 1)
		; Second trimester, play limited kicks (5%)
		if (Utility.RandomInt(1, 100) <= 5)
			if (akActor == PlayerRef)
				Debug.Notification("You feel your baby kicking")
				Sound.SetInstanceVolume(LaborSound[0].Play(akActor), SoundVolume.GetValue())
			elseIf (akActor.GetCurrentLocation() == PlayerRef.GetCurrentLocation() && akActor.GetDistance(PlayerRef) <= 512.0)
				float distance = akActor.GetDistance(PlayerRef)
				float volume = ((SoundVolume.GetValue() / 2.0) - (distance / 1000.0))
				
				Debug.Notification("It sounds like " + akActor.GetDisplayName() + "'s baby is kicking")
				Sound.SetInstanceVolume(LaborSound[0].Play(akActor), volume)
			endIf
		endIf
	elseIf (pregnantDay >= trimesterDuration * 2 && pregnantDay < PregnancyDuration.GetValueInt() - 1)
		; Third trimester, play more frequent kicks (15%)
		if (Utility.RandomInt(1, 100) <= 15)
			if (akActor == PlayerRef)
				Debug.Notification("You feel your baby kicking")
				Sound.SetInstanceVolume(LaborSound[0].Play(akActor), SoundVolume.GetValue())
			elseIf (akActor.GetCurrentLocation() == PlayerRef.GetCurrentLocation() && akActor.GetDistance(PlayerRef) <= 512.0)
				float distance = akActor.GetDistance(PlayerRef)
				float volume = ((SoundVolume.GetValue() / 2.0) - (distance / 1000.0))
				
				Debug.Notification("It sounds like " + akActor.GetDisplayName() + "'s baby is kicking")
				Sound.SetInstanceVolume(LaborSound[0].Play(akActor), volume)
			endIf
		endIf
	endIf
    
    if (pregnantDay >= PregnancyDuration.GetValueInt())
    	if (VerboseMode.GetValueInt())
            Debug.Notification(akActor.GetDisplayName() + " is giving birth")
        endIf
        
        Util.SendTrackingEvent("FertilityModeLabor", akActor, actorIndex)
    elseIf (akActor == PlayerRef && MiscarriageEnabled.GetValueInt())
        int wakingDays = (now - Storage.LastSleep) as int
        
        if (wakingDays > 0)
            ; Reduce the baby's health by 1% every hour after one day without sleep. This
            ; means a miscarriage will occur about 4 hours into the 5th day after 
            ; conception and complete lack of sleep.
            Storage.BabyHealth -= 1
            
            if (Storage.BabyHealth <= 0)
                ; Remove all pregnancy metrics for an abortion/miscarriage
                Storage.LastConception[actorIndex] = 0.0
                Storage.LastBirth[actorIndex] = 0.0
                Storage.LastFather[actorIndex] = ""
                Storage.CurrentFather[actorIndex] = ""
                Storage.FatherRaceId[actorIndex] = -1
                Storage.BabyHealth = 100
                
                AbortMessage.Show()
            endIf
        endIf
    elseIf (akActor == PlayerRef && pregnantDay >= PregnancyDuration.GetValueInt() - 1)
        ; Play a random labor sound
        Sound.SetInstanceVolume(LaborSound[Utility.RandomInt(0, LaborSound.Length - 1)].Play(akActor), SoundVolume.GetValue())
    endIf
endFunction

function CheckBabyGrowth(Actor akActor, int actorIndex)
{Apply baby spawn or removal checks for the PC and NPCs}
    if (Storage.EventLock[actorIndex] != _eventNone)
        return
    endIf
    
    Storage.EventLock[actorIndex] = _eventSpawn
    
    float now = Utility.GetCurrentGameTime()
    int n = Storage.BirthBabyRace.Length
    Armor baby = none
    
    ; Potential bug: this algorithm finds the *last* baby item in the
    ; actor's inventory. If the actor was given or has stolen a baby
    ; then there could be an unexpected count and/or unexpected race
    while (n)
        n -= 1
        
        if (akActor.GetItemCount(Storage.BirthBabyRace[n]) > 0)
            baby = Storage.BirthBabyRace[n]
        endIf
    endWhile
    
    if (akActor == PlayerRef || Storage.LastFather[actorIndex] == PlayerRef.GetDisplayName() || akActor == LoveInterest.GetActorRef())
        ; Attempt to spawn one of the player's children
        if (baby && ((now - Storage.BabyAdded[actorIndex]) as int) >= BabyDuration.GetValueInt())
        	bool spawned = false
        	
        	if (AdoptionEnabled.GetValueInt())
        		Actor child = Util.TrySpawnChildAdopt(akActor)
	            
	            if (child)
	                akActor.RemoveItem(baby, 1)
	                Storage.LastFather[actorIndex] = ""
	                Storage.BabyAdded[actorIndex] = 0.0
	                Storage.BabyHealth = 100
	                Util.RenameChild(child)
	                spawned = true
	            endIf
			elseIf (!TrainingEnabled.GetValueInt())
				int gender = Utility.RandomInt(0, 1)
				int raceIndex = GetRaceIndex(akActor, actorIndex)
				ActorBase childBase = Storage.Children[2 * raceIndex + gender]
				
				; Match hair color to the parent
				childBase.SetHairColor(akActor.GetActorBase().GetHairColor())
				
				Actor child = PlayerRef.PlaceActorAtMe(childBase) as Actor
				
				Util.RenameChild(child)
				child.EvaluatePackage()
				child.MoveToPackageLocation()
				
				akActor.RemoveItem(baby, 1)
				Storage.LastFather[actorIndex] = ""
				Storage.BabyAdded[actorIndex] = 0.0
				Storage.BabyHealth = 100
				spawned = true
				
				Debug.Notification(child.GetDisplayName() + " fled to Whiterun")
        	endIf
        	
        	if (!spawned && TrainingEnabled.GetValueInt())
        		akActor.RemoveItem(baby, 1)
                Storage.LastFather[actorIndex] = ""
                Storage.BabyAdded[actorIndex] = 0.0
                Storage.BabyHealth = 100
                
			    string genderMsg = "son"
			    int gender = 0
			    
			    if (Utility.RandomInt(1, 100) < 50)
			        genderMsg = "daughter"
			        gender = 1
			    endIf
			    
			    string name = Util.GenerateName("Name your " + genderMsg)
			    
			    Storage.PlayerChildAdd(akActor, name, gender)
			    
			    Debug.Notification(name + " can now be summoned from the MCM")
        	endIf
        endIf
    elseIf (baby && ((now - Storage.BabyAdded[actorIndex]) as int) >= BabyDuration.GetValueInt())
        ; Simply remove the baby item for an unrelated child, the player can roleplay what actually happened. ;)
        akActor.RemoveItem(baby, 1)
        Storage.BabyAdded[actorIndex] = 0.0
    endIf
    
    Storage.EventLock[actorIndex] = _eventNone
endfunction

function PlayBabySound(Actor akActor)
{Conditionally play a baby sound in suitable situations}
    if (akActor.IsInCombat())
        return
    endIf
    
    Weather currentWeather = Weather.GetCurrentWeather()
    
    if (currentWeather == none || Utility.RandomInt(1, 100) > 30)
        return
    endIf
    
    int weatherClass = currentWeather.GetClassification()
    int r = Utility.RandomInt(1, 100)
    
    if (weatherClass == _weatherPleasant)
        ; 50% between laughing and giggling; there *is* a difference
        if (r < 50)
            Sound.SetInstanceVolume(BabyLaugh[Utility.RandomInt(0, BabyLaugh.Length - 1)].Play(akActor), SoundVolume.GetValue())
        else
            Sound.SetInstanceVolume(BabyGiggle[Utility.RandomInt(0, BabyGiggle.Length - 1)].Play(akActor), SoundVolume.GetValue())
        endIf
    elseIf (weatherClass == _weatherRainy)
        Sound.SetInstanceVolume(BabyCry[Utility.RandomInt(0, BabyCry.Length - 1)].Play(akActor), SoundVolume.GetValue())
    elseIf (weatherClass == _weatherSnow)
        ; 30% sneeze versus amusement at the snow
        if (r < 70)
            Sound.SetInstanceVolume(BabyAmused[Utility.RandomInt(0, BabyAmused.Length - 1)].Play(akActor), SoundVolume.GetValue())
        else
            Sound.SetInstanceVolume(BabySneeze[Utility.RandomInt(0, BabySneeze.Length - 1)].Play(akActor), SoundVolume.GetValue())
        endIf
    endIf
endFunction

function GiveBirth(Actor akActor, int actorIndex)
{Perform birth logic for the given actor}
    if (BirthType.GetValueInt() == 0)
        ; Do a whole lot of nothing, as stated in the MCM. :)
    elseIf (BirthType.GetValueInt() == 1)
        ; Add a filled black soul gem to the actor's inventory
        if (akActor != PlayerRef)
            akActor.AddItem(BabyGem, 1, true)
        else
            akActor.AddItem(BabyGem, 1, false)
        endIf
    elseIf (BirthType.GetValueInt() == 2)        
        int raceIndex = GetRaceIndex(akActor, actorIndex)
        Armor babyArmor = BabyDefault
        
        if (raceIndex != -1)
            babyArmor = Storage.BirthBabyRace[raceIndex]
        endIf
        
        if (akActor.GetItemCount(babyArmor) > 0)
            ; Limit the number of baby items for any actor to one. This
            ; ensures that we can better control child spawning in the
            ; average cases. Not perfect, but it *is* simple
        else
            if (akActor != PlayerRef)
                akActor.AddItem(babyArmor, 1, true)
                akActor.EquipItem(babyArmor, true, true)
            else
                akActor.AddItem(babyArmor, 1, false)
                akActor.EquipItem(babyArmor, false, false)
            endIf
            
            Storage.BabyAdded[actorIndex] = Utility.GetCurrentGameTime()
        endIf
    endIf
endFunction

int function FindRandomFather(int actorIndex)
{Attempt to identify a random father in the same cell as the tracked female actor with actorIndex}
	int n = Storage.TrackedFathers.Length
	int fatherIndex = -1
                    
    ; Identify a "random" potential father in the same location as the potential mother
    while (n)
        n -= 1
        
        if (Storage.LastFatherLocation[n] == Storage.LastMotherLocation[actorIndex])
            ; We found a possible match, initiate a random array selection
            if (fatherIndex == -1 || Utility.RandomInt(1, 100) < 50)
                fatherIndex = n
            endIf
        endIf
    endWhile
    
    return fatherIndex
endFunction

int function FindRandomMother(int actorIndex)
{Attempt to identify a random mother in the same cell as the tracked male actor with actorIndex}
	int n = Storage.TrackedActors.Length
	int motherIndex = -1
                    
    ; Identify a "random" potential mother in the same location as the potential father
    while (n)
        n -= 1
        
        if (Storage.LastFatherLocation[actorIndex] == Storage.LastMotherLocation[n])
            ; We found a possible match, initiate a random array selection
            if (motherIndex == -1 || Utility.RandomInt(1, 100) < 50)
                motherIndex = n
            endIf
        endIf
    endWhile
    
    return motherIndex
endFunction

int function GetRaceIndex(Actor akActor, int actorIndex)
{Retrieve the race index of the specified actor with given settings}
	int raceIndex = -1
        
    if (BirthRace.GetValueInt() == 0)
	    raceIndex = Storage.BirthMotherRace.Find(akActor.GetLeveledActorBase().GetRace())
	elseIf (BirthRace.GetValueInt() == 1)
		if (Storage.FatherRaceId[actorIndex] == -1)
			; Safety check for a missing father race, use the mother
			raceIndex = Storage.BirthMotherRace.Find(akActor.GetLeveledActorBase().GetRace())
		else
			raceIndex = Storage.BirthMotherRace.Find(Game.GetForm(Storage.FatherRaceId[actorIndex]) as Race)
		endIf
	elseIf (BirthRace.GetValueInt() == 2)
		if (Storage.FatherRaceId[actorIndex] == -1)
			; Safety check for a missing father race, use the mother
			raceIndex = Storage.BirthMotherRace.Find(akActor.GetLeveledActorBase().GetRace())
		elseIf (Utility.RandomInt(1, 100) < 50)
			raceIndex = Storage.BirthMotherRace.Find(akActor.GetLeveledActorBase().GetRace())
		else
			raceIndex = Storage.BirthMotherRace.Find(Game.GetForm(Storage.FatherRaceId[actorIndex]) as Race)
		endIf
    else
    	raceIndex = BirthRaceSpecific.GetValueInt()
    endIf
    
    return raceIndex
endFunction

function UpdateLeveledLists()
{Dynamically adds potions to specified leveled lists}
	LeveledList.AddForm(PotionAbort, 1, 1)
	LeveledList.AddForm(PotionWashout, 1, 1)
	LeveledList.AddForm(PotionFertility, 1, 1)
	LeveledList.AddForm(PotionContraception, 1, 1)
	
	Debug.Trace("Fertility Mode: Potions added to apothecary leveled list")
endFunction