Scriptname _DFLicensing extends Quest

QF__Gift_09000D62 Property _DFlow Auto
_DFDealUberController Property _DflowDealController Auto
_DFGoldConQScript Property _DflowGoldMode Auto

FormList Property _DFLicenseLocations Auto

Actor Property PlayerRef Auto
Keyword Property KeywordCity Auto

Float Property BasePrice = 150.0 Auto
Float Property Markup = 10.0 Auto

; Made these globals so easy to test in conditions AND easy for other mods to read.
GlobalVariable Property _DFLicenseSupplyWeapon Auto
GlobalVariable Property _DFLicenseSupplyMagic Auto
GlobalVariable Property _DFLicenseSupplyProtection Auto ; Armor or bikini
GlobalVariable Property _DFLicenseSupplyBikini Auto
GlobalVariable Property _DFLicenseSupplyArmor Auto
GlobalVariable Property _DFLicenseSupplyClothes Auto
GlobalVariable Property _DFLicenseSupplyWhore Auto
GlobalVariable Property _DFLicenseSupplyCurfew Auto
GlobalVariable Property _DFLicenseEnabledMagic Auto
GlobalVariable Property _DFLicenseEnabledProtection Auto
GlobalVariable Property _DFLicenseStatus Auto
GlobalVariable Property _DFLicenseEnableCount Auto
; We never *supply* property or freedom licenses, though we might steal them.
GlobalVariable Property _DWill Auto

Int Property LicenseCount = 9 AutoReadOnly Hidden
Int Property StateIgnore = 0 AutoReadOnly Hidden
Int Property StateAsk = 1 AutoReadOnly Hidden
Int Property StateWaitGrant = 2 AutoReadOnly Hidden
Int Property StateWaitExpire = 3 AutoReadOnly Hidden
Int Property StateWaitDisable = 4 AutoReadOnly Hidden
Int Property StateDiscover = 5 AutoReadOnly Hidden

Bool Property ShowDiagnostics Auto
Bool Property FixedSLS Auto
Bool Property BlockedWeapons Auto
Bool Property BlockedProtection Auto
Bool Property BlockedClothes Auto
Bool Property Paused Auto

String[] licenseNames
String[] licenseTokens
Int[] licenseStates
Float[] requestTimes
Bool isEnabled ; DO NOT USE
Bool mentionedWhoreLicense
Bool mentionedClothesLicense
Bool mentionedGoldControl
Bool startedViaGoldControl


; FOLDSTART - Complex properties
Bool Property Enabled
    Bool Function Get()
        Bool isSet = StorageUtil.GetIntValue(None, "_DF_LicensingEnabled") As Bool
        ;Debug.TraceConditional("DF - _DFLicenses.Enabled " + self + ", Get = " + isSet, True)
        Return isSet
    EndFunction
    Function Set(Bool value)
        ;Debug.TraceConditional("DF - _DFLicenses.Enabled " + self + ", " + StorageUtil.GetIntValue(None, "_DF_LicensingEnabled") + ", Set = " + value, True)
        UpdateEnableStatus(value)
    EndFunction
EndProperty

Bool Property SupplyEnabled
    Bool Function Get()
        Int currentStage = GetStage()
        Return currentStage >= 10 && currentStage < 90
    EndFunction
EndProperty

Float Property LicenseGrantTimeoutInGameDays
    Float Function Get()
        ; 1 game hour ~ typically 3 real minutes
        Return 1.0 / 24.0 
    EndFunction
EndProperty

Int Property LicenseSupplyWeapon 
    Int Function Get()
        Return _DFLicenseSupplyWeapon.GetValue() As Int
    EndFunction
    Function Set(Int value)
        _DFLicenseSupplyWeapon.SetValue(value As Float)
    EndFunction
EndProperty
Int Property LicenseSupplyMagic 
    Int Function Get()
        Return _DFLicenseSupplyMagic.GetValue() As Int
    EndFunction
    Function Set(Int value)
        _DFLicenseSupplyMagic.SetValue(value As Float)
    EndFunction
EndProperty
Int Property LicenseSupplyProtection
    Int Function Get()
        Return _DFLicenseSupplyProtection.GetValue() As Int
    EndFunction
    Function Set(Int value)
        Float finalValue = DecideArmorOrBikinLicenseSupply(value)
        _DFLicenseSupplyProtection.SetValue(finalValue)
    EndFunction
EndProperty
Int Property LicenseSupplyBikini 
    Int Function Get()
        Return _DFLicenseSupplyBikini.GetValue() As Int
    EndFunction
    Function Set(Int value)
        _DFLicenseSupplyBikini.SetValue(value As Float)
    EndFunction
EndProperty
Int Property LicenseSupplyArmor 
    Int Function Get()
        Return _DFLicenseSupplyArmor.GetValue() As Int
    EndFunction
    Function Set(Int value)
        _DFLicenseSupplyArmor.SetValue(value As Float)
    EndFunction
EndProperty
Int Property LicenseSupplyClothes 
    Int Function Get()
        Return _DFLicenseSupplyClothes.GetValue() As Int
    EndFunction
    Function Set(Int value)
        _DFLicenseSupplyClothes.SetValue(value As Float)
    EndFunction
EndProperty
Int Property LicenseSupplyWhore 
    Int Function Get()
        Return _DFLicenseSupplyWhore.GetValue() As Int
    EndFunction
    Function Set(Int value)
        _DFLicenseSupplyWhore.SetValue(value As Float)
    EndFunction
EndProperty
Int Property LicenseSupplyCurfew 
    Int Function Get()
        Return _DFLicenseSupplyCurfew.GetValue() As Int
    EndFunction
    Function Set(Int value)
        _DFLicenseSupplyCurfew.SetValue(value As Float)
    EndFunction
EndProperty

Int Property LicenseSupplyAny
    Int Function Get()
        Return ( \
                _DFLicenseSupplyWeapon.GetValue() \
                + _DFLicenseSupplyMagic.GetValue() \
                + _DFLicenseSupplyBikini.GetValue() \
                + _DFLicenseSupplyArmor.GetValue() \
                + _DFLicenseSupplyClothes.GetValue() \
                + _DFLicenseSupplyWhore.GetValue() \
                + _DFLicenseSupplyCurfew.GetValue() \
                ) As Int
    EndFunction
EndProperty

Int Property Will
    Int Function Get()
        Return _DWill.GetValue() As Int
    EndFunction
EndProperty
Int Property StatusReportID
    Int Function Get()
        Return _DFLicenseStatus.GetValue() As Int
    EndFunction
    Function Set(Int value)
        _DFLicenseStatus.SetValue(value As Float)
    EndFunction
EndProperty
Int Property LicenseEnableCount
    Int Function Get()
        Return _DFLicenseEnableCount.GetValue() As Int
    EndFunction
    Function Set(Int value)
        _DFLicenseEnableCount.SetValue(value As Float)
    EndFunction
EndProperty
Int Property LicenseEnabledMagic
    Int Function Get()
        Return _DFLicenseEnabledMagic.GetValue() As Int
    EndFunction
    Function Set(Int value)
        _DFLicenseEnabledMagic.SetValue(value As Float)
    EndFunction
EndProperty
Int Property LicenseEnabledProtection
    Int Function Get()
        Return _DFLicenseEnabledProtection.GetValue() As Int
    EndFunction
    Function Set(Int value)
        _DFLicenseEnabledProtection.SetValue(value As Float)
    EndFunction
EndProperty

; FOLDEND - License supply properties

; FOLDSTART - Notes
; We can SEND...
; _SLS_IssueLicence
; _SLS_RevokeLicence
; _SLS_BlockLicenceBuy

; We can RECEIVE...
; _SLS_LicenceIssuedEvent
; _SLS_LicenceStateUpdateEvent

; We can QUERY... See 'licenseTokens'.
; StorageUtil.GetIntValue(None, "_SLS_HasValidMagicLicence", -2)
; StorageUtil.GetIntValue(None, "_SLS_HasValidWeaponLicence", -2)
; StorageUtil.GetIntValue(None, "_SLS_HasValidArmorLicence", -2)
; StorageUtil.GetIntValue(None, "_SLS_HasValidBikiniLicence", -2)
; StorageUtil.GetIntValue(None, "_SLS_HasValidClothesLicence", -2)
; StorageUtil.GetIntValue(None, "_SLS_HasValidCurfewLicence", -2)
; StorageUtil.GetIntValue(None, "_SLS_HasValidWhoreLicence", -2)
; StorageUtil.GetIntValue(None, "_SLS_HasValidPropertyLicence", -2)
; StorageUtil.GetIntValue(None, "_SLS_HasValidFreedomLicence", -2)
; FOLDEND - Notes


; Called on stage set to 1
; Starts up the license quest ... does not enable any supply.
; Should be safe to recall this.
Function StartLicensing()

    UnregisterForUpdate()
    
    Debug.TraceConditional("DF - StartLicensing - start", ShowDiagnostics)
    
    licenseNames = New String[9]
    licenseNames[0] = "Weapon"
    licenseNames[1] = "Magic"
    licenseNames[2] = "Bikini"
    licenseNames[3] = "Armor"
    licenseNames[4] = "Clothes"
    licenseNames[5] = "Whore"
    licenseNames[6] = "Curfew"
    licenseNames[7] = "Property"
    licenseNames[8] = "Freedom"

    licenseTokens = New String[9]
    licenseTokens[0] = "_SLS_HasValidWeaponLicence"
    licenseTokens[1] = "_SLS_HasValidMagicLicence"
    licenseTokens[2] = "_SLS_HasValidBikiniLicence"
    licenseTokens[3] = "_SLS_HasValidArmorLicence"
    licenseTokens[4] = "_SLS_HasValidClothesLicence"
    licenseTokens[5] = "_SLS_HasValidWhoreLicence"
    licenseTokens[6] = "_SLS_HasValidCurfewLicence"
    licenseTokens[7] = "_SLS_HasValidPropertyLicence"
    licenseTokens[8] = "_SLS_HasValidFreedomLicence"
    
    licenseStates = New Int[9]
    requestTimes = New Float[9]
    
    ; Need to know about enablement before we can begin licensing
    RefreshSLSEnableStatusAndResetStates()
    
    RegisterEventListeners()
    ;Debug.Notification("Started Licensing")
    Debug.TraceConditional("DF - StartLicensing - end", ShowDiagnostics)
    
    RegisterForSingleUpdate(7.0)

EndFunction

; Called on game load, if we have SLS, to add listeners and updates again
; Whether quest is running or not, will call StartLicensing()
Function TryResumeLicensing()
    GoToState("Busy")
    Debug.TraceConditional("DF - TryResumeLicensing - start - quest Enabled " + Enabled + ", running " + IsRunning() + ", stage " + GetStage(), True)
    ;Debug.Notification("Try Resume Licensing")

    ; While it would be nicer to do this in start, this allows the list to be updated in a running game.
    PopulateLicenseLocations()

    If Enabled
        If IsRunning()
            Debug.TraceConditional("DF - ResumeLicensing", ShowDiagnostics)
            ;Debug.Notification("Resume Licensing")
            If GetStage() > 100
                Stop()
                Start()
            Else
                StartLicensing()
            EndIf
        Else
            Debug.TraceConditional("DF - Licensing.Start()", ShowDiagnostics)
            ; TO-DO - only start on load if enabled in MCM
            ; This will also call StartLicensing(), but also sets quest stage.
            Start()
        EndIf
    Else
        ; Nothing to do, don't start anything.
        Debug.TraceConditional("DF - TryResumeLicensing - not enabled, don't start anything.", ShowDiagnostics)
        ;Debug.Notification("Still Not Licensing")
    EndIf
    
    Debug.TraceConditional("DF - TryResumeLicensing - end", True)
    GoToState("")
EndFunction

; Called on game load if no SLS
Function TryStop()
    GoToState("Busy")
    Debug.TraceConditional("DF - TryStop - start - quest Enabled " + Enabled, True)
    If IsRunning()
        SetStage(100)
    EndIf
    Debug.TraceConditional("DF - TryStop - end", True)
    GoToState("")
EndFunction

; Called on stage set to 100
; Shuts down license quest
Function EndLicensing()
    Debug.TraceConditional("DF - EndLicensing", True)
    ;Debug.Notification("End Licensing")

    startedViaGoldControl = False

    UnregisterEventListeners()
    UnregisterForUpdate()
    
    ; If the quest ends, it may periodically attempt restart on waking up, or if you get a new follower.
    ; That will have no effect if not enabled.
EndFunction

; The global enable status for licensing.
Function UpdateEnableStatus(Bool newEnable)

    Bool isSet = StorageUtil.GetIntValue(None, "_DF_LicensingEnabled") As Bool
    Debug.TraceConditional("DF - UpdateEnableStatus: on " + self + ", new " + newEnable + ", old " + isSet, True)

    If newEnable == isSet
        Debug.TraceConditional("DF - UpdateEnableStatus: on " + self + ", nothing to do", True)
        Return
    EndIf
    
    If newEnable
        StorageUtil.SetIntValue(None,  "_DF_LicensingEnabled", 1)
        Debug.TraceConditional("DF - UpdateEnableStatus - ENABLE", True)
        
        ;Debug.TraceConditional("DF - UpdateEnableStatus: on " + self + ", Enabled now " + Enabled + ", should be True", True)
        
        If !IsRunning() || GetStage() >= 100
            TryResumeLicensing()
        ElseIf GetStage() == 90
            ; Otherwise, leave the quest alone and let it progress ... excluding from 90 to shutdown.
            If LicenseSupplyAny
                SetStage(10)
            Else
                SetStage(1)
            EndIf
            ; Otherwise already running and on some other stage.
        EndIf
    Else
        StorageUtil.SetIntValue(None,  "_DF_LicensingEnabled", 0)
        Debug.TraceConditional("DF - UpdateEnableStatus - DISABLE", True)

        ;Debug.TraceConditional("DF - UpdateEnableStatus: on " + self + ", Enabled now " + Enabled + ", should be False", True)

        If IsRunning() && GetStage() < 90
            SetStage(90)
        ElseIf GetStage() > 100
            Stop()
        EndIf
    EndIf
   
EndFunction

Function RegisterEventListeners()
    ; Get an object reference for the licence that will be issued.
    ; Also lets us know who is issuing a license... what if it's not us?
    RegisterForModEvent("_SLS_LicenceIssuedEvent", "LicenceIssueHandler")
    
    ; Fired for all kinds of reasons. State may not even have changed.
    ; Ironically, not fired on license issue.
    RegisterForModEvent("_SLS_LicenceStateUpdateEvent", "LicenseUpdateHandler")
EndFunction

Function UnregisterEventListeners()
    UnregisterForModEvent("_SLS_LicenceIssuedEvent")
    UnregisterForModEvent("_SLS_LicenceStateUpdateEvent")
EndFunction


; Called by stage 9 script. Do not call directly. Stage 9 script also sets stage 10.
Function BeginFromGoldControl()
    startedViaGoldControl = True
    mentionedGoldControl = False
EndFunction

; Called by stage 10 script when the player opts in...
; This is triggered by Stage 10, and as such, has no way to check for situations where it's being called repeatedly.
; You shouldn't EVER call this directly. The way to start active licensing is to set the quest stage.
Function BeginSupply()
    Debug.TraceConditional("DF - BeginSupply", ShowDiagnostics)
    ;Debug.Notification("Begin license supply")
    
    ; It doesn't matter if the license isn't enabled in SLS, it will simply be ignored if so.
    ; EXCEPT for bikini and armor ... where we need to decide which we are supplying...
    ; AND for whore and curfew.
    ; The latter are simple, in that they will not be supplied unless enslaved.
    ; Curfew license supply if a *maybe* for now.
    LicenseEnabledMagic = GetLicenseEnabledInSLS(1)

    LicenseSupplyWeapon = GetLicenseEnabledInSLS(0) ; 0
    LicenseSupplyMagic =  LicenseEnabledMagic ; 1
    ; 2 bikini, 3 armor
    LicenseSupplyClothes = GetLicenseEnabledInSLS(4) ; 4
    LicenseSupplyCurfew = 0 ; 6
    
    If _DflowGoldMode.Enabled
        LicenseSupplyWhore = GetLicenseEnabledInSLS(5)
    Else
        LicenseSupplyWhore = 0 ; 5
    EndIf

    ; Set bikini and armor
    ; This implicitly calls DecideArmorOrBikinLicenseSupply()
    LicenseSupplyProtection = 1 
    ; As this eagerly sets supply, we can use it to determined whether protection is sufficiently enabled in SLS.
    LicenseEnabledProtection = LicenseSupplyProtection
    
    If LicenseSupplyClothes && _DflowDealController.HaveNakedDeals()
        LicenseSupplyClothes = 0
    EndIf
    
    mentionedClothesLicense = False
    mentionedWhoreLicense = False
    
EndFunction

; Called by state 90 script if player opts out.
; See notes on the BeginSupply function ... you should NEVER call this directly; always set the quest stage.
Function StopSupply()
    Debug.TraceConditional("DF - StopSupply", ShowDiagnostics)
    ;Debug.Notification("Stop license supply")
    
    LicenseSupplyWeapon = 0
    LicenseSupplyMagic = 0
    LicenseSupplyProtection = 0
    LicenseSupplyArmor = 0
    LicenseSupplyBikini = 0
    LicenseSupplyClothes = 0
    LicenseSupplyWhore = 0
    LicenseSupplyCurfew = 0
    startedViaGoldControl = False
EndFunction

; Handles the _SLS_LicenceIssuedEvent license issue events.
; LicenceType: 0 - Magic, 1 - weapons, 2 - Armor, 3 - Bikini, 4 - Clothes.
;              5 - Curfew, 6 - Whore, 7 - Freedom, 8 - Property. -1 = Not set -> set via dialogue
Event LicenceIssueHandler(Form licenceForm, Int licenceType, Int term, Form requestingMod)
    Debug.TraceConditional("DF - LicenceIssueHandler - issued " + licenceType + ", term " + term + ", mod " + requestingMod, ShowDiagnostics)
    If 0 == licenceType
        Debug.TraceConditional("DF - granted MAGIC license, term " + term, ShowDiagnostics)
    ElseIf 1 == licenceType
        Debug.TraceConditional("DF - granted WEAPON license, term " + term, ShowDiagnostics)
    ElseIf 2 == licenceType
        Debug.TraceConditional("DF - granted ARMOR license, term " + term, ShowDiagnostics)
    ElseIf 3 == licenceType
        Debug.TraceConditional("DF - granted BIKINI license, term " + term, ShowDiagnostics)
    ElseIf 4 == licenceType
        Debug.TraceConditional("DF - granted CLOTHES license, term " + term, ShowDiagnostics)
    ElseIf 5 == licenceType
        Debug.TraceConditional("DF - granted CURFEW license, term " + term, ShowDiagnostics)
    ElseIf 6 == licenceType
        Debug.TraceConditional("DF - granted WHORE license, term " + term, ShowDiagnostics)
    ElseIf 7 == licenceType
        Debug.TraceConditional("DF - granted FREEDOM license, term " + term, ShowDiagnostics)
    ElseIf 8 == licenceType
        Debug.TraceConditional("DF - granted PROPERTY license, term " + term, ShowDiagnostics)
    Else
        Debug.TraceConditional("DF - granted unknown type!!! " + licenceType + ", term " + term, ShowDiagnostics)
    EndIf
    
        
    DumpLicenseStates()
    ;UpdateLicenseStates()
EndEvent

Event LicenseUpdateHandler(string eventName, string strArg, float numArg, Form sender)
    Debug.TraceConditional("DF - LicenseUpdateHandler - UPDATE EVENT", ShowDiagnostics)
    ;UpdateLicenseStates()
EndEvent

Event OnUpdate()
    UpdateLicenseStates()
    RegisterForSingleUpdate(7.0)
EndEvent


; Called whenever a license state changes.
Function UpdateLicenseStates()
    ; Prevent re-entry
    GoToState("Busy")
    
    Int currentStage = GetStage()
    If 1 == currentStage
        RefreshSLSEnableStatusAndResetStates()
        GoToState("")
        Return
    EndIf

    
    Bool canRenewLicenses = False
    
    Actor follower = None
    If _DFlow.Alias__DMaster
        follower = _DFlow.Alias__DMaster.GetActorRef()
    EndIf

    Location where = PlayerRef.GetCurrentLocation()
    If where && follower
        ; The follower can magically obtain licenses... or you're in a quartermaster location.
        canRenewLicenses = where.HasKeyword(KeywordCity)
        If !canRenewLicenses
            Cell currentCell = PlayerRef.GetParentCell()
            If currentCell
                Int findLoc = _DFLicenseLocations.Find(currentCell)
                ;Debug.TraceConditional("DF - findLoc " + where.GetFormId() + " result " + findLoc, True)
                canRenewLicenses = findLoc >= 0
            EndIf
        EndIf
    EndIf
    
    ; Don't enable more licenses if we're shutting down...
    If currentStage < 90
    
        ; Possibly disable clothes license, if there was one, because deals make is less useful.
        Bool haveNakedDeals = _DflowDealController.HaveNakedDeals()
        If haveNakedDeals && LicenseSupplyClothes
            Debug.TraceConditional("DF - disable clothes license due to deals", ShowDiagnostics)
            LicenseSupplyClothes  = 0
        ElseIf !haveNakedDeals && !LicenseSupplyClothes
            Debug.TraceConditional("DF - enable clothes license - no blocking deals", ShowDiagnostics)
            LicenseSupplyClothes = GetLicenseEnabledInSLS(4)
        EndIf
        
        ; Try to enable whore license if in gold control mode.
        If FixedSLS
            Bool goldControl =_DflowGoldMode.Enabled
            If goldControl && !LicenseSupplyWhore
                Debug.TraceConditional("DF - Enable whore license in gold control", ShowDiagnostics)
                LicenseSupplyWhore = GetLicenseEnabledInSLS(5)
            ElseIf !goldControl && LicenseSupplyWhore
                Debug.TraceConditional("DF - disable whore license", ShowDiagnostics)
                LicenseSupplyWhore = 0
            EndIf
        EndIf
    EndIf

    
    Int[] enabledSLS = New Int[9]
    
    Int[] supply = New Int[9]
    supply[0] = LicenseSupplyWeapon
    supply[1] = LicenseSupplyMagic
    supply[2] = LicenseSupplyBikini
    supply[3] = LicenseSupplyArmor
    supply[4] = LicenseSupplyClothes
    supply[5] = LicenseSupplyWhore
    supply[6] = LicenseSupplyCurfew
    ; 7, 8 = Property and Freedom, can be left at 0 as we don't supply them.
    
    

    
    Debug.TraceConditional("DF - Update licenses " + LicenseCount, ShowDiagnostics)
    
    Int supplyCount = 0
    Int suppliedCount = 0
    Int ignoredCount = 0
    Int enabledCount = 0
    
    Bool canRequestThisUpdate = True
    
    ; Handle the license states
    Int ii = 0
    While ii < LicenseCount
        
        enabledSLS[ii] = GetLicenseEnabledInSLS(ii)
        
        ; If it's disabled in SLS, leave the state alone, in case it gets re-enabled, we will start handling it again.
        If enabledSLS[ii] 
        
            enabledCount += 1
            
            Int stateNow = licenseStates[ii]
            Int supplyNow = supply[ii]

            Debug.TraceConditional("DF - Handling license " + ii + ", state " + stateNow + ", supply " + supplyNow + ", " + licenseNames[ii], ShowDiagnostics)

            ; External state transition triggers
            If StateIgnore == stateNow && 0 != supplyNow
                ; Discover existing license state.
                stateNow = StateDiscover
            EndIf
            
            ; State transitions
            If StateDiscover == stateNow
                If CanGetLicense(ii)
                    stateNow = StateAsk
                ElseIf HaveLicense(ii)
                    stateNow = StateWaitExpire
                ElseIf 0 == supplyNow
                    stateNow = StateIgnore
                EndIf
                ; If we can't find a way out of StateDiscover, stay there...
            EndIf
            
            If StateAsk == stateNow
                If HaveLicense(ii)
                    stateNow = StateWaitExpire
                ElseIf CanGetLicense(ii) && canRenewLicenses
                
                    ; TO-DO - get the correct quartermaster as source instead.
                    ; TO-DO - give licenses to follower then follower hands them over.
                    ; TO-DO - follower goes somewhere to get licenses.
                    
                    If canRequestThisUpdate
                        ; Throttle requests to one per update so SLS doesn't choke.
                        canRequestThisUpdate = False
                        ChargeForLicense(ii)
                        RequestLicence(ii, 0, follower)
                        stateNow = StateWaitGrant
                        requestTimes[ii] = Utility.GetCurrentGameTime()
                        suppliedCount += 1 ; count this as supplied for dialog purposes.
                    EndIf
                    ; Otherwise we will stay in this state, still trying to request.
                EndIf
                ; If we can't find a way out of Ask, stay there...
            ElseIf StateWaitGrant == stateNow
                ; Waiting for a license
                If HaveLicense(ii)
                    Debug.TraceConditional("DF - License was granted " + ii, ShowDiagnostics)
                    stateNow = StateWaitExpire
                Else
                    Float now = Utility.GetCurrentGameTime()
                    Float waitTime = requestTimes[ii]
                    If now - waitTime > LicenseGrantTimeoutInGameDays
                        stateNow = StateAsk
                    EndIf
                EndIf
            ElseIf StateWaitExpire == stateNow
                ; Waiting for loss - if paused, don't transition to the ask state - it will happen on unpause.
                If !Paused
                    If !HaveLicense(ii)
                        Debug.TraceConditional("DF - License expired " + ii, ShowDiagnostics)
                        stateNow = StateAsk
                    EndIf
                EndIf
            ElseIf StateWaitDisable == stateNow
                ; Waiting to expire and disable
                If !HaveLicense(ii)
                    Debug.TraceConditional("DF - License disabled " + ii, ShowDiagnostics)
                    stateNow = StateIgnore
                EndIf
            EndIf
            
            If StateWaitExpire == stateNow
                suppliedCount += 1
            ElseIf StateIgnore == stateNow
                ignoredCount += 1
            EndIf
            
            licenseStates[ii] = stateNow
        EndIf
        
        If supply[ii]
            supplyCount += 1
        EndIf
        
        ii += 1
    EndWhile

    LicenseEnableCount = enabledCount
    
    ; Handle disables that might occur in SLS that stop SUPPLY
    If 0 != LicenseSupplyMagic && !enabledSLS[1]
        LicenseSupplyMagic = 0
    EndIf
    If 0 != LicenseSupplyBikini && !enabledSLS[2]
        LicenseSupplyBikini = 0 ; 2 = bikini
    EndIf
    If 0 != LicenseSupplyArmor && !enabledSLS[3]
        LicenseSupplyArmor = 0 ; 3 = armor
    EndIf
    
    ; Not supplying protection if not supplying bikini or armor
    If LicenseEnabledProtection && 0 == LicenseSupplyBikini && 0 == LicenseSupplyArmor
        LicenseSupplyProtection = 0
    EndIf

    ; These states are used to enable/disable dialogs about magic/protection license.
    ; If bikini and armor not enabled as licenses, don't enable protection.
    If enabledSLS[2] || enabledSLS[3]
        LicenseEnabledProtection = 1
    Else
        LicenseEnabledProtection = 0
    EndIf

    LicenseEnabledMagic = enabledSLS[1]

    
    
    UpdateStatusDialogSelector(currentStage, enabledCount, supplyCount, suppliedCount)
    Debug.TraceConditional("DF - StatusReportID set to " + StatusReportID, ShowDiagnostics)
    

    If ShowDiagnostics
        Debug.TraceConditional("DF - SupplyWeapon  " + LicenseSupplyWeapon + ", enabled " + enabledSLS[0], True)
        Debug.TraceConditional("DF - SupplyMagic   " + LicenseSupplyMagic + ", enabled " + enabledSLS[1], True)
        Debug.TraceConditional("DF - SupplyBikini  " + LicenseSupplyBikini + ", enabled " + enabledSLS[2], True)
        Debug.TraceConditional("DF - SupplyArmor   " + LicenseSupplyArmor + ", enabled " + enabledSLS[3], True)
        Debug.TraceConditional("DF - SupplyClothes " + LicenseSupplyClothes + ", enabled " + enabledSLS[4], True)
        Debug.TraceConditional("DF - SupplyWhore   " + LicenseSupplyWhore + ", enabled " + enabledSLS[5], True)
        Debug.TraceConditional("DF - SupplyCurfew  " + LicenseSupplyCurfew + ", enabled " + enabledSLS[6], True)
        Debug.TraceConditional("DF - SupplyProtect " + LicenseSupplyProtection + ", enabled " + LicenseEnabledProtection, True)

        Debug.TraceConditional("DF - StatusReportID " + StatusReportID, True)
        Debug.TraceConditional("DF - LicenseEnableCount " + LicenseEnableCount, True)
        Debug.TraceConditional("DF - LicenseEnabledMagic " + LicenseEnabledMagic, True)
        Debug.TraceConditional("DF - LicenseEnabledProtection " + LicenseEnabledProtection, True)
        Debug.TraceConditional("DF - ignoredCount " + ignoredCount + ", LicenseCount " + LicenseCount, True)
        Debug.TraceConditional("DF - supplyCount " + suppliedCount, True)
        
        Debug.TraceConditional("DF - HaveWeapon  " + StorageUtil.GetIntValue(None, "_SLS_HasValidWeaponLicence", -2), True)
        Debug.TraceConditional("DF - HaveMagic   " + StorageUtil.GetIntValue(None, "_SLS_HasValidMagicLicence", -2), True)
        Debug.TraceConditional("DF - HaveBikini  " + StorageUtil.GetIntValue(None, "_SLS_HasValidBikiniLicence", -2), True)
        Debug.TraceConditional("DF - HaveArmor   " + StorageUtil.GetIntValue(None, "_SLS_HasValidArmorLicence", -2), True)
        Debug.TraceConditional("DF - HaveClothes " + StorageUtil.GetIntValue(None, "_SLS_HasValidClothesLicence", -2), True)
    EndIf
    
    If ignoredCount == LicenseCount
        SetStage(100)
        currentStage = 100
    EndIf
    Debug.TraceConditional("DF - Stage " + currentStage, ShowDiagnostics)
    
    GoToState("")
    
EndFunction


Function UpdateStatusDialogSelector(Int currentStage, Int enabledCount, Int supplyCount, Int suppliedCount)

    ; Handle dialog/chitty-chat about licenses...
    ;----------------------------------------------
    ; Report IDs
    ; 0 = dialog disabled
    ; 1 = no licenses yet
    ; 2 = missing licenses
    ; 3 = managing normal
    ; 4 = no armor
    ; 5 = no magic
    ; 6 = no armor or magic
    ; 7 = no licenses enabled
    ; 8 = I got you a whore license because...
    ; 9 = I didn't get you a clothes license because... 
    ; 10 = As I'm looking after your gold...
     
    StatusReportID = 0
    If 10 == currentStage
        If startedViaGoldControl && !mentionedGoldControl
            StatusReportID = 10
        ElseIf 0 == enabledCount
            StatusReportID = 7 ; no licenses enabled
        ElseIf 0 == suppliedCount
            StatusReportID = 1 ; no licenses yet
        ElseIf suppliedCount < supplyCount
            StatusReportID = 2 ; missing licenses
        ElseIf !mentionedWhoreLicense && LicenseSupplyWhore
            StatusReportID = 8 ; I got you a whore license ... whore ...
        ElseIf !mentionedClothesLicense && !IsLicenseDisabledInSLS(4) && 0 == LicenseSupplyClothes
            StatusReportID = 9 ; I didn't get you a clothes license because I want you naked.
        ElseIf suppliedCount == suppliedCount
            If !LicenseSupplyProtection && !LicenseSupplyMagic
                StatusReportID = 6 ; no armor or magic
            ElseIf !LicenseSupplyMagic
                StatusReportID = 5 ; no magic
            ElseIf !LicenseSupplyProtection
                StatusReportID = 4 ; no armor
            Else
                StatusReportID = 3 ; situation normal - managing
            EndIf
        EndIf
    EndIf
            
EndFunction

Function ShownWhoreDialog()
    mentionedWhoreLicense = True
    StatusReportID = 0
EndFunction

Function ShownClothesDialog()
    mentionedClothesLicense = True
    StatusReportID = 0
EndFunction

Function ShownGoldControlDialog()
    mentionedGoldControl = True
    StatusReportID = 0
EndFunction

; Handle pause events.
Function Pause(Bool pauseMod)
    Paused = pauseMod
EndFunction


Function RefreshSLSEnableStatusAndResetStates()

    Debug.TraceConditional("DF - RefreshSLSEnableStatus - start", ShowDiagnostics)

    StatusReportID = 0

    Int[] enabledSLS = New Int[9]
    Int enabledCount = 0
    
    Int ii = 0
    While ii < LicenseCount
        enabledSLS[ii] = GetLicenseEnabledInSLS(ii)
        licenseStates[ii] = 0
        If enabledSLS[ii]
            enabledCount += 1
        EndIf
        ii += 1
    EndWhile
    
    LicenseEnableCount = enabledCount
    LicenseEnabledMagic = enabledSLS[1]
    If enabledSLS[2] || enabledSLS[3]
        LicenseEnabledProtection = 1
    Else
        LicenseEnabledProtection = 0
    EndIf
    
    If ShowDiagnostics
        Debug.TraceConditional("DF - LicenseEnableCount " + LicenseEnableCount, True)
        Debug.TraceConditional("DF - LicenseEnabledMagic " + LicenseEnabledMagic, True)
        Debug.TraceConditional("DF - LicenseEnabledProtection " + LicenseEnabledProtection, True)

        Debug.TraceConditional("DF - RefreshSLSEnableStatus - end", True)
    EndIf
EndFunction


; If bikini license is enabled, follower will supply, otherwise armor.
; Returns expected state of LicenseSupplyProtection
Float Function DecideArmorOrBikinLicenseSupply(Int supply)
    
    ; 2 bikini, 3 armor - prefer bikini, but if neither enabled, then we support neither.
    If supply > 0
        If !IsLicenseDisabledInSLS(2)
            Debug.TraceConditional("DF - Enable bikini supply", ShowDiagnostics)
            LicenseSupplyBikini = 1 
            Return 1.0
        ElseIf !IsLicenseDisabledInSLS(3)
            Debug.TraceConditional("DF - Enable armor supply", ShowDiagnostics)
            LicenseSupplyArmor = 1
            Return 1.0
        Else
            Debug.TraceConditional("DF - Enable no protection enabled", ShowDiagnostics)
            LicenseSupplyArmor = 0
            LicenseSupplyBikini = 0
            Return 0.0
        EndIf
    Else
        Debug.TraceConditional("DF - Enable no protection requested", ShowDiagnostics)
        LicenseSupplyArmor = 0
        LicenseSupplyBikini = 0
        Return 0.0
    EndIf
    
EndFunction



Function SupplyingFollowerDismissed()
    ; 0 "Weapon"
    ; 1 "Magic"
    ; 2 "Bikini"
    ; 3 "Armor"
    ; 4 "Clothes"
    ; 5 "Whore"
    ; 6 "Curfew"

    If LicenseSupplyWeapon
        LicenseSupplyWeapon = 0
        licenseStates[0] = StateWaitDisable
        RevokeLicense(0)
    EndIf
    If LicenseSupplyMagic
        LicenseSupplyMagic = 0
        licenseStates[1] = StateWaitDisable
        RevokeLicense(1)
    EndIf
    If LicenseSupplyProtection
        If LicenseSupplyBikini
            LicenseSupplyBikini = 0
            licenseStates[2] = StateWaitDisable
            RevokeLicense(2)
        EndIf
        If LicenseSupplyArmor
            LicenseSupplyArmor = 0
            licenseStates[3] = StateWaitDisable
            RevokeLicense(3)
        EndIf
    EndIf
    If LicenseSupplyClothes
        LicenseSupplyClothes = 0
        licenseStates[4] = StateWaitDisable
        RevokeLicense(4)
    EndIf
    If LicenseSupplyWhore
        LicenseSupplyWhore = 0
        licenseStates[5] = StateWaitDisable
        RevokeLicense(5)
    EndIf
    If LicenseSupplyCurfew
        LicenseSupplyCurfew = 0
        licenseStates[6] = StateWaitDisable
        RevokeLicense(6)
    EndIf

    ; Don't stop and reset, that happens at stage 100.
EndFunction



; Values: -1: Licence type disabled, 0: Does not have licence or licence expired, 1: Has a valid licence
Bool Function HaveLicense(Int licenseID)
    String storageToken = licenseTokens[licenseID]
    Return StorageUtil.GetIntValue(None, storageToken, -2) > 0
EndFunction

Bool Function CanGetLicense(Int licenseID)
    String storageToken = licenseTokens[licenseID]
    Return StorageUtil.GetIntValue(None, storageToken, -2) == 0
EndFunction

Bool Function IsLicenseDisabledInSLS(Int licenseID)

    If licenseID > 4 && !FixedSLS
        Return True
    EndIf

    String storageToken = licenseTokens[licenseID]
    ; Though -1 is disabled, -2 means SLS hasn't set it yet, so assume disabled in that case.
    Return StorageUtil.GetIntValue(None, storageToken, -2) < 0 
EndFunction

Int Function GetLicenseEnabledInSLS(Int licenseID)
    If IsLicenseDisabledInSLS(licenseID)
        Return 0
    Else
        Return 1
    EndIf
EndFunction


Function DumpLicenseStates()

    If ShowDiagnostics
        Debug.TraceConditional("DF - DumpLicenses... ", True)
        If HaveLicense(0)
            Debug.TraceConditional("DF - DumpLicenses - 0 - Weapon   " + licenseTokens[0], True)
        EndIf
        If HaveLicense(1)
            Debug.TraceConditional("DF - DumpLicenses - 1 - Magic    " + licenseTokens[1], True)
        EndIf
        If HaveLicense(2)
            Debug.TraceConditional("DF - DumpLicenses - 2 - Bikini   " + licenseTokens[2], True)
        EndIf
        If HaveLicense(3)
            Debug.TraceConditional("DF - DumpLicenses - 3 - Armor    " + licenseTokens[3], True)
        EndIf
        If HaveLicense(4)
            Debug.TraceConditional("DF - DumpLicenses - 4 - Clothes  " + licenseTokens[4], True)
        EndIf
        If HaveLicense(5)
            Debug.TraceConditional("DF - DumpLicenses - 5 - Whore  " + licenseTokens[5], True)
        EndIf
    EndIf
EndFunction


; Issue a license...
; Int LicenceType, Int TermDuration, Form Issuer, Form GiveLicTo, Bool DeductGold, Form Sender
; LicenceType: 0 - Magic, 1 - weapons, 2 - Armor, 3 - Bikini, 4 - Clothes.
;              5 - Curfew, 6 - Whore, 7 - Freedom, 8 - Property. -1 = Not set -> set via dialogue
; - TermDuration: 0 - Short term, 1 - Long term, 2 - Perpetual
; - Issuer: The actor who's name will appear on the licence as having issued it to the player. 
; - GiveLicTo: The object reference to give the licence to. Usually the player but can be a container etc. Can be None, in which case the licence won't be moved. 
; - DeductGold: Remove the usual cost from the player. Won't matter if the player hasn't enough gold
; - Sender: A form that identifies your mod (Eg. your quest). The form you send to survival will be sent back to you with the ObjectReference for the licence that was issued. You'll know it was your mod that requested the licence if the forms match. 
; Based on example in the SLS API
Function RequestLicence(Int licenseID, Int term, Form issuer, Bool deductGold = False)

    Debug.TraceConditional("DF - RequestLicense " + licenseID, ShowDiagnostics)
    
    Debug.Notification("Getting you a " + licenseNames[licenseID] + " license")
    
    Int licenseType
    ; Convert my licenseID to SLS licenseType
    If 0 == licenseID
        licenseType = 1 ; Weapon
    ElseIf 1 == licenseID
        licenseType = 0 ; Magic
    ElseIf 2 == licenseID
        licenseType = 3 ; Bikini
    ElseIf 3 == licenseID
        licenseType = 2 ; Armor
    ElseIf 4 == licenseID
        licenseType = 4 ; Clothes
    ElseIf 5 == licenseID
        licenseType = 6 ; Whore
    ElseIf 6 == licenseID
        licenseType = 5 ; Curfew
    ElseIf 7 == licenseID
        licenseType = 8 ; Property
    ElseIf 8 == licenseID
        licenseType = 7 ; Freedom
    Else
        Debug.TraceConditional("DF - RequestLicense - unsupported license ID " + licenseID, ShowDiagnostics)
        Return
    EndIf
    Debug.TraceConditional("DF - RequestLicense SLS type " + licenseType, ShowDiagnostics)
    
    Int eventID = ModEvent.Create("_SLS_IssueLicence")
    If eventID
        ModEvent.PushInt(eventID, licenseType)
        ModEvent.PushInt(eventID, term)
        ModEvent.PushForm(eventID, issuer)
        ModEvent.PushForm(eventID, PlayerRef)
        ModEvent.PushBool(eventID, deductGold)
        ModEvent.PushForm(eventID, self As Form)
        ModEvent.Send(eventID)
    EndIf
    
    If FixedSLS
        Utility.Wait(0.1)
    Else
        Utility.Wait(5.0)
    EndIf
    
EndFunction


Function ChargeForLicense(Int licenseID)
    
    ; No per-license price differences...
    _DFlow.ChargeForSLSLicense(BasePrice, Markup)
    
EndFunction



Function SetBlockLicensePurchases(Bool blockPurchase = True)
    Int eventID = ModEvent.Create("_SLS_BlockLicenceBuy")
    If eventID
        ModEvent.PushForm(eventID, self As Form)
        ModEvent.PushBool(eventID, blockPurchase)
        ModEvent.Send(eventID)
    EndIf
EndFunction

Bool Function IsLicensePurchaseBlocked()
    Return StorageUtil.FormListCount(None, "_SLS_LicenceBlockingForms") > 0
EndFunction


Function RevokeLicenseByID(Int index)
    RevokeLicense(licenseNames[index])
EndFunction

Function RevokeAllLicenses()
    RevokeLicense("All")
EndFunction

Function RevokeRandomLicense()
    RevokeLicense("Random")
EndFunction

; Revoke licences.
; Type can be:
; "All" - Revoke all licences
; "Random" - Revoke a random licence type the player has.
; "Magic"
; "Weapon"
; "Armor"
; "Bikini"
; "Clothes"
; "Curfew"
; "Whore"
; "Freedom"
; "Property"
; See licenseNames ... though there are additional strings you can pass here: All and Random.
Function RevokeLicense(String licenseType)
    Int eventID = ModEvent.Create("_SLS_RevokeLicence")
    If eventID
        ModEvent.PushString(eventID, "_SLS_RevokeLicence") ; This isn't checked, but whatever...
        ModEvent.PushString(eventID, licenseType)
        ModEvent.PushString(eventID, 0.0) ; Not used.
        ModEvent.PushForm(eventID, self As Form)
        ModEvent.Send(eventID)
    EndIf
EndFunction

; This doesn't really interface with SLS - and doesn't use any SLS types.
; It's safe not to shim this; it's just getting Location forms from vanilla.
Function PopulateLicenseLocations()

    Form[] locations = New Form[5]
    locations[0] = Game.GetForm(0x00016DF4) ; Markarth
    locations[1] = Game.GetForm(0x00045A1D) ; Riften
    locations[2] = Game.GetForm(0x000213A0) ; Solitude
    locations[3] = Game.GetForm(0x000580A2) ; Whiterun
    locations[4] = Game.GetForm(0x0001677A) ; Windhelm
    
    Int ii = 5
    While ii
        ii -= 1
        Form loc = locations[ii]
        If loc
            Debug.TraceConditional("DF - adding QM location " + loc.GetName() + ", id " + loc.GetFormId(), ShowDiagnostics)
            _DFLicenseLocations.AddForm(loc)
        EndIf
    EndWhile

EndFunction


State Busy

    Function TryResumeLicensing()
        Debug.TraceConditional("DF - TryResumeLicensing - BUSY", True)
    EndFunction
    
    Function TryStop()
        Debug.TraceConditional("DF - TryStop - BUSY", True)
    EndFunction

    Function UpdateLicenseStates()
        Debug.TraceConditional("DF - UpdateLicenseStates - BUSY", True)
    EndFunction
    
EndState

; QuarterMaster cells
; Hold       Cell     Quartermaster             ID       Location
; Markarth 00016DF4 - Surgug                - 00046774
; Riften   00045A1D - Okan-Jei              - 00046775
; Solitude 000213A0 - Ancolanar             - 00046772
; Whiterun 000580A2 - Trilbjorn Stone-Tooth - 00046213 - 0007312F
; Windhelm 0001677A - Erilas                - 00046773
