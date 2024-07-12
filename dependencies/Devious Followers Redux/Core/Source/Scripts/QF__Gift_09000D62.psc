;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 44
Scriptname QF__Gift_09000D62 Extends Quest Hidden

;BEGIN ALIAS PROPERTY _DMaster
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias__DMaster Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_34
Function Fragment_34()
;BEGIN CODE
StartNewAgreement(None, 10)
SetDebt(0)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_42
Function Fragment_42()
;BEGIN CODE
ResetPunishmentTracking(Alias__DMaster.GetActorRef())
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_32
Function Fragment_32()
;BEGIN CODE
; Enslavement with pre-existing debt
;
DTimerReset()
FitSlaveKit()
int tG = PlayerRef.GetItemCount(Gold001)
PlayerRef.RemoveItem(Gold001, tG)
Enslavemsg1.show()
SetStage(100)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_28
Function Fragment_28()
;BEGIN CODE
;WARNING: Unable to load fragment source from function Fragment_28 in script QF__Gift_09000D62
;Source NOT loaded
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_22
Function Fragment_22()
;BEGIN CODE
Playerref.SendModEvent("DFEnslave")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_11
Function Fragment_11()
;BEGIN CODE
DTimerReset()
ResetPunishmentTracking(Alias__DMaster.GetActorRef())
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_6
Function Fragment_6()
;BEGIN CODE
ResetDflowMain()
StorageUtil.UnsetFormValue(PlayerRef, "_DFLow_Follower")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_14
Function Fragment_14()
;BEGIN CODE
; Enslavement with defined freedom cost
;
SetDebt(FreedomCost.GetValue())
DTimerReset()
FitSlaveKit()
int tG = PlayerRef.GetItemCount(Gold001)
PlayerRef.RemoveItem(Gold001, tG)
Enslavemsg1.show()
SetStage(100)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_10
Function Fragment_10()
;BEGIN CODE
; Nothing to see here...
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_8
Function Fragment_8()
;BEGIN CODE
; nothing (enslavement)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_13
Function Fragment_13()
;BEGIN CODE
StartNewAgreement(None, 10)
SetDebt(500)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_12
Function Fragment_12()
;BEGIN CODE
DTimerReset()
SetDebt(0)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_41
Function Fragment_41()
;BEGIN CODE
DDelay()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Function UpdateVersion()
    String modName = "DeviousFollowers.esp"
    Int index = Game.GetModByName(modName)
    If 255 != index 
        Collar = Game.GetFormFromFile(0x00213D43, modName) As Armor
        Mitts = Game.GetFormFromFile(0x00032C61, modName) As Armor
        Boots = Game.GetFormFromFile(0x00213D44, modName) As Armor
        
        If GetStage() >= 10 && !BoredomQuest.IsRunning()
            BoredomQuest.Start()
        EndIf
    EndIf

EndFunction


; Adds every single deal in one go on enslavement
Function SetDeals()

    int NumDeals = 0 
    int MaxedDeals = 0
    Int Dstage = 0

    string[] rules = DealManager.GetEnslavementRules()
    int i = 0

    while i < rules.length
        int stage = DealManager.ActivateRule(rules[i])
        if stage == 1
            NumDeals += 1
        elseif stage == 3
            MaxedDeals += 1
        endIf
        i += 1
    endWhile

    Tool.MCM.DC.DealsMax = MaxedDeals
    Tool.MCM.DC.Deals = NumDeals
EndFunction

Function ResetDflowMain()

    Actor who = Alias__DMaster.GetActorRef()
    If who
        ResetPunishmentTracking(who)
    EndIf
    DTimerReset()
    BTimerReset()
    ETimerReset()
    BoredomQuest.Reset()
    BoredomQuest.Start()
    _DFDailyDebtAdjust.SetValue(0.0)
    ;_DFBoredom.SetValue(0.0)
    ;_DFExpectedDealCount.SetValue(0)
    PriceReset() ; Reset device removal cost
    
    DealController.PickRandomDeal()
    
EndFunction


; Enslavement from Simple Slavery or other event.
; Gets rid of existing follower
; Picks a slaver to be the new DF, or tries to at least.
; May even raise the slaver from the dead! (This seems a terrible idea, but it probably never happens).
Function Enslave()

    Actor slaver = ScanActor

    ExternalRemoveFollower() ; Resets to stage 0, then resets everything.

    If !slaver || slaver == Game.GetPlayer()
        slaver = Tool.FindNewFollower()
    EndIf
    
    If !slaver
        ; Pick a vanilla mercenary anyway
        Actor[] mercs = New Actor[5]
        mercs[0] = Actor1
        mercs[1] = Actor2
        mercs[2] = Actor3
        mercs[3] = Actor4
        mercs[4] = Actor5
        Int pick = Utility.RandomInt(0, 4)
        slaver = mercs[pick]
        
        ; We have no choice but to enable SOMEBODY
        ForceEnableDevious(slaver)
    EndIf
    
    If slaver.IsDead()
        slaver.Resurrect()
    EndIf
    
    ObjectReference portDestination = slaver
    PlayerRef.moveTo(portDestination)
        
    Int choice = SSMessage.Show()
    
    If 0 != choice
        ; Player refuses the "deal"
        ; Player gets an instant +200 slavery punishment for refusing to be an obedient slave.
        StorageUtil.AdjustIntValue(PlayerRef, "DF_Enslaved_TotalPunishCount_AllFollowers", 200)

        StealAllItems()
        Tool.AddAllHoldBounties(True)
        libs.ForceEquipDevice(libs.PlayerRef, Item , Rend, libs.zad_DeviousCollar)
        
        Reset()
        SetStage(0)
        Start()
        Utility.wait(5.0)
        libs.PlayerRef.MoveTo(Pit)
        Tool.FitBeltAndPlugs()
        
    Else
        ; Player accepted the devious bargain...
        AddFollower(slaver)
        Alias__DMaster.ForceRefTo(slaver)
        
        ; Deals, Enslaved, Enslaved and Deals
        Float weight = 	Tool.MCM._DFSWeightD + Tool.MCM._DFSWeightE + Tool.MCM._DFSWeightED
        Float randomF  = Utility.RandomFloat(0, weight)
        
        If randomF <= Tool.MCM._DFSWeightED
        
            SetDeals()
            SetupDFSlavery(slaver)
            Return ; don't choose more outcomes
            
        EndIf

        randomF -= Tool.MCM._DFSWeightED
        
        If randomF <= Tool.MCM._DFSWeightE
        
            SetupDFSlavery(slaver)
            Return ; don't choose more outcomes

        EndIf
        
        ; No enslavement, just deals...
        SetStage(10)
        SetDeals()
        Tool.DealMessages()	
        
    EndIf
    
EndFunction

Function SetupDFSlavery(Actor whoMaster)

    ResetPunishmentTracking(whoMaster)

    PriceReset() ; Reset device removal cost
    SetStage(98)
    SetDebt(FreedomCost.GetValue())
    Game.GetPlayer().SendModEvent("PlayerRefEnslaved")
EndFunction

; This is used when player is enslaved without a follower swap due to debt excess.
Function EnslaveDirect()
    Tool.UnequipGear()
    Actor whoMaster = Alias__DMaster.GetActorRef()
    If whoMaster
        ResetPunishmentTracking(whoMaster)
    EndIf
    _DFBoredom.SetValue(0.0)
    _DFDailyDebtAdjust.SetValue(0.0)
    _DFExpectedDealCount.SetValue(0)
    PriceReset() ; Reset device removal cost
    
    SetStage(99)
EndFunction

; Fit all missing slave items
Function FitSlaveKit()

    ; Fit the items directly if possible. If quest items in the way, add to inventory instead.
    Bool fitCollar = True
    Bool fitMitts = True
    Bool fitBoots = True
    
    Keyword questItem = libs.zad_QuestItem
    If PlayerRef.WornHasKeyword(questItem)
    
        Armor collarSlot = PlayerRef.GetWornForm(0x00000020) as Armor
        If collarSlot && collarSlot.HasKeyword(questItem)
            fitCollar = False
        EndIf
        Armor mittSlot = PlayerRef.GetWornForm(0x00000008) as Armor
        If mittSlot && mittSlot.HasKeyword(questItem)
            fitMitts = False
        EndIf
        Armor bootSlot = PlayerRef.GetWornForm(0x00000080) as Armor
        If bootSlot && bootSlot.HasKeyword(questItem)
            fitBoots= False
        EndIf
        
    EndIf
    
    ; Don't refit items that are already correct!
    ; Remove existing items so we can re-fit - this refits our own items when it shouldn't
    Bool removed = False
    If fitCollar && PlayerRef.WornHasKeyword(libs.zad_DeviousCollar)
        libs.ManipulateGenericDeviceByKeyword(PlayerRef, libs.zad_DeviousCollar, False)
        removed = True
    EndIf

    If fitCollar && PlayerRef.WornHasKeyword(libs.zad_DeviousBondageMittens)
        libs.ManipulateGenericDeviceByKeyword(PlayerRef, libs.zad_DeviousBondageMittens, False)
        removed = True
    EndIf

    If fitCollar && PlayerRef.WornHasKeyword(libs.zad_DeviousBoots)
        libs.ManipulateGenericDeviceByKeyword(PlayerRef, libs.zad_DeviousBoots, False)
        removed = True
    EndIf
    
    If removed
        Utility.Wait(4.0)
    EndIf
    
    Bool fitted = False
    If fitCollar
        Libs.EquipDevice(PlayerRef, Collar, CollarR, libs.zad_DeviousCollar)
        fitted = True
    Else
        PlayerRef.AddItem(Collar)
    EndIf
    
    If fitMitts
        Libs.EquipDevice(PlayerRef, Mitts, MittsR, libs.zad_DeviousBondageMittens)
        fitted = True
    Else
        PlayerRef.AddItem(Mitts)
    EndIf
    
    If fitBoots
        Libs.EquipDevice(PlayerRef, Boots, BootsR, libs.zad_DeviousBoots)
        fitted = True
    Else
        PlayerRef.AddItem(Boots)
    EndIf
    
    If fitted
        Utility.Wait(2.0)
    EndIf

EndFunction


Function AdjustPostSlaveryDebt()

    ; Uses PunishmentDebtReduction, which is a percentage.
    ; Reduce debt by this much.
    ; If that's still more then EnslavementDebt, then reduce further.
    Debug.TraceConditional("DF - AdjustPostSlaveryDebt - start", True)
    Float debtGold = Debt.GetValue()
    Float reduction = debtGold * PunishmentDebtReduction * 0.01
    Float reduced = debtGold - reduction
    
    Float enslavementDebtGold = EnslavementDebt.GetValue()
    Float minimal = enslavementDebtGold - 100.0
    If minimal < 10.0
        minimal = 10.0
    EndIf
    If reduced > minimal
        reduced = minimal
    EndIf
    Debug.TraceConditional("DF - AdjustPostSlaveryDebt - debtGold" + debtGold + ", reduction " + reduction + ", enslave at " + enslavementDebtGold + ", minimal " + minimal + ", reduced " + reduced, True)
    
    SetDebt(reduced)
    Debug.TraceConditional("DF - AdjustPostSlaveryDebt - end", True)
    
EndFunction


Function SetPostSlaveryDebt()

    Debug.TraceConditional("DF - SetPostSlaveryDebt", True)
    ; If the PC is buying out of debt, they are obligated to pay off all their own debt.
    Int debtGold = Debt.GetValue() as Int
    
    If debtGold > 10
        debtGold -= 10
        PlayerRef.RemoveItem(Gold001, debtGold)
        DebtPay(debtGold)
    Else
        SetDebt(10)
    EndIf
EndFunction


Function ReduceExpectedDeals(Float reduceBy)

    Debug.TraceConditional("DF - ReduceExpectedDeals by " + reduceBy, True)
    Float expectedDeals = _DFExpectedDealCount.GetValue()
    expectedDeals -= reduceBy
    If expectedDeals < 0.0
        expectedDeals = 0.0
    EndIf
    _DFExpectedDealCount.SetValue(expectedDeals)
    
EndFunction

Function SetPostSlaveryDeals()

    Debug.TraceConditional("DF - SetPostSlaveryDeals - start", True)
    Int dealsToRemove = PunishmentDealReduction As Int
    Debug.TraceConditional("DF - SetPostSlaveryDeals - got " + dealsToRemove + " deals", True)
    
    While dealsToRemove > 0
        dealsToRemove -= 1
        Bool removed = ((DealController As Quest) As _DFDealUberController).RemoveRandomDeal()
        If removed
            Debug.TraceConditional("DF - SetPostSlaveryDeals - remove ok, " + dealsToRemove + " remaining", True)
        Else
            Debug.TraceConditional("DF - SetPostSlaveryDeals - remove failed", True)
            dealsToRemove = 0
        EndIf
    EndWhile
    Debug.TraceConditional("DF - SetPostSlaveryDeals - emd", True)
    
EndFunction


Function AddDealItem(String itemName)
    If "ring" == itemName
        PlayerRef.AddItem(DealRing, 1)
    ElseIf "amulet" == itemName
        PlayerRef.AddItem(DealAmulet, 1)
    ElseIf "circlet" == itemName
        PlayerRef.AddItem(DealCirclet, 1)
    EndIf
EndFunction

; Set tracking to zero, also called on dismissal
Function ResetPunishmentTracking(Actor whoMaster)

    StorageUtil.SetIntValue(PlayerRef, Tool.TagEnslavedPunishCount, 0)
    
    If whoMaster
        StorageUtil.SetIntValue(whoMaster, Tool.TagEnslavedPunishCount, 0)
        Int previousTotal = StorageUtil.GetIntValue(whoMaster, Tool.TagEnslavedTotalPunishCount, 0)
        StorageUtil.SetIntValue(PlayerRef, Tool.TagEnslavedTotalPunishCount, previousTotal)
    Else
        StorageUtil.SetIntValue(PlayerRef, Tool.TagEnslavedTotalPunishCount, 0)
    EndIf
    
EndFunction


; Called by _DFlowFollowerController
Function UpdateFollowerDismissalTags(Actor whoMaster)

    If whoMaster
        Debug.TraceConditional("DF - UpdateFollowerDismissalTags for " + whoMaster.GetActorBase().GetName(), True)
        
        SetPersonality(whoMaster) ; So if we have personality-based dismissal results, there will definitely be one to refer to.
        
        StorageUtil.UnsetIntValue(whoMaster, Tool.TagMaster)
        
        ; Persist the follower's boredom.
        Float boredom = _DFBoredom.GetValue()
        StorageUtil.SetFloatValue(whoMaster, Tool.TagBoredom, boredom)
        
        Float timeHired = StorageUtil.GetFloatValue(whoMaster, Tool.TagMasterDays, 0.0)
        If timeHired < 0.0
            timeHired = 0.0
        EndIf
        
        Float lastHired = StorageUtil.GetFloatValue(whoMaster, Tool.TagLastHireTime, 0.0)
        If lastHired >= 0.0
            Float extraHired = Utility.GetCurrentGameTime() - lastHired
            If extraHired > 0.0
                timeHired += extraHired
            EndIf
        EndIf
        
        StorageUtil.SetFloatValue(whoMaster, Tool.TagMasterDays, timeHired)
        
        ; Dismiss a follower, and you increase expected deals... though they are not a property of the follower ... more like persistent reputation.
        Float expectedDeals = _DFExpectedDealCount.GetValue()
        expectedDeals += 1.0
        _DFExpectedDealCount.SetValue(expectedDeals)
    Else
        Debug.TraceConditional("DF - UpdateFollowerDismissalTags for nobody", True)
    EndIf
    
EndFunction


Function UpdateFollowerHireTags(Actor whoMaster)

    If whoMaster
        Debug.TraceConditional("DF - UpdateFollowerHireTags for " + whoMaster.GetActorBase().GetName(), True)
        
        StorageUtil.SetIntValue(whoMaster, Tool.TagMaster, 1)

        Float now = Utility.GetCurrentGameTime()
        StorageUtil.SetFloatValue(whoMaster, Tool.TagLastHireTime, now)

        Float storedBoredom = StorageUtil.GetFloatValue(whoMaster, Tool.TagBoredom, -1.0)
        If storedBoredom >= 0.0
            _DFBoredom.SetValue(storedBoredom)
        Else
            StorageUtil.SetFloatValue(whoMaster, Tool.TagBoredom, 0.0)
            _DFBoredom.SetValue(0.0)
        EndIf
        
        SetPersonality(whoMaster)

    Else
        Debug.TraceConditional("DF - UpdateFollowerHireTags for nobody", True)
    EndIf

EndFunction


Int Function GetPersonality(Actor who)
    Int v = StorageUtil.GetIntValue(who, Tool.TagPersonality, -1)
    If v < 0
        SetPersonality(who)
        v = StorageUtil.GetIntValue(who, Tool.TagPersonality, -1)
    EndIf
    Return v
EndFunction

Int Function GetAggression(Actor who)
    Int v = StorageUtil.GetIntValue(who, Tool.TagAggression, -1)
    If v < 0
        SetPersonality(who)
        v = StorageUtil.GetIntValue(who, Tool.TagAggression, -1)
    EndIf
    Return v
EndFunction

Int Function GetGreed(Actor who)
    Int v = StorageUtil.GetIntValue(who, Tool.TagGreed, -1)
    If v < 0
        SetPersonality(who)
        v = StorageUtil.GetIntValue(who, Tool.TagGreed, -1)
    EndIf
    Return v
EndFunction

Int Function GetHonor(Actor who)
    Int v = StorageUtil.GetIntValue(who, Tool.TagHonor, -1)
    If v < 0
        SetPersonality(who)
        v = StorageUtil.GetIntValue(who, Tool.TagHonor, -1)
    EndIf
    Return v
EndFunction

Int Function GetLust(Actor who)
    Int v = StorageUtil.GetIntValue(who, Tool.TagLust, -1)
    If v < 0
        SetPersonality(who)
        v = StorageUtil.GetIntValue(who, Tool.TagLust, -1)
    EndIf
    Return v
EndFunction

Int Function GetControl(Actor who)
    Int v = StorageUtil.GetIntValue(who, Tool.TagControl, -1)
    If v < 0
        SetPersonality(who)
        v = StorageUtil.GetIntValue(who, Tool.TagControl, -1)
    EndIf
    Return v
EndFunction

Int Function GetPlayful(Actor who)
    Int v = StorageUtil.GetIntValue(who, Tool.TagPlayful, -1)
    If v < 0
        SetPersonality(who)
        v = StorageUtil.GetIntValue(who, Tool.TagPlayful, -1)
    EndIf
    Return v
EndFunction


Function SetPersonality(Actor who)

    Debug.TraceConditional("DF - SetPersonality for " + who.GetActorBase().GetName(), True)
    
    Int personality = StorageUtil.GetIntValue(who, Tool.TagPersonality, -1)
    If personality < 0
        If 1 == Utility.RandomInt(1, 20)
            ; Only 1 in 20 (5%) chance of nightmare ... rather than 1 in 6
            ; Maybe it should just be even though?
            personality = Tool.PersonalityNightmare ; 6
        Else
            personality = Utility.RandomInt(0, 5) ; just evenly distributed
        EndIf
        StorageUtil.SetIntValue(who, Tool.TagPersonality, personality)
        Debug.TraceConditional("DF - Personality set to " + personality, True)
    EndIf
    
    Int aggression = StorageUtil.GetIntValue(who, Tool.TagAggression, -1)
    If aggression < 0
        aggression = RollStat(aggressionRange[personality])
        Debug.TraceConditional("DF - Aggression set to " + aggression, True)
        StorageUtil.SetIntValue(who, Tool.TagAggression, aggression)
    EndIf

    Int greed = StorageUtil.GetIntValue(who, Tool.TagGreed, -1)
    If greed < 0
        greed = RollStat(greedRange[personality])
        Debug.TraceConditional("DF - Greed set to " + greed, True)
        StorageUtil.SetIntValue(who, Tool.TagGreed, greed)
    EndIf

    Int honor = StorageUtil.GetIntValue(who, Tool.TagHonor, -1)
    If honor < 0
        honor = RollStat(honorRange[personality])
        Debug.TraceConditional("DF - Honor set to " + honor, True)
        StorageUtil.SetIntValue(who, Tool.TagHonor, honor)
    EndIf
    
    Int lust = StorageUtil.GetIntValue(who, Tool.TagLust, -1)
    If lust < 0
        lust = RollStat(lustRange[personality])
        Debug.TraceConditional("DF - Lust set to " + lust, True)
        StorageUtil.SetIntValue(who, Tool.TagLust, lust)
    EndIf
    
    Int control = StorageUtil.GetIntValue(who, Tool.TagControl, -1)
    If control < 0
        control = RollStat(controlRange[personality])
        Debug.TraceConditional("DF - Control set to " + control, True)
        StorageUtil.SetIntValue(who, Tool.TagControl, control)
    EndIf
    
    Int playful = StorageUtil.GetIntValue(who, Tool.TagPlayful, -1)
    If playful < 0
        playful = RollStat(playfulRange[personality])
        Debug.TraceConditional("DF - Playful set to " + playful, True)
        StorageUtil.SetIntValue(who, Tool.TagPlayful, playful)
    EndIf
    
EndFunction

Function InitPersonalityValues()

    aggressionRange = New Int[7]
    greedRange = New Int[7]
    honorRange = New Int[7]
    lustRange = New Int[7]
    controlRange = New Int[7]
    playfulRange = New Int[7]

    ; Personalities
    ; 
    ; Aggression - used for follower vs willpower contests
    ; Greed - to choose between money and anything else
    ; Honor - to not lie, to not steal, to not make up new rules, but also holds the PC to high standards
    ; Lust - wants sex, wants the PC to want sex, wants the PC to open their mind to sheer debauchery
    ; Controlling - wants to increase PC helplessness whenever possible, and control any aspect that they can
    ; Playful - likes randomness, will pick sex, or games, or making the player "enjoy" things above other goals like money, truth, or control.
    ; All relative, even a Lust 1 DF still likes sex, just may not prioritize it.
    ;                                                Aggression     Greed     Honor      Lust     Control     Playful
    ; 0 Default - does random stuff                      Any         High      Any        Any        Any        Any
    ; 1 Slaver - determined to enslave you              High         Mid       Low        Any       High        Mid
    ;
    ; 2 Profiteer - wants you to earn and pay            Low         High      Mid        Mid        Low        Low
    ; 3 Sexy - wants to possess you for sex              Mid         Low       Mid       High        Mid       High
    ;
    ; 4 Sadist - wants to break your spirit             High         Low       Low        Mid       High        Low
    ; 5 Moral - wants to enforce your morality           Low         Mid      High        Low        Mid        Low
    ; 6 Nightmare - simply hard mode                    High        High       Low       High       High        Low
    ; 0 Any: 1-100,   1 Low: 1-50,   2 Mid: 26-75,   3 High: 51-100
    ; A given follower might not quite fit their "stereotype" in terms of stat rolls.
    ; The stereotype will drive their deal ordering though.
    
    ; Default
    aggressionRange[0] =  StatRangeAny
    greedRange[0] = StatRangeHi
    honorRange[0] = StatRangeAny
    lustRange[0] = StatRangeAny
    controlRange[0] = StatRangeAny
    playfulRange[0] = StatRangeAny

    ; Slaver
    aggressionRange[1] =  StatRangeHi
    greedRange[1] = StatRangeMid
    honorRange[1] = StatRangeLo
    lustRange[1] = StatRangeAny
    controlRange[1] = StatRangeHi
    playfulRange[1] = StatRangeMid
    
    ; Profiteer
    aggressionRange[2] =  StatRangeLo
    greedRange[2] = StatRangeHi
    honorRange[2] = StatRangeMid
    lustRange[2] = StatRangeMid
    controlRange[2] = StatRangeLo
    playfulRange[2] = StatRangeLo
    
    ; Sexy
    aggressionRange[3] =  StatRangeMid
    greedRange[3] = StatRangeLo
    honorRange[3] = StatRangeMid
    lustRange[3] = StatRangeHi
    controlRange[3] = StatRangeMid
    playfulRange[3] = StatRangeHi

    ; Sadist
    aggressionRange[4] =  StatRangeHi
    greedRange[4] = StatRangeLo
    honorRange[4] = StatRangeLo
    lustRange[4] = StatRangeMid
    controlRange[4] = StatRangeHi
    playfulRange[4] = StatRangeLo
    
    ; Moral
    aggressionRange[5] =  StatRangeLo
    greedRange[5] = StatRangeMid
    honorRange[5] = StatRangeHi
    lustRange[5] = StatRangeLo
    controlRange[5] = StatRangeMid
    playfulRange[5] = StatRangeLo
    
    ; Nightmare
    aggressionRange[6] = StatRangeHi
    greedRange[6] = StatRangeHi
    honorRange[6] = StatRangeLo
    lustRange[6] = StatRangeHi
    controlRange[6] = StatRangeHi
    playfulRange[6] = StatRangeLo
    
EndFunction


Int Function RollStat(Int bias)
    If 1 == bias
        Return BiasedInt(1, 50)
    ElseIf 2 == bias
        Return BiasedInt(26, 75)
    ElseIf 3 == bias
        Return BiasedInt(51, 100)
    Else
        ; 0 etc
        Return BiasedInt(1, 100)
    EndIf
EndFunction


Int Function BiasedInt(Int lo, Int hi)
    Int r1 = Utility.RandomInt(lo, hi)
    Int r2 = Utility.RandomInt(lo, hi)
    Return (r1 + r2) / 2
EndFunction


Function ChargeForSLSLicense(Float basePrice, Float markup)
    
    Float markupF = DebtPerDay.GetValue()
    markupF *= markup
    markupF /= 100.0 ; markup is a percentage
    
    Float price = basePrice + markupF
    
    If GetStage() >= 98
        ; Half-price licenses for poor slaves.
        price *= 0.5
    EndIf
    
    AdjustDebt(price)
    
EndFunction

; This is now the preferred way to interact with debt internally, as it handles gold control properly - but not discounts and penalty rates.
 ; debtDelta amount is added to debt, positive values increase debt.
Function AdjustDebt(Float debtDelta)

    Int surplus = 0
    Debug.Trace("DF - AdjustDebt - " + debtDelta)
    
    If debtDelta >= 0.0
        AddDebt(debtDelta)
    Else
        ; Reduce debt
        surplus = DebtPayGoldQ(-debtDelta)
    EndIf
    
    (_GoldControl As _DFGoldConQScript).AddCredit(surplus)

EndFunction


 ; Simplistic add debt utility - no gold control support; negative values force SET not adjust.
Int Function AddDebt(Float amount)

    Float debtF = Debt.GetValue()
    If debtF >= 0.0
        ; Add on the +ve debt amount
        debtF += amount
    Else
        ; Set, don't adjust if debt currently has a -ve value (-ve debt implies credit, but we don't track credit like that).
        debtF = amount
    EndIf

    Debug.Trace("DF - AddDebt - " + debtF)
    Debt.SetValue(debtF)
    
    Return debtF As Int
    
EndFunction


 ; Returns any credit the player has as negative debt and resets debt to zero.
Int Function NormalizeDebt()

    Float debtF = Debt.GetValue()
    Int credit = 0
    If debtF < 0.0
        Debt.SetValue(0.0)
        credit = (-debtF) As Int
    EndIf
    
    Return credit
 
 EndFunction

; Now an adjustDebt synonym, was an AddDebt synonmym
Function Debt(Float addDebtAmount)

    AdjustDebt(addDebtAmount)
    
EndFunction

Function ApplyPunishmentDebt()

    Tool.MCM.CalculateScaledDebts()

    Float punishmentDebt = _DFPunDebt.GetValue()
    ; Deliberately allow game to trigger this reduction too...
    If GetStage() >= 98
        ; Half punishments for poor slaves.
        punishmentDebt *= 0.5
    EndIf
    
    ; Always make sure there's some punishment debt, regardless of how _DFPunDebt was calculated.
    If punishmentDebt < 10.0
        punishmentDebt = 10.0
    EndIf

    Debug.Trace("DF - ApplyPunishmentDebt - " + punishmentDebt)
    
    AdjustDebt(punishmentDebt)

EndFunction

 ; Add punishment debt
Function PunDebt()
    Tool.PunDebt()
EndFunction


Function PunCrawl()
    _DFStanding.SetValue(0.0)
    StorageUtil.SetStringValue(PlayerRef, "_SD_sDefaultStance", "Crawling")
    PunDebt()
EndFunction

Function BuyDebt()
    Float buyDebt = _DFPunDebt.GetValue() * 0.5
    AdjustDebt(buyDebt)
EndFunction


Function BuyoutOfSlavery()

    SetPostSlaveryDebt()
    SetPostSlaveryDeals()
    ReduceExpectedDeals(10.0)
    
    Actor who = Alias__DMaster.GetActorRef()
    Reset()
    Alias__DMaster.ForceRefto(who)
    
    SetStage(10)
    
    SendModEvent("PlayerRefFreed")

EndFunction


; Scale current outstanding debt by defined fraction (usually > 1.0)
Function DebtPercent(Float scaleDebt)
    ; e.g. 0.5 = half debt, 2.0 = double debt

    Float debtF = Debt.GetValue()
    Float debtAdjust = debtF * scaleDebt - debtF
    AdjustDebt(debtAdjust)

EndFunction

; Reduce debt by deal debt-relief amount
Function DealDebt()

    Tool.MCM.CalculateScaledDebts()
    Float debtRelief = _DflowDealBaseDebt.GetValue() ;
    AdjustDebt(-debtRelief)

EndFunction

; Increase debt by half debt-relief amount
Function DealRejectDebt()

    Tool.MCM.CalculateScaledDebts()
    Float debtRelief = _DflowDealBaseDebt.GetValue()
    AdjustDebt(0.5 * debtRelief)

EndFunction

; Reset the device removal cost to base (called from _DflowSleepQuestScript)
Function PriceReset()

    RemovedDevicesCount = 0
    PriceUpdate()
    
EndFunction

; Called by the removal quest dialog to get the correct price value.
Function PriceUpdate()

    Tool.MCM.CalculateScaledDebts()

    Float removalBase = CalculateDeviceRemovalCost()
    _DFlowRemovalP.SetValue(removalBase)
    UpdateCurrentInstanceGlobal(_DFlowRemovalP)
    
EndFunction

; Charge the player for removing a device.
Function DeviceRemovalGold()

    Tool.MCM.CalculateScaledDebts()

    Float currentPrice = CalculateDeviceRemovalCost()
    Int removalGold = currentPrice As Int
    Int playerGold = PlayerRef.GetGoldAmount()
    If playerGold < removalGold || (_GoldControl As _DFGoldConQScript).Enabled
        ; Add debt instead - scale by debt percentage adjustment
        Float debtScale = _DFlowRemovalDebtTimes.GetValue() * 0.01
        removalGold = (currentPrice * debtScale) As Int
        AdjustDebt(removalGold)
        Tool.ReduceResistFloat(1.0) ; Reduce resist due to leeching off follower.
    Else
        PlayerRef.RemoveItem(Gold001, removalGold)
    EndIf
    
    RemovedDevicesCount += 1
    PriceUpdate()
    LoseDeviceRemovalLives()

EndFunction

Float Function CalculateDeviceRemovalCost()
    
    Float baseRemovalPrice = _DflowRemovalBasePrice.GetValue()
    Float increasePrice = _DFlowRemovalInc.GetValue()
    
    Float currentPrice = baseRemovalPrice + (RemovedDevicesCount As Float) * increasePrice
    
    Return currentPrice
    
EndFunction

; Apply device removal cost and increment price
Function DeviceRemovalDebt()

    ; There's really just one function for this now, which handles the not-enough-gold case.
    DeviceRemovalGold()
    
EndFunction

Function LoseDeviceRemovalLives()
    ; Will of 4 or less, uses follower lives to remove devices.
    Int willpower = Will.GetValue() As Int
    If willpower <= 4
        Int Lost = 5 - willpower
        Utility.RandomInt(0, Lost)
        Lives.SetValue((Lives.GetValueInt() - Utility.RandomInt(0, 2)))
    EndIf
EndFunction

Function SetZeroLives()
    Float current = Lives.GetValue()
    If current >= 1.0
        Lives.SetValue(0.0)
        Debug.Notification("$DF_ZERO_LIVES")
    EndIf
EndFunction

; Quietly reduce debt by amount
Function Debtm(Float amount)
    AdjustDebt(-amount)
EndFunction

; Paying off debt via the weird potion
Function PotionPayDebt()
    Float currentDebt = Debt.GetValue()
    Float payOff = currentDebt - 1.0
    If payOff < 1.0
        Return
    EndIf
    
    DebtPay(payOff)
EndFunction    

; Noisily pay debt
Function DebtPay(Float amount)

	Float currentDebt = Debt.GetValue()
	Int mainStage = GetStage()
    
    If mainStage == 150 ; owned with devices
        amount /= 2.0
    EndIf
    
	Float livesFraction = Lives.GetValue() / LivesM.GetValue()
    
    ; Tired followers add extra debt
	If mainStage < 98 && livesFraction <= 0.3
    
        Float rnd = Utility.RandomInt(5, 9) As Float
        rnd /= 10.0 ; between 50 and 90%
        amount *= rnd
        Tool.MCM.Noti("TiredAdded", amount As int)
        
	EndIf

    Float debtGold = currentDebt - amount
    
    If debtGold < -200.0
        debtGold = -200.0
    EndIf
    
    If debtGold > 0.0
        Tool.AddFatigue()
    EndIf
    
    Debt.SetValue(debtGold)
    
EndFunction

; Pay off debt with amount, and return any cash left over.
Int Function DebtPayGoldQ(Float amount)
    
    ; This had a bug that was eating credit values set into debt as negative numbers.
    
	Int mainStage = GetStage()
    If mainStage == 150 ; owned with devices
        amount *= 0.5
    EndIf

	Float currentDebt = Debt.GetValue()
   	Float surplus = 0.0
    
    If currentDebt > 0.0
        If amount > currentDebt
            surplus = amount - currentDebt
            currentDebt = 0.0
        Else
            currentDebt -= amount
        EndIf

        Debt.SetValue(currentDebt)
    Else
        ; If player has zero or negative debt, then don't adjust it, return everything as credit.
        surplus = amount
    EndIf
    
    Return surplus As Int
        
EndFunction

; Simply set the debt value
Function SetDebt(Float value)

    Debt.SetValue(value)

EndFunction

; Set Delay to 'now' plus a game hour.
Function DDelay()
    ; 0.04 is slightly less than a game hour; 0.0416 recurring would be an exact hour
    Delay = Utility.GetCurrentGameTime() + 0.04
EndFunction

; Reset the debt timer to the next interval
Function DTimerReset()
    Float t = GameDaysPassed.GetValue() + DebtPollhrs.GetValue()
    Timer.SetValue(t)
EndFunction

; The debt punishment timer is in _DFlowConditionals

; Reset the event timer to the next interval
Function ETimerReset()
    Float t = GameDaysPassed.GetValue() + ETimerP.GetValue()
    ETimer.SetValue(t)
EndFunction

; Reset the boredom timer
Function BTimerReset()
    Tool.BTimerReset()
EndFunction

Function ReduceBoredom(Int dealReduce = 1)
    Tool.ReduceBoredom(dealReduce)
EndFunction


; Main debt calculation - triggered from a misc dialog on _DFlow (Remember, I need my fair share too?)
; If you don't trigger this, debt doesn't go up, but contract time doesn't go down either.
; Now resets the debt timer.
Function DebtInc()

    Tool.UpdateChaos()
    Tool.MCM.CalculateScaledDebts()

    Int demp = Lives.GetValue() As Int
    demp -= 1
    Tool.MCM.GoldCont.LivesLost()
    Lives.SetValue(demp)
    
    Float gameDaysNow = GameDaysPassed.GetValue()
    
    ; Timer gets set to Now + DebtPollHrs on reset, so this calculates time since timer set.
    Float daysElapsed = gameDaysNow - Timer.GetValue() + DebtPollhrs.GetValue() ;Works out how much time has passed

    If daysElapsed > 1.0 ; if more than 1 day has elapsed, cap at 1 in case follower had been dismissed by other means
        daysElapsed = 1.0
    EndIf
    
    ; Determines if the PC has defaulted on their deals, but doesn't punish them; that's handled individually for each deal.
    Tool.MCM.MDC.CheckAndClearDealRequests()
    
    ; Reduce minimum contract remaining
    Float contractRemaining = _DFMinimumContractRemaining.GetValue()
    contractRemaining -= daysElapsed
    If contractRemaining < 0.0
        contractRemaining = 0.0
    EndIf
    _DFMinimumContractRemaining.SetValue(contractRemaining)
    
    Float debtAdjust = _DFDailyDebtAdjust.GetValue()
    Float boredom = _DFBoredom.GetValue()

    If gameDaysNow > _DFBoredomTimer.GetValue()
    
        BTimerReset()
        
        ; This begins at zero. It's reset to zero on a new agreement, and on enslavement.
        Int expectedDeals = (_DFExpectedDealCount.GetValue() + 0.5) As Int
        Int deals = DealController.Deals
            
        ; Don't increase boredom for very low willpower PC
        If Will.GetValue() >= 2.0
        
            If deals >= expectedDeals && boredom > 0.0
                ; Reset boredom, increase expected deals
                boredom = 0.0
                _DFBoredom.SetValue(boredom)
                debtAdjust = 0.0
                Float excessDeals = (deals - expectedDeals) As Float
                _DFBoredomTimer.SetValue(_DFBoredomTimer.GetValue() + excessDeals * _DFBoredomIntervalDays.GetValue()) ; extend timer due to excess deals
                
                expectedDeals += 1
                Int limit = _DFExpectedDealLimit.GetValue() As Int
                If expectedDeals > limit
                    expectedDeals = limit
                EndIf
                _DFExpectedDealCount.SetValue(expectedDeals As Float)
                Debug.Notification("$DF_CONFIDENT_FOLLOWER")
            Else
                Debug.Notification("$DF_BORED_FOLLOWER")
                Float boreDelta = 1.0 + ((expectedDeals - deals) As Float) / 10.0
                boredom += boreDelta
                Tool.AdjustBoredom(boreDelta)
            EndIf
        
        Else
            If deals < expectedDeals
                Debug.Notification("$DF_BORED_FOLLOWER")
                Float boreDelta = 1.2 + ((expectedDeals - deals) As Float) / 10.0
                boredom += boreDelta
                Tool.AdjustBoredom(boreDelta)
            EndIf
        EndIf
        
    EndIf
    

    ; If follower is "bored", then add debt rate increment.
    If boredom > 0.0
        ; Increase debt adjust by increment (adjust is a percentage)
        debtAdjust += _DFDailyDebtIncrement.GetValue() * daysElapsed
    EndIf
    
    ; _DFDailyDebtAdjust accumulates while bored
    ; It's reset (above) when boredom <= 0 AND deals >= expected AND willpower >= 2.0
    _DFDailyDebtAdjust.SetValue(debtAdjust)
    
    Float deals = DealController.Deals As Float
    Float discount = deals * 10.0
    
    Float dealScale = (100.0 + debtAdjust) - discount
    dealScale *= 0.01 ; Convert from percentage

    ; Make discountLimit negative to fix its sense (it's 0.0 to 1.0, not a percentage)
    Float discountLimit = 1.0 - _DFDiscountLimit.GetValue()
    If dealScale < discountLimit
        dealScale = discountLimit
    ElseIf dealScale > 2.0 ; Also impose a penalty limit
        dealScale = 2.0
    EndIf
    

    Float playerLevel = Game.GetPlayer().GetLevel() As Float
    Float debtPerDayGold = DebtPerDay.GetValue()
    Float D = debtPerDayGold
    
    Float followerCount = PlayerFollowerCount.GetValue()
    Float dfFollowerCount = _DFFollowerCount.GetValue()
    If dfFollowerCount > followerCount
        followerCount = dfFollowerCount
    EndIf
    
    Float perFollower = DebtPerFollower.GetValue() / 100.0 ; additional debt per follower is expressed As a percentage of the default debt
    
    ; Total cost is 1.0 + (followerCount - 1) * perFollower
    
    Float F = 1.0 + (followerCount - 1.0) * perFollower ; Working out additional follower multiplier

    If F < 1.0 ; Error catch.
        F = 1.0 
    EndIf
    
    ; D debtPerday, F followerScale, C = current debt
    Float M = daysElapsed * D * F
    Float oldDebt = Debt.GetValue()
    Float I = 0.0

    If Debt.GetValue() > 0.0 ; no interest on negative debt
        I = oldDebt * ( daysElapsed * (Intrest.GetValue()/100)) ; Interest to add to exsisting debt
    EndIf

    ; Existing debt + discounting(New Debt + Interest) + boredomAdjustment
    Float newDebt = oldDebt + dealScale * (M + I)
    Debt.SetValue(newDebt)
    
    Int PL = Game.GetPlayer().GetLevel(); Recalc Enslavement debt on level up

    If PL > CurrentLevel
        Float tq = EnslavePerLevel.GetValue() * (PL - CurrentLevel)
        Float tp = EnslavementDebt.GetValue() + tq
        EnslavementDebt.setvalue(tp)
        EnslavementHalfDebt.setvalue(tp/2)
        CurrentLevel = PL
    EndIf

    If (Lives.GetValue() As Int) > 0
        If (Debt.GetValue() < EnslavementDebt.GetValue())
             Tool.MCM.Noti("DebtAdd")
        Else
        Tool.MCM.Noti("DebtOver")
        EndIf
    Else
        Tool.MCM.Noti("DebtTired")
    EndIf
    
    DTimerReset()
    
EndFunction

; Add a hireling as a follower with a starting debt.
Function Lend (ObjectReference HirelingRef)

    Actor hirelingActor = HirelingRef As Actor	
    HasHirelingGV.Value = 1

    hirelingActor.AddToFaction(CurrentHireling)

    (pDialogueFollower As DialogueFollowerScript).SetFollower(HirelingActor)

EndFunction

; Add a regular follower.
Function AddFollower(ObjectReference newMaster)
    Actor followerActor = newMaster As Actor
    If followerActor
        AddFollowerActor(followerActor)
    EndIf
EndFunction

Function AddFollowerActor(Actor newMaster)
    Q2.AddFollower(newMaster)
    StartNewAgreement(newMaster, 10)
EndFunction
    


Function ExternalRemoveFollower()

    Actor who = Alias__DMaster.GetActorRef() As Actor
    Q2.DFlowRemoveFollower()
    Q2.InternalRemoveFollower(who) ; Resets and sets stage 0
    Tool.MCM.ResetQuests() ; Reset all the other quests too.

EndFunction

; Return missing slave items to inventory, did not fit them, and added 500 hardwired debt.
; Deprecated - replaced with FitSlaveKit
Function LostItems()
EndFunction


Function StealAllItems()
    ; But send them to a chest, so they aren't destroyed forever...
    Bool taken = False
    Int iFormIndex = PlayerRef.GetNumItems()
    While iFormIndex > 0
        iFormIndex -= 1
        Form kForm = PlayerRef.GetNthForm(iFormIndex)
        ObjectReference asObjRef = kForm As ObjectReference
        If !asObjRef
            Int count = PlayerRef.GetItemCount(kForm)
            PlayerRef.Removeitem(kForm, count, True, _DFlowSoldItems)
            taken = True
        EndIf
    EndWhile
    
    If taken
        ; Quest to regain lost items
        If _DFlowItems.IsStopped()
            _DflowItems.Start()
        EndIf
        _DflowItems.SetStage(1)
    EndIf
EndFunction


Function RobPlayerItems(Bool voluntary = False)

    ; Beginning to question if the correct way to configure this is percentage.
    Int lootValue = 0
    Int removePercentage = _DFlowItemsPerRemoved.GetValue() as Int
    
    If voluntary && removePercentage < 50
        removePercentage = 50
    EndIf

    If removePercentage < 5
        Return
    EndIf

    Debug.Notification("$DF_FOLLOWER_TAKE")
    Bool taken = False


    Int iFormIndex = PlayerRef.GetNumItems()
    While iFormIndex > 0

        iFormIndex -= 1
        Form kForm = PlayerRef.GetNthForm(iFormIndex)
        If !kForm.HasKeyWord(SexLabNoStripKeyword) \
            && !kForm.HasKeyWord(VendorNoSaleKeyword) \
            && !kForm.HasKeyWord(VendorBookKeyword) \
            && !kForm.HasKeyWord(VendorToolKeyword) \
            && !kForm.HasKeyWord(VendorAnimalPartKeyword) \
            && !kForm.HasKeyWord(VendorRawFoodKeyword) \
            && !kForm.HasKeyWord(VendorFirewoodKeyword) \
            && !kForm.HasKeyWord(VendorKeyKeyword) 
            
                ; Let's try *not* removing forms that are also obj refs ...
                ObjectReference asObjRef = kForm As ObjectReference
                If !asObjRef
                
                    Int count = PlayerRef.GetItemCount(kForm)
                    Int removeCount = count
                    
                    ; The follower grabs all the small valuables regardless.
                    Int goldValue = kForm.GetGoldValue()
                    Float weight = kForm.GetWeight()
                    Float ratio = (goldValue As Float) / weight
                    
                    ; If ratio not great, chance not to take
                    If ratio < 20.0
                        If 1 == count
                            Int r = Utility.RandomInt(1, 100)
                            If r > removePercentage
                                removeCount = 0 ; Don't take it
                            EndIf
                        ElseIf removePercentage < 90 ; Otherwise they're all taken
                            Int takePercent = Utility.RandomInt(0, removePercentage * 2)
                            removeCount = (count * takePercent) / 100
                        EndIf
                    EndIf
                    
                    If removeCount > 0
                        PlayerRef.Removeitem(kForm, removeCount, True, _DFlowSoldItems)
                        lootValue += removeCount * goldValue
                        taken = True
                    EndIf

                EndIf
        EndIf

    EndWhile

    Int pcGold = PlayerRef.GetGoldAmount() As Int
    PlayerRef.RemoveItem(Gold001, pcGold)
    pcGold = (pcGold * 75) / 100
    
    ; Actually give the PC some debt relief from the stolen items!
    ;Debug.Notification("Loot value " + lootValue)
    pcGold += lootValue / 10

    DebtPay(pcGold)
    Tool.ReduceResist(18)

    If taken
        ; Quest to regain lost items
        If _DFlowItems.IsStopped()
            _DflowItems.Start()
        EndIf
        _DflowItems.SetStage(1)
    EndIf

EndFunction


; Clean, re-usable way to start a new relationship with a follower.
; Note that the _DFlow quest stages reset the debt timer, and set debt. For hirelings they set 500 debt.
; Stage 2 = mercenary start, calls this and sets debt.
; Stage 10 = regular start, resets timer, this is called by the special starting dialog.
Function StartNewAgreement(Actor newMaster, Int questStageID)

    Actor currentDF = Alias__DMaster.GetActorRef()
    If currentDF == newMaster
        Debug.TraceConditional("DF - StartNewAgreement - already have this DF as master", True)
    Else
        
        If newMaster
            Debug.TraceConditional("DF - StartNewAgreement " + newMaster.GetActorBase().GetName() + " stage " + questStageID, True)
            
            If currentDF
                Debug.TraceConditional("DF - StartNewAgreement - stripping faction from old DF " + currentDF.GetActorBase().GetName(), True)
                currentDF.RemoveFromFaction(_DMaster) ; This is just to clean up lingering DMaster factions, not a proper follower removal.
                ; If this follower is being removed, something else should be handling it.
            EndIf
            
            Alias__DMaster.ForceRefTo(newMaster)
            newMaster.RemoveFromFaction(pDismissedFollower)
            newMaster.AddToFaction(_DMaster)
            
            ; If we add a DF, ensure we have a default SS master.
            ; This shouldn't be changed if set, as the player can set it.
            If !ScanActor
                ScanActor = newMaster
            EndIf
            
            ResetPunishmentTracking(newMaster)
        EndIf

        ; Start minimum contract...
        _DFMinimumContractRemaining.SetValue(_DFMinimumContract.GetValue())
        
        _GoldControl.SetStage(0)
        _DFlowSold.Enable = False
        
        DTimerReset()
        BTimerReset()

        ; Do NOT set debt - see comments above, this is driven by the quest stage fragment code.
        ;Debt.SetValue(0.0)
        UpdateFollowerHireTags(newMaster) ; also sets boredom from stored value...
        
        _DFDailyDebtAdjust.SetValue(0.0)
        ;_DFExpectedDealCount.SetValue(0) -- this is not a peristent value that lingers across hires.
        
        PriceReset() ; Reset device removal price

        Tool.ResetSpanking()
        BoredomQuest.Start()
        Tool.PickSlaveryDestination()
        PickEndlessSlaveryDestination()
        
        ; Shouldn't have this stage if it's disabled.
        If _DFLicenses.GetStage() > 100
            _DFLicenses.Stop()
            _DFLicenses.Start()
        EndIf

    EndIf

    SetStage(questStageID)
    ; See also _DflowFollowerController

    DealController.PickRandomDeal()

EndFunction

Function QuickStartNewAgreement()

    Debug.TraceConditional("DF - QuickStartNewAgreement", True)
    If Alias__DMaster.GetActorRef()
        Debug.TraceConditional("DF - QuickStartNewAgreement - already have a DF - aborting", True)
        Return
    EndIf
    
    ; The returned followers may include some ignored only via storageutil...
    Actor[] followers = Q2.GetFrameworkFollowers(_DFDisable)
    
    Bool started = False
    Int ii = 0
    Int stopAt = followers.Length
    While ii < stopAt
        Actor who = followers[ii]
        
        If who && !IsIgnore(who)
            stopAt = 0
            
            Debug.Notification("Your new follower is devious")
            Debug.TraceConditional("DF - QuickStartNewAgreement - startAgreement with " + who.GetActorBase().GetName(), True)

            Topic toSay = Game.GetFormFromFile(0x000151AF, "DeviousFollowers.esp") As Topic ; I hope you're not going to cheat me...
            If toSay
                who.Say(toSay, who, False)
            EndIf
            StartNewAgreement(who, 3) ; resets debt and bounces to stage 10.
            started = True
        EndIf
        ii += 1
    EndWhile
            
    If !started
        Debug.TraceConditional("DF - QuickStartNewAgreement - didn't find any *valid* followers after all...", True)
    EndIf
    
    _DFlowSold.Enable = False
    ; Ensure deal isn't zero if possible
    DealController.PickRandomDeal()
    Tool.PickSlaveryDestination()
    PickEndlessSlaveryDestination()
       
EndFunction


; Used in debug add to restart follower without resetting debt etc.
Function RestartAgreement(Actor newMaster, Int questStageID)

    If newMaster
        Alias__DMaster.ForceRefTo(newMaster)
        newMaster.RemoveFromFaction(pDismissedFollower)
        ForceEnableDevious(newMaster)
    If questStageID < 98 || questStageID >= 200
        ResetPunishmentTracking(newMaster)
    EndIf
    EndIf
 
    _DFlowSold.Enable = False 
    DTimerReset()
    BTimerReset()
    
    UpdateFollowerHireTags(newMaster) ; also sets boredom from stored value
    
    _DFDailyDebtAdjust.SetValue(0.0)
    
    SetStage(questStageID)
    ; See also _DflowFollowerController
    
    BoredomQuest.Reset()
    BoredomQuest.Start()

    Tool.ResetSpanking()
    
    DealController.PickRandomDeal()
    Tool.PickSlaveryDestination()
    PickEndlessSlaveryDestination()

EndFunction


Function PayOffFollower(Actor follower)

    Int debtGold = Debt.GetValue() as Int
    If debtGold > 0
        PlayerRef.RemoveItem(Gold001, debtGold)
    EndIf
    
    If debtGold > 1
        DebtPay(debtGold)
    Else
        SetDebt(0)
    EndIf

    Reset()
    SetStage(9)
    Alias__DMaster.ForceRefto(follower)
    _DFlowSold.Enable = False

    Debug.Notification("PAID OFF")

EndFunction


Function RepairFollower()

    Utility.Wait(4.0)
    ; Do we have a vanilla follower?
    Quest dialogueFollowerQuest = Game.GetForm(0x000750BA) As Quest
    ReferenceAlias primaryAlias = dialogueFollowerQuest.GetAlias(0) As ReferenceAlias

    If !dialogueFollowerQuest
        Debug.Notification("Vanilla follower quest broken")
        Return
    EndIf
    
    pDialogueFollower = dialogueFollowerQuest
    
    Actor primaryFollower = None
    If primaryAlias
        primaryFollower = primaryAlias.GetActorRef()
        Debug.Notification("RepairFollower has alias")
    EndIf
    
    Actor deviousOne = None
    If Alias__DMaster
        deviousOne = Alias__DMaster.GetActorRef()
    EndIf
    
    If !primaryFollower && deviousOne
        ; Vanilla follower missing, but DF present
        Q2.AddFollowerToFramework(deviousOne)
        primaryFollower = deviousOne
    ElseIf primaryFollower && !deviousOne
        ; Vanilla follower present, but DF missing
        Alias__DMaster.ForceRefTo(primaryFollower)
    ElseIf primaryFollower && deviousOne && primaryFollower != deviousOne
        ; Both followers present, but they don't match up.
        ; Update DF to use vanilla follower
        Alias__DMaster.ForceRefTo(primaryFollower)
    EndIf
    
    If primaryFollower
        ForceEnableDevious(primaryFollower)
    EndIf
    
    Utility.Wait(1.0)

    If GetStage() < 10
        SetStage(10)
        Utility.Wait(5.0)
    EndIf

    ; Check/Fix some basic factions
    If primaryFollower
    
        Faction potential = Game.GetForm(0x0005C84D) As Faction
        Faction current = Game.GetForm(0x0005C84E) As Faction
        Faction playerFollower = Game.GetForm(0x00084D1B) As Faction
        
        primaryFollower.AddToFaction(potential)
        
        If !primaryFollower.IsInFaction(current)
            Debug.Notification("Follower not in CurrentFollowers faction")
        EndIf
        If !primaryFollower.IsInFaction(playerFollower)
            Debug.Notification("Follower not in PlayerFollowers faction")
        EndIf
        If !primaryFollower.IsInFaction(Fac)
            Debug.Notification("Follower not in _DMaster faction") ; Should be impossible because it comes from alias.
        EndIf
       
        Float boredom = _DFBoredom.GetValue()
        StorageUtil.SetFloatValue(primaryFollower, Tool.TagBoredom, boredom)

        UpdateFollowerHireTags(primaryFollower) ; also sets boredom from stored value...
        
        Utility.Wait(1.0)

    EndIf
    
    DealController.PickRandomDeal()

EndFunction

Function EnslavedDueToDebt()

    Debug.TraceConditional("DF - EnslavedDueToDebt - begin", True)
    ; _Dtats was unset, so probably wasn't working - repaired for updaters in MCM update.
    Int maxTattoos = _Dtats.GetValue() As Int

    If maxTattoos > 0

        Int t = Utility.RandomInt(1, maxTattoos)
        While t > 0
            t -= 1
            SendModEvent("RapeTattoos_addTattoo")
            Utility.Wait(3)
        EndWhile

    EndIf

    ; SSO was unset, so probably wasn't working - repaired for updaters in MCM version update step.
    ; SSO = GetFormFromFile(0x0002F68A, "DeviousFollowers.esp")
    Int slaveryTarget = _DFSlaveryTarget.GetValue() As Int
    
    If _DFlowSold.Active
        slaveryTarget = _DFEndlessSlaveryTarget.GetValue() As Int
    EndIf
    
    If 1 == slaveryTarget && Tool.HaveSimpleSlavery()
        ; Simple slavery
        Debug.Notification("You feel dizzy... Your vision blurs...")

        ; Player is sent to Simple Slavery ... remove them from DF.
        SendModEvent("DF-RemoveFollower")
        PlayerRef.RemoveItem(Gold001, 16000) ; Just steal a bunch of gold.
        SetDebt(0)
        Reset()
        SetStage(0)
        Start()
        DDelay()
        SendModEvent("SSLV Entry") ; Welcome to the auction - we also listen for this, but it's more reliable to be explicit, maybe?

    ElseIf 2 == slaveryTarget && Tool.HaveLola()
        ; Submissive Lola
        Debug.TraceConditional("DF - EnslavedDueToDebt - Start SlaveryWatcher", True)
        Debug.Notification("Start the slavery watcher...")
        ; Player is sent to Submissive Lola
        _DFSlaveryWatcher.Start()
        ;_DFSlaveryWatcher.SetStage(10)
    
    ElseIf 3 == slaveryTarget
        ; Sold - Nothing to do, just leave this to play out.
    Else
        ; 0 == slaveryTarget
        ; Internal DF slavery
        SetStage(99) ; This prevents the mod pausing itself in the mod event, so has to happen first
        ETimerReset()
        SendModEvent("PlayerRefEnslaved") ; This just sets the "PEnslaved" flag on _Dtick, the enslavement behaviours results from the quest stage.

    EndIf
    
    Utility.Wait(10.0) ; Allow some time for the slavery to clear immediate events before we resume.
    Tool.ResumeAll()
    
    ; Set a new destination for next enslavement.
    Tool.PickSlaveryDestination()
    PickEndlessSlaveryDestination()
    Debug.TraceConditional("DF - EnslavedDueToDebt - end", True)
   
EndFunction


; This is only used when forced into gold control due to debt.
Function EnterGoldControl()

    ; Previously, debt was set to enslavement threshold - 100
    ; This was effectively sinking an arbitrary amount of debt for the player. Win for them! But too easy to sink huge debts this way.
    ; Cap the amount that can be sunk at some factor of debt per day
    Float perDay = DebtPerDay.GetValue()
    Float sinkLimit = perDay * 0.5
    Float currentDebt = Debt.GetValue()
    Float targetDebt = EnslavementDebt.GetValue() - 100.0
    
    ; This should always be true here but ... Skyrim
    If currentDebt > targetDebt
        Float sink = currentDebt - targetDebt
        If sink > sinkLimit
            sink = sinkLimit
        EndIf
        Float newDebt = currentDebt - sink
        
        SetDebt(newDebt)
    EndIf

    Tool.ReduceResist(18)

    _GoldControl.Setstage(1)

    Tool.ResumeALL()
    
EndFunction

Function ForceEnableDevious(Actor who)
    who.RemoveFromFaction(_DFDisable)
    StorageUtil.UnsetIntValue(who, TagNeverDevious)
EndFunction


; This sibling of this lives in Tool. Probably they should both be here, but they aren't.
Function PickEndlessSlaveryDestination()

    Debug.TraceConditional("DF - PickEndlessSlaveryDestination - start", True)

    Int svWeight = EndlessSlaveWeight As Int    ; Enslaved in DFC - 0
    Int ssWeight = EndlessAuctionWeight As Int  ; Simple Slavery auction weight - 1
    Int loWeight = EndlessLolaWeight As Int     ; Lola weight - 2
    Int dfWeight = EndlessSoldWeight As Int     ; Sold in DFC - 3
    
    Debug.TraceConditional("DF - PickEndlessSlaveryDestination - weights - ss " + ssWeight + ", lola " + loWeight + ", df " + dfWeight, True)
    
    If !Tool.HaveSimpleSlavery()
        ssWeight = 0
    EndIf
    If !Tool.HaveLola()
        loWeight = 0
    EndIf
    
    Int totalWeight = svWeight + ssWeight + loWeight + dfWeight
    Int roll = Utility.RandomInt(0, totalWeight - 1)
    
    Int slaveryTarget = 3 ; sold to another follower in-game mechanic
    
    If roll < svWeight
        slaveryTarget = 0 ; Internal slavery
    ElseIf roll < svWeight + ssWeight
        slaveryTarget = 1 ; Simple Slavery
    ElseIf roll < svWeight + ssWeight + loWeight
        slaveryTarget = 2 ; Lola
    EndIf
    
    _DFEndlessSlaveryTarget.SetValue(slaveryTarget As Float)

    Debug.TraceConditional("DF - PickEndlessSlaveryDestination is " + slaveryTarget + " - end", True)

EndFunction



; Check for follower that should not be devious.
Bool Function IsIgnore(Actor who)
    Int tagged = StorageUtil.GetIntValue(who, TagNeverDevious, -1)
    If tagged >= 0
        Return True
    EndIf
    Return who.GetFactionRank(_DFDisable) >= -1
EndFunction


_DflowFollowerController Property Q2 Auto
zadlibs Property libs  Auto  
_DFTools Property Tool auto
Quest Property pDialogueFollower Auto
Quest Property Ticker Auto
Quest Property _GoldControl Auto ; I do not like this circular dependency, but it's been forced by poor design elsewhere :(
Quest Property BoredomQuest Auto
Quest Property _DFlowItems Auto
Quest Property _DFSlaveryWatcher Auto
Quest Property _DFLicenses Auto

QF__DflowDealController_0A01C86D Property DealController Auto
_DFsold Property _DFlowSold Auto

; GoldControl should have stored its credit, and done the cash adjustments entirely in here. Too late now.

Faction Property CurrentHireling  Auto  
Faction Property Fac  Auto  ; _DMaster
Faction Property WR  Auto  ; Whiterun Crime
Faction Property B  Auto  ; Rift Crime
Faction Property C  Auto  ; Winterhold Crime
Faction Property CrimeFactionHaafingar Auto ; Solitude Crime
Faction Property pDismissedFollower Auto
Faction Property _DFDisable Auto
Faction Property _DMaster Auto

ObjectReference Property Pit Auto  
ObjectReference Property _DFlowSoldItems Auto

Keyword Property SexLabNoStripKeyword Auto
Keyword Property VendorNoSaleKeyword Auto
Keyword Property VendorBookKeyword Auto
Keyword Property VendorToolKeyword Auto
Keyword Property VendorAnimalPartKeyword Auto
Keyword Property VendorRawFoodKeyword Auto
Keyword Property VendorFirewoodKeyword Auto
Keyword Property VendorKeyKeyword Auto
Keyword Property _DFCrawlRequired Auto

GlobalVariable Property Lives Auto  
GlobalVariable Property LivesM Auto  
GlobalVariable Property Will Auto
GlobalVariable Property Debt Auto 

GlobalVariable Property CanRehireGV  Auto
GlobalVariable Property HasHirelingGV  Auto  
GlobalVariable Property Failure Auto
GlobalVariable Property Timer Auto  
GlobalVariable Property ETimer Auto  
GlobalVariable Property ETimerP Auto 
GlobalVariable Property GameDaysPassed Auto
GlobalVariable Property QuestStage Auto
GlobalVariable Property PlayerFollowerCount Auto
GlobalVariable Property HirelingCommentNextAllowed auto
GlobalVariable Property SSO  Auto
GlobalVariable Property _DFSlaveryTarget Auto

GlobalVariable Property DebtPerDay Auto
GlobalVariable Property Intrest Auto
GlobalVariable Property EnslavementDebt Auto
GlobalVariable Property EnslavementHalfDebt Auto
GlobalVariable Property FreedomCost Auto
GlobalVariable Property EnslavePerLevel Auto ; Still used!
GlobalVariable Property DebtPollhrs Auto
GlobalVariable Property DebtPerFollower Auto
GlobalVariable Property DebtPerLevel Auto ; No longer used

GlobalVariable Property _DflowDealBaseDebt Auto
GlobalVariable Property _DflowRemovalBasePrice Auto
GlobalVariable Property _DflowRemovalP Auto
GlobalVariable Property _DflowRemovalInc Auto
GlobalVariable Property _DflowRemovalDebtTimes Auto
GlobalVariable Property _DFPunDebt  Auto
GlobalVariable Property _DFMinimumContract Auto
GlobalVariable Property _DFMinimumContractRemaining Auto
GlobalVariable Property _DFFollowerCount Auto
GlobalVariable Property _DFDiscountLimit Auto
GlobalVariable Property _DFBoredom Auto
GlobalVariable Property _DFBoredomIntervalDays Auto
GlobalVariable Property _DFBoredomTimer Auto
GlobalVariable Property _DFDailyDebtAdjust Auto
GlobalVariable Property _DFDailyDebtIncrement Auto
GlobalVariable Property _DFExpectedDealCount Auto
GlobalVariable Property _DFExpectedDealLimit Auto
GlobalVariable Property _DFFatigue Auto
GlobalVariable Property _DFStanding Auto
GlobalVariable Property _DFlowItemsPerRemoved Auto
GlobalVariable Property _DFDailyDealTimer Auto
GlobalVariable Property _Dtats  Auto  
GlobalVariable Property _DFEndlessSlaveryTarget Auto

GlobalVariable Property pPlayerFollowerCount auto

Actor Property PlayerRef  Auto  
Actor Property Actor1 Auto
Actor Property Actor2 Auto
Actor Property Actor3 Auto
Actor Property Actor4 Auto
Actor Property Actor5 Auto
Actor Property ScanActor Auto ; The SS target slaver


Int Property RemovedDevicesCount = 0 Auto
Int Property Flow = 1 Auto  
Int Property CurrentLevel Auto

Float Property PunishmentDebtReduction = 25.0 Auto
Float Property PunishmentDealReduction = 4.0 Auto

Float Property EndlessSoldWeight = 100.0 Auto
Float Property EndlessSlaveWeight = 0.0 Auto
Float Property EndlessAuctionWeight = 0.0 Auto
Float Property EndlessLolaWeight = 0.0 Auto

Float Property Delay Auto Conditional

MiscObject Property Gold001  Auto
Message Property SSMessage auto
Message Property Enslavemsg1  Auto   

Weapon Property FollowerHuntingBow Auto
Ammo Property FollowerIronArrow Auto

Armor Property Collar Auto  ; slave collar inventory
Armor Property Mitts  Auto  ; slave mittens inventory
Armor Property Boots  Auto  ; slave boots inventory

Armor Property CollarR Auto  ; slave collar
Armor Property MittsR  Auto  ; slave mittens
Armor Property BootsR  Auto  ; slave boots

; Collar
Armor Property Item  Auto  
Armor Property Rend  Auto  

; Deal jewellery
Armor Property DealRing Auto
Armor Property DealAmulet Auto
Armor Property DealCirclet Auto

Int Property StatRangeAny = 0 AutoReadOnly
Int Property StatRangeLo = 1 AutoReadOnly
Int Property StatRangeMid = 2 AutoReadOnly
Int Property StatRangeHi = 3 AutoReadOnly

String Property TagNeverDevious = "DF_FollowerNeverDevious" AutoReadOnly ; Non-DRY duplicate of the one in Tool - keep in sync.

Int[] aggressionRange
Int[] greedRange
Int[] honorRange
Int[] lustRange
Int[] controlRange
Int[] playfulRange