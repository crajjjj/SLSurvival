Scriptname slaMainScr extends Quest  

Int Function GetCurrentVersion()
    Return 20190720
EndFunction


; FOLDSTART - Properties

slaInternalScr Property slaUtil Auto
slaConfigScr Property slaConfig Auto
Spell Property slaCloakSpell Auto
Spell Property slaDesireSpell Auto
GlobalVariable Property slaNextTimePlayerNaked Auto
Quest Property slaScanAll Auto
Quest Property slaNakedNPC Auto
Keyword Property armorCuirass Auto
Keyword Property clothingBody Auto
Faction Property slaNaked Auto
GlobalVariable Property sla_NextMaintenance  Auto
GlobalVariable Property sla_AnimateFemales Auto
GlobalVariable Property sla_AnimateMales Auto
GlobalVariable Property sla_AnimationThreshhold Auto
GlobalVariable Property sla_UseLineOfSight Auto
Formlist Property sla_NakedArmorList Auto
Float Property updateFrequency = 120.00 Auto Hidden
Int[] Property actorTypes Auto Hidden ; [0] = 43/kNPC [1] = 44/kLeveledCharacter [2] = 62/kCharacter
SexLabFramework Property sexLab Auto ; SexLab
Actor Property playerRef Auto
GlobalVariable Property gameDaysPassed Auto
Quest Property slaScanAllNpcs Auto

; FOLDEND - Properties


; FOLDSTART - Variables

Float lastSexFinished = 0.00

Int previousPlayerArousal = 0;
Float lastNotificationTime = 0.0;
Actor crosshairRef = None

Bool wasPlayerRaped = False;
Bool bWasInitialized = False
Bool bUseLOS = False
Bool bNakedOnly = True
Bool bDisabled = False

; Bool bIsLocked = False ; Gone because we have genuine atomic locks - use SlaInternals.TryLock and SlaInternals.Unlock
; Int [] lockingInts ; Gone because we have genuine atomic locks

Actor[] theActors
Int _Internal_actorCount
Float lastActorScanTime

Bool haveSLSO

; FOLDEND - Variables


; FOLDSTART - Quasi constants

Int modVersion = 0;
Keyword nakedArmorWord
Keyword zadDeviousBelt = None
Float arousalSearchRadius = 2048.0

; FOLDEND - Quasi constants



State cleaning

    Event OnUpdate()
    
        GotoState("")
        
        slax.Info("SLAX - cleaning state - OnUpdate")
        CleanActorStorage()
        RegisterForSingleUpdate(updateFrequency)
        
    endEvent
    
EndState


State initializing

    Event OnUpdate()
        
        slax.Info("SLAX - initialize state - OnUpdate")

        If modVersion < GetCurrentVersion()
            slaConfig.IsUseSOS = False
            slaConfig.slaPuppetActor = playerRef
            ;slaConfig.TimeRateHalfLife = 2.0
            ;slaConfig.SexOveruseEffect = 5
            
            slaUtil = Quest.GetQuest("sla_Internal") As slaInternalScr
            slaConfig.slaUtil = slaUtil
            
            ; Remove antique cloak spell
            If(playerRef.HasSpell(slaCloakSpell))
                playerRef.RemoveSpell(slaCloakSpell)    
            EndIf
        EndIf
        
        If !slaUtil
            slaUtil = Quest.GetQuest("sla_Internal") As slaInternalScr
        EndIf
        

        SetVersion(GetCurrentVersion())
        
        slaNextTimePlayerNaked.SetValue(0.0)    
            
        RegisterForModEvents()
        
        RegisterForCrosshairRef()
        
        nakedArmorWord = Keyword.GetKeyword("EroticArmor")
        
        slax.Info("SLAX - Initialize state - set up key handling")
        UnregisterForAllKeys()
        UpdateKeyRegistery()

        
        String deviousDevicesAssets = "Devious Devices - Assets.esm"
        Int ddAssetsId = Game.GetModByName(deviousDevicesAssets)
        
        If 255 != ddAssetsId
            slax.Info("SLAX found Devious Devices - Assets.esm")
            zadDeviousBelt = Game.GetFormFromFile(0x02003330, deviousDevicesAssets) As Keyword
        Else
            zadDeviousBelt = None
        EndIf

        UpdateDesireSpell()


        
        slax.Info("SLAX - return to empty state")
        GotoState("")
        RegisterForSingleUpdate(updateFrequency) ;Start scanning in two minutes
        bWasInitialized = True

        If(slaConfig.wantsPurging && (GameDaysPassed.getValue() >= sla_NextMaintenance.getValue()))
            StartCleaning()
        EndIf
        
    EndEvent

EndState


; State - EMPTY

Int Function IsAnimatingFemales()
    Return sla_AnimateFemales.getValue() As Int
EndFunction

Function SetIsAnimatingFemales(Int newValue)
    sla_AnimateFemales.setValue(newValue)
EndFunction

Int Function IsAnimatingMales()
    Return sla_AnimateMales.getValue() As Int
EndFunction

Function SetIsAnimatingMales(Int newValue)
    sla_AnimateMales.setValue(newValue)
EndFunction

Int Function GetAnimationThreshold()
    Return sla_AnimationThreshhold.getValue() As Int
EndFunction

Function SetAnimationThreshold(Int newValue)
    sla_AnimationThreshhold.setValue(newValue)
EndFunction


Int Function GetUseLOS()

    Return sla_UseLineOfSight.GetValue() As Int
    
EndFunction

Int Function GetNakedOnly()
    Return bNakedOnly As Int
EndFunction

Function SetNakedOnly(Int newValue)
    bNakedOnly = newValue As Bool
EndFunction

Int Function GetDisabled()
    Return bDisabled As Int
EndFunction

Function SetDisabled(Int newValue)
    bDisabled = newValue As Bool
EndFunction

Function SetUseLOS(Int newValue)
    sla_UseLineOfSight.setValue(newValue)
    bUseLOS = newValue As Bool
EndFunction


Function SetUpdateFrequency(Float frequency)

    updateFrequency = frequency
    If(bWasInitialized)
        UnregisterForUpdate()
        RegisterForSingleUpdate(updateFrequency)
    EndIf
    
EndFunction 

Event OnInit()
EndEvent

Function SetCleaningTime()
    Float nextTime = GameDaysPassed.GetValue() + 10.0 
    sla_NextMaintenance.SetValue(nextTime)
EndFunction


; This always runs on load
Function Maintenance()

    UnregisterForUpdate()
    GotoState("initializing")
    
    bWasInitialized = False

    ActorTypes = new Int[3]
    ActorTypes[0] = 43
    ActorTypes[1] = 44
    ActorTypes[2] = 62
    
    lastActorScanTime = 0
    SlaInternals.ClearLocks()
    lastSexFinished = 0.00
    bUseLOS = GetUseLOS() As Bool
    
    slax.Info("SLAX - trigger maintenance OnUpdate in 10.0 seconds")
    
    RegisterForSingleUpdate(10.0)

EndFunction


Function StartCleaning()

    UnregisterForUpdate()
    GotoState("cleaning")
    RegisterForSingleUpdate(10.0)
    
EndFunction


Bool Function IsSexLabActive()

    Int ii = SexLab.Threads.Length
    While ii
        ii -= 1
        If SexLab.Threads[ii].IsLocked
            Return True ; // There is a locked/active thread.
        EndIf
    EndWhile
    
    Return False ; // No threads where locked/active
    
EndFunction


; This handles the locking - callers should NO LONGER TRY TO pre-LOCK, that WAS A BROKEN PATTERN.
Int Function GetAllActors(Int lockID)
    slax.EnableDebugSpam(True)
    slax.DebugSpam_SetInfo()
    slax.Info("SLAX - GetAllActors(" + lockID + ")")
    
    ; Fails if ANY lock already taken
    If(!SlaInternals.TryLock(lockID))
        slax.Info("SLAX - GetAllActors(" + lockID + ") - LOCK NOT TAKEN")
        ;Debug.Trace("Was locked, returning lock failed indicator")
        Return -1 ; Lock not taken
        
    EndIf
    
    ; TODO: can add feature here to never process creatures for arousal ... some might find it useful (use slaScanAllNpcs)
    slaScanAllScript scanner = slaScanAll As slaScanAllScript
    Float now = Utility.GetCurrentRealTime()    ; In seconds
    
    slax.Info("SLAX - GetAllActors(" + lockID + ") - start scan at " + now)
    
    If now - lastActorScanTime > 10.0           ; Don't rescan actors if not enough time passed
    
        _Internal_actorCount = scanner.GetArousedActors()
        slax.Info("SLAX - GetAllActors - scanned " + _Internal_actorCount + " local actors")

        lastActorScanTime = now
        
    EndIf
    
    ; Each theActors array is a unique array - so if another instance modifies it, it's completely safe.
    theActors = SlaInternals.DuplicateActorArray(scanner.arousedActors, _Internal_actorCount)

    ; Note lock got taken above, and must be released at some point.
    SlaInternals.Unlock(lockID)

    Float final = Utility.GetCurrentRealTime()
    slax.Info("SLAX - GetAllActors(" + lockID + ") - end scan at " + now + " = " + (final - now) + " seconds")
    slax.Info("SLAX - got " + theActors.Length + " actors")
    
    Return theActors.Length

EndFunction

; Deprecated - don't call this, use GetAllActors() directly instead.
Actor[] Function GetLoadedActors(Int lockID)

    Int actorCount = GetAllActors(LockID)
    If actorCount < 0
        Return None
    EndIf
    Return theActors
    
EndFunction

; Deprecated - does nothing - routines it locked handle their own locking now
Int Function LockScan(Int lockID)
    Return -1
EndFunction

; Deprecated - does nothing - routines it unlocked handle their own locking now
Bool Function UnlockScan(Int lockID)
    Return True
EndFunction


; Deprecated - does nothing - routines it checked locks on handle their own locking now
Bool Function CheckForLock(Int lockID)
    Return False
EndFunction


; Deprecated - does nothing - routines it checked locks on handle their own locking now
; This was internal and should never have been called by externals anyway, but who can say?
Function CheckForLocks()
EndFunction


Event OnUpdate()

    If (lastSexFinished > 0) &&  ((Utility.GetCurrentRealTime() - lastSexFinished) < 10.0)
        ; Aroused scan skipped because sexlab was animating within the last 10 seconds.
        RegisterForSingleUpdate(updateFrequency)
        Return
    EndIf
    
    If bDisabled || IsSexLabActive()
        ; Aroused scan skipped because sexlab is animating or disabled
        RegisterForSingleUpdate(updateFrequency)
        Return
    EndIf
    
    UpdateActorArousals()

    ; Subtle difference - sends mod event before scheduling update - SLAR did the opposite, which could lead to re-entrance.
    RegisterForSingleUpdate(updateFrequency) ; default is 120 seconds, but may vary.
    
EndEvent


; This is not exclusive with the GetAllActors() call on ArouseNPCsWithinRadius()
; Further, both can run and "GetAllActors()" - they don't hold the lock for their entire execution, only while needed.
; However, GetAllActors has been made smart enough to DO NOTHING and just return the old results if called with high frequency.
Function UpdateActorArousals()
    Int actorCount = GetAllActors(2) ; LOCK THE ACTORS
    If actorCount < 0
        Debug.Trace("UpdateActorArousals - GetAllActors already locked")
        Return
    EndIf
    
    Actor[] updateActors = PapyrusUtil.PushActor(theActors, playerRef)
    actorCount += 1 
    slaNakedScript nakedScanner = (slaNakedNPC As slaNakedScript)
    Int nakedCount = nakedScanner.GetNakedActors()
    Actor[] nakedActors = nakedScanner.nakedActors
    Bool isPlayerNaked = IsActorNaked(playerRef)
    ; Track updated actors so we can call slaUtil.GetActorArousal on any that weren't updated through another path.
    Bool[] updated = Utility.CreateBoolArray(actorCount)
    
    If isPlayerNaked
        Int ii = actorCount
        While ii > 0
            ii -= 1
            Actor observer = updateActors[ii]
            If observer != playerRef
                UpdateNakedArousal(observer, playerRef)
                updated[ii] = True
            EndIf
        EndWhile
    EndIf
    

    
    If bNakedOnly
        ; Only handle updates on genuinely naked actors... NPC or Player.
        
        
    
        If nakedCount > 0
        
            Int ii = actorCount
            While ii > 0
                ii -= 1
                Actor observer = updateActors[ii]
                Int jj = nakedCount
                While jj > 0
                    jj -= 1
                    Actor naked = nakedActors[jj]
                    If observer != naked
                        UpdateNakedArousal(observer, naked)
                        updated[ii] = True
                    EndIf
                EndWhile
            EndWhile
        EndIf
        
        Int kk = actorCount
        While kk
            kk -= 1
            If !updated[kk]
                slaUtil.GetActorArousal(updateActors[kk])
            EndIf
        EndWhile
        
    Else
        ; Handle everyone, naked or not.
        ; In this case we handle updates for sexy clothes and other new features in UpdateClothedArousal
        
        Int ii = actorCount
        While ii > 0
            ii -= 1
            Actor observer = updateActors[ii]
            
            Int jj = actorCount
            While jj > 0
                jj -= 1
                Actor observed = updateActors[jj]
                
                If observer != observed
                    If nakedActors.Find(observed) >= 0
                        UpdateNakedArousal(observer, observed)
                    Else
                        UpdateClothedArousal(observer, observed) ; New!!!
                    EndIf
                EndIf
            EndWhile
        EndWhile
    
    EndIf
    
    SendModEvent("sla_UpdateComplete", None, actorCount)

EndFunction


;Called by external programs using a modevent like
;Int eid = ModEvent.Create("eventname")
;ModEvent.PushForm(eid, Actor)
;ModEvent.PushFloat(eid, 3.5)
;ModEvent.Send(eid)

Event ModifyExposure(Form actorForm, Float exposureValue)

    Actor who = actorForm As Actor
    If who
        slaUtil.FloatUpdateActorExposure(who, exposureValue, "external ModifyExposure event")
    EndIf
    
EndEvent


Function UpdateNakedArousal(Actor who, Actor observed)
    If !who || !observed
        Return
    EndIf
    
    Bool hasLos = True

    If bUseLOS
        hasLos = who.HasLOS(observed)
    EndIf

    If hasLos
        
        Int genderPreference = slaUtil.GetGenderPreference(who)
        
        If genderPreference == 2 || genderPreference == observed.GetLeveledActorBase().GetSex()
            slaUtil.FloatUpdateActorExposure(who, 4.0, "seeing naked " + observed.GetLeveledActorBase().GetName())
        Else
            slaUtil.FloatUpdateActorExposure(who, 2.0, "seeing naked " + observed.GetLeveledActorBase().GetName())
        EndIf

        If slaUtil.GetActorTimeSinceLastSeenNaked(observed) >= slaConfig.ExhibitionismCooldown
            StorageUtil.FormListClear(observed, "SLAroused.Voyeurs")
            If LewdMod() > 0
                slaUtil.UpdateActorExhibitionism(observed, slaConfig.Exhibitionism as Float - (slaConfig.Exhibitionism as Float/2 - (slaConfig.Exhibitionism*(LewdMod()*0.05)) * SexLab.Stats.GetSkillLevel(observed, "Lewd", 0.3)))
            Else
                slaUtil.UpdateActorExhibitionism(observed, slaConfig.Exhibitionism)
            EndIf
            StorageUtil.FormListAdd(observed, "SLAroused.Voyeurs", who)
        ElseIf !StorageUtil.FormListHas(observed, "SLAroused.Voyeurs", who)
            If LewdMod() > 0
                slaUtil.UpdateActorExhibitionism(observed, slaConfig.ExhibitionismAdditional as Float - (slaConfig.ExhibitionismAdditional as Float/2 - (slaConfig.ExhibitionismAdditional*(LewdMod()*0.05)) * SexLab.Stats.GetSkillLevel(observed, "Lewd", 0.3)))
            Else
                slaUtil.UpdateActorExhibitionism(observed, slaConfig.ExhibitionismAdditional)
            EndIf
            StorageUtil.FormListAdd(observed, "SLAroused.Voyeurs", who)
        EndIf

        If slaUtil.GetActorExhibitionism(observed) >= slaConfig.ExhibitionismThreshold
            slaUtil.SetActorExhibitionist(observed)
        ElseIf slaUtil.IsActorExhibitionist(observed)
            slaUtil.SetActorExhibitionist(observed)
        EndIf
            
        If slaUtil.IsActorExhibitionist(observed)
            slaUtil.FloatUpdateActorExposure(observed, 2.0, "being exhibitionist to " + who.GetLeveledActorBase().GetName())
        EndIf
        
    EndIf
    
EndFunction


Function UpdateClothedArousal(Actor who, Actor observed)

EndFunction


; Note to modders : do not call IsActorNaked() because it is expensive - check sla_Naked faction rank instead
Bool Function IsActorNaked(Actor who)

    If !who
        Return False
    EndIf

    Bool isNaked = IsActorNakedVanilla(who)
    
    If !isNaked
        ; Consider 'naked armor for NPC' option
        If who == playerRef || slaConfig.IsExtendedNPCNaked
            isNaked = IsActorNakedExtended(who)
        EndIf
    EndIf

    If isNaked
        who.SetFactionRank(slaNaked, 0)
    Else
        who.SetFactionRank(slaNaked, -2)
    EndIf
    
    Return isNaked
    
EndFunction


Bool Function IsActorNakedVanilla(Actor who)

    Return !(who.WornHasKeyword(ArmorCuirass) || who.WornHasKeyword(ClothingBody))
    
EndFunction


Bool Function IsActorNakedExtended(Actor who)
    ; Can't just use WornHasKeyword, because we're trying to establish nakedness, not simply presence of a flagged armor.

    Armor armorToCheck = who.GetWornForm(0x00000004) As Armor ; Slot 32 - body
    If armorToCheck
        If armorToCheck.HasKeyword(nakedArmorWord) ; Naked in body slot overrides other armors.
            Return True
        EndIf
        If StorageUtil.GetIntValue(armorToCheck, "SLAroused.IsNakedArmor") > 0
            Return True
        EndIf
        If armorToCheck.HasKeyword(ArmorCuirass) || armorToCheck.HasKeyword(ClothingBody)
            ;wearing slot 32 that is not naked
            Return False
        EndIf
    EndIf
    
    ; Old code called GetEquippedArmors, which was a cut+paste of the same code in the MCM...
    ; ... it took several seconds to complete ...
    ; This was likely the reason for the option to disable NPC naked armors, as even the PC check alone would take several seconds!
    
    ; Instead just check feasible bikini slots... This is NOT the same code As GetBikiniArmorsForTargetActor in the MCM.
    ; It's still expensive, but it's an order faster than it was, as the cost of being a little more picky about its conditions.
    
    ; The extent to which this improves the responsiveness of arousal with armors in play is not to be underestimated, as the cost
    ; before this change was several seconds *per* npc tested.
    
    ; It was also written to get all armors THEN test them for nakedness - so it always paid the full fetch price, even if an armor could be found on the first try.
    String orderCacheKey = "sla_AuxilliaryArmorSlots"
    Int[] slotsToTest = StorageUtil.IntListToArray(slaConfig, orderCacheKey)
    
    If !slotsToTest || slotsToTest.Length != 7
        slotsToTest = new Int[7]
        slotsToTest[0] = Math.LeftShift(1, 14) ; slot 44
        slotsToTest[1] = Math.LeftShift(1, 15) ; slot 45
        slotsToTest[2] = Math.LeftShift(1, 18) ; slot 48
        slotsToTest[3] = Math.LeftShift(1, 19) ; slot 49
        slotsToTest[4] = Math.LeftShift(1, 22) ; slot 52
        slotsToTest[5] = Math.LeftShift(1, 26) ; slot 56
        slotsToTest[6] = Math.LeftShift(1, 28) ; slot 58
        StorageUtil.IntListCopy(slaConfig, orderCacheKey, slotsToTest)
    EndIf

    Int ii = 0
    While ii < 7
        Armor candidate = who.GetWornForm(slotsToTest[ii]) As Armor
        ; We can early-out if we find a naked armor
        If candidate
        
            If candidate.HasKeyword(ArmorCuirass) || candidate.HasKeyword(ClothingBody)
                ; Look for an alternative to body covering armor that would make the character appear non-naked
                If (StorageUtil.GetIntValue(candidate, "SLAroused.IsNakedArmor") < 1) && !candidate.HasKeyword(nakedArmorWord)
                    Return False
                EndIf
                
            EndIf
        
        EndIf
        
        ii += 1
    EndWhile
    
    Return True ; Nothing found, naked after all...
    
EndFunction


; DEPRECATED
; Left this extremely slow function in case some other mods are referencing it.
Form[] Function GetEquippedArmors(Actor who)
    Form[] armorList

    If (who == None)
        Return armorList
    EndIf
        
    Int[] slaSlotMaskValues = slaConfig.slaSlotMaskValues
        
    Int index = 0
    While index < slaSlotMaskValues.length
        Form tmpForm = who.GetWornForm(slaSlotMaskValues[index])
        
        If (tmpForm != None)
            If (armorList.Find(tmpForm) < 0)
                armorList = sslUtility.PushForm(tmpForm, armorList)
            EndIf
        EndIf
        
        index += 1
    EndWhile
    
    Return armorList
EndFunction


Function UpdateCloakEffect()
; DEPRECATED - removed - does nothing - left in case some mod depends on it.
EndFunction


Int Function GetVersion()   
    Return modVersion
EndFunction


Function UpdateKeyRegistery() ; Wish I could fix the spelling of this.

    slax.Info("SLAX - UpdateKeyRegistry - key " + slaConfig.NotificationKey)
    RegisterForKey(slaConfig.NotificationKey)
    
EndFunction


Function SetVersion(Int  newVersion)

    If modVersion < newVersion
        modVersion = newVersion
    ElseIf (modVersion > newVersion)
        Debug.Notification("SexLab Aroused error : downgrading to version " + newVersion + " is not supported")
    EndIf
    
EndFunction


Function UpdateDesireSpell()

    If slaConfig.IsDesireSpell
        playerRef.RemoveSpell(slaDesireSpell)
        playerRef.AddSpell(slaDesireSpell, False)
    Else
        playerRef.RemoveSpell(slaDesireSpell)
    EndIf
    
EndFunction


Event OnKeyDown(Int keyCode)    

    slax.Info("SLAX - Key DOWN - key code " + keyCode + " expecting " + slaConfig.NotificationKey)
    If !Utility.IsInMenuMode() && slaConfig.NotificationKey == keyCode

        slax.Info("SLAX - performing key action")
        Debug.Notification(playerRef.GetLeveledActorBase().GetName() + " arousal level " + slaUtil.GetActorArousal(playerRef))
        
        If crosshairRef
            Debug.Notification(crosshairRef.GetLeveledActorBase().GetName() + " arousal level " + slaUtil.GetActorArousal(crosshairRef))
            slaConfig.slaPuppetActor = crosshairRef
        Else
            slaConfig.slaPuppetActor = playerRef
        EndIf
    EndIf
    
EndEvent


Event OnKeyUp(Int KeyCode, Float HoldTime)

    If !Utility.IsInMenuMode() && slaConfig.NotificationKey == keyCode
        If (HoldTime > 2.0)
            StartPCMasturbation()
        EndIf
    EndIf
    
EndEvent


Function StartPCMasturbation()

    slax.Info("SLAX - StartPCMasturbation")
    ; TODO - hook into SLD masturbation if present
    
    sslBaseAnimation[] animations
    Actor[] sexActors = new Actor[1]
    sexActors[0] = playerRef
            
    If 0 == playerRef.GetLeveledActorBase().GetSex()
        animations = SexLab.GetAnimationsByTag(1, "Masturbation", "M")
    Else
        animations = SexLab.GetAnimationsByTag(1, "Masturbation", "F")
    EndIf
            
    Int id = SexLab.StartSex(sexActors, animations)
    If id < 0
        Debug.Notification("SexLab animation failed to start [" + id + "]")
    EndIf
    
EndFunction


Event OnCrosshairRefChange(ObjectReference ref)

    crosshairRef = ref as Actor
    
EndEvent


Event OnStageStart(string eventName, string argString, float argNum, form sender)

    slax.Info("SLAX - OnStageStart - " + eventName + " : " + argString + " : " + argNum)

    Actor[] actorList = SexLab.HookActors(argString)
    
    If (actorList.Length < 1)
        Return
    EndIf
    
    sslThreadController thisThread = SexLab.HookController(argString)
    
    If (thisThread.animation.HasTag("Foreplay"))
        Int ii = 0
        While ii < actorList.length
            slaUtil.FloatUpdateActorExposure(actorList[ii], 1.0, "foreplay")
            ii += 1
        EndWhile
    EndIf
    
    ; Use player as arousal center if available.
    If actorList.Find(PlayerRef) >= 0
        ArouseNPCsWithinRadius(playerRef, arousalSearchRadius)
    Else
        ArouseNPCsWithinRadius(actorList[0], arousalSearchRadius)
    EndIf
    
EndEvent


; From event OrgasmEnd - non SLSO
Event OnAnimationEnd(String eventName, String argString, Float argNum, Form sender)

    lastSexFinished = Utility.GetCurrentRealTime() ; Always update this

    slax.Info("SLAX - OnAnimationEnd - " + eventName + " : " + argString + " : " + argNum)

    
    Actor[] actorList = SexLab.HookActors(argString)
    If (actorList.Length < 1)
        Return
    EndIf

    sslThreadController thisThread = SexLab.HookController(argString)
    Actor victim = SexLab.HookVictim(argString)
    sslBaseAnimation animation = SexLab.HookAnimation(argString)
    
    If victim
        If victim == PlayerRef
            wasPlayerRaped = True
        EndIf
        slaUtil.FloatUpdateActorExposure(victim, -10.0, "being rape victim")
    EndIf
    
    Bool[] canOrgasm = FindAnimationCanOrgasm(animation)
    
    Float animationDuration = GetAnimationDuration(thisThread)
    Float timeFactor = thisThread.TotalTime / animationDuration
    slax.Info("SLAX - OnAnimationEnd - animationDuration " + animationDuration + ", totalTime " + thisThread.TotalTime + ", timeFactor " + timeFactor)

    Float exposureValue = timeFactor * -20.0

    Int ii = actorList.Length
    While ii
    
        ii -= 1
        Bool willOrgasm = FindActorWillOrgasm(animation, canOrgasm, actorList, ii)
        
        If willOrgasm
            slaUtil.UpdateActorOrgasmDate(actorList[ii])
            slaUtil.FloatUpdateActorExposure(actorList[ii], exposureValue, "having orgasm")
        EndIf
        
    EndWhile
    
EndEvent

Int Function LewdMod()
    If HaveSLSO()
        Return JsonUtil.GetIntValue("/SLSO/Config", "sl_sla_orgasmexposuremodifier")
    Else
        Return slaConfig.LewdMod
    EndIf
EndFunction

Event OnSexLabAnimationEnd(String eventName, String argString, Float argNum, Form sender)
    sslThreadController controller = SexLab.GetController(argString As Int)
    Actor[] actorList = SexLab.HookActors(argString)
    Actor akVictim = SexLab.HookVictim(argString)
    Int i = 0
    While i < actorList.Length
        If actorList[i]
            Int orgasmCount = (controller.ActorAlias(actorList[i]) as sslActorAlias).GetOrgasmCount()
            If actorList[i] == akVictim
                If orgasmCount == 0 && LewdMod() > 0
                    slaUtil.UpdateActorFrustration(actorList[i], slaConfig.Frustration as Float - (slaConfig.Frustration as Float/2 - (slaConfig.Frustration*(LewdMod()*0.05)) * SexLab.Stats.GetSkillLevel(actorList[i], "Lewd", 0.3)))
                EndIf
	        	If LewdMod() > 0
	        		slaUtil.UpdateActorMasochism(actorList[i], slaConfig.Masochism as Float - (slaConfig.Masochism as Float/2 - (slaConfig.Masochism*(LewdMod()*0.05)) * SexLab.Stats.GetSkillLevel(actorList[i], "Lewd", 0.3)))
	        	Else
	        		slaUtil.UpdateActorMasochism(actorList[i], slaConfig.Masochism)
	        	EndIf
                StorageUtil.SetFloatValue(actorList[i], "SLAroused.LastRapeDate", Utility.GetCurrentGameTime())
            ElseIf orgasmCount == 0
            	slaUtil.UpdateActorFrustration(actorList[i], slaConfig.Frustration as Float)
            EndIf
        EndIf
        i += 1
    EndWhile
EndEvent

Event OnSexLabAnimationStart(String eventName, String argString, Float argNum, Form sender)
    Actor[] actorList = SexLab.HookActors(argString)
    Actor akVictim = SexLab.HookVictim(argString)
    Int i = 0
    While i < actorList.Length
    	If akVictim 
    		If actorList[i] != akVictim && slaUtil.GetActorExposure(actorList[i]) < slaConfig.MinRapeStartArousal
    			slaUtil.SetActorExposure(actorList[i], slaConfig.MinRapeStartArousal)
    		EndIf
    	ElseIf slaUtil.GetActorExposure(actorList[i]) < slaConfig.MinStartArousal
    		slaUtil.SetActorExposure(actorList[i], slaConfig.MinStartArousal)
    	EndIf
        If actorList[i] == akVictim
            If LewdMod() > 0
                Float FrustrationLossModded = -slaConfig.FrustrationLoss as Float/2 + (slaConfig.FrustrationLoss*(LewdMod()*0.05)) * SexLab.Stats.GetSkillLevel(actorList[i], "Lewd", 0.3)
                If FrustrationLossModded > 0
                    FrustrationLossModded = 0
                EndIf
                slaUtil.UpdateActorFrustration(actorList[i], FrustrationLossModded)
            Else
                slaUtil.UpdateActorFrustration(actorList[i], -slaConfig.FrustrationLoss)
            EndIf
            If LewdMod() > 0
                slaUtil.UpdateActorTrauma(actorList[i], slaConfig.Trauma as Float/2 - (slaConfig.Trauma*(LewdMod()*0.05)) * SexLab.Stats.GetSkillLevel(actorList[i], "Lewd", 0.3))
            Else
                slaUtil.UpdateActorTrauma(actorList[i], slaConfig.Trauma)
            EndIf
        EndIf
        i += 1
    EndWhile
EndEvent

; From event StageStart
Event OnStageStartSLSO(String eventName, String argString, Float argNum, Form sender)

    slax.Info("SLAX - OnStageStartSLSO - " + eventName + " : " + argString + " : " + argNum)

    ; This only does anything if per-stage arousal bonuses are enabled.
    ; Just goes to show you miss out on a lot if you don't enable that small feature.
    If JsonUtil.GetIntValue("/SLSO/Config", "sl_sla_stage_arousal") == 1
    
        Actor[] actorList = SexLab.HookActors(argString)
        Actor[] targetActorList = actorList
        Int actorCount = actorList.Length
        
        If (actorCount < 1)
            Return
        EndIf
        
        ; Seems a bit muddled!
        sslThreadController controller = SexLab.GetController(argString As Int)
        sslThreadController thisThread = SexLab.HookController(argString)
        Float arousalBonus
        
        ; Use own skills for masturbation/group sex; use partner skills for duo.
        ; Always use actor 0 for skills, so flip duo actors to use partner skills.
        If 2 == actorCount
        
            targetActorList =  new Actor [2]
            targetActorList[0] = actorList[1]
            targetActorList[1] = actorList[0]
            
        EndIf   
        
        ; If male actor in duo has orgasmed, block bonuses
        Bool isBlocked = False
        Int ii = 0
        If actorCount <= 2
        
            While ii < actorCount 
            
                ; Yes, more efficient to make these conditions are directly in the && chain, but I also want to read and understand this SPAM.
                Int orgasmCount = (controller.ActorAlias(actorList[ii]) As sslActorAlias).GetOrgasmCount()
                Int genderId = (controller.ActorAlias(actorList[ii]) As sslActorAlias).GetGender()
                Int positionIndex = controller.GetPosition(actorList[ii])
                Bool isMalePosition = controller.Animation.MalePosition(positionIndex)
                
                If orgasmCount > 0 && 1 != genderId && isMalePosition
                
                    slax.Info("SLAX - OnStageStartSLSO - male position actor " + actorList[ii].GetLeveledActorBase().GetName() + " has cum, stage-end bonuses blocked for both actors")
                    isBlocked = True
                    ii = 10 ; break
                    
                EndIf
                
                ii += 1
                
            EndWhile
            
        EndIf   
        
        If !isBlocked
        
            Int jj = 0
            While jj < actorCount
            
                Int actorOrgasmCount = (controller.ActorAlias(targetActorList[jj]) As sslActorAlias).GetOrgasmCount()
                If 0 == actorOrgasmCount
                
                    Actor victim = SexLab.HookVictim(argString)
                    Float exposureMultiplier = 1
                    
                    If victim && victim == targetActorList[jj] && JsonUtil.GetIntValue("/SLSO/Config", "condition_victim_arousal") != 1
                    
                        ;check level, cap multiplier to -+300%
                        exposureMultiplier = PapyrusUtil.ClampFloat(GetLewd(victim) - 3.0, -3.0, 3.0)
                        
                        If JsonUtil.GetIntValue("/SLSO/Config", "condition_victim_arousal") == 0
                            exposureMultiplier = 0.0
                        ElseIf exposureMultiplier < 0.5 && exposureMultiplier > -0.5
                            exposureMultiplier = 1.0
                        EndIf
                    EndIf
                    
                    If 0.0 != exposureMultiplier ; This is valid because explicitly set above - also Papyrus magic float compares...
                    
                        ; Force Actor ExposureRate to 1.0
                        Float exposureRateBackup = slaUtil.GetActorExposureRate(targetActorList[jj])
                        slaUtil.SetActorExposureRate(targetActorList[jj], 1.0)
                        
                        If thisThread.animation.HasTag("Masturbation") || (thisThread.animation.HasTag("Foreplay") && thisThread.LeadIn)
                        
                            arousalBonus = 1.0 + SexLab.Stats.GetSkillLevel(actorList[jj], "Foreplay")
                            slaUtil.FloatUpdateActorExposure(targetActorList[jj], arousalBonus * exposureMultiplier, "Foreplay")
                            
                        EndIf
                        
                        If !(thisThread.LeadIn || thisThread.animation.HasTag("Masturbation"))
                        
                            ; Let the actor use more than one skill...
                            ; Animations with more sex types can score more bonus - this is deliberate - but the bonus gets scaled down somewhat.
                            ; Previously, a grandmaster Anal slut could easily get almost no increase on an animation that was mostly anal.
                            arousalBonus = 1.0
                            
                            If (thisThread.animation.HasTag("Vaginal"))
                                arousalBonus += SexLab.Stats.GetSkillLevel(actorList[jj], "Vaginal")
                            EndIf
                            
                            If (thisThread.animation.HasTag("Anal"))
                                arousalBonus += SexLab.Stats.GetSkillLevel(actorList[jj], "Anal")
                            EndIf
                            
                            If (thisThread.animation.HasTag("Oral"))
                                arousalBonus += SexLab.Stats.GetSkillLevel(actorList[jj], "Oral")
                            EndIf
                            
                            If (thisThread.animation.HasTag("Bestiality"))
                                arousalBonus += GetLewd(actorList[jj])
                            EndIf
                            
                            slaUtil.FloatUpdateActorExposure(targetActorList[jj], 0.5 * arousalBonus * exposureMultiplier, "SLSO-stage-end")
                        EndIf
                        
                        ; Restore Actor ExposureRate - TODO - make this unnecessary by having an API call to just set an exposure modifier.
                        slaUtil.SetActorExposureRate(targetActorList[jj], exposureRateBackup)
                    EndIf
                EndIf
                jj += 1
            EndWhile
            
        EndIf ; !isBlocked

        ; Choose PC as arousal center if appropriate.
        If actorList.Find(playerRef) >= 0
            ArouseNPCsWithinRadius(playerRef, arousalSearchRadius)
        Else
            ArouseNPCsWithinRadius(actorList[0], arousalSearchRadius)
        EndIf
    EndIf
    
EndEvent


; From event SexLabOrgasmSeparate
Event OnSexLabOrgasmSeparate(Form actorForm, Int thread)

    lastSexFinished = Utility.GetCurrentRealTime() ; Always update this
    
    slax.Info("SLAX - OnSexLabOrgasmSeparate")

    Actor who = actorForm As Actor
    String argString = Thread As String
    
    sslThreadController thisThread = SexLab.HookController(argString)
    sslBaseAnimation animation = SexLab.HookAnimation(argString)
    Actor victim = SexLab.HookVictim(argString)
    
    Float exposureModifier = JsonUtil.GetIntValue("/SLSO/Config", "sl_sla_orgasmexposuremodifier") As Float
    Float exposureLoss = JsonUtil.GetIntValue("/SLSO/Config", "sl_sla_orgasmexposureloss") As Float
    Float lewdness = GetLewd(victim)
    
    Float animationDuration = GetAnimationDuration(thisThread)
    Float timeFactor = thisThread.TotalTime / animationDuration
    slax.Info("SLAX - OnSexLabOrgasmSeparate - animationDuration " + animationDuration + ", totalTime " + thisThread.TotalTime + ", timeFactor " + timeFactor)
    
    If victim
        If victim == playerRef
            wasPlayerRaped = True
        EndIf
        ; For default value of orgasmExposureLoss: (no time factor for rape modifier)
        ; * lower arousal from being raped with lewdness lv3- SSL_Debaucherous
        ; * raise arousal from being raped with lewdness lv4+ SSL_Nymphomaniac
            ; slaUtil.UpdateActorExposure(victim, JsonUtil.GetIntValue("/SLSO/Config", "sl_sla_orgasmexposureloss")/2
            ; + JsonUtil.GetIntValue("/SLSO/Config", "sl_sla_orgasmexposuremodifier") * SexLab.Stats.GetSkillLevel(victim, "Lewd", 0.3)
 
        ; TODO: this is not a good implementation - as increasing the modifier has the unanticipated effect of shifting the lewdness balance point
        Float exposureValue = 0.5*exposureLoss + exposureModifier * lewdness
        slaUtil.FloatUpdateActorExposure(victim, exposureValue, "being rape victim")
    EndIf

    ; For default value of orgasmExposureLoss:
    ; * lower arousal with lewdness lv6-
    ; * raise arousal with lewdness lv7+
        ; JsonUtil.GetIntValue("/SLSO/Config", "sl_sla_orgasmexposureloss")
        ; + JsonUtil.GetIntValue("/SLSO/Config", "sl_sla_orgasmexposuremodifier") * SexLab.Stats.GetSkillLevel(akActor, "Lewd", 0.3)

    ; TODO: this is not a good implementation - as increasing the modifier has unanticipated effect of shifting the lewdness balance point
    Float exposureValue = timeFactor * (exposureLoss + exposureModifier * lewdness)
    slaUtil.UpdateActorOrgasmDate(who)
    slaUtil.FloatUpdateActorExposure(who, exposureValue, "having orgasm")
    
EndEvent


; From event OrgasmEnd
Event OnAnimationEndSLSO(String eventName, String argString, Float argNum, Form sender)

    lastSexFinished = Utility.GetCurrentRealTime() ; Always update this
    
    slax.Info("SLAX - OnAnimationEndSLSO - " + eventName + " : " + argString + " : " + argNum)
    
    ; This path only valid if SeparateOrgasms DISABLED in SexLab OR SLSO "always orgasm" OR an NPC scene and NPCs always orgasm
    ; It REPLACES the stage end handling.

    Actor[] actorList = SexLab.HookActors(argString)
    If actorList.Length < 1
        Return
    EndIf

    sslThreadController thisThread = SexLab.HookController(argString)

    
    If !SexLab.config.SeparateOrgasms \
        || 1 == JsonUtil.GetIntValue("/SLSO/Config", "sl_default_always_orgasm") \
        || (!thisThread.HasPlayer && JsonUtil.GetIntValue("/SLSO/Config", "sl_npcscene_always_orgasm") == 1)
    
        Actor victim = SexLab.HookVictim(argString)
        sslBaseAnimation animation = SexLab.HookAnimation(argString)

        ; Let's not refetch these for every actor either...
        Float exposureLoss = JsonUtil.GetIntValue("/SLSO/Config", "sl_sla_orgasmexposureloss") As Float
        Float exposureModifier = JsonUtil.GetIntValue("/SLSO/Config", "sl_sla_orgasmexposuremodifier") As Float
        
        If victim
        
            wasPlayerRaped = (victim == playerRef)
            
            Float lewdness = GetLewd(playerRef)
            ; With SLSO default where loss = -6 * modifier ...
            ; TODO again - fix this - as its behaviour is unintuitive for the player - loss and modifier must be proportional to each other
            slaUtil.FloatUpdateActorExposure(victim, 0.5*exposureLoss + exposureModifier * lewdness, "being rape victim")
            
        EndIf
        
        ; This timeFactor calculation is basically nonsense; I can't even decide what the intent was. 
        ; The animation duration calculation is relatively expensive, needlessly calling this for every actor was a waste.
        ; Get some info on the results to see if it achieves anything useful at all...
        Float animationDuration = GetAnimationDuration(thisThread)
        Float timeFactor = thisThread.TotalTime / animationDuration
        slax.Info("SLAX - OnAnimationEndSLSO - animationDuration " + animationDuration + ", totalTime " + thisThread.TotalTime + ", timeFactor " + timeFactor)
        
        Bool[] canOrgasm = FindAnimationCanOrgasm(animation)
        
        Int ii = 0  
        Int count = actorList.Length
        While ii < count
            
            Bool willOrgasm = FindActorWillOrgasm(animation, canOrgasm, actorList, ii)
            Actor who = actorList[ii]
            
            If willOrgasm
            
                Float lewdness = GetLewd(who)
                Float exposureValue = timeFactor * (exposureLoss  +  exposureModifier * lewdness)
                slaUtil.UpdateActorOrgasmDate(who)
                slaUtil.FloatUpdateActorExposure(who, exposureValue, "having orgasm")
                
            Else
                slax.Info("SLAX - OnAnimationEndSLSO - " + who.GetLeveledActorBase().GetName() + " will not orgasm")
            EndIf
            
            ii += 1
            
        EndWhile
        
    EndIf
    
EndEvent


Bool Function FindActorWillOrgasm(sslBaseAnimation animation, Bool[] canOrgasm, Actor[] actorList, Int ii)

    Bool willOrgasm = False
    Int animationGender = animation.GetGender(ii)
    
    Actor who = actorList[ii]
    
    slax.Info("SLAX - FindActorWillOrgasm - " + who.GetLeveledActorBase().GetName() + " in a position with gender #" + animationGender)
    
    Bool actorHasDeviousBelt = zadDeviousBelt && who.WornHasKeyword(zadDeviousBelt)
    String actorName = who.GetLeveledActorBase().GetName()

    If actorHasDeviousBelt
  
        ; TODO - optionally allow anal orgasms on open belts
        slax.Info("SLAX - FindActorWillOrgasm - " + actorName + " cannot orgasm due to chastity")
        
    Else
    
        If animationGender < 2
        
            willOrgasm = canOrgasm[animationGender]
            
            If 0 == animationGender
                slax.Info("SLAX - FindActorWillOrgasm - " + actorName + " in a male position - can orgasm " + willOrgasm)
            ElseIf 1 == animationGender; Female animation slot
                slax.Info("SLAX - FindActorWillOrgasm - " + actorName + " in a female position - can orgasm " + willOrgasm)
            EndIf
            
        Else ; Creature animation slot - TODO - need to check the gender values, as SLSO tests seem muddled
        
            willOrgasm = canOrgasm[2]
            slax.Info("SLAX - FindActorWillOrgasm - " + actorName + " in a neutral (creature) position - can orgasm " + willOrgasm)
            slax.Info("SLAX - FindActorWillOrgasm - " + actorName + " is in a creature position - can orgasm " + canOrgasm)
            
        EndIf

    EndIf
    
    Return willOrgasm

EndFunction



Bool[] Function FindAnimationCanOrgasm(sslBaseAnimation animation)

    ; TODO check chastity bra preventing male boobjob orgasm
    ; TODO check gag preventing male oral orgasm
    ; TODO check gag preventing female cunnilingus orgasm
    slax.Info("SLAX - FindCanOrgasm - animation has tags " + animation.GetTags())
    
    Bool hasOral         = animation.HasTag("Oral")
    Bool hasAnal         = animation.HasTag("Anal")
    Bool hasVaginal      = animation.HasTag("Vaginal")
    Bool hasMasturbation = animation.HasTag("Masturbation")
    Bool hasBlowjob      = animation.HasTag("Blowjob")
    Bool hasBoobjob      = animation.HasTag("Boobjob")
    Bool hasHandjob      = animation.HasTag("Handjob")
    Bool hasFootjob      = animation.HasTag("Footjob")
    Bool has69           = animation.HasTag("69")
    Bool hasFisting      = animation.HasTag("Fisting")
    Bool hasCunnilingus  = animation.HasTag("Cunnilingus")
    Bool hasLesbian      = animation.HasTag("Lesbian")
    Bool hasFingering    = animation.HasTag("Fingering")
    Bool hasThighjob     = animation.HasTag("Thighjob")
    Bool hasBodyjob      = animation.HasTag("Bodyjob")
    
    Bool[] canOrgasm = new Bool[3] ; 0 Male, 1 Female, 2 Creature
    
    canOrgasm[0] = hasAnal || hasVaginal || hasMasturbation || has69 || hasBlowjob || hasBoobjob || hasHandjob || hasFootjob || hasOral || hasThighjob || hasBodyjob
    slax.Info("SLAX - FindCanOrgasm - MALE " + canOrgasm[0])
    
    canOrgasm[1] = hasVaginal || hasMasturbation || has69 || hasFisting || hasCunnilingus || hasLesbian || hasFingering
    slax.Info("SLAX - FindCanOrgasm - FEMALE " + canOrgasm[1])

    canOrgasm[2] = hasAnal || hasVaginal || hasMasturbation || has69 || hasBlowjob || hasBoobjob || hasHandjob || hasFootjob || hasOral || hasThighjob || hasBodyjob
    slax.Info("SLAX - FindCanOrgasm - MALE " + canOrgasm[2])
    
    canOrgasm[3] = hasVaginal || hasMasturbation || has69 || hasFisting || hasCunnilingus || hasLesbian || hasFingering
    slax.Info("SLAX - FindCanOrgasm - FEMALE " + canOrgasm[3])
    
    Return canOrgasm

EndFunction


; This is not exclusive with the GetAllActors() call on OnUpdate()
; Further, both can run and "GetAllActors()" - they don't hold the lock for their entire execution, only while needed.
; However, GetAllActors has been made smart enough to DO NOTHING and just return the old results if called with high frequency.
Function ArouseNPCsWithinRadius(Actor who, Float radius)

    If !who
        Return
    EndIf

    Int actorCount = GetAllActors(3) ; LOCK THE ACTORS
    If actorCount < 0
        Debug.Trace("ArouseNPCsWithinRadius - GetActors already locked")
        Return
    EndIf
    
    
    Int ii = 0
    While (ii < actorCount)
    
        Actor observer = theActors[ii] ; might be the player, not always an npc

        If (observer != None)
            If (who.GetDistance(observer) < radius && !observer.IsInFaction(SexLab.AnimatingFaction))
            
                If (observer.HasLOS(who))
                    slaUtil.FloatUpdateActorExposure(observer, 1.0, "watching sex including " + who.GetLeveledActorBase().GetName())
                EndIf
                
            EndIf
        EndIf
        ii += 1
        
    EndWhile
    
EndFunction


Float Function GetLewd(Actor who)

    Return SexLab.Stats.GetSkillLevel(who, "Lewd", 0.3)

EndFunction


Float Function GetAnimationDuration(sslThreadController thisThread)

    If !thisThread
        Return -1.0
    EndIf
    
    Float[] timeList =  thisThread.Timers
    
    Float duration = 0.0
    Float stageTimer = 0.0
    
    Int stageCount = thisThread.animation.StageCount()
    
    Int ii = 0
    While (ii < timeList.length && ii < stageCount)
    
        If ii == stageCount - 1
            stageTimer = timeList[4]
        elseif ii < 3
            stageTimer = timeList[ii]
        Else
            stageTimer = timeList[3]
        EndIf
        
        duration += stageTimer
        ii += 1
        
    EndWhile
    
    Return duration
    
EndFunction


Function OnPlayerArousalUpdate(Int arousal) 

    If (arousal <= 20 && (previousPlayerArousal > 20 || lastNotificationTime + 0.5 <= GameDaysPassed.GetValue()))
        If wasPlayerRaped
            Debug.Notification("$SLA_NotificationArousal20Rape")
            wasPlayerRaped = False
        Else
            Debug.Notification("$SLA_NotificationArousal20")
        EndIf
        lastNotificationTime = GameDaysPassed.GetValue()
    ElseIf arousal >= 90 && (previousPlayerArousal < 90 || lastNotificationTime + 0.2 <= GameDaysPassed.GetValue())
        Debug.Notification("$SLA_NotificationArousal90")
        lastNotificationTime = GameDaysPassed.GetValue()
    ElseIf arousal >= 70 && (previousPlayerArousal < 70 || lastNotificationTime + 0.3 <= GameDaysPassed.GetValue())
        Debug.Notification("$SLA_NotificationArousal70")
        lastNotificationTime = GameDaysPassed.GetValue()
    ElseIf arousal >= 50 && (previousPlayerArousal < 50 || lastNotificationTime + 0.4 <= GameDaysPassed.GetValue())
        Debug.Notification("$SLA_NotificationArousal50")
        lastNotificationTime = GameDaysPassed.GetValue()
    EndIf

    previousPlayerArousal = arousal
    
EndFunction


Function CleanActorStorage()

    Debug.Notification("SLAX cleaning actor storage")
    
    setCleaningTime()
    
    Int ii = StorageUtil.debug_GetFloatObjectCount()
    
    Int removedCount = 0;
    
    While ii
        ii -= 1
        Form storageObject = StorageUtil.debug_GetFloatObject(ii)
        Int nn = StorageUtil.debug_GetFloatKeysCount(storageObject)
        While nn
            nn -= 1
            String ValueName = StorageUtil.debug_GetFloatKey(storageObject, nn)

            If (ValueName == "SLAroused.ActorExposure")

            Bool IsActor = IsActor(storageObject)
                If( !IsActor || (IsActor && !IsImportant(storageObject As Actor)))
                    removedCount += 1
                    ClearFromActorStorage(storageObject)

                    ; // Exit the string keys loop since aroused keys have already been found
                    nn = 0
                EndIf
            EndIf
            
        EndWhile
    EndWhile
    
    Debug.Trace("Removed " + removedCount + " unused settings.  Finished at " + Utility.GetCurrentRealTime());
    Debug.Notification("Actor Storage Cleaning Complete")
    
EndFunction


Bool Function IsActor(Form formRef)

    Return (formRef As Actor) != None
    ;Return formRef && ActorTypes.Find(formRef.GetType()) != -1
    
EndFunction


Bool Function IsImportant(Actor who)

    If !who || who.IsDead() || who.IsDeleted() || who.IsChild()
        Return False
    elseIf who == playerRef
        Return True
    EndIf
    
    ActorBase whoBase = who.GetLeveledActorBase()
    Return whoBase.IsUnique() || whoBase.IsEssential() || whoBase.IsInvulnerable() || whoBase.IsProtected() || who.IsGuard() || who.IsPlayerTeammate()
    
EndFunction


Function ClearFromActorStorage(Form FormRef)
    
    ;StorageUtil.FormListRemove(none, "SLAroused.TimeRate", none, True)
    
    StorageUtil.UnsetFloatValue(FormRef, "SLAroused.TimeRate")
    StorageUtil.UnsetFloatValue(FormRef, "SLAroused.ExposureRate")
    StorageUtil.UnsetFloatValue(FormRef, "SLAroused.ActorExposure")
    StorageUtil.UnsetFloatValue(FormRef, "SLAroused.ActorExposureDate")
    StorageUtil.UnsetFloatValue(FormRef, "SLAroused.LastOrgasmDate")
    
EndFunction


Bool Function HaveSLSO()

    Return 255 != Game.GetModByName("SLSO.esp")
    
EndFunction


Function RegisterForModEvents()

    UnregisterForAllModEvents()

    If HaveSLSO()
    
        slax.Info("SLAX - RegisterForModEvents - have SLSO - using extended events")
        
        RegisterForModEvent("StageStart", "OnStageStartSLSO")
        RegisterForModEvent("OrgasmEnd", "OnAnimationEndSLSO") ; SLSO generates these if separate orgasms disabled or some variety of always orgasm enabled
        RegisterForModEvent("SexLabOrgasmSeparate", "OnSexLabOrgasmSeparate")
        
    Else
    
        slax.Info("SLAX - RegisterForModEvents - no SLSO found - using basic events")
        
        RegisterForModEvent("StageStart", "OnStageStart")
        RegisterForModEvent("OrgasmEnd", "OnAnimationEnd")
        
    EndIf
    
    RegisterForModEvent("slaUpdateExposure", "ModifyExposure")
    RegisterForModEvent("AnimationEnd", "OnSexLabAnimationEnd")
    RegisterForModEvent("AnimationStart", "OnSexLabAnimationStart")
    
EndFunction
