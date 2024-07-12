Scriptname _SLS_LicenceProperty extends Quest  

Event OnInit()
	ActivatorLocs = new String[5]
	ActivatorLocs[0] = "Whiterun"
	ActivatorLocs[1] = "Solitude"
	ActivatorLocs[2] = "Markarth"
	ActivatorLocs[3] = "Windhelm"
	ActivatorLocs[4] = "Riften"
EndEvent

Event OnUpdateGameTime()
	Debug.Trace("_SLS_: _SLS_LicenceProperty: OnUpdateGameTime()")
	Utility.Wait(5.0) ; Wait for licences to expire first. Otherwise update here runs before licence expires when WAITing (skipping) through expiry. 
	If !LicUtil.HasValidPropertyLicence
		EvictFromAll(DoEvict = true, DoImmediately = true)
		Debug.Trace("_SLS_: _SLS_LicenceProperty: OnUpdateGameTime(): EvictFromAll()")
	EndIf
EndEvent
;/
Event OnStoryScript(Keyword akKeyword, Location akLocation, ObjectReference akRef1, ObjectReference akRef2, int aiValue1, int aiValue2)
	Debug.Messagebox("OnStoryScript")
	If akKeyword == MarriageWeddingKeyword
		Debug.Messagebox("Got married to " + (akRef1 as Actor).GetLeveledActorBase().GetName())
	EndIf
EndEvent

Event OnStoryRelationshipChange(ObjectReference akActor1, ObjectReference akActor2, int aiOldRelationship, int aiNewRelationship)
	Debug.Messagebox("OnStoryRelationshipChange")
EndEvent
/;
Function ScheduleLicenceExpiry(ObjectReference LicRef)
	ScheduledExpiryTime = StorageUtil.GetFloatValue(LicRef, "_SLS_LicenceExpiry", -1.0) - 1.0
	If ScheduledExpiryTime > 0.0
		;Debug.Messagebox("ScheduledExpiryTime: " + ScheduledExpiryTime + "\nGetCurrentGameTime(): " + Utility.GetCurrentGameTime() + "\nEvict at time: " + (ScheduledExpiryTime - Utility.GetCurrentGameTime()) + 0.1)
		RegisterForSingleUpdateGameTime(24.0 * ((ScheduledExpiryTime - Utility.GetCurrentGameTime()) + 0.1))
	EndIf
EndFunction

Bool Function GetOwnsProperty(Int ActLoc)
	GoToState(ActivatorLocs[ActLoc])
	Return OwnsProperty()
EndFunction

Function EvictFromAll(Bool DoEvict, Bool DoImmediately)
	; DoEvict: Evict = true = Evict from homes. Evict = false = lift eviction
	; DoImmediately: true = bar/unbar door now. false = do bar/unbar later when eviction script update runs
	Eviction.IsLicenceEvicted = DoEvict
	Int i = 0
	While i < ActivatorLocs.Length
		GoToState(ActivatorLocs[i])
		Evict(DoEvict, DoImmediately)
		i += 1
	EndWhile
EndFunction

Function ScheduleUnEvictFromAll()
	
EndFunction

Function EvictFrom(Int ActLoc, Bool DoEvict, Bool DoImmediately) ; ActivatorLocation: 0 - Whiterun, 1 - Solitude, 2 - Markarth, 3 - Windhelm, 4 - Riften
	GoToState(ActivatorLocs[ActLoc])
	Evict(DoEvict, DoImmediately)
EndFunction

State Whiterun
	Bool Function OwnsProperty()
		If Eviction.OwnsWhiterun
			Return true
		EndIf
		Return false
	EndFunction
	
	Function Evict(Bool DoEvict, Bool DoImmediately)
		If DoImmediately
			Eviction.EvictWhiterun(DoEvict, Notify = false)
		EndIf
		If DoEvict
			Eviction.IsBarredWhiterun = true
		EndIf
	EndFunction
EndState

State Solitude
	Bool Function OwnsProperty()
		If Eviction.OwnsSolitude
			Return true
		EndIf
		Return false
	EndFunction
	
	Function Evict(Bool DoEvict, Bool DoImmediately)
		If DoImmediately
			Eviction.EvictSolitude(DoEvict, Notify = false)
		EndIf
		If DoEvict
			Eviction.IsBarredSolitude = true
		EndIf
	EndFunction
EndState

State Markarth
	Bool Function OwnsProperty()
		If Eviction.OwnsMarkarth
			Return true
		EndIf
		Return false
	EndFunction
	
	Function Evict(Bool DoEvict, Bool DoImmediately)
		If DoImmediately
			Eviction.EvictMarkarth(DoEvict, Notify = false)
		EndIf
		If DoEvict
			Eviction.IsBarredMarkarth = true
		EndIf
	EndFunction
EndState

State Windhelm
	Bool Function OwnsProperty()
		If Eviction.OwnsWindhelm
			Return true
		EndIf
		Return false
	EndFunction
	
	Function Evict(Bool DoEvict, Bool DoImmediately)
		If DoImmediately
			Eviction.EvictWindhelm(DoEvict, Notify = false)
		EndIf
		If DoEvict
			Eviction.IsBarredWindhelm = true
		EndIf
	EndFunction
EndState

State Riften
	Bool Function OwnsProperty()
		If Eviction.OwnsRiften
			Return true
		EndIf
		Return false
	EndFunction
	
	Function Evict(Bool DoEvict, Bool DoImmediately)
		If DoImmediately
			Eviction.EvictRiften(DoEvict, Notify = false)
		EndIf
		If DoEvict
			Eviction.IsBarredRiften = true
		EndIf
	EndFunction
EndState

; Empty State ====================================
Bool Function OwnsProperty()
	Debug.Trace("_SLS_: _SLS_LicenceProperty: OwnsProperty(): State not set")
	Return false
EndFunction

Function Evict(Bool DoEvict, Bool DoImmediately)
	Debug.Trace("_SLS_: _SLS_LicenceProperty: Evict(): State not set")
EndFunction

Float Property ScheduledExpiryTime = -1.0 Auto Hidden

String[] ActivatorLocs

_SLS_LicenceUtil Property LicUtil Auto
SLS_EvictionTrack Property Eviction Auto

Actor Property PlayerRef Auto

Keyword Property MarriageWeddingKeyword Auto
