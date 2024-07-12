ScriptName Apropos2TrackActorAlias Extends ReferenceAlias

Import Apropos2Util
Import ApUtil

String Property StoragePath = ".apropos2track" AutoReadOnly
String Property StoragePathTransient = ".apropos2track-transient" AutoReadOnly

Actor Property ActorRef Auto
Actor Property PlayerRef  Auto
Apropos2SystemConfig Property Config Auto
Apropos2Framework Property Framework Auto
Apropos2DescriptionDb Property Database Auto
Apropos2Descriptions Property Descriptions Auto
SexLabFramework Property SexLab Auto
slaUtilScr Property SlaUtil Auto

String[] areasOfInterest

Int _currentHour = 0
Float _lastGameTime = 0.0

Int _aproposId = -1

Int Property Id 
    Int Function get()
        Return _aproposId
    EndFunction
    Function set(Int new_value)
        _aproposId = new_value
    EndFunction
EndProperty

Actor Function GetActor()
    Return ActorRef
EndFunction

Auto State ReadyForTracking
    Event OnBeginState()
        If Config.TraceMessagesEnabled
            Log("ReadyForTracking.OnBeginState")
        EndIf
        ActorRef = none
        _currentHour = 0
        _lastGameTime = 0.0        
        Clear()
    EndEvent
    
    Event OnUpdate()
        ; catch any pending updates
    EndEvent

    Function Track(Actor anActor, Int actorSlot)
        If config.TraceMessagesEnabled
            LogActor(anActor, "Track(), slot=" + actorSlot)
        EndIf
        ForceRefTo(anActor)
        ActorRef = GetActorRef()
        Id = actorSlot
        GoToState("Tracking")
    EndFunction        
EndState

State Tracking
    Event OnBeginState()
        Debug("Tracking.OnBeginState")

        _lastGameTime = Utility.GetCurrentGameTime()
        RegisterForSingleUpdateGameTime(Config.FrequencyWearTearDegrade)
    EndEvent	

    Event OnUpdateGameTime()
        UnregisterForUpdateGameTime()

        If _lastGameTime == 0.0
            _lastGameTime  = Utility.GetCurrentGameTime()
        EndIf     

        Float currentTime = Utility.GetCurrentGameTime()
        Float hoursPassedFloat = (currentTime - _lastGameTime) * 24
        Int hoursPassed = hoursPassedFloat As Int

        If hoursPassed <= 0
            hoursPassed = 1
        EndIf

        ; Int timePeriodsPassed = hoursPassed / Config.FrequencyWearTearDegrade

        ; Log("hoursPassed=" + hoursPassed + ", periods=" + timePeriodsPassed)

        ; Int periodCount = 0
        ; Float chanceDegrade = Config.ChanceWTDegrade

        ; While periodCount < timePeriodsPassed
        ;     If Utility.RandomInt() <= chanceDegrade 
        ;         DegradeWearAndTear()
        ;     EndIf
        ;     periodCount += 1
        ;     Config.Log("... computed period: " + periodCount, toConsole=True)
        ; EndWhile

        _lastGameTime = currentTime

        RegisterForSingleUpdateGameTime(Config.FrequencyWearTearDegrade)

    EndEvent
EndState

State ClearTracking
	Event OnBeginState()
		Debug("ClearTracking.OnBeginState")
		UnregisterForUpdate()

        _currentHour = 0
        _lastGameTime = 0.0

        GoToState("ReadyForTracking")		
	EndEvent

    Event OnEndState()
    EndEvent
    
    Event OnUpdate()
    EndEvent
EndState

Function Track(Actor anActor, Int actorSlot)
EndFunction

Function CheckLibLoaded(Form frm, String msg)
    If !frm
        Debug(msg + " did not load!")
    EndIf
EndFunction

Function Setup()
    ; Reset function Libraries - SexLabQuestFramework
    If !Config || !Descriptions || !Database || !Framework
        Form api = GetFramework()
        If api
            Config        = api As Apropos2SystemConfig
            Descriptions  = api As Apropos2Descriptions
            Database      = api As Apropos2DescriptionDb
            Framework     = api As Apropos2Framework

            CheckLibLoaded(Config, "Config")
            CheckLibLoaded(Descriptions, "Descriptions")
            CheckLibLoaded(Database, "Database")
            CheckLibLoaded(Framework, "Framework")
        EndIf
        
        If !SexLab
            SexLab = GetSexLab()
        EndIf        

        If !SlaUtil
            SlaUtil = GetSLA()
        EndIf

    EndIf
    PlayerRef = Game.GetPlayer()

    areasOfInterest = New String[9]
    areasOfInterest[0] = "Anal"
    areasOfInterest[1] = "Vaginal"
    areasOfInterest[2] = "Oral"
    areasOfInterest[3] = "Boobjob"
    areasOfInterest[4] = "Handjob"
    areasOfInterest[5] = "Threesome"
    areasOfInterest[6] = "Gangbang"
    areasOfInterest[7] = "Lesbian"
    areasOfInterest[8] = "Cunnilingus"

    GotoState("ReadyForTracking")
EndFunction

Function TestAccessors()
	Int i = GetCount()
	i = GetCount(isVictim=True)
	i = GetCount("vaginal", isAggressor=True, fctn="banditfaction")
EndFunction



; .all.total => GetCount(); GetTransientCount()
; .all.total-victim => GetCount(isVictim=True); GetTransientCount(isVictim=True)
; .all.total-aggressor - excl gb => GetCount(isAggressor=True)
; .vaginal.total => GetCount("vaginal"), GetTransientCount("vaginal")
; .vaginal.total-victim => GetCount("vaginal", isVictim=True)
; .vaginal.total-aggressor => GetCount("vaginal", isAggressor=True)
; .gangbang.total => GetCount("gangbang")
; .gangbang.total-victim
; .all.factions.banditfaction.total => GetCount(faction="banditfaction")
Int Function GetCount(String bodyArea = "all", Bool isVictim = False, Bool isAggressor = False, String lctn = "", String fctn = "", String creatureRace = "")
	Actor anActor = GetActor()
	String the_key = GetKey(StoragePath, bodyArea, isVictim, isAggressor, lctn, fctn, creatureRace)
	Int storageValue = JFormDB.solveInt(anActor, the_key)
	Return storageValue
EndFunction

Int Function GetTransientCount(String bodyArea = "all", Bool isVictim = False, Bool isAggressor = False, String lctn = "", String fctn = "", String creatureRace = "")
	Actor anActor = GetActor()
	String the_key = GetKey(StoragePathTransient, bodyArea, isVictim, isAggressor, lctn, fctn, creatureRace)
	Int storageValue = JFormDB.solveInt(anActor, the_key)
	Return storageValue	
EndFunction

Function IncrementCount(String bodyArea = "all", Bool isVictim = False, Bool isAggressor = False, String lctn = "", String fctn = "", String creatureRace = "")
	Actor anActor = GetActor()
	String the_key = GetKey(StoragePath, bodyArea, isVictim, isAggressor, lctn, fctn, creatureRace)
	Int curVal = JFormDB.solveInt(anActor, the_key)
	curVal += 1
	Bool success = JFormDb.solveIntSetter(anActor, the_key, curVal, true)
EndFunction

Function IncrementTransientCount(String bodyArea = "all", Bool isVictim = False, Bool isAggressor = False, String lctn = "", String fctn = "", String creatureRace = "")
	Actor anActor = GetActor()
	String the_key = GetKey(StoragePathTransient, bodyArea, isVictim, isAggressor, lctn, fctn, creatureRace)
	Int curVal = JFormDB.solveInt(anActor, the_key)
	curVal += 1
	Bool success = JFormDb.solveIntSetter(anActor, the_key, curVal, true)	
EndFunction

Function ProcessOrgasm()

EndFunction

String Function GetKey(String prefix, String bodyArea = "all", Bool isVictim = False, Bool isAggressor = False, String lctn = "", String fctn = "", String creatureRace = "")
	String path = prefix + "." + bodyArea ;; .apropos2track.all, .apropos2track.anal

	If !lctn && !fctn
		If isVictim 
			path += ".total-victim"
		ElseIf isAggressor
			path += ".total-aggressor"
		Else
			path += ".total"
		EndIf
	EndIf

	If fctn && !lctn && !creatureRace
		If isVictim 
			path += ".factions." + fctn + ".total-victim"
		ElseIf isAggressor
			path += ".factions." + fctn + ".total-aggressor"
		Else
			path += ".factions." + fctn + ".total"
		EndIf
	EndIf

	If lctn && !fctn && !creatureRace
		If isVictim 
			path += ".locations." + lctn + ".total-victim"
		ElseIf isAggressor
			path += ".locations." + lctn + ".total-aggressor"
		Else
			path += ".locations." + lctn + ".total"
		EndIf		
	EndIf

	If creatureRace && !lctn && !fctn
		If isVictim 
			path += ".creatures." + creatureRace + ".total-victim"
		Else
			path += ".locations." + creatureRace + ".total"
		EndIf			
	EndIf

	; If loc && fac && !creatureRace
	; 	If isVictim 
	; 		path += ".factions." + fac + "." + loc + ".total-victim"
	; 	ElseIf isAggressor
	; 		path += ".factions." + fac + "." + loc + ".total-aggressor"
	; 	Else
	; 		path += ".factions." + fac + "." + loc + ".total"
	; 	EndIf			
	; EndIf

	Log("GetKey(...) ==> " + path)

	Return path
EndFunction

; Stubs

; Stubs

Function LogActor(Actor anActor, String msg)
    Config.LogActor(anActor, msg, Source="Apropos2TrackActorAlias")
EndFunction

Function DebugActor(Actor anActor, String msg)
    Config.DebugActor(anActor, msg, Source="Apropos2TrackActorAlias")
EndFunction

Function Log(String msg)
    Config.Log(msg, Source="Apropos2TrackActorAlias")
EndFunction

Function Debug(String msg)
    Config.Debug(msg, Source="Apropos2TrackActorAlias")
EndFunction