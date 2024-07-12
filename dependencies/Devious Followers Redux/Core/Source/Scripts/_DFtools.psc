Scriptname _DFtools extends Quest  Hidden

; FOLDSTART - Properties
_LDC Property LDC Auto
SexLabFramework Property SexLab  Auto 
Zadlibs Property libs Auto
_DflowMCM Property MCM Auto
Quest Property Q  Auto  ; _DFlow
Quest Property G  Auto  ; _DflowGames
Quest Property _DFlowFindFollower Auto
Quest Property _DFlowSexScan Auto
Quest Property _DFlowHorseScan Auto
Quest Property _DFlowGuardScan Auto
Quest Property _DFlowGames Auto

ReferenceAlias Property Follower Auto
ReferenceAlias Property VanillaFollower Auto


Bool Property Suspended Auto
Bool Property PEnslave Auto
Bool Property DealODog Auto
Actor Property PlayerRef Auto
Actor Property Horse Auto
Actor Property PC Auto
Actor Property Dog Auto

Keyword Property LocTypeInn Auto
Keyword Property LocTypePlayerHouse Auto
Keyword Property LocTypeDwelling Auto
Keyword Property LocTypeCity Auto
Keyword Property LocTypeHold Auto
Keyword Property LocTypeBanditCamp Auto
Keyword Property LocTypeDungeon Auto

Keyword Property SLNS Auto
Keyword Property ArmorClothing Auto
Keyword Property ArmorLight Auto
Keyword Property ArmorHeavy Auto
Keyword Property Warmer Auto
Keyword Property _DFEndless Auto
Keyword Property ddRestraintsKey Auto
Keyword Property ddChastityKey Auto
Keyword Property ddPiercingKey Auto
Keyword Property _DFGemP  Auto

Faction Property CrimeFacWhiterun  Auto ; Whiterun
Faction Property CrimeFacRiften    Auto ; Riften
Faction Property CrimeFacSolitude  Auto ; Haafingar
Faction Property CrimeFacMarkarth  Auto ; Markarth
Faction Property CrimeFacWindhelm  Auto ; Windhelm - Eastmarch
Faction Property CrimeFacWinterhold Auto ; Winterhold
Faction Property CrimeFacDawnstar  Auto ; Dawnstar - Pale
Faction Property CrimeFacMorthal   Auto ; Morthal - Hjaalmarch
Faction Property CrimeFacFalkreath Auto ; Falkreath

Faction Property DismissedFollowerFac Auto
ObjectReference Property Pit Auto

Armor Property PunishBeltI Auto
Armor Property PunishBeltR Auto
Armor Property PunishPlugVI Auto
Armor Property PunishPlugVR Auto
Armor Property PunishPlugAI Auto
Armor Property PunishPlugAR Auto

Armor Property _DFWhoreHeavyArmor Auto
Armor Property _DFWhoreLightArmor Auto
Armor Property _DFWhoreMageArmor Auto
Armor Property _DFWhoreHeavyArmorCust Auto
Armor Property _DFWhoreLightArmorCust Auto
Armor Property _DFWhoreMageArmorCust Auto
Armor Property Collar Auto
Armor Property ArmCuffs Auto
Armor Property LegCuffs Auto
Armor Property Boots Auto
Armor Property Gloves Auto
Armor Property Jacket Auto
Armor Property JacketR Auto
Armor Property Gag Auto
Armor Property Mittens Auto
Armor Property MittensR Auto
Armor Property Binder Auto
Armor Property BinderR Auto
Armor Property BlindFold Auto
Armor Property PrisonerchainsR Auto
Armor Property PrisonerchainsI Auto
Armor Property ChainsOfDebtR Auto
Armor Property ChainsOfDebtI Auto


GlobalVariable Property _DflowWill Auto
GlobalVariable Property _DFlowResist Auto
GlobalVariable Property _DWillMed Auto
GlobalVariable Property _DWillLow Auto
GlobalVariable Property _DFFatigue Auto
GlobalVariable Property _DFFatigueRate Auto
GlobalVariable Property _DFGoldPerFatigue Auto
GlobalVariable Property _DFExpectedDealCount Auto
GlobalVariable Property _DFBoredom Auto
GlobalVariable Property _DFBoredomTimer Auto
GlobalVariable Property _DFBoredomIntervalDays Auto
GlobalVariable Property _DFSpankEagerness Auto
GlobalVariable Property _DFOutdoorSpanking Auto
GlobalVariable Property _DFSpankDealRequests Auto
GlobalVariable Property _DFResistanceBroken Auto
GlobalVariable Property _DFPunishmentTimer Auto
GlobalVariable Property _DFGameCommentTimer Auto

GlobalVariable Property GameDaysPassed Auto
GlobalVariable Property ETimerp Auto
GlobalVariable Property HEDebt  Auto  
GlobalVariable Property Debt  Auto  
GlobalVariable Property _DFSlutCount Auto

GlobalVariable Property _DFSexScanRadius Auto
GlobalVariable Property _DFSexScanAllowMale Auto
GlobalVariable Property _DFSexScanAllowFemale Auto

GlobalVariable Property _DFInternalEnslaveWeight Auto
GlobalVariable Property _DFLolaEnslaveWeight Auto
GlobalVariable Property _DFlowSimpleSlaveryOdds Auto
GlobalVariable Property _DFSlaveryTarget Auto

Spell Property HitlistSpell  Auto

FormList Property actorlist Auto
FormList Property hitlist Auto

FormList Property _DFSexScanFound Auto
FormList Property _DFHorseScanFound Auto
FormList Property _DFGuardScanFound Auto

Message Property _DFlowDealB1 Auto
Message Property _DFlowDealB2 Auto
Message Property _DFlowDealB3 Auto
Message Property _DFlowDealB4 Auto
Message Property _DFlowDealO1 Auto
Message Property _DFlowDealO2 Auto
Message Property _DFlowDealO3 Auto
Message Property _DFlowDealO4 Auto
Message Property _DFlowDealH1 Auto
Message Property _DFlowDealH2 Auto
Message Property _DFlowDealH3 Auto
Message Property _DFlowDealH4 Auto
Message Property _DFlowDealP1 Auto
Message Property _DFlowDealP2 Auto
Message Property _DFlowDealP3 Auto
Message Property _DFlowDealS1 Auto
Message Property _DFlowDealS2 Auto
Message Property _DFlowDealS3 Auto

Message Property _DFKeyGameAll Auto
Message Property _DFKeyGameCPrice Auto
Message Property _DFKeyGameCKeys Auto
Message Property _DFKeyGameCAll Auto
Message Property _DFKeyGameAllS Auto
Message Property _DFKeyGameCKeysS Auto
Message Property _DFKeyGameCAllS Auto

Float Property PunishmentInterval = 0.02083 Auto ; Around half an hour game time.
Float Property SpankingTimer Auto
Float Property MaxResistanceFatigue = 100.0 Auto
Int Property RapistCounter = 0 Auto
Int Property Suspend = 0 Auto ; Flags the dhlp-Suspend/Enable event status

Race Property HorseRace Auto
_DDeal Property DB Auto
_DDeal Property DO Auto
_DDeal Property DH Auto
_DDeal Property DP Auto
_DDeal Property DS Auto
_MDDeal Property DM1 Auto
_MDDeal Property DM2 Auto
_MDDeal Property DM3 Auto
_MDDeal Property DM4 Auto
_MDDeal Property DM5 Auto

String Property TagNeverDevious = "DF_FollowerNeverDevious" AutoReadOnly 
String Property TagMaster = "DF_FollowerMaster" AutoReadOnly
String Property TagMasterDays = "DF_FollowerMasterDays" AutoReadOnly
String Property TagBoredom = "DF_FollowerBoredom" AutoReadOnly
String Property TagLastHireTime = "TagLastHireTime" AutoReadOnly
String Property TagEnslavedPunishCount = "DF_Enslaved_PunishCount" AutoReadOnly
String Property TagEnslavedTotalPunishCount = "DF_Enslaved_TotalPunishCount" AutoReadOnly

String Property TagPersonality = "DF_FollowerPersonality" AutoReadOnly
String Property TagAggression = "DF_FollowerAggression" AutoReadOnly
String Property TagGreed = "DF_FollowerGreed" AutoReadOnly
String Property TagHonor = "DF_FollowerHonor" AutoReadOnly
String Property TagLust = "DF_FollowerLust" AutoReadOnly
String Property TagControl = "DF_FollowerControl" AutoReadOnly
String Property TagPlayful = "DF_FollowerPlayful" AutoReadOnly

Int Property PersonalityDefault = 0 AutoReadOnly
Int Property PersonalitySlaver = 1 AutoReadOnly
Int Property PersonalityProfiteer = 2 AutoReadOnly
Int Property PersonalitySexy = 3 AutoReadOnly
Int Property PersonalitySadist = 4 AutoReadOnly
Int Property PersonalityMoral = 5 AutoReadOnly
Int Property PersonalityNightmare = 6 AutoReadOnly


;ObjectReference _DFlowFollowerKeyContainer


MiscObject Property Gold001 Auto

Scene Property _DflowGamesDogKitten Auto  ; Dog sex scene 1
Scene Property _DflowGamesDogKitten2 Auto ; Dog sex scene 2
Bool Property DenDmgStop = False Auto

Idle Property BleedOutStart Auto
Idle Property BleedOutStop Auto

Key Property RKey Auto
Key Property CKey Auto
Key Property PTool Auto

String[] Property SpankAnimationNames Auto
String[] Property SpankAnimationNamesExt Auto
String[] Property SpankAnimationNamesExtAlt Auto



; FOLDEND - Properties

; FOLDSTART - Internal Variables

Float Turn = 0.0
Float PDelay = 0.0
Int counter ; Global sex counter - a bug factory - no longer used.
Int PlayerLvL = 1
Int spankCounter = 0 ; Just for debugging
Int currentGenderMask ; Local copy, so we know what to restore if we need to try a fallback mask.
Float defaultScanRadius = 1024.0

Actor[] RapistID
Float[] RapistsXPos
Float[] RapistsYPos
Float[] RapistsZPos

; FOLDEND - Internal Variables


Function SexScanStart(Float radius)
    SetSexScanRadius(radius)
    _DFlowSexScan.Stop()
    _DFlowSexScan.Reset()
    _DFSexScanFound.Revert()
    _DFlowSexScan.Start()
    Utility.Wait(0.1)
EndFunction

; Historically did this... Now checks not in combat during scan.
; akTarget.StopCombat()
; akTarget.StopCombatAlarm()
; akTarget.SheatheWeapon()
; akTarget.AddToFaction(_DCalm)
; akTarget.SetFactionRank(_DCalm, 100)
;
; Returns the count of items found this time
; Must pass an array big enough to hold all the possible items.
; Can be bigger - starts placing items at offset, so it's easy to build up a large array with repeated calls.
; The scanner only scans FIVE items at a time, so a large array isn't necessarily required.
; It won't overflow the array, and if you call it repeatedly without restarting it won't add any items.
Int Function SexScanUpdate(Actor[] foundThisTime, Int offset = 0)

    Int limit = foundThisTime.Length
    
    Int numRefs = _DFlowSexScan.GetNumAliases()
    Debug.TraceConditional("DF - SexScanUpdate - refs " + numRefs + ", limit " + limit + ", offset " + offset, True)
    
    Int ii = 0
    Int jj = offset

    While ii < numRefs
        ReferenceAlias found = _DFlowSexScan.GetNthAlias(ii) As ReferenceAlias
        If found
            Actor foundActor = found.GetActorRef()
            If foundActor
                Debug.TraceConditional("DF - SexScanUpdate - adding actor ref " + ii + " position " + jj + " : " + foundActor.GetActorBase().GetName(), True)
                _DFSexScanFound.AddForm(foundActor)
                _DFSexScanFound.AddForm(foundActor.GetActorBase()) ; Some possibility that formlists only work for base objects.
                If jj < limit
                    foundThisTime[jj] = foundActor
                    jj += 1
                Else
                    ii = numRefs
                EndIf
            EndIf
        EndIf
        ii += 1
    EndWhile
    
    _DFlowSexScan.Stop()
    _DFlowSexScan.Reset()
    
    Debug.TraceConditional("DF - SexScanUpdate - returning " + jj + " - " + offset, True)
    Return jj - offset
    
EndFunction

Function SexScanRestart(Float delay = 0.1)
    _DFlowSexScan.Start()
    Utility.Wait(delay)
EndFunction


Bool Function InSex()
    Bool r = SexLabUtil.IsActorActive(playerref)
    Return r
EndFunction

; 1 = males, 2 = females, 3 = both, anything else also both
Function SetScanGenders(Int allowMask)

    currentGenderMask = allowMask
    If 1 == allowMask
        _DFSexScanAllowMale.SetValue(1.0)
        _DFSexScanAllowFemale.SetValue(0.0)
    ElseIf 2 == allowMask
        _DFSexScanAllowMale.SetValue(0.0)
        _DFSexScanAllowFemale.SetValue(1.0)
    Else
        _DFSexScanAllowMale.SetValue(1.0)
        _DFSexScanAllowFemale.SetValue(1.0)
    EndIf

EndFunction


Function WaitForSex(Float maxTime = 180.0)

    ; SLSO scenes can really drag on, so don't be too eager to abort
    
    Float now = Utility.GetCurrentRealTime()
    Float endTime = now + maxTime
    
    Utility.Wait(4.0)
    While (InSex() || libs.IsAnimating(playerref)) && Utility.GetCurrentRealTime() < endTime
        Utility.Wait(4.0)
    EndWhile
EndFunction


; The default guard scene requires three guards, but we could look for fewer, or repeat and find more.
; Shares radius global with standard and guard scanners. In practice that probably won't ever be changed much from default.
Int Function GuardScan(Actor[] foundThisTime, Int offset = 0, Bool clearFoundList = True)

    Debug.TraceConditional("DF - GuardScan - START", True)
    
    SetSexScanRadius()
    
    _DFlowGuardScan.Stop()
    _DFlowGuardScan.Reset()
    
    If clearFoundList
        _DFGuardScanFound.Revert()
    EndIf
    
    
    _DFlowGuardScan.Start()
    Utility.Wait(0.1)
    
    Int limit = foundThisTime.Length
    
    Int numRefs = _DFlowGuardScan.GetNumAliases()
    
    Int ii = 0
    Int jj = offset

    While ii < numRefs
        Debug.TraceConditional("DF - GuardScan - ref " + ii, True)
        ReferenceAlias found = _DFlowGuardScan.GetNthAlias(ii) As ReferenceAlias
        If found
            Debug.TraceConditional("DF - GuardScan - ref " + ii + " exists", True)
            Actor foundActor = found.GetActorRef()
            If foundActor
                Debug.TraceConditional("DF - GuardScan - ref " + ii + " has an actor", True)
                _DFGuardScanFound.AddForm(foundActor)
                If jj < limit
                    foundThisTime[jj] = foundActor
                    jj += 1
                Else
                    ii = numRefs
                EndIf
            EndIf
        EndIf
        ii += 1
    EndWhile
    
    _DFlowGuardScan.Stop()
    _DFlowGuardScan.Reset()
    
    Debug.TraceConditional("DF - GuardScan - got " + (jj - offset) + " guards", True)

    Return jj - offset
EndFunction


; The default horse scene requires three horses, but we could look for fewer, or repeat and find more.
; Shares radius global with standard and guard scanners. In practice that probably won't ever be changed much from default.
Int Function HorseScan(Actor[] foundThisTime, Int offset = 0, Bool clearFoundList = True)

    SetSexScanRadius()
    
    _DFlowHorseScan.Stop()
    _DFlowHorseScan.Reset()
    
    If clearFoundList
        _DFHorseScanFound.Revert()
    EndIf
    
    
    _DFlowHorseScan.Start() ; This is a blocking latent function, so waiting isn't really required.
    Utility.Wait(0.1)
    
    Int limit = foundThisTime.Length
    
    Int numRefs = _DFlowHorseScan.GetNumAliases()
    
    Int ii = 0
    Int jj = offset

    While ii < numRefs
        ReferenceAlias found = _DFlowHorseScan.GetNthAlias(ii) As ReferenceAlias
        If found
            Actor foundActor = found.GetActorRef()
            If foundActor
                _DFHorseScanFound.AddForm(foundActor)
                If jj < limit
                    foundThisTime[jj] = foundActor
                    jj += 1
                Else
                    ii = numRefs
                EndIf
            EndIf
        EndIf
        ii += 1
    EndWhile
    
    _DFlowHorseScan.Stop()
    _DFlowHorseScan.Reset()
    
    Return jj - offset
EndFunction


Function AddDealItem(String itemName)
    (Q As QF__Gift_09000D62).AddDealItem(itemName)
EndFunction

Function PlacePCNearPlayer()
    PC.enable()
    PC.Moveto(Game.GetPlayer(), 1000, 1000, 1000)
EndFunction


Function SceneErrorCatch(Scene theScene, Int timer)

    Int seconds = 0

    While theScene.IsPlaying() && seconds < timer
        seconds += 3
        Utility.Wait(3.0)
    EndWhile

    theScene.Stop()

EndFunction


Function SceneErrorCatchandPlay(Scene theScene, Int timer)

    theScene.Start()
    SceneErrorCatch(theScene, timer)

EndFunction

Form[] Function GetJsonWhoreArmor(string jsonKey)
    Form[] f = JSONUtil.FormListToArray("../Devious Followers Redux/Config/whore-armor", jsonKey)

    if !f || f.Length == 0
        f = JSONUtil.FormListToArray("../Devious Followers Redux/Config/whore-armor.default", jsonKey)
    endIf   

    return f
EndFunction

Armor[] Function GetArmorOfType(string prefix) 
    Armor[] items = new Armor[2]

    Form[] tops = GetJsonWhoreArmor(prefix + "-tops")
    Form[] bottoms = GetJsonWhoreArmor(prefix + "-bottoms")

    int topIndex = Utility.RandomInt(0, tops.length - 1)
    if tops.length > 0
        items[0] = tops[topIndex] as Armor
    endIf
    
    int bottomIndex = topIndex
    if bottoms.length > 0
        if bottomIndex >= bottoms.length
            bottomIndex = Utility.RandomInt(0, bottoms.length - 1)
        endIf
        items[1] = bottoms[bottomIndex] as Armor
    endIf

    return items
EndFunction

Function GiveArmorOfType(Actor akActor, string prefix)
    Armor[] items = GetArmorOfType(prefix)

    Keyword kwd = Keyword.GetKeyword("_DFWArmor")

    if !items[0].HasKeyword(kwd)
        PO3_SKSEFunctions.AddKeywordToForm(items[0], kwd)
    endIf

    akActor.AddItem(items[0])
    akActor.AddItem(items[1])
EndFunction

Function GiveWhoreArmor(Bool punish)

    Actor player = Game.GetPlayer()

    GiveArmorOfType(player, "heavy")
    GiveArmorOfType(player, "light")
    GiveArmorOfType(player, "mage")
    
    If punish
        (Q as QF__Gift_09000D62).PunDebt()
    EndIf
    
EndFunction


Function AddPunishmentDebt(Int multiple = 1)

    While multiple > 0
        multiple -= 1
        (Q as QF__Gift_09000D62).PunDebt()
    EndWhile

EndFunction
    


Actor Function GetNearestActor()
    ; This scanned for up to a minute, with the standard radius and scanner.
    ; It isn't used anywhere.
EndFunction


Bool Function Horsetime()

    Bool hadSex = False
    Actor[] horses = New Actor[3]
    Int foundCount = HorseScan(horses)

    PauseAll()

    If foundCount > 0 && SexInternal_1(horses[0])
        MCM.noti("H1")
        WaitForSex()
        hadSex = True
    EndIf

    If foundCount > 1 && SexInternal_1(horses[1])
        MCM.noti("H2")
        WaitForSex()
        hadSex = True
    EndIf

    If foundCount > 2 && SexInternal_1(horses[2])
        MCM.noti("H3")
        WaitForSex()
        hadSex = True
    EndIf
    
    ResumeAll()
    
    Return hadSex
    
EndFunction


Function SleepGameCheck()

    Int stage = Q.GetStage()
    
    If stage >= 10 && stage < 100 && _DflowWill.GetValue() <= 5 || Debt.GetValue() >= HEDebt.GetValue() 
    
        If ETimerp.GetValue() <= GameDaysPassed.GetValue()
            
            Int chance = Utility.RandomInt(0, 1)
            
            If chance != 0
                
                ; If the player can catch the follower, the game doesn't begin, and willpower can be recovered.
                If Libs.PlayerRef.WornHasKeyword(libs.zad_Deviousgag)
                
                    ; Game begins if you are ONLY wearing a gag ... not sure why to be honest ... safer I guess?
                    If  !Libs.PlayerRef.WornHasKeyword(libs.zad_DeviousHeavyBondage) \
                        && !Libs.PlayerRef.WornHasKeyword(libs.zad_DeviousCollar)  \
                        && !Libs.PlayerRef.WornHasKeyword(libs.zad_DeviousCorset) \
                        && !Libs.PlayerRef.WornHasKeyword(libs.zad_DeviousBelt) \
                        && !Libs.PlayerRef.WornHasKeyword(libs.zad_DeviousHarness)
                    
                        G.SetStage(300)
                        MCM.noti("S1") ; Follower succeeded in starting the game
                    Else
                        MCM.noti("S2") ; Caught follower trying to tie you up
                    EndIf
                EndIf
            EndIf
        EndIf
    EndIf
    
EndFunction



Function AddCum()

    Bool one
    Bool two 
    Bool three
    Bool four

    Int rounds = Utility.RandomInt(1, 4)
    Int count = 0

    While count < rounds

        one = Utility.RandomInt(0, 1) as Bool 
        two = Utility.RandomInt(0, 1) as Bool 
        three = Utility.RandomInt(0, 1) as Bool 
        Sexlab.AddCum(Game.GetPlayer(), one, two, three)
        If one || two || three
            count += 1
        EndIf
    EndWhile

EndFunction


Function DenialDmg(Int dmg, Bool isCreature, Bool hBondage)

    ; DO is ownership deal.
    ; DO.Stat changes the dialogs the player has when playing belt game.
    ; Values over 200.0 leave the player unable to resist dog sex etc.
    If DO.GetStage() == 4
        
        DO.Stat += dmg
        
        If Utility.RandomInt(0, 2) >= 1
            
            If DO.Stat > 0 && DO.Stat <= 10
                If !hBondage  && !isCreature
                    Debug.Notification("$DF_DENIAL1")
                ElseIf hBondage  && !isCreature
                    Debug.Notification("$DF_DENIAL2")
                Else
                    Debug.Notification("$DF_DENIAL3")
                EndIf
            ElseIf DO.Stat > 10 && DO.Stat <= 20
                If !hBondage  && !isCreature
                    Debug.Notification("$DF_DENIAL4")
                ElseIf hBondage  && !isCreature
                    Debug.Notification("$DF_DENIAL5")
                Else
                    Debug.Notification("$DF_DENIAL6")
                EndIf
            ElseIf DO.Stat > 20
                If !hBondage  && !isCreature
                    Debug.Notification("$DF_DENIAL7")
                ElseIf hBondage  && !isCreature
                    Debug.Notification("$DF_DENIAL8")
                Else
                    Debug.Notification("$DF_DENIAL9")
                EndIf
            EndIf
            
        EndIf
    
    EndIf
        
EndFunction


Function DenialDmgCon(Int dmg, Bool isCreature, Bool hBondage)
        
    If DO.GetStage() == 4
    
        DO.Stat += dmg
        
        If Utility.RandomInt(0, 2) >= 1
            If DO.Stat > 15
                If !hBondage  && !isCreature
                    Debug.Notification("$DF_DENIAL7")
                ElseIf hBondage  && !isCreature
                    Debug.Notification("$DF_DENIAL8")
                Else
                    Debug.Notification("$DF_DENIAL9")
                EndIf
            EndIf
        EndIf
    
    EndIf
        
EndFunction



; Returns the total number of partners used in scenes.
; Important as used in quests where you must have sex with X partners...
;
; Historically, this scanned for up to four minutes if nothing found, or longer if it found things, with a 30 second Wait after each sex scene.
; Potentially, this could result in tediously long rape sequences if there were NPCs to do the work, and run for much more than 4 minutes.
; The intent was fairly vague and ill-defined.
;
; Now, the number of participants is simply capped at 9, at most three x three-person rape.
; The time allowed is capped at four minutes, unless overridden. Will keep looking for rapists for at least that long.
; If sex happens it may eat up all that time with a single event.
Int Function Rapetime(Float secondsToTry = -1.0, Float scanRadius = 1024.0)

    Debug.TraceConditional("DF - Rapetime " + (secondsToTry As Int), True)
    Actor[] rapists = new Actor[12]
    Int partnerCount = 0
    
    If secondsToTry < 0.0 ; This is a way of detecting legacy calls to this function
        secondsToTry = 240.0
        scanRadius *= 2.0
    EndIf
        
    SexScanStart(scanRadius)
    
    Float realSeconds = Utility.GetCurrentRealTime()

    PauseAll()
    
    Float now = Utility.GetCurrentRealTime()
    Int rr = 0
    Int limit = rapists.Length
    Int poolSize = 0
    
    While now >= realSeconds && now < realSeconds + secondsToTry
    
        Int found = SexScanUpdate(rapists, poolSize)
        Debug.TraceConditional("DF - Rapetime found " + found + " attackers", True)
        poolSize += found
        Int available = poolSize - rr
        Float delay = 3.0
        
        Bool hadSex = False

        If available >= 4 && Utility.RandomInt(0, 99) < 20 ; five way animations are rare, so soon get sick of them if we have any at all
            Actor r0 = rapists[rr]
            Actor r1 = rapists[rr+1]
            Actor r2 = rapists[rr+2]
            Actor r3 = rapists[rr+3]
            Debug.TraceConditional("DF - Rapetime - Sex4 " + rr, True)
            Debug.TraceConditional("DF - Rapetime - actor0 " + r0.GetActorBase().GetName(), True)
            Debug.TraceConditional("DF - Rapetime - actor1 " + r1.GetActorBase().GetName(), True)
            Debug.TraceConditional("DF - Rapetime - actor2 " + r2.GetActorBase().GetName(), True)
            Debug.TraceConditional("DF - Rapetime - actor3 " + r3.GetActorBase().GetName(), True)
            If SexInternal_4(r0, r1, r2, r3)
                rr += 4
                WaitForSex()
                hadSex = True
            Else
                Debug.TraceConditional("DF - Rapetime - Sex4 failed " + rr, True)
            EndIf
        EndIf

        If available >= 3 && Utility.RandomInt(0, 99) < 40
            Actor r0 = rapists[rr]
            Actor r1 = rapists[rr+1]
            Actor r2 = rapists[rr+2]
            Debug.TraceConditional("DF - Rapetime - Sex3 " + rr, True)
            Debug.TraceConditional("DF - Rapetime - actor0 " + r0.GetActorBase().GetName(), True)
            Debug.TraceConditional("DF - Rapetime - actor1 " + r1.GetActorBase().GetName(), True)
            Debug.TraceConditional("DF - Rapetime - actor2 " + r2.GetActorBase().GetName(), True)
            If SexInternal_3(r0, r1, r2)
                rr += 3
                WaitForSex()
                hadSex = True
            Else
                Debug.TraceConditional("DF - Rapetime - Sex3 failed " + rr, True)
            EndIf
        EndIf
        
        If !hadSex && available >= 2 && Utility.RandomInt(0, 99) < 40
            Actor r0 = rapists[rr]
            Actor r1 = rapists[rr+1]
            Debug.TraceConditional("DF - Rapetime - Sex2 " + rr, True)
            Debug.TraceConditional("DF - Rapetime - actor0 " + r0.GetActorBase().GetName(), True)
            Debug.TraceConditional("DF - Rapetime - actor1 " + r1.GetActorBase().GetName(), True)
            If SexInternal_2(r0, r1)
                rr += 2
                WaitForSex()
                hadSex = True
            Else
                Debug.TraceConditional("DF - Rapetime - Sex2 failed " + rr, True)
            EndIf
        EndIf
        
        If !hadSex && available >= 1
            Actor r0 = rapists[rr]
            Debug.TraceConditional("DF - Rapetime - Sex1 " + rr, True)
            Debug.TraceConditional("DF - Rapetime - actor0 " + r0.GetActorBase().GetName(), True)
            rr += 1 ; Always eat solo actor, in case they're the cause sex is failing.
            If SexInternal_1(r0, True)
                hadSex = True
            Else
                Debug.TraceConditional("DF - Rapetime - Sex failed " + rr, True)
            EndIf
        EndIf
        
        If !hadSex
            ; Delay before we rescan
            delay = 17.0
        EndIf
        
        If rr >= limit
            ; Break out and stop, that's enough rapes.
            ResumeAll()
            SetSexScanRadius()
            Debug.TraceConditional("DF - Rapetime finished due to limit", True)
            Return rr
        EndIf
    
        Utility.Wait(delay)
        If poolSize < limit
            SexScanRestart()
        EndIf
        
        ;Int ff = 0
        ;Int ffLimit = _DFSexScanFound.GetSize()
        ;While ff < ffLimit
        ;    Actor rapist = _DFSexScanFound.GetAt(ff) As Actor
        ;    If rapist
        ;        Debug.TraceConditional("DF - Rapetime - foundList " + ff + " : " + rapist.GetActorBase().GetName() + " (" + rapist.GetFormID() + ")", True)
        ;    Else
        ;        ActorBase baseRapist = _DFSexScanFound.GetAt(ff) As ActorBase
        ;        Debug.TraceConditional("DF - Rapetime - foundList " + ff + " : base " + baseRapist.GetName(), True)
        ;    EndIf
        ;    ff += 1
        ;EndWhile
        
        now = Utility.GetCurrentRealTime()
        
    EndWhile
    
    ResumeAll()
    SetSexScanRadius()
    Debug.TraceConditional("DF - Rapetime finished due to time", True)
    Return rr
    
EndFunction

Function SetSexScanRadius(Float radius = -1.0)
    If radius < 0.0
        _DFSexScanRadius.SetValue(defaultScanRadius)
    Else
        _DFSexScanRadius.SetValue(radius)
    EndIf
EndFunction



; QuickStart(actor a1, actor a2 = none, actor a3 = none, actor a4 = none, actor a5 = none, actor victim = none, string hook = "", string tags = "")

Bool Function SingleRape(Actor b)
    ; Don't attempt sex in full chastity.
    If !VaginalOk(PlayerRef) && !AnalOk(PlayerRef) && !OralOk(PlayerRef) && !BoobsOk(PlayerRef)
        Return False
    EndIf
    MCM.MDC.DelayChastity()
    
     Bool r = False
     
   ; If no belt, and female, prefer vaginal
    If VaginalOk(PlayerRef)
        r = SexLabUtil.QuickStart(PlayerRef, b, none, none, none,  PlayerRef, "", "Vaginal")
    EndIf
    
    ; Belt but it is open, prefer anal
    If !r && AnalOk(PlayerRef)
        r = SexLabUtil.QuickStart(PlayerRef, b, none,  none, none,  PlayerRef, "", "Anal")
    EndIf
    
    ; Try for oral
    If !r && OralOk(PlayerRef)
        r = SexLabUtil.QuickStart(PlayerRef, b, none, none, none,  PlayerRef, "", "Blowjob")
        If !r
            r = SexLabUtil.QuickStart(PlayerRef, b, none, none, none,  PlayerRef, "", "Oral")
        EndIf
    EndIf

    Return r

EndFunction

Bool Function SingleSex(Actor b)
    ; Player is NOT victim
        ; Don't attempt sex in full chastity.
    If !VaginalOk(PlayerRef) && !AnalOk(PlayerRef) && !OralOk(PlayerRef) && !BoobsOk(PlayerRef)
        Return False
    EndIf
    MCM.MDC.DelayChastity()
    
    PauseAll()
    
    ; ToDo: make this properly robust, this hack will have to do for now.
    Bool r = False
    
    ; If no belt, and female, prefer vaginal
    If VaginalOk(PlayerRef)
        r = SexLabUtil.QuickStart(PlayerRef, b, none, none, none,  none, "", "Vaginal")
    EndIf
    
    ; Belt but it is open, prefer anal
    If !r && AnalOk(PlayerRef)
        r = SexLabUtil.QuickStart(PlayerRef, b, none,  none, none,  none, "", "Anal")
    EndIf
    
    ; Try for oral
    If !r && OralOk(PlayerRef)
        r = SexLabUtil.QuickStart(PlayerRef, b, none, none, none,  none, "", "Blowjob")
        If !r
            r = SexLabUtil.QuickStart(PlayerRef, b, none, none, none,  none, "", "Oral")
        EndIf
    EndIf
    
    ; Try for boob-job
    If !r && BoobsOk(PlayerRef)
        r = SexLabUtil.QuickStart(PlayerRef, b, none, none, none,  none, "", "Boobjob")
    EndIf
    
    
    ; Try for anything. Probably going to be a bad result.
    If !r
        r = SexLabUtil.QuickStart(PlayerRef, b, none, none, none,  none, "", "")
    EndIf
    
    ResumeAll()
    
    Return r
    
EndFunction

Bool Function Masturbation(Actor b)
    ; For some puzzling reason, some callers pass the follower in here, but they clearly mean for the player to masturbate.
    Bool r = SexLabUtil.QuickStart(PlayerRef, none, none, none, none,  none, "", "")
    Return r
EndFunction


Bool Function ForePlay(Actor b)
    ; Player is victim
    Bool r = SexLabUtil.QuickStart(PlayerRef, b, none, none,  none,  PlayerRef, "", "foreplay")
    Return r
EndFunction


Bool Function SexGrope(Actor b)	
    ; Player is victim
    Bool r = SexLabUtil.QuickStart(PlayerRef, b, none, none, none,  PlayerRef, "", "Assault")
    If r != True
        r = SexLabUtil.QuickStart(PlayerRef, b, none, none,  none,  PlayerRef, "", "Grope")
    EndIf
    If !r
        r = SexLabUtil.QuickStart(PlayerRef, b, none, none,  none,  PlayerRef, "", "foreplay")
    EndIf
    If !r
        r = SexLabUtil.QuickStart(PlayerRef, b, none, none,  none,  PlayerRef, "", "")
    EndIf
    Return r
EndFunction


Bool Function SexAnal(Actor b)
    ; Player is victim
    MCM.MDC.DelayChastity()
    ; Don't attempt anal sex if closed-belted
    If !AnalOk(PlayerRef)
        Return False
    EndIf
    
    Bool r = SexLabUtil.QuickStart(PlayerRef,  b, none,  none,  none,  PlayerRef, "", "Anal")
    Return r
EndFunction


Bool Function SexOral(Actor b)	
    ; Player is victim
    MCM.MDC.DelayGag()

    ; Don't attempt oral sex if gagged
    Bool r = False
    
    If !OralOk(PlayerRef)
        Return False
    EndIf
    
    Int npcGender = SexLabUtil.GetAPI().GetGender(b)
    
    If 0 == npcGender || 2 == npcGender
        ; Only do blowjob for males
        r = SexLabUtil.QuickStart(PlayerRef, b, none, none, none,  PlayerRef, "", "Blowjob")
    EndIf
    
    If !r
        r = SexLabUtil.QuickStart(PlayerRef, b, none, none, none,  PlayerRef, "", "Oral")
    EndIf
    
    Return r
    
EndFunction


; Used by external callers, such as fragments, that usually lack pause handling.
Bool Function Sex(Actor npc0)
    PauseAll()
    SexInternal_1(npc0)
    ResumeAll()
EndFunction

Bool Function Sex2(Actor npc0, Actor npc1)
    PauseAll()
    SexInternal_2(npc0, npc1)
    ResumeAll()
EndFunction

Bool Function Sex3(Actor npc0, Actor npc1, Actor npc2)
    PauseAll()
    SexInternal_3(npc0, npc1, npc2)
    ResumeAll()
EndFunction

Bool Function Sex4(Actor npc0, Actor npc1, Actor npc2, Actor npc3)
    PauseAll()
    SexInternal_4(npc0, npc1, npc2, npc3)
    ResumeAll()
EndFunction


Bool Function SexInternal_1(Actor b, Bool waitComplete = False)	
    ; Player is victim
    
    ; Don't attempt sex in full chastity.
    If !VaginalOk(PlayerRef) && !AnalOk(PlayerRef) && !OralOk(PlayerRef) && !BoobsOk(PlayerRef)
        Return False
    EndIf
    
    ; ToDo: make this properly robust, this hack will have to do for now.
    Bool r = False
    
    ; If no belt, and female, prefer vaginal
    If VaginalOk(PlayerRef)
        r = SexLabUtil.QuickStart(PlayerRef, b, none, none, none,  PlayerRef, "", "Vaginal")
    EndIf
    
    ; Belt but it is open, prefer anal
    If !r && AnalOk(PlayerRef)
        r = SexLabUtil.QuickStart(PlayerRef, b, none,  none, none,  PlayerRef, "", "Anal")
    EndIf
    
    ; Try for oral
    If !r && OralOk(PlayerRef)
        r = SexLabUtil.QuickStart(PlayerRef, b, none, none, none,  PlayerRef, "", "Blowjob")
        If !r
            r = SexLabUtil.QuickStart(PlayerRef, b, none, none, none,  PlayerRef, "", "Oral")
        EndIf
    EndIf
    
    ; Try for boob-job
    If !r && BoobsOk(PlayerRef)
        r = SexLabUtil.QuickStart(PlayerRef, b, none, none, none,  PlayerRef, "", "Boobjob")
    EndIf
    
    
    ; Try for anything. Probably going to be a bad result.
    If !r
        r = SexLabUtil.QuickStart(PlayerRef, b, none, none, none,  PlayerRef, "", "")
    EndIf
    
    If waitComplete
        WaitForSex()
    EndIf
    
    Return r
EndFunction


Bool Function SexInternal_2(Actor b, Actor c, Bool waitComplete = False)
    ; Player is victim

    ; Don't attempt group sex in even basic chastity. Even if you get an animation, DD will likely sabotage it.
    If !VaginalOk(PlayerRef) || !AnalOk(PlayerRef) || !OralOk(PlayerRef)
        Return False
    EndIf

    Bool r = False

    ; If gagged and female, and not belted, prefer vaginal
    If VaginalOk(PlayerRef) && !OralOk(PlayerRef)
        r = SexLabUtil.QuickStart(PlayerRef, b, c, none, none,  PlayerRef, "", "Vaginal")
    EndIf
    
    ; Belt but it is open, prefer anal
    If !r && AnalOk(PlayerRef)
        r = SexLabUtil.QuickStart(PlayerRef, b, c, none, none,  PlayerRef, "", "Anal")
    EndIf
    
    If !r
     r = SexLabUtil.QuickStart(PlayerRef, b, c, none, none,  PlayerRef, "", "")
    EndIf
    
    If waitComplete
        WaitForSex()
    EndIf
    
    Return r
EndFunction


Bool Function SexInternal_3(Actor b, Actor c, Actor d, Bool waitComplete = False)
    ; Player is victim
    
    ; Don't attempt group sex in even basic chastity. Even if you get an animation, DD will likely sabotage it.
    If !VaginalOk(PlayerRef) || !AnalOk(PlayerRef) || !OralOk(PlayerRef)
        Return False
    EndIf
    
    Bool r = False
    
    ; If gagged and female, and not belted, prefer vaginal
    If VaginalOk(PlayerRef) && !OralOk(PlayerRef)
        r = SexLabUtil.QuickStart(PlayerRef, b, c, d, none,  PlayerRef, "", "Vaginal")
    EndIf
    
    ; Belt but it is open, prefer anal
    If !r && AnalOk(PlayerRef)
        r = SexLabUtil.QuickStart(PlayerRef, b, c, d, none,  PlayerRef, "", "Anal")
    EndIf
    
    If !r
     r = SexLabUtil.QuickStart(PlayerRef, b, c, d, none,  PlayerRef, "", "")
    EndIf

    If waitComplete
        WaitForSex()
    EndIf
    
    Return r
EndFunction

Bool Function SexInternal_4(Actor b, Actor c, Actor d, Actor e, Bool waitComplete = False)
    ; Player is victim
    
    ; Don't attempt group sex in even basic chastity. Even if you get an animation, DD will likely sabotage it.
    If !VaginalOk(PlayerRef) || !AnalOk(PlayerRef) || !OralOk(PlayerRef)
        Return False
    EndIf
    
    Bool r = False
    
    ; If gagged and female, and not belted, prefer vaginal
    If VaginalOk(PlayerRef) && !OralOk(PlayerRef)
        r = SexLabUtil.QuickStart(PlayerRef, b, c, d, e,  PlayerRef, "", "Vaginal")
    EndIf
    
    ; Belt but it is open, prefer anal
    If !r && AnalOk(PlayerRef)
        r = SexLabUtil.QuickStart(PlayerRef, b, c, d, e,  PlayerRef, "", "Anal")
    EndIf
    
    If !r
     r = SexLabUtil.QuickStart(PlayerRef, b, c, d, e,  PlayerRef, "", "")
    EndIf

    If waitComplete
        WaitForSex()
    EndIf
    
    Return r
EndFunction



; Don't consider plugs or hobble-dress, or pet-suit blocking, though we probably should.
Bool Function VaginalOk(Actor who)
    Return 1 == who.GetActorBase().GetSex() && !who.WornHasKeyword(libs.zad_DeviousBelt)
EndFunction

Bool Function AnalOk(Actor who)
    Return !who.WornHasKeyword(libs.zad_DeviousBelt) || who.WornHasKeyword(libs.zad_PermitAnal)
EndFunction

Bool Function OralOk(Actor who)
    Return !who.WornHasKeyword(libs.zad_DeviousGag) || who.WornHasKeyword(libs.zad_PermitOral)
EndFunction

Bool Function BoobsOk(Actor who)
    Return !who.WornHasKeyword(libs.zad_DeviousBra)
EndFunction


Function ResetSpanking()

    ; Next spank allowed in 3.5 game hours by default (also used for spank deal)
    SpankingTimer = Utility.GetCurrentGameTime() + MCM.SpankingCoolDownHours / 24.0
    _DFSpankEagerness.SetValue(0.0)
    
EndFunction


Function AllowSpanking()

    SpankingTimer = Utility.GetCurrentGameTime()
    UpdateSpankingStatus()
    
EndFunction


Function UpdateSpankingStatus()
    
    ; Enable spanking dialogs IF...
    ; Time since last spank has elapsed AND
    ; _DFBoredom > 0.0 OR
    ; PC is a masochist.
    ; Set to 1.0 if boredom
    ; Set to 2.0 if masochist
    ; Set to 3.0 for both.
    ; Set to 4.0 for spanking deal
    ; Set to 0.5 if spanks possible and cooldown timer elapsed.
    ; Test against non zero to enable generally.

    Float spankingStatus = 0.0
    
    Float now = Utility.GetCurrentGameTime()
    If SpankingTimer <= now
    
        If CheckSpanking()
            CheckOutdoorSpanking() ; Update the outdoor status
            
            ;Debug.Notification("Outdoor spanking " + _DFOutdoorSpanking.GetValue())
            
            If 2.0 == MCM.MDC.SpankingRule
                spankingStatus = 4.0
            Else
                
                If _DFBoredom.GetValue() > 0.0
                    spankingStatus += 1.0
                EndIf
                If HaveSTA()
                    Int masochism = _DFSpankShim.GetMasochismStage()
                    If masochism >= 2 ; Loves
                        spankingStatus += 2.0
                    ElseIf masochism == 1 && 0.0 == spankingStatus ; Likes
                        spankingStatus = 1.0
                    EndIf
                EndIf
                
                If 0.0 == spankingStatus
                    spankingStatus = 0.5 ; Enables (theoretical) involuntary spanking
                EndIf
            EndIf
            ; Timer will get set if player gets spanked
        EndIf
    EndIf
    
    _DFSpankEagerness.SetValue(spankingStatus)

EndFunction


Bool Function CheckSpanking()

    ; First two anims MUST exist, third is optional, but must have a name entry
    If SexLab && SpankAnimationNames && SpankAnimationNames.Length >= 3
        bool canSpank = SexLab.GetAnimationByName(SpankAnimationNames[0]) && SexLab.GetAnimationByName(SpankAnimationNames[1])
        Debug.Trace("DF - Check Spank - " +  SpankAnimationNames[0] + " = " + SexLab.GetAnimationByName(SpankAnimationNames[0]) + " - " + SpankAnimationNames[1] + " = " + SexLab.GetAnimationByName(SpankAnimationNames[1]))
        Return canSpank
    EndIf

    Debug.Trace("DF - Check Spank - Uninitialized")

    Return False
        
EndFunction

Bool Function CheckOutdoorSpanking()
    
    If SexLab
        If SpankAnimationNamesExt && SpankAnimationNamesExt.Length >= 3
            If SexLab.GetAnimationByName(SpankAnimationNamesExt[0]) && \
                SexLab.GetAnimationByName(SpankAnimationNamesExt[1])
                    _DFOutdoorSpanking.SetValue(1.0)
                    Return True
            EndIf
        EndIf
        
        If SpankAnimationNamesExtAlt && SpankAnimationNamesExtAlt.Length >= 3
            If SexLab.GetAnimationByName(SpankAnimationNamesExtAlt[0]) && \
                SexLab.GetAnimationByName(SpankAnimationNamesExtAlt[1])
                    _DFOutdoorSpanking.SetValue(1.0)
                    Return True
            EndIf
        EndIf
    EndIf
    
    _DFOutdoorSpanking.SetValue(0.0)
    Return False
        
EndFunction

String Function GetSpankingAnims()

    String found = "$DF_NO_SEXLAB_INSTALL"
    
    If SexLab
    
        Int foundDF = 0
    
        If SexLab.GetAnimationByName(SpankAnimationNames[0])
            foundDF += 1
        EndIf
        If SexLab.GetAnimationByName(SpankAnimationNames[1])
            foundDF += 1
        EndIf
        If SexLab.GetAnimationByName(SpankAnimationNames[2])
            foundDF += 1
        EndIf
        
        If SexLab.GetAnimationByName(SpankAnimationNamesExt[0])
            foundDF += 1
        EndIf
        If SexLab.GetAnimationByName(SpankAnimationNamesExt[1])
            foundDF += 1
        EndIf
        If SexLab.GetAnimationByName(SpankAnimationNamesExt[2])
            foundDF += 1
        EndIf
        
        If SexLab.GetAnimationByName(SpankAnimationNamesExtAlt[0])
            foundDF += 1
        EndIf
        If SexLab.GetAnimationByName(SpankAnimationNamesExtAlt[1])
            foundDF += 1
        EndIf
        If SexLab.GetAnimationByName(SpankAnimationNamesExtAlt[2])
            foundDF += 1
        EndIf
        
        If 9 == foundDF
            found = "$DF_SPANK_ANIMS_OK"
        ElseIf 0 == foundDF
            found = "$DF_SPANK_ANIMS_MISSING"
        Else
            found = "$DF_SPANK_ANIMS_PARTIAL"
        EndIf
        
        Int match = 0
        
        If SpankAnimationNames[0] == "DF Nibbles Spanking (Chair)"
            match += 1
        EndIf
        If SpankAnimationNames[1] == "DF Nibbles Spanking (Paddle)"
            match += 1
        EndIf
        If SpankAnimationNames[2] == "DF Anubs Rape"
            match += 1
        EndIf
        If SpankAnimationNamesExt[0] == "DF Anubs Spank"
            match += 1
        EndIf
        If SpankAnimationNamesExt[1] == "DF Anubs Spank Fist"
            match += 1
        EndIf
        If SpankAnimationNamesExt[2]  == "DF Anubs Rape"
            match += 1
        EndIf
        If SpankAnimationNamesExtAlt[0] == "DF Rydin Overlap Spanking"
            match += 1
        EndIf
        If SpankAnimationNamesExtAlt[1] == "DF Rydin Underarm Spanking"
            match += 1
        EndIf
        If SpankAnimationNamesExtAlt[2]  == "DF Anubs Rape"
            match += 1
        EndIf
        
        If 9 != match
            found = "$DF_SPANK_ANIMS_EDITED"
        EndIf

    EndIf
    
    Return found

EndFunction

Bool Function CheckSpankingCode()
    ; STA isn't required for spanking to happen.
    Return HaveSTA() && _DFSpankShim.CheckPatch()
EndFunction

String Function GetSpankingCodeStatus()
    ; STA isn't required for spanking to happen.
    If !HaveSTA()
        Return "$DF_NO_STA"
    EndIf
    If !_DFSpankShim.CheckPatch()
        Return "$DF_STA_UNPATCHED"
    EndIf
    Float staVersion = _DFSpankShim.GetStaVersion()
    If staVersion < 3.5
        Return "$DF_STA_TOO_OLD"
    EndIf
    ; Alas can't check for 3.7 which MATTERS because 3.7 reports as 3.5
    Return "$DF_PATCHED_OK"
    
EndFunction

Bool Function Spank(Actor spanker, Int severity = -1)
    ; Returns True is the spanking played OK, False otherwise.
    
    ; Resets eagerness and timer, and deal timer
    ResetSpanking()
   
   ; Update the spanking rule
   Int spankRequestCount = _DFSpankDealRequests.GetValue() As Int
   spankRequestCount += 1
   _DFSpankDealRequests.SetValue(spankRequestCount As Float)
    
    If severity < 0
        Int mainStage = Q.GetStage()
        ; For slaves, willpower doesn't matter, master picks at random
        If mainStage >= 100 && mainStage < 200
            severity = Utility.RandomInt(0, 2)
        Else
            Float will = _DflowWill.GetValue()
            If will >= 8.0
                severity = 0
                If Utility.RandomInt(0, 10000) < 2000
                    severity = 1
                EndIf
            ElseIf will >= 4.0
                severity = Utility.RandomInt(0, 1)
            ElseIf will >= 2.0
                severity = Utility.RandomInt(0, 2)
            Else
                severity = Utility.RandomInt(1, 2)
                If Utility.RandomInt(0, 10000) < 2000
                    severity = 0
                EndIf
            EndIf
        EndIf
    EndIf
    
    Bool outside = _DFOutdoorSpanking.GetValue() > 0.0
    If outside
        Location loc = PlayerRef.GetCurrentLocation()
        If loc.HasKeyword(LocTypeDwelling) ; Don't count dungeons as interior for this purpose
            outside = False
        EndIf
    EndIf
    
    ; SpankAnimationNames : Nibbles
    ; SpankAnimationNamesExt : Anub
    ; SpankAnimationNamesExtAlt : Rydin
    
    String[] animationNames = SpankAnimationNames
    If outside
        animationNames = SpankAnimationNamesExt
        If Utility.RandomInt(1, 10000) <= 5000
            animationNames = SpankAnimationNamesExtAlt
        EndIf
    Else
        ; If inside, small chance of Anub or Rydin
        If Utility.RandomInt(1, 10000) <= 500
            animationNames = SpankAnimationNamesExt
        ElseIf Utility.RandomInt(1, 10000) <= 500
            animationNames = SpankAnimationNamesExtAlt
        EndIf
    EndIf
    
    String name = animationNames[severity]
    sslBaseAnimation spankAnim = SexLab.GetAnimationByName(name)
    
    If !spankAnim
        Debug.Notification("Missing sex animation: '" + name + "'")
        Return False
    EndIf
    
    Actor[] sexActors = New Actor[2]
    sexActors[0] = PlayerRef
    SexActors[1] = spanker
    
    ; Why do this instead of just assuming from the selection? So the user can change animations in the ESP.
    ; Pre-defined stage handling only for supported animations.
    Int knownAnimation = -1
    
    If name == "DF Nibbles Spanking (Chair)"
        knownAnimation = 0
    ElseIf name == "DF Nibbles Spanking (Paddle)"
        knownAnimation = 1
    ElseIf name == "DF Rydin Overlap Spanking"
        knownAnimation = 2
    ElseIf name == "DF Rydin Underarm Spanking"
        knownAnimation = 3
    ElseIf name == "DF Anubs Spank"
        knownAnimation = 4
    ElseIf name ==  "DF Anubs Spank Fist"
        knownAnimation = 5
    ElseIf name == "DF Anubs Rape"
        knownAnimation = 6
    EndIf
    
    ; Debug.Notification("Known Animation " + knownAnimation)

    ; Need this for Anub Rape, which only spanks on one stage
    Bool isVictim = knownAnimation && 2 == severity
    Int stageCount = spankAnim.StageCount

    ; Don't administer more spanks than this
    ; In practice it's usually a lot less
    Int expectedSpanks = 15 + severity * 10
    
    Bool playedOK = False

    ; If the rape animation (with spanking) is used, then treat as rape "Victim".
    Int threadID = PlaySexAnimation(sexActors, isVictim, spankAnim)
    
    If threadID >= 0
    
        Bool staEnabled = DisableSTASpanking() ; Stop STA applying its own spanks as well

        Utility.Wait(10.0) ; Give animation some time to Start
            
        spankCounter = 0
        
        
        Int spanksLeft = expectedSpanks
        Float rateAdjust = (severity As Float)
    
        While spanksLeft > 0
            
            ; This is generally NOT how people respond to sexLab...
            ; but we have an active task here, makes sense to integrate SL checks with it
            sslThreadController controller = SexLab.ThreadSlots.GetController(threadID)

            ; If some dumb filter changed our animation, we're done here... no spanks.
            If !controller || controller.Animation != spankAnim
                Return False
            EndIf
            
            Int spankStage = controller.Stage

            ; Debug.Notification("Stage " + spankStage + " " + outside)

            Float delay = 3.0
            
            String st = controller.GetState()
            If st != "Animating" && st != "Advancing"
                spanksLeft = 0
                
            ; Nibbles 0, 1, Rydin 2, 3, Anub 4, 5, 6
            ElseIf 0 == knownAnimation
                ; Nibbles chair
                If 4 == spankStage
                    spanksLeft = 0
                Else
                    spanksLeft -= 1
                    SpankPlayerAss()
                    If spankStage == 3
                        delay = 2.0
                    Else
                        delay = 4.0
                    EndIf
                EndIf
            ElseIf 1 == knownAnimation
                ; Nibbles paddle
                If 5 == spankStage
                    If spanksLeft > 2
                        spanksLeft = 2
                    EndIf
                EndIf
                spanksLeft -= 1
                SpankPlayerAss()
                delay = 3.0
            ElseIf 2 == knownAnimation
                ; Rydin overlap
                If 2 == spankStage || 4 == spankStage
                    spanksLeft -= 1
                    SpankPlayerAss()
                    delay = 3.0
                ElseIf 5 == spankStage
                    spanksLeft -= 1
                    SpankPlayerAss()
                    delay = 2.0
                EndIf
            ElseIf 3 == knownAnimation
                ; Rydin underarm
                If 2 == spankStage 
                    spanksLeft -= 1
                    SpankPlayerAss()
                    delay = 2.5
                ElseIf 3 == spankStage
                    spanksLeft -= 1
                    SpankPlayerAss()
                    delay = 2.0
                EndIf
            ElseIf 4 == knownAnimation
                ; Anub spank
                spanksLeft -= 1
                SpankPlayerAss()
                delay = 3.0
            ElseIf 5 == knownAnimation
                ; Anub spank fist
                If 3 == spankStage
                    SpankPlayerTits()
                    delay = 3.0
                Else
                    spanksLeft -= 1
                    SpankPlayerAss()
                    delay = 2.5
                EndIf
            ElseIf 6 == knownAnimation
                ; Anub Rape
                If 2 == controller.Stage || (controller.Stage >= 5 && controller.Stage <= 7)
                    spanksLeft -= 1
                    SpankPlayerAss()
                    delay = 1.5
                ElseIf controller.Stage > 3
                    spanksLeft -= 1
                    SpankPlayerTits()
                    delay = 2.5
                EndIf

            Else
                ; The player changed the spank animations, we know nothing about them.
                spanksLeft -= 1
                If Utility.RandomInt(1, 1000) < 400
                    SpankPlayerTits()
                Else
                    SpankPlayerAss()
                EndIf
                
                delay -= rateAdjust
            EndIf
                
            Utility.Wait(delay)
            
        EndWhile
        
        ;Debug.Notification("Finished with " + spankCounter + " spanks")
        
        If staEnabled
            EnableSTASpanking()
        EndIf
        
        playedOK = True
        
    EndIf

    ; We need to add tit spanks because otherwise we can't max out pain
    ; Both intensities must max for that to happen.
    Int bonusTitSpanks = Utility.RandomInt(0, 4 + severity * 4)
    
    ; Apply consequences good and bad, whether animation played or not.
    FixupSpanks(expectedSpanks - spankCounter, bonusTitSpanks)
    
    ; The special STA functions don't do resist changes, it's all here.
    ReduceResist(15 + severity * 5)
     ; Add fatigue, so spanks not "for free" when willpower has crashed out
    AddFatigueValue(1.0)
    
    ; Boredom only accumulates at 1.0 per X days - usually - it shouldn't be a big value
    ; Spanking reduces K*(2 + severity)  so K < 0.5 seems reasonable
    ; boredeom doesn't increase if will below 4
    Float amusement = 0.4 * ((2.0 + severity) As Float)
    AdjustBoredom(-amusement)
    
    ; Nice easter egg. You won't be punished for a While because you JUST GOT SPANKED!
    ; Exploit freely to do stuff like take out your gag and eat food.
    DeferPunishments()
        
    Return playedOK

EndFunction


Int Function PlaySexAnimation(Actor[] sexActors, Bool hasVictim, sslBaseAnimation playAnim, String hook = "")

    ; Returns threadId or -1 fail, or -2 no animation
    ; Use ThreadSlots.GetController(threadID) to get the controller
    If !playAnim
        Return -2
    EndIf

	;SexLabFramework SexLab = SexLabUtil.GetAPI()
	If !SexLab
		return -1
	EndIf
    
    Actor theVictim = None
    If hasVictim
        theVictim = sexActors[0]
    EndIf
    
    sslBaseAnimation[] explicitAnims = New sslBaseAnimation[1]
    explicitAnims[0] = playAnim
    
    ObjectReference centerOn = None
    Bool allowBed = False
    
    Int threadID = SexLab.StartSex(sexActors, explicitAnims, theVictim, centerOn, allowBed, hook)
    
    Return threadID
    
EndFunction


Function SpankPlayerAss()
    If HaveSTA()
        spankCounter += 1
        _DFSpankShim.SpankAss()
    EndIf
EndFunction

Function SpankPlayerTits()
    If HaveSTA()
        spankCounter += 1
        _DFSpankShim.SpankTits()
    EndIf
EndFunction

Function SpankPlayerSound()
    If HaveSTA()
        _DFSpankShim.SpankSound()
    EndIf
EndFunction

Bool Function DisableSTASpanking()
    If HaveSTA()
        Return _DFSpankShim.SetSpankEnable(False)
    EndIf
    Return False
EndFunction

Function EnableSTASpanking()
    If HaveSTA()
        _DFSpankShim.SetSpankEnable(True)
    EndIf
EndFunction

Function FixupSpanks(Int assSpanks, Int titSpanks)
    If HaveSTA()
        _DFSpankShim.FixupSpanks(assSpanks, titSpanks)
    EndIf
EndFunction

Bool Function HaveSTA()
    Return 255 != Game.GetModByName("Spank That Ass.esp")
EndFunction


Bool Function HaveLola()
    Int lolaIndex = Game.GetModByName("submissivelola_est.esp")
    Debug.TraceConditional("DFC - Lola Index is " + lolaIndex, True)
    If 255 != lolaIndex
        ; Quest.GetQuest("vkjReturnToDFC") -- not working.
        Quest lolaDfQuest = Game.GetFormFromFile(0x000604C5, "submissivelola_est.esp") As Quest 
        Debug.TraceConditional("DFC - Lola DfQuest is " + lolaDfQuest, True)
        Return lolaDfQuest
    EndIf
    Debug.TraceConditional("DFC - Lola not found", True)
    Return False
EndFunction

Bool Function HaveSimpleSlavery()
    Int ssIndex = Game.GetModByName("SimpleSlavery.esp")
    Return 255 != ssIndex
EndFunction



Function BTimerReset() ; Reset the boredom timer
    Float t = GameDaysPassed.GetValue() + _DFBoredomIntervalDays.GetValue()
    _DFBoredomTimer.SetValue(t)
EndFunction


Function ResetExpectations()

    _DFBoredom.SetValue(0.0)
    
    Actor whoMaster = Follower.GetActorRef()
    If whoMaster
        StorageUtil.SetFloatValue(whoMaster, TagBoredom, 0.0)
    EndIf

    _DFExpectedDealCount.SetValue(0.0)

    BTimerReset()
    
EndFunction

; Reduce expected deals and reset boredom timer
Function ReduceBoredom(Int dealReduce = 0)

    _DFBoredom.SetValue(0.0)
    
    Actor whoMaster = Follower.GetActorRef()
    If whoMaster
        StorageUtil.SetFloatValue(whoMaster, TagBoredom, 0.0)
    EndIf
    
    Int expectedDeals = _DFExpectedDealCount.GetValue() As Int
    expectedDeals -= dealReduce
    If expectedDeals < 0
        expectedDeals = 0
    EndIf
    _DFExpectedDealCount.SetValue(expectedDeals As Float)
    
    ; Persist the follower's boredom.
    Float boredom = _DFBoredom.GetValue()
    StorageUtil.SetFloatValue(whoMaster, TagBoredom, boredom)
    
    BTimerReset()

EndFunction

; Simply adjusts boredom; expected deals untouched; timer reset optional
Function AdjustBoredom(Float delta, Bool resetTimer = False)

    Float bored = _DFBoredom.GetValue()
    bored += delta
    If bored < 0.0
        bored = 0.0
    ElseIf bored > 100.0
        bored = 100.0
    EndIf
    
    _DFBoredom.SetValue(bored)
    
    Actor whoMaster = Follower.GetActorRef()
    If whoMaster
        StorageUtil.SetFloatValue(whoMaster, TagBoredom, bored)
        
        ; Persist the follower's boredom.
        Float boredom = _DFBoredom.GetValue()
        StorageUtil.SetFloatValue(whoMaster, TagBoredom, boredom)

    EndIf
    
    If resetTimer
        BTimerReset()
    EndIf

EndFunction


Function AddFatigue()
    Float rate = _DFFatigueRate.GetValue()
    AddFatigueValue(rate)
EndFunction

Function AddFatigueValue(Float rate)

    Float fatigue = _DFFatigue.GetValue()
    fatigue += rate
    If fatigue > MaxResistanceFatigue ; defaults to 100.0
        fatigue = MaxResistanceFatigue
    EndIf
    
    _DFFatigue.SetValue(fatigue)
EndFunction

Function IncreaseWill(Int maxIncrease) ; No longer used.

    Int Temp = _DflowWill.GetValue() as Int
    Int Rnd = Utility.RandomInt(1 , maxIncrease)
    Temp = Rnd + Temp
    If Temp >= 10
        _DflowWill.SetValue(10)
    Elseif Temp <= 5
        _DflowWill.SetValue(5)
    Else
        _DflowWill.SetValue(Temp)
    EndIf
    MCM.noti("Will" , _DFlowWill.GetValue() as Int)
    
EndFunction

Function ReduceWill() ; Reduce by one point. This is used by ReduceResist

    Float willpower = _DflowWill.GetValue()
    _Dutil.Info("DF - ReduceWill: starting willpower is " + willpower)

    willpower -= 1.0
    If willpower < 0.0
        willpower = 0.0
    EndIf

    Float floorWill = (willpower As Int) As Float ; I intend to make willpower fully floating point in future.
    _DFlowWill.SetValue(floorWill)
    
    _Dutil.Info("DF - ReduceWill: ending willpower is " + floorWill)
    
EndFunction


Function IncreaseResist(Int lo, Int hi) ; No longer used.
    Float increaseBy = (Utility.RandomInt(lo , hi) As Float)
    IncreaseResistFloat(increaseBy)
EndFunction

; This doesn't account for "fatigue" by design. You can get above fatigued level if something is adding resistance.
Function IncreaseResistFloat(Float gain)

    ; GetMaxResist factors in level, deals, and devices, but NOT willpower; that is done in FindMaxResist
    Float maxResist = MCM.GetMaxResist() As Float
    
    Float oldWillpower = _DFlowWill.GetValue()
    Float willpower = oldWillpower
    Float resistance = _DFlowResist.GetValue()
    Float resistanceLimit = FindMaxResist(willpower, maxResist)

    Float maxWill = GetMaxWill()
    
    resistance += gain
    
    While resistance > resistanceLimit
        If willpower >= maxWill
            willpower = maxWill
            resistance = resistanceLimit
        Else
            resistance -= resistanceLimit
            willpower += 1.0
            resistanceLimit = FindMaxResist(willpower, maxResist)
        EndIf
    EndWhile
    
    _Dutil.Info("DF - IncreaseResist: final resistance " + resistance + " final will " + willpower)
    
    _DFlowResist.SetValue(resistance)
    _DFlowWill.SetValue(willpower)
    
    If willpower != oldWillpower
        MCM.noti("Will" , willpower As Int)
    EndIf

EndFunction



Function ReduceResist(Int loss) ; This is still used a LOT
    ReduceResistFloat(loss As Float)
EndFunction


Function ReduceResistFloat(Float loss)

    ; GetMaxResist doesn't include willpower, that is done in FindMaxResist
    Float maxResist = MCM.GetMaxResist() As Float
    Float oldWillpower = _DFlowWill.GetValue()
    Float resistance = _DFlowResist.GetValue()
    
    _Dutil.Info("DF - ReduceResist: startingWill " +  oldWillpower + ", starting resist " + resistance + ", removing " + loss)
    
    resistance -= loss
    
    While resistance <= 0.0
    
        Float willpower = _DFlowWill.GetValue()
        
        If willpower <= 0.0
            ; Willpower has totally bottomed out.
            _DFlowResist.SetValue(0.0) ; Maybe this needs to be 1.0 not to break something? ... live dangerously!
             _DFResistanceBroken.SetValue(_DFResistanceBroken.GetValue() - resistance) ; For curiosity ... SLD may use this one day.
             _Dutil.Info("DF - ReduceResist - bottomed out resistance and willpower")
             
             Return
        EndIf
        
        ReduceWill() ; subtract one, doesn't change resistance.
        willpower = _DFlowWill.GetValue() ; Carry over any excess loss to the next willpower point. Removed hairy recursion with global interaction.
        
        Float resistanceGain = FindMaxResist(willpower, maxResist)
        
        resistance += resistanceGain

        _Dutil.Info("DF - ReduceResist - regain resist due to lost will " + resistanceGain + ", resistance now " + resistance)
        
    EndWhile

    _DFlowResist.SetValue(resistance)

    _Dutil.Info("DF ReduceResist by " + loss + " to " + resistance)
    
    Float newWillpower = _DFlowWill.GetValue()
    
    Int old = oldWillpower As Int
    Int now = newWillpower As Int
    If now < old
    
        _Dutil.Info("DF - ReduceResist - Notify player of final willpower " + newWillpower)
        MCM.noti("Will" , now)
        
    EndIf
    
        
    _Dutil.Info("DF - ReduceResist - final resistance " + resistance)

EndFunction


; Another nice misnomer - this restores willpower and resistance on sleeping.
; No longer a big delay in here; it was for DeviousWorld which is incompatible now anyway.
; Don't assume resistance or willpower have integral values now.
Function RestoreResist()

    Int willpowerMode = MCM._DFWillRegainMode

    _Dutil.Info("DF - RestoreResist: regainMode " + willpowerMode)
    
    Float willRegained = MCM.MaxWillRegain ; The new default
    If willRegained < 1.0 ; It's Skyrim, so be defensive.
        willRegained = 1.0
    EndIf
    
    Float deals = (MCM.DealController as QF__DflowDealController_0A01C86D).Deals As Float
    _Dutil.Info("DF - RestoreResist: deals " + deals)
    
    If 0 != willpowerMode ; Apply limited increase to willpower, based on deals and devices.
    
        _Dutil.Info("DF - RestoreResist: use limited willpower regain mechanic")
        Float devices = CountDeviceClasses() As Float
        
        Float score = deals
        If devices > deals
            score = devices
        EndIf
        ; We consider score to be norminally from 0 to 13.
        ; Apply a mild power scale so regain penalties don't kick in hard.
        Float ease = MCM.WillRegainEase
        score = Math.Pow(score, ease) / Math.Pow(13.0, ease)
        If score > 1.0
            score = 1.0
        ElseIf score < 0.0
            score = 0.0
        EndIf
        
        ; Score of 0 is full regain.
        ; Score of 13+ is zero regain.
        ; The full regain is the MaxWillRegain value from the MCM.
        Float regainNormal = (1.0 - score)
        willRegained *= regainNormal
        
        willRegained += MCM.MinWillRegain
        
        ; If you don't get any, there's still a chance... Hope springs eternal.
        If willRegained < 1.0 && Utility.RandomInt(1, 1000) > 500
            willRegained = 1.0
        EndIf
        
        _Dutil.Info("DF - RestoreResist: score " + score + ", deals " + deals + ", devices " + devices + ", regained " + willRegained)
        
    EndIf
    
    Float willpower = _DflowWill.GetValue()
    
    _Dutil.Info("DF - RestoreResist: starting willpower " + willpower)
    
    willpower += willRegained
    
    If willpower > 10.0
        willpower = 10.0
    EndIf
    
    _Dutil.Info("DF - RestoreResist: updated willpower " + willpower)
    
    Float maxWill = GetMaxWill()
        
    If willpower > maxWill
        willpower = maxWill
    EndIf
    
    _Dutil.Info("DF - RestoreResist: final willpower " + willpower)
    
    Float maxResist = MCM.GetMaxResist() As Float
    
    ; After sleep we get best resistance for our current willpower
    Float resistance = FindMaxResist(willpower, maxResist)
    _DFlowResist.SetValue(resistance)
    _DFlowWill.SetValue(willpower)

    Float fatigue = _DFFatigue.GetValue()
    _Dutil.Info("DF - RestoreResist: pre-fatigue resistance " + resistance + ", willpower " + willpower + ", fatigue " + fatigue)

    If fatigue >= 1.0
        ReduceResistFloat(fatigue)
    EndIf

    Float finalResist = _DFlowResist.GetValue()
    Float finalWill = _DFlowWill.GetValue()
    _Dutil.Info("DF - RestoreResist: post-fatigue resistance " + finalResist + ", willpower " + finalWill)
    
    ; Notify player if there was no change due to fatigue
    If finalWill == willpower
        MCM.noti("Will" , willpower As Int)
    EndIf

EndFunction


Float Function GetMaxWill()

    Return 10.0
    ; The 2.X style willpower capping, was intended to work with the default regain of 10.0
    ; That is NOW ENTIRELY GONE ... and has been replaced with a sliding scale deal-resistance modifier.
    ; If MCM._DFDealEffectWill
    
        ; Float deals = (MCM.DealController as QF__DflowDealController_0A01C86D).Deals As Float
        
        ; Float maxWill = 10.0 - 0.5 * deals 
        ; If maxWill < 5.0
            ; maxWill = 5.0
        ; EndIf

        ; If maxWill > 10.0
            ; maxWill = 10.0
        ; EndIf
        ; Return maxWill
    ; Else
        ; Return 10.0
    ; EndIf

EndFunction


Float Function FindMaxResist(Float willpower, Float maxResist)
    ; Moved all this functionality to the MCM so it can sit with GetMaxResist and friends.
    Return MCM.GetWillAdjustedMaxResist(willpower, maxResist)
EndFunction


; Returns a weighted item class count from 0 to 14
Int Function CountDeviceClasses()

    Int count = 0
    
    ; Weaker items that are grouped
    If Libs.PlayerRef.WornHasKeyword(libs.zad_DeviousCorset) || Libs.PlayerRef.WornHasKeyword(libs.zad_DeviousHarness)
        count += 1
    EndIf
    
    If Libs.PlayerRef.WornHasKeyword(libs.zad_DeviousArmCuffs) || Libs.PlayerRef.WornHasKeyword(libs.zad_DeviousLegCuffs)
        count += 1
    EndIf
    
    
    ; Items that count single, in the moderate class
    If Libs.PlayerRef.WornHasKeyword(libs.zad_DeviousCollar)
        count += 1
    EndIf
    If Libs.PlayerRef.WornHasKeyword(libs.zad_DeviousBelt)
        count += 1
    EndIf
    If Libs.PlayerRef.WornHasKeyword(libs.zad_DeviousGag)
        count += 1
    EndIf
    If Libs.PlayerRef.WornHasKeyword(libs.zad_DeviousBoots)
        count += 1
    EndIf
    

    ; Items that count double because more impactful than others
    ; Some of these set a minimal level of misery due to their impact, but we don't want them to be overwhelming in combination.
    Int minCount = 0

    If Libs.PlayerRef.WornHasKeyword(libs.zad_DeviousSuit)
        count += 2 
        minCount = 4
    EndIf

    If Libs.PlayerRef.WornHasKeyword(libs.zad_DeviousBlindfold)
        count += 2
        minCount = 5
    EndIf

    If Libs.PlayerRef.WornHasKeyword(libs.zad_DeviousBondageMittens)
        count += 2
        minCount = 5
    EndIf

    If Libs.PlayerRef.WornHasKeyword(libs.zad_DeviousHeavyBondage)
        count += 2
        minCount = 6
    EndIf
    
    If count < minCount
        count = minCount
    EndIf

    Return count

EndFunction


Function RemoveGear()

    Armor a = PlayerRef.GetWornForm(0x00000002) as Armor
    Armor b = PlayerRef.GetWornForm(0x00000004) as Armor
    Armor c = PlayerRef.GetWornForm(0x00000008) as Armor
    Armor d = PlayerRef.GetWornForm(0x00000080) as Armor

    If a && (a.HasKeyword(ArmorClothing)||a.HasKeyword(ArmorHeavy)||a.HasKeyword(ArmorLight)) && !a.HasKeyword(Warmer) && !a.HasKeyword(SLNS)
        PlayerRef.RemoveItem(a,1,1)
    EndIf

    If b && (b.HasKeyword(ArmorClothing)||b.HasKeyword(ArmorHeavy)||b.HasKeyword(ArmorLight)) && !d.HasKeyword(Warmer) && !a.HasKeyword(SLNS)
        PlayerRef.RemoveItem(b,1,1)
    EndIf

    If c && (c.HasKeyword(ArmorClothing)||c.HasKeyword(ArmorHeavy)||c.HasKeyword(ArmorLight)) && !c.HasKeyword(Warmer) && !a.HasKeyword(SLNS)
        PlayerRef.RemoveItem(c,1,1)
    EndIf

    If d && (d.HasKeyword(ArmorClothing)||d.HasKeyword(ArmorHeavy)||d.HasKeyword(ArmorLight)) && !d.HasKeyword(Warmer) && !a.HasKeyword(SLNS)
        PlayerRef.RemoveItem(d,1,1)
    EndIf

EndFunction


Function DropGear()

    Armor a = PlayerRef.GetWornForm(0x00000002) as Armor
    Armor b = PlayerRef.GetWornForm(0x00000004) as Armor
    Armor c = PlayerRef.GetWornForm(0x00000008) as Armor
    Armor d = PlayerRef.GetWornForm(0x00000080) as Armor

    If a && (a.HasKeyword(ArmorClothing)||a.HasKeyword(ArmorHeavy)||a.HasKeyword(ArmorLight)) && !a.HasKeyword(Warmer) && !a.HasKeyword(SLNS)
        PlayerRef.UnequipItem(a)
        playerref.dropObject(a)
    EndIf

    If b && (b.HasKeyword(ArmorClothing)||b.HasKeyword(ArmorHeavy)||b.HasKeyword(ArmorLight)) && !d.HasKeyword(Warmer) && !a.HasKeyword(SLNS)
        PlayerRef.UnequipItem(b)
        playerref.dropObject(b)
    EndIf

    If c && (c.HasKeyword(ArmorClothing)||c.HasKeyword(ArmorHeavy)||c.HasKeyword(ArmorLight)) && !c.HasKeyword(Warmer) && !a.HasKeyword(SLNS)
        PlayerRef.UnequipItem(c)
        playerref.dropObject(c)
    EndIf

    If d && (d.HasKeyword(ArmorClothing)||d.HasKeyword(ArmorHeavy)||d.HasKeyword(ArmorLight)) && !d.HasKeyword(Warmer) && !a.HasKeyword(SLNS)
        PlayerRef.UnequipItem(d)
        playerref.dropObject(d)
    EndIf

EndFunction


Function UnequipGear()

    Armor a = PlayerRef.GetWornForm(0x00000002) as Armor
    Armor b = PlayerRef.GetWornForm(0x00000004) as Armor
    Armor c = PlayerRef.GetWornForm(0x00000008) as Armor
    Armor d = PlayerRef.GetWornForm(0x00000080) as Armor

    If a && (a.HasKeyword(ArmorClothing)||a.HasKeyword(ArmorHeavy)||a.HasKeyword(ArmorLight)) && !a.HasKeyword(Warmer) && !a.HasKeyword(SLNS)
        PlayerRef.UnequipItem(a)
    EndIf

    If b && (b.HasKeyword(ArmorClothing)||b.HasKeyword(ArmorHeavy)||b.HasKeyword(ArmorLight)) && !d.HasKeyword(Warmer) && !a.HasKeyword(SLNS)
        PlayerRef.UnequipItem(b)
    EndIf

    If c && (c.HasKeyword(ArmorClothing)||c.HasKeyword(ArmorHeavy)||c.HasKeyword(ArmorLight)) && !c.HasKeyword(Warmer) && !a.HasKeyword(SLNS)
        PlayerRef.UnequipItem(c)
    EndIf

    If d && (d.HasKeyword(ArmorClothing)||d.HasKeyword(ArmorHeavy)||d.HasKeyword(ArmorLight)) && !d.HasKeyword(Warmer) && !a.HasKeyword(SLNS)
        PlayerRef.UnequipItem(d)
    EndIf

EndFunction


Function AbandonPlayer(Actor who)

    AddPunishmentScore(200)
        
    PlayerRef.RemoveAllItems()
    Utility.Wait(3.0)
    AddPrisonerChains()
    AddAllHoldBounties(True) ; Skip one hold at random
    Utility.Wait(5.0)
    Q.Reset()
    Q.SetStage(0)

    PlayerRef.MoveTo(Pit)

    ; Don't dismiss the follower again if I've already dismissed them
    If !who.IsInFaction(DismissedFollowerFac)
        ; This resets punishment tracking
        (Q As QF__Gift_09000D62).ExternalRemoveFollower()
    EndIf
    
    FitBeltAndPlugs()

EndFunction


Function AddAllHoldBounties(Bool skipOneHold)

    Int skipId = 0
    If skipOneHold
        skipId = Utility.RandomInt(1, 9)
    EndIf

    If 1 != skipId
        CrimeFacWhiterun.ModCrimeGold(1000)
    EndIf
    If 2 != skipId
        CrimeFacRiften.ModCrimeGold(1000)    
    EndIf
    If 3 != skipId
        CrimeFacSolitude.ModCrimeGold(1000)  
    EndIf
    If 4 != skipId
        CrimeFacMarkarth.ModCrimeGold(1000)  
    EndIf
    If 5 != skipId
        CrimeFacWindhelm.ModCrimeGold(1000)  
    EndIf
    If 6 != skipId
        CrimeFacWinterhold.ModCrimeGold(1000)
    EndIf
    If 7 != skipId
        CrimeFacDawnstar.ModCrimeGold(1000)  
    EndIf
    If 8 != skipId
        CrimeFacMorthal.ModCrimeGold(1000)   
    EndIf
    If 9 != skipId
        CrimeFacFalkreath.ModCrimeGold(1000) 
    EndIf
    
EndFunction


Function FitBeltAndPlugs()

    Bool skipBelt = False
    Armor belt = PlayerRef.GetWornForm(0x00080000) as Armor
    If belt ; slot 49
        If belt.HasKeyword(libs.zad_QuestItem) || belt.HasKeyword(libs.zad_BlockGeneric)
            Return
        Else
            skipBelt = True
        EndIf
    EndIf
        
    Bool skipVaginal = False
    Armor plugV = PlayerRef.GetWornForm(0x08000000) as Armor
    If plugV && plugV.HasKeyword(libs.zad_DeviousPlugVaginal) ; slot 57
        skipVaginal = True
    EndIf

    Bool skipAnal = False
    Armor plugA = PlayerRef.GetWornForm(0x00040000) as Armor
    If plugA && plugA.HasKeyword(libs.zad_DeviousPlugAnal); slot 48
        skipAnal = True
    EndIf

    If !skipVaginal
        Libs.EquipDevice(PlayerRef, PunishPlugVI, PunishPlugVR, libs.zad_DeviousPlugVaginal)
    EndIf
    
    If !skipAnal
        Libs.EquipDevice(PlayerRef, PunishPlugAI, PunishPlugAR, libs.zad_DeviousPlugAnal)
    EndIf
    
    If !skipBelt
        Libs.EquipDevice(PlayerRef, PunishBeltI, PunishBeltR, libs.zad_DeviousBelt)
    EndIf

EndFunction

Function FitChainsOfDebt()
    UnequipGear()
    Utility.Wait(2.0)
    AddChainsOfDebt()
EndFunction

Function FitPrisonerChains()
    UnequipGear()
    Utility.Wait(2.0)
    AddPrisonerChains()
EndFunction

Function FitFullSet()

    UnequipGear()
    Utility.Wait(4.0)
    ; This is all the items that DF requires for traditional deals. The blindfold is only in modular deals; it's added too.
    ; BlindFold, Collar, Gag, Gloves, Nipple Piercings, Corset, Arm Cuffs, Leg Cuffs, Plug Anal, Belt, Vaginal Piercings, Boots
    TryAddDevice(libs.zad_DeviousBelt)
    TryAddDevice(libs.zad_DeviousCorset)
    TryAddDevice(libs.zad_DeviousPiercingsVaginal)
    TryAddDevice(libs.zad_DeviousPiercingsNipple)
    TryAddDevice(libs.zad_DeviousPlugAnal)
    TryAddDevice(libs.zad_DeviousCollar)
    TryAddDevice(libs.zad_DeviousGag)
    TryAddDevice(libs.zad_DeviousGloves)
    TryAddDevice(libs.zad_DeviousLegCuffs)
    TryAddDevice(libs.zad_DeviousBoots)
    TryAddDevice(libs.zad_DeviousBlindfold)
    TryAddDevice(libs.zad_DeviousArmCuffs)
    
EndFunction

Function TryAddDevice(Keyword deviceKeyword)

    If !PlayerRef.WornHasKeyword(deviceKeyword)
        LDC.EquipDeviceByKeyword(deviceKeyword)
    EndIf
    Int waits = 6
    While !PlayerRef.WornHasKeyword(deviceKeyword) && waits
        waits -= 1
        Utility.Wait(1.0)
    EndWhile
    Utility.Wait(0.3)
    
EndFunction

Function AddChainsOfDebt()

    Debug.Notification("Add Chains of Debt")

    If PlayerRef.WornHasKeyword(_DFEndless)
        Debug.Notification("Already wearing chains of debt")
        Return ; Already worn
    EndIf

    ; Collar, CuffsFront, LegCuffs, HeavyBondage
    Keyword questItem = libs.zad_QuestItem
    If PlayerRef.WornHasKeyword(questItem)

        Armor heavy = PlayerRef.GetWornForm(0x00010000) as Armor
        If heavy && heavy.HasKeyword(questItem)
            Return
        EndIf
        Armor collarSlot = PlayerRef.GetWornForm(0x00000020) as Armor
        If collarSlot && collarSlot.HasKeyword(questItem)
            Return
        EndIf
        Armor armCuffsSlot = PlayerRef.GetWornForm(0x20000000) as Armor
        If armCuffsSlot && armCuffsSlot.HasKeyword(questItem)
            Return
        EndIf

        If heavy && heavy.HasKeyword(libs.zad_DeviousHeavyBondage)
            libs.ManipulateGenericDeviceByKeyword(PlayerRef, libs.zad_DeviousHeavyBondage, False )
        EndIf
        If collarSlot && collarSlot.HasKeyword(libs.zad_DeviousCollar)
            libs.ManipulateGenericDeviceByKeyword(PlayerRef, libs.zad_DeviousCollar, False )
        EndIf
        If armCuffsSlot && armCuffsSlot.HasKeyword(libs.zad_DeviousArmCuffs)
            libs.ManipulateGenericDeviceByKeyword(PlayerRef, libs.zad_DeviousArmCuffs, False )
        EndIf

    Else
        libs.ManipulateGenericDeviceByKeyword(Playerref, libs.zad_DeviousHeavyBondage, False)
        libs.ManipulateGenericDeviceByKeyword(PlayerRef, libs.zad_DeviousCollar, False )
        libs.ManipulateGenericDeviceByKeyword(PlayerRef, libs.zad_DeviousArmCuffs, False )
    EndIf

    utility.Wait(2.0)
    Libs.EquipDevice(PlayerRef, ChainsOfDebtI, ChainsOfDebtR, libs.zad_DeviousCollar)
EndFunction

Function AddPrisonerChains()

    Debug.Notification("Add Prisoner Chains")

    If PlayerRef.WornHasKeyword(_DFEndless)
        Debug.Notification("Prisoner chains blocked by chains of debt")
        Return ; Already worn
    EndIf

    Bool needHeavy = True
    Armor heavy
    If PlayerRef.HasKeyword(libs.zad_DeviousHeavyBondage)
        heavy = PlayerRef.GetWornForm(0x00010000) as Armor
        needHeavy = False
        If heavy && heavy == PrisonerChainsR
            Debug.Notification("Already wearing prisoner chains")
            Return
        EndIf
    EndIf
    

    Keyword questItem = libs.zad_QuestItem
    If PlayerRef.WornHasKeyword(questItem)
        ; Determine if there's a blocking quest item before we try and add chains...
        If needHeavy
            heavy = PlayerRef.GetWornForm(0x00010000) as Armor
        EndIf
        If heavy && heavy.HasKeyword(questItem)
            Return
        EndIf

        Armor collarSlot = PlayerRef.GetWornForm(0x00000020) as Armor
        If collarSlot && collarSlot.HasKeyword(questItem)
            Return
        EndIf

        Armor armCuffsSlot = PlayerRef.GetWornForm(0x20000000) as Armor
        If armCuffsSlot && armCuffsSlot.HasKeyword(questItem)
            Return
        EndIf

        If heavy && heavy.HasKeyword(libs.zad_DeviousHeavyBondage)
            libs.ManipulateGenericDeviceByKeyword(PlayerRef, libs.zad_DeviousHeavyBondage, False )
        EndIf
        If collarSlot && collarSlot.HasKeyword(libs.zad_DeviousCollar)
            libs.ManipulateGenericDeviceByKeyword(PlayerRef, libs.zad_DeviousCollar, False )
        EndIf
        If armCuffsSlot && armCuffsSlot.HasKeyword(libs.zad_DeviousArmCuffs)
            libs.ManipulateGenericDeviceByKeyword(PlayerRef, libs.zad_DeviousArmCuffs, False )
        EndIf
    Else
        libs.ManipulateGenericDeviceByKeyword(Playerref, libs.zad_DeviousHeavyBondage, False)
        libs.ManipulateGenericDeviceByKeyword(PlayerRef, libs.zad_DeviousCollar, False )
        libs.ManipulateGenericDeviceByKeyword(PlayerRef, libs.zad_DeviousArmCuffs, False )
    EndIf

    utility.Wait(2.0)
    Libs.EquipDevice(PlayerRef, PrisonerchainsI, PrisonerchainsR, libs.zad_DeviousCollar)

EndFunction


Bool Function RandomDevice(Int b)

    Int a = Utility.randomInt(0,b)
    If a > 100
    a = 100
    EndIf

    If a > 0 
        PlayerRef.additem(Collar, 1,True)
        libs.ManipulateGenericDeviceByKeyword(libs.Playerref, libs.zad_DeviousCollar,True)
    Else 
        Return False
    EndIf
    If a <= 10
            PlayerRef.additem(Armcuffs, 1,True)
        libs.ManipulateGenericDeviceByKeyword(libs.Playerref, libs.zad_DeviousArmCuffs,True)
            PlayerRef.additem(Legcuffs, 1,True)
        libs.ManipulateGenericDeviceByKeyword(libs.Playerref, libs.zad_DeviousLegCuffs,True)
    ElseIf a <= 20
            PlayerRef.additem(Boots, 1,True)
        libs.ManipulateGenericDeviceByKeyword(libs.Playerref, libs.zad_DeviousBoots,True)
    ElseIf a <= 30 
            PlayerRef.additem(Gloves, 1,True)
         libs.ManipulateGenericDeviceByKeyword(libs.Playerref, libs.zad_DeviousGloves,True)
    ElseIf a <= 40
            PlayerRef.additem(Boots, 1,True) 
        libs.ManipulateGenericDeviceByKeyword(libs.Playerref, libs.zad_DeviousBoots,True)
            PlayerRef.additem(Armcuffs, 1,True)
        libs.ManipulateGenericDeviceByKeyword(libs.Playerref, libs.zad_DeviousArmCuffs,True)
            PlayerRef.additem(Legcuffs, 1,True)
        libs.ManipulateGenericDeviceByKeyword(libs.Playerref, libs.zad_DeviousLegCuffs,True)
    ElseIf a <= 50
            PlayerRef.additem(Boots, 1,True)
         libs.ManipulateGenericDeviceByKeyword(libs.Playerref, libs.zad_DeviousBoots,True)
            PlayerRef.additem(Armcuffs, 1,True)
        libs.ManipulateGenericDeviceByKeyword(libs.Playerref, libs.zad_DeviousArmCuffs,True)
            PlayerRef.additem(Legcuffs, 1,True)
        libs.ManipulateGenericDeviceByKeyword(libs.Playerref, libs.zad_DeviousLegCuffs,True)
            PlayerRef.additem(Gloves, 1,True)
        libs.ManipulateGenericDeviceByKeyword(libs.Playerref, libs.zad_DeviousGloves,True)
    ElseIf a <= 60
         libs.equipDevice(libs.PlayerRef, Mittens , MittensR, libs.zad_DeviousBondageMittens, skipevents = False, skipmutex = True) 
            PlayerRef.additem(Armcuffs, 1,True)
        libs.ManipulateGenericDeviceByKeyword(libs.Playerref, libs.zad_DeviousArmCuffs,True)
            PlayerRef.additem(Legcuffs, 1,True)
        libs.ManipulateGenericDeviceByKeyword(libs.Playerref, libs.zad_DeviousLegCuffs,True)
            PlayerRef.additem(Gag, 1,True)
        libs.ManipulateGenericDeviceByKeyword(libs.Playerref, libs.zad_DeviousGag,True)
    ElseIf a <= 70
            PlayerRef.additem(Boots, 1,True)
         libs.ManipulateGenericDeviceByKeyword(libs.Playerref, libs.zad_DeviousBoots,True)
            PlayerRef.additem(Armcuffs, 1,True)
        libs.ManipulateGenericDeviceByKeyword(libs.Playerref, libs.zad_DeviousArmCuffs,True)
            PlayerRef.additem(Legcuffs, 1,True)
        libs.ManipulateGenericDeviceByKeyword(libs.Playerref, libs.zad_DeviousLegCuffs,True)
            
        libs.equipDevice(libs.PlayerRef, Binder , BinderR, libs.zad_DeviousArmbinder,True) 
    ElseIf a <= 80
            PlayerRef.additem(BlindFold, 1,True)
         libs.ManipulateGenericDeviceByKeyword(libs.Playerref, libs.zad_DeviousBlindfold,True)
            PlayerRef.additem(Armcuffs, 1,True)
        libs.ManipulateGenericDeviceByKeyword(libs.Playerref, libs.zad_DeviousArmCuffs,True)
            PlayerRef.additem(Legcuffs, 1,True)
        libs.ManipulateGenericDeviceByKeyword(libs.Playerref, libs.zad_DeviousLegCuffs,True)
            PlayerRef.additem(Gag, 1,True)
        libs.ManipulateGenericDeviceByKeyword(libs.Playerref, libs.zad_DeviousGag,True)
    ElseIf a <= 90
            PlayerRef.additem(Boots, 1,True)
         libs.ManipulateGenericDeviceByKeyword(libs.Playerref, libs.zad_DeviousBoots,True)
            PlayerRef.additem(Armcuffs, 1,True)
        libs.ManipulateGenericDeviceByKeyword(libs.Playerref, libs.zad_DeviousArmCuffs,True)
            PlayerRef.additem(Legcuffs, 1,True)
        libs.ManipulateGenericDeviceByKeyword(libs.Playerref, libs.zad_DeviousLegCuffs,True)
         libs.equipDevice(libs.PlayerRef, Jacket , JacketR,  libs.zad_DeviousStraitJacket,True) 
    ElseIf a <= 100
            PlayerRef.additem(Boots, 1,True)
         libs.ManipulateGenericDeviceByKeyword(libs.Playerref, libs.zad_DeviousBoots,True)
            PlayerRef.additem(Armcuffs, 1,True)
        libs.ManipulateGenericDeviceByKeyword(libs.Playerref, libs.zad_DeviousArmCuffs,True)
            PlayerRef.additem(Legcuffs, 1,True)
        libs.ManipulateGenericDeviceByKeyword(libs.Playerref, libs.zad_DeviousLegCuffs,True)
         libs.equipDevice(libs.PlayerRef, Jacket , JacketR,  libs.zad_DeviousStraitJacket,True) 
            PlayerRef.additem(Gloves, 1,True)
        libs.ManipulateGenericDeviceByKeyword(libs.Playerref, libs.zad_DeviousGloves,True)
            PlayerRef.additem(BlindFold, 1,True)
         libs.ManipulateGenericDeviceByKeyword(libs.Playerref, libs.zad_DeviousBlindfold,True)
    EndIf
        Return True
        
EndFunction


Bool Function PiercingActivate(Bool reward = True, Int howStrong = 2)

        Armor vPiercing = StorageUtil.GetFormValue(PlayerRef, "zad_Equipped" + libs.LookupDeviceType(libs.zad_DeviousPiercingsVaginal) + "_Rendered") as Armor
        Armor nPiercing = StorageUtil.GetFormValue(PlayerRef, "zad_Equipped" + libs.LookupDeviceType(libs.zad_DeviousPiercingsNipple) + "_Rendered") as Armor
        If reward && ((vPiercing && (vPiercing.HasKeyword(_DFGemP))) || (nPiercing && (nPiercing.HasKeyword(_DFGemP))))
            MCM.Noti("Pier4") ; Reward
            Libs.VibrateEffect(playerRef, howStrong, 0)
            ReduceResist(6)
            Return True
        ElseIf !reward && ((vPiercing && (vPiercing.HasKeyword(_DFGemP))) || (nPiercing && (nPiercing.HasKeyword(_DFGemP))))
            If howStrong >= 6
                MCM.Noti("Pier3") ; Massive shock
                PlayerRef.PlayIdle(BleedOutStart)
                Utility.Wait(2)
                PlayerRef.PlayIdle(BleedOutStop)
                libs.ShockEffect.RemoteCast(PlayerRef, PlayerRef, PlayerRef)
                libs.Aroused.UpdateActorExposure(PlayerRef, -Utility.RandomInt(10, 20))
                ReduceResist(12)
                
            ElseIf PDelay < GameDaysPassed.GetValue()
                MCM.Noti("Pier") ; Shock
                libs.ShockEffect.RemoteCast(PlayerRef, PlayerRef, PlayerRef)
                libs.Aroused.UpdateActorExposure(PlayerRef, -Utility.RandomInt(10, 20))
                PDelay = GameDaysPassed.GetValue() + 0.04
                ReduceResist(4)
             Elseif (Utility.RandomInt(0,2)) > 1
                MCM.Noti("Pier2") ; Tingle
             EndIf
            Return True
        EndIf
        Return False
EndFunction


Function KeyGame(Int Cost, Actor Sender) 

    Int KeyDiff = MCM._DFKeyDiffI ; 0 = 60%, 1 = 50%, 2 = 42%, 3 = 37% , 4 = 33%
    Float ConcealChance = (MCM._DFKConceal/100) + Turn
    Turn += 0.1*KeyDiff

    Bool doSex = False
    Int Keyn = 3
    Int KeyR = 0
    Int KeyC = 0
    Int ToolP = 0
    Int Roll = 0
    Float TInc = MCM._DflowRemovalBasePrice.GetValue()

    ConcealChance = 1/ConcealChance*3

    If ConcealChance < 3
      ConcealChance = 3
    EndIf

    Int Conceal = Utility.RandomInt(1,ConcealChance as Int);  1 = Conceal Keys , 2 = Conceal Price , 3 = Conceal All, 4+= Show all 
    If Cost < MCM._DflowRemovalBasePrice.GetValue() 
        Cost = (MCM._DflowRemovalBasePrice.GetValue()/2) as INT + Cost
    EndIf
       
        Roll = Utility.RandomInt((TInc/3) As Int,(TInc*1.0) As Int)
        Cost = Roll + Cost

    Roll = Utility.RandomInt(1,3+KeyDiff)
    If Roll == 1
        KeyR += 1
    ElseIf Roll == 2
        KeyC += 1
    ElseIf Roll == 3
        ToolP += 1
    Else
        
    EndIf

    Roll = Utility.RandomInt(0,4+KeyDiff)
    If Roll == 1
        KeyR += 1
    ElseIf Roll == 2
        KeyC += 1
    ElseIf Roll == 3
        ToolP += 1
    Else
        
    EndIf

    Roll = Utility.RandomInt(0,5+KeyDiff)
    If Roll == 1
        KeyR += 1
    ElseIf Roll == 2
        KeyC += 1
    ElseIf Roll == 3
        ToolP += 1
    Else
        
    EndIf

    Roll = Utility.RandomInt(0,12)
    If Roll == 9
        KeyR += 1
        KeyC += 1
        ToolP += 1
    EndIf

    Roll = Utility.RandomInt(0,3)
    If Roll == 1
        doSex = True
    ElseIf Roll == 2
        Cost = (Cost*1.25) As Int
    ElseIf Roll == 3

    Else
        
    EndIf 

    Roll = Utility.RandomInt(0,9)
    If Roll == 9
       Cost -= MCM._DflowRemovalBasePrice.GetValue() as Int
    EndIf

    If Turn > Utility.RandomInt(0,20)
        Cost = 2*Cost
    EndIf 

    If Turn > Utility.RandomInt(3,20)
        Cost = 2*Cost
    EndIf 

    ;  1 = Conceal Keys , 2 = Conceal Price , 3 = Conceal All, 3-6 = Show all
    If Cost > (MCM._DflowRemovalBasePrice.GetValue()*4) as Int

    Cost =(MCM._DflowRemovalBasePrice.GetValue()*4) as Int
    Conceal = -1
    doSex = True
    Elseif Cost < 0
    Cost = 0
    EndIf
    Int choice = 0
    If Conceal == 1
        If doSex
            Choice = _DFKeyGameCKeysS.Show(Cost)
        Else
            Choice = _DFKeyGameCKeys.Show(Cost)
        EndIf
    ElseIf Conceal ==2
        If doSex
            Choice = _DFKeyGameCPrice.Show(KeyR,KeyC,ToolP)
        Else
            Choice = _DFKeyGameCPrice.Show(KeyR,KeyC,ToolP)
        EndIf
    ElseIf Conceal ==3
        If doSex
            Choice = _DFKeyGameCAll.Show()
        EndIf
    ElseIf Conceal ==-1
        If doSex
            Choice = _DFKeyGameCAllS.Show()
        EndIf
    Else 
        If doSex
            Choice = _DFKeyGameAllS.Show(KeyR,KeyC,ToolP,Cost)
        Else
            Choice = _DFKeyGameAll.Show(KeyR,KeyC,ToolP,Cost)
        EndIf
    EndIf

    If Choice == 1
        PlayerRef.Additem(RKey, KeyR)
        PlayerRef.Additem(CKey, KeyC)
        PlayerRef.Additem(PTool, ToolP)
        Turn = 0
        If Game.GetPlayer().GetItemCount(Gold001) < Cost
        (Q as QF__Gift_09000D62).Debt(Cost)
        Else
        Game.GetPlayer().RemoveItem(Gold001,Cost)
        EndIf
        MCM.GoldCont.LivesLost()
        Float ML = MCM.Lives.GetValue() - 1.0
        MCM.Lives.SetValue(ML)
        
        If doSex
            If Sex(Sender)
                WaitForSex()
            EndIf
        EndIf

    Else
        KeyGame(Cost,Sender)
    EndIf

EndFunction

Bool Function CheckAndRemoveKeys(Actor followerActor, ObjectReference destinationContainer = None)

    ; If we don't play the animation, take the keys anyway...
    
    Bool playAnimation = !PlayerRef.IsInCombat() && !PlayerRef.IsArrested() && followerActor.Is3DLoaded() && PlayerRef.HasLOS(followerActor) && PlayerRef.GetDistance(followerActor) < 500.0 \
       && !followerActor.IsInDialogueWithPlayer() && !followerActor.IsDoingFavor() && !_DFlowAnimation.IsInvalidAnimationActor(PlayerRef) 

    Bool[] animationState 
    Float startTime = Utility.GetCurrentRealTime()
    Bool taken = False

    If playAnimation
        animationState = _DFlowAnimation.StartAnimation(PlayerRef, "ft_out_of_breath_reg")
    EndIf
    
    Int iFormIndex = PlayerRef.GetNumItems()
    While iFormIndex > 0
        iFormIndex -= 1
        Form kForm = PlayerRef.GetNthForm(iFormIndex)
        
        If kForm.HasKeyWord(ddRestraintsKey) || kForm.HasKeyWord(ddChastityKey)
            Int count = PlayerRef.GetItemCount(kForm)
            PlayerRef.Removeitem(kForm, count, True, destinationContainer)
            taken = True
        EndIf

    EndWhile
    
    If playAnimation && animationState[0]
        Float endTime = Utility.GetCurrentRealTime()
        Float remainingWait = 5.0 - (endTime - startTime)
        If remainingWait > 0.3
            Utility.Wait(remainingWait)
        EndIf
        
        _DFlowAnimation.EndAnimation(PlayerRef, animationState)
    EndIf
    
    Return taken

EndFunction


Function PauseAll()	
    SendModEvent("DF-SceneStart")
    SendModEvent("dhlp-Suspend")
    libs.GlobalEventFlag = False
    Suspend = 1 ; NEVER USE THIS FOR DETECTION MCM DISPLAY ONLY
    StorageUtil.SetIntValue(None, "DF_PausedForScene", 1)
EndFunction

Function ResumeAll()	 
    SendModEvent("DF-SceneEnd")
    SendModEvent("dhlp-Resume")
    libs.GlobalEventFlag = True	
    Suspend = 0 ; NEVER USE THIS FOR DETECTION MCM DISPLAY ONLY
    StorageUtil.SetIntValue(None, "DF_PausedForScene", 0)
EndFunction

Function Enslaved()
    PEnslave = True
    SendModEvent("PlayerRefEnslaved")
EndFunction

Function Unenslaved()
    PEnslave = False
    SendModEvent("PlayerRefFreed")
EndFunction


Function DealDelayhr()
    DO.DelayHr()
    DB.DelayHr()
    DH.DelayHr()
    DP.DelayHr()
    DS.DelayHr()
EndFunction


Function DealReset()
    DO.Reset()
    DB.Reset()
    DH.Reset()
    DP.Reset()
    DS.Reset()
EndFunction


Function DealMessages()

    Float Dealnumber = 0.0
    Int Stage = 0

    Stage = DB.Getstage()
    If Stage == 1
        DealNumber += 1
        _DFlowDealB1.Show(DealNumber)
    ElseIf Stage == 2
        DealNumber += 1
        _DFlowDealB2.Show(DealNumber)

    ElseIf Stage == 3
        DealNumber += 1
        _DFlowDealB3.Show(DealNumber)
    ElseIf Stage == 4
        DealNumber += 1
        _DFlowDealB4.Show(DealNumber)
        
    EndIf 

    Utility.Wait(1)

    Stage = DO.Getstage()
    If Stage == 1
        DealNumber += 1
        _DFlowDealO1.Show(DealNumber)
    ElseIf Stage == 2
        DealNumber += 1
        _DFlowDealO2.Show(DealNumber)
        
    ElseIf Stage == 3
        DealNumber += 1
        _DFlowDealO3.Show(DealNumber)
    ElseIf Stage == 4
        DealNumber += 1
        _DFlowDealO4.Show(DealNumber)
        
    EndIf 

    Utility.Wait(1)

    Stage = DH.Getstage()
    If Stage == 1
        DealNumber += 1
        _DFlowDealH1.Show(DealNumber)
    ElseIf Stage == 2
        DealNumber += 1
        _DFlowDealH2.Show(DealNumber)
        
    ElseIf Stage == 3
        DealNumber += 1
        _DFlowDealH3.Show(DealNumber)

    ElseIf Stage == 4
        DealNumber += 1
        _DFlowDealH4.Show(DealNumber)
    EndIf 

    Utility.Wait(1)

    Stage = DP.Getstage()
    If Stage == 1
        DealNumber += 1
        _DFlowDealP1.Show(DealNumber)
    ElseIf Stage == 2
        DealNumber += 1
        _DFlowDealP2.Show(DealNumber)
    ElseIf Stage == 3
        DealNumber += 1
        _DFlowDealP3.Show(DealNumber)
    EndIf 

    Utility.Wait(1)

    Stage = DS.Getstage()
    If Stage == 1
        DealNumber += 1
        _DFlowDealS1.Show(DealNumber)
    ElseIf Stage == 2
        DealNumber += 1
        _DFlowDealS2.Show(DealNumber)
    ElseIf Stage == 3
        DealNumber += 1
        _DFlowDealS3.Show(DealNumber)
    EndIf 

    Stage = DM1.GetStage() + DM2.GetStage() + DM3.GetStage() + DM4.GetStage() + DM5.GetStage()
    If stage > 0
        ; Tell the player they need to check the MCM to see their modular deals.
        Debug.Notification("$DF_CHECKDEALSMCM")
    EndIf

EndFunction


Function MakeDonation(Int amount)

    Int currentGold = PlayerRef.GetItemCount(Gold001)
    
    If currentGold >= amount
        
        Float fatigue = _DFFatigue.GetValue()
        Float cost = _DFGoldPerFatigue.GetValue()
        
        fatigue -= (amount As Float) / cost
        If fatigue < 0.0
            fatigue = 0.0
        EndIf

        PlayerRef.RemoveItem(Gold001, amount)
        _DFFatigue.SetValue(fatigue)
        
    EndIf
    
EndFunction


Actor[] Function GetAllFollowers()

    Actor[] findActorList = New Actor[16]
    Int followerCount = -1

    If 255 != Game.GetModByName("AmazingFollowerTweaks.esp")
        followerCount = _df_AFT_extensions.FindFollowers(findActorList)
    EndIf
    
    If followerCount < 0 && 255 != Game.GetModByName("EFFCore.esm")
        followerCount = _df_EFF_extensions.FindFollowers(findActorList)
    EndIf

    If followerCount < 0 && 255 != Game.GetModByName("nwsFollowerFramework.esp")
        followerCount = _df_NFF_extensions.FindFollowers(findActorList)
    EndIf
    
    If followerCount <= 0
        Actor vanillaActor = vanillaFollower.GetActorRef()
        If vanillaActor
            followerCount = 1
            findActorList[0] = vanillaActor
        EndIf
    EndIf
    
    If followerCount <= 0
        Return None
    EndIf
    
    Actor[] returnList = PapyrusUtil.ActorArray(followerCount)
    Int ii = followerCount
    While ii
        ii -= 1
        returnList[ii] = findActorList[ii]
    EndWhile
    
    Return returnList

EndFunction


Function EndScene()
    ; For player and followers
    
    Scene playerScene = PlayerRef.GetCurrentScene()
    If playerScene
        _DUtil.Spam("DF::EndScene - player has scene - playing " + playerScene.IsPlaying())
        playerScene.Stop()
    EndIf
    
    Actor[] followers = GetAllFollowers()
    If followers
    
        Actor masterFollower = Follower.GetActorRef()
    
        Int ff = followers.Length
        _DUtil.Spam("DF::EndScene - found " + ff + " followers")
        While ff
            ff -= 1
            Actor factor = followers[ff]
            
            If factor == masterFollower
                _DUtil.Spam("DF::EndScene - master follower at " + ff)
            EndIf
            
            Scene followerScene = factor.GetCurrentScene()
            If followerScene
                _DUtil.Spam("DF::EndScene - follower " + ff + " has scene - playing " + followerScene.IsPlaying() + " " + factor.GetActorBase().GetName())
                followerScene.Stop()
            EndIf
        EndWhile
    EndIf
    
EndFunction



; This was only used locally in the Jarl scenes.
; It's not used for the forced Start quest.
; It's no longer used AT ALL.
Actor Function FindGuard(Actor oldGuard) 
    Return None
EndFunction


; The nice version, just guards...
Function JarlScene(Actor Jarl)
    ; 400 = Speak to follower: you like my little device? => go to the Jarl (401)
    ; 401 = Speak to Jarl: nice puppy
    ; 402 = Quest *scene* running
    ; 403 = Script scene running (this script)
    ; 404 = complete

    AdvanceCommentTimer(20.0)
    _DFlowGames.SetStage(403)
    PlayerRef.SetDontMove(False)

    Float timeoutAfter = 180.0
    
    If Jarl
        MCM.Noti("Unsnap") ; free
        If SexInternal_1(Jarl)
            DelayPlaySceneAndWait(15.0, timeoutAfter, _DflowGamesDogKitten) ; guard sex dialog
        EndIf
        Utility.Wait(2.0)
        MCM.Noti("Snap")
        Utility.Wait(4.0)
    EndIf
    
    Actor[] guards = New Actor[3]
    Int guardCount = GuardScan(guards)
    Actor guard
    
    If guardCount > 0
        guard = guards[0]
        If guard
            MCM.Noti("JG") ; calls a guard
            Utility.Wait(3.0)
            guard.MoveTo(Game.Getplayer()) ; This is a mess - guards need proper AI. Or maybe nobody cares?
            MCM.Noti("Unsnap") ; free
            Utility.Wait(4.0)
            
            If SexInternal_1(guard)
                DelayPlaySceneAndWait(15.0, timeoutAfter, _DflowGamesDogKitten) ; guard sex dialog
            EndIf
        EndIf
    EndIf

    If guardCount > 1
        guard = guards[1]
        If guard

            MCM.Noti("JG1") ; jarl whistles and another guard comes over
            Utility.Wait(4.0)
            guard.MoveTo(Game.Getplayer()) ; This is a mess - guards need proper AI.
            If SexInternal_1(guard)
                DelayPlaySceneAndWait(15.0, timeoutAfter, _DflowGamesDogKitten); guard sex dialog
            EndIf

            MCM.Noti("JG2") ; guard keeps going while the jarl watches
            Utility.Wait(4.0)
            If SexInternal_1(guard)
                DelayPlaySceneAndWait(15.0, timeoutAfter, _DflowGamesDogKitten) ; guard sex dialog
            EndIf
            Utility.Wait(4.0)
        EndIf
    EndIf

    If guardCount > 2
        guard = guards[2]
        If guard
            MCM.Noti("JG1") ; jarl whistles and another guard comes over
            Utility.Wait(4.0)
            guard.MoveTo(Game.Getplayer()) ; This is a mess - guards need proper AI.
            If SexInternal_1(guard)
                DelayPlaySceneAndWait(15.0, timeoutAfter, _DflowGamesDogKitten) ; guard sex dialog
            EndIf
        EndIf
    EndIf
    
    if guardCount > 0
        Utility.Wait(3.0)
        MCM.Noti("JG3") ; called off
        Utility.Wait(3.0)
        MCM.Noti("Snap")
    EndIf
    
    Utility.Wait(10.0)
    
EndFunction


; Creature content version
Function JarlScene2(Actor Jarl)

    AdvanceCommentTimer(20.0)
    _DFlowGames.SetStage(403)
    PlayerRef.SetDontMove(False)

    Float timeoutAfter = 120.0
    
    MCM.Noti("Unsnap") ; free
    
    If Jarl
        If SexInternal_1(Jarl)
            DelayPlaySceneAndWait(15.0, timeoutAfter, _DflowGamesDogKitten) ; guard sex dialog
        EndIf
        Utility.Wait(2.0)
        MCM.Noti("Snap")
        Utility.Wait(4.0)
    EndIf

    If Dog
        MCM.Noti("Unsnap") ; free for sex
        Debug.Notification("$DF_JARLDOG1")
        Dog.Enable()
        Dog.AllowPCDialogue(False) ; It's silly if you can talk to the dog.
        Dog.MoveTo(Game.Getplayer())
        Utility.Wait(4.0)

        If SexInternal_1(Dog)
            DelayPlaySceneAndWait(15.0, timeoutAfter, _DflowGamesDogKitten2) ; dog sex dialog
            Debug.Notification("$DF_JARLDOG2") ; stops, then starts again
            Utility.Wait(4.0)
        EndIf
        
        If SexInternal_1(Dog)
            DelayPlaySceneAndWait(15.0, timeoutAfter, _DflowGamesDogKitten2) ; dog sex dialog
            Debug.Notification("$DF_JARLDOG3") ; still knotted
            Utility.Wait(4.0)
        EndIf

        If SexInternal_1(Dog)
            DelayPlaySceneAndWait(15.0, timeoutAfter, _DflowGamesDogKitten2) ; dog sex dialog
            Debug.Notification("$DF_JARLDOG4") ; dog off
            Utility.Wait(3.0)
        EndIf
        MCM.Noti("Snap")
    EndIf
    Utility.Wait(10.0)
    
EndFunction

    
Function DelayPlaySceneAndWait(Float preDelay, Float timeoutAfter, Scene toPlay)
    Utility.Wait(preDelay)
    If toPlay
        toPlay.Start()
    EndIf
    WaitForSex(timeoutAfter)
EndFunction



; Count how often the follower said the words for the slut deal.
Function IncrementSlutCount()

    Float existingCount = _DFSlutCount.GetValue()
    If existingCount == _DFSlutCount.Mod(1.0)
        _DFSlutCount.SetValue(existingCount + 1.0)
    EndIf
    
    Int slutCount = _DFSlutCount.GetValue() As Int
    _Dutil.Info("DF IncrementSlutCount " + slutCount)
EndFunction

Function UpdateChaos()
    MCM.Chaos(False)
EndFunction


; Adds to the slavery punishment tracking, for external slave punishment, and speculative "strict punishment" feature.
Function AddPunishmentScore(Int score)
    Int questStage = Q.GetStage()
    If questStage >= 98 && questStage < 200
        StorageUtil.AdjustIntValue(PlayerRef, "DF_Enslaved_PunishCount", score)
        StorageUtil.AdjustIntValue(PlayerRef, "DF_Enslaved_TotalPunishCount", score)
        StorageUtil.AdjustIntValue(PlayerRef, "DF_Enslaved_TotalPunishCount_AllFollowers", score)
        
        Actor whoMaster = Follower.GetActorRef()
        If whoMaster
            StorageUtil.AdjustIntValue(whoMaster, "DF_Enslaved_PunishCount", score)
            StorageUtil.AdjustIntValue(whoMaster, "DF_Enslaved_TotalPunishCount", score)
        EndIf
    EndIf
EndFunction

; Get tracking from actor
Function RestorePunishmentTracking(Actor whoMaster)
    StorageUtil.SetIntValue(PlayerRef, "DF_Enslaved_PunishCount", 0)
    Int questStage = Q.GetStage()
    If questStage >= 98 && questStage < 200
        If whoMaster
            ; Current from master, but total from player
            Int followerValue = StorageUtil.GetIntValue(whoMaster, "DF_Enslaved_PunishCount", 0)
            StorageUtil.SetIntValue(PlayerRef, "DF_Enslaved_PunishCount", followerValue)
            
            Int currentTotal = StorageUtil.GetIntValue(PlayerRef, "DF_Enslaved_TotalPunishCount", 0)
            StorageUtil.SetIntValue(whoMaster, "DF_Enslaved_TotalPunishCount", currentTotal)
        EndIf
    EndIf
EndFunction


Function BlackFade(bool FadeOut = true)
    Debug.Trace("DF - Fading out")
    if FadeOut
        Debug.Trace("DF - Fading out")
        Game.FadeOutGame(false, true, 60.0, 0.0)
    else
        Debug.Trace("DF - Fading in")
        Game.FadeOutGame(false, true, 0.2, 3.0)
    endIf
EndFunction

; A way to call this from tools rather than _DFlow
Function PunDebt()

    (Q As QF__Gift_09000D62).ApplyPunishmentDebt()
    
    ;Int cash = PlayerRef.GetItemCount(Gold001)
    ;cash /= 2
    ;PlayerRef.RemoveItem(Gold001, cash)
    
    AddPunishmentScore(10)
    MCM.CalculateScaledDebts()

    DeferPunishments()
    
    Debug.Notification("$DF_PUNDEBT")
    
    ; Potentially make PC available for spanking even if cooldown not elapsed.
    AllowSpanking()
    
EndFunction

Function DeferPunishments()

    ; Don't punish the player without a delay. This is also set on taking a new deal, so the player has time to comply.
    _DFPunishmentTimer.SetValue(Utility.GetCurrentGameTime() + PunishmentInterval) 
    
EndFunction

; Locate a new follower who can act as DF
Actor Function FindNewFollower()
    
    _DFlowFindFollower.Stop()
    _DFlowFindFollower.Reset()
    _DFlowFindFollower.Start()
    Utility.Wait(1.0)
    ReferenceAlias theAlias = _DFlowFindFollower.GetNthAlias(0) As ReferenceAlias
    
    Actor found
    If theAlias
        found = theAlias.GetActorRef()
    EndIf
    
    _DFlowFindFollower.Stop()
    Return found
    
EndFunction

Function AdvanceCommentTimer(Float seconds)

    seconds /= (86400.0/20.0) ; Convert seconds to game time in days... at 20x normal time-rate ... would be better if I got the time rate properly ... but even then player can change before timer is used.
    Float current = _DFGameCommentTimer.GetValue()
    Float now = Utility.GetCurrentGameTime()
    Float offset = now - current
    Float adjustBy = seconds + offset
    
    ; While the Get above defeats atomicity, I'm hoping this call will ensure that other code gets the updated value and doesn't hold onto the old one.
    _DFGameCommentTimer.Mod(adjustBy)

EndFunction

Function DisableControlsForScene()
    ; Basically does nothing because of Zadlibs constant calling of UpdateControls()
    ; Game.DisablePlayerControls(abMovement = True, abFighting = True, abCamSwitch = False, abLooking = False, abSneaking = True, abMenu = False, abActivate = True, abJournalTabs = True, aiDisablePOVType = 0)
    ; So we need another approach...
    libs.UpdateControls()
    PlayerRef.SetDontMove()
EndFunction

Function EnablePlayerControls()
    ; Game.EnablePlayerControls(True, True, True, True, True, True, True, True, 0)
    libs.UpdateControls()
    PlayerRef.SetDontMove(False)
EndFunction

Function PrepareForScene()
    Debug.TraceConditional("DF - PrepareForScene", True)
    PauseAll()
    DisableControlsForScene()
    PC.MoveTo(Game.Getplayer(), 1000, 1000)
    PC.Enable()
EndFunction

Function CleanUpAfterScene()
    Debug.TraceConditional("DF - CleanUpAfterScene", True)
    PC.Disable()
    EnablePlayerControls()
    ResumeAll()
EndFunction


Function PickSlaveryDestination()

    Debug.TraceConditional("DF - PickSlaveryDestination - start", True)

    Int ssWeight = _DFlowSimpleSlaveryOdds.GetValue() As Int ; Alas spelling...
    Int loWeight = _DFLolaEnslaveWeight.GetValue() As Int
    Int dfWeight = _DFInternalEnslaveWeight.GetValue() As Int
    
    Debug.TraceConditional("DF - PickSlaveryDestination - weights - ss " + ssWeight + ", lola " + loWeight + ", df " + dfWeight, True)
    
    If !HaveSimpleSlavery()
        ssWeight = 0
    EndIf
    If !HaveLola()
        loWeight = 0
    EndIf
    
    Int totalWeight = ssWeight + loWeight + dfWeight
    Int roll = Utility.RandomInt(0, totalWeight - 1)
    
    Int slaveryTarget = 0 ; internal - also default
    If roll < ssWeight
        slaveryTarget = 1 ; Simple Slavery
    ElseIf roll < ssWeight + loWeight
        slaveryTarget = 2
    EndIf
    
    _DFSlaveryTarget.SetValue(slaveryTarget As Float)

    Debug.TraceConditional("DF - PickSlaveryDestination is " + slaveryTarget + " - end", True)

EndFunction
