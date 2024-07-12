Scriptname _DFlowModDealController extends _DFRulePack Conditional

; FOLDSTART - Properties
;Teir 1 & 2 Rules
; Int state ||1= Can be used || 2= InUse || 3=Inuse second state || 0= Disabled
_DFtools Property Tool Auto

Float Property TimerSetting Auto
Float Property AllowPretendKeyCheck Auto Conditional

Int Property CuffsRule Auto Conditional ;1 Added
Int Property CollarRule Auto Conditional  ;2 Added
Int Property GagRule Auto Conditional ;3 Added
Int Property NPRule Auto Conditional ;4 Added
Int Property VPRule Auto Conditional ;5 Added
Int Property NakedRule Auto Conditional ;6 Added
Int Property WhoreRule Auto Conditional ;7 Added
Int Property BlindFoldRule Auto Conditional ;8 Added
Int Property BootsRule Auto Conditional ;9 Added
Int Property GlovesRule Auto Conditional ;10 Added

Int Property SpankingRule Auto Conditional ; 21
Int Property SexRule Auto Conditional ; 22
Int Property LactacidRule Auto Conditional ; 23
Int Property RingRule Auto Conditional ; 24
Int Property AmuletRule Auto Conditional ; 25
Int Property CircletRule Auto Conditional ; 26

Int Property TimerStatus Auto Conditional ; 0 = no timed deals, 1 = lots of time, 2 = some time, 3 = almost out of time, 4 = failed previous, have defaulted deals

;Teir 3 Rules
Int Property PetSuitInTownRule Auto Conditional ;11 Added 3 = Added by follower
Int Property CrawlInTownRule Auto Conditional ;12 Added using anal plug!
Int Property InnKeeperRule Auto Conditional ;13 Added 3 = Oral || 4= Fuck || 5 = FuckEveryOne || 6 = FuckDog
Int Property BoundInTownRule Auto Conditional ;14 Added 
Int Property MerchantRule Auto Conditional ;Added 15  || 3 == Oral || 4 == Fuck || 5 = Dog
Int Property JacketRule Auto Conditional ; 16 Jacket in town
Int Property ExpensiveRule Auto Conditional ; 17 Owe a lot of money
Int Property KeyRule Auto Conditional ; 18
Int Property SkoomaRule Auto Conditional ; 19
Int Property MilkingRule Auto Conditional ; 20

Int Property SexDealRequests Auto Conditional
Int Property SkoomaDealRequests Auto Conditional
Int Property LactacidDealRequests Auto Conditional
Int Property MilkDealRequests Auto Conditional

Int Property SpankDealDefaults Auto Conditional
Int Property SexDealDefaults Auto Conditional
Int Property SkoomaDealDefaults Auto Conditional
Int Property LactacidDealDefaults Auto Conditional
Int Property MilkDealDefaults Auto Conditional

Bool Property IsPaused Auto Conditional
Bool Property ShowDiagnostics Auto

Float Property DelayGag Auto Hidden Conditional
Float Property DelayChastity Auto Hidden Conditional

GlobalVariable Property GameDaysPassed Auto
GlobalVariable Property _DFSpankDealRequests Auto ; Updated by _DFtools
GlobalVariable Property _DFDailyDealTimer Auto ; Checked by DebtInc in QF__Gift_09000D62, updated in this file.
GlobalVariable Property _DFModMmePresent Auto
GlobalVariable Property _DFModSkoomaWhorePresent Auto
GlobalVariable Property _DFKeyFound Auto
GlobalVariable Property _DWill Auto
GlobalVariable Property _DFEnableKeySearchGreeter Auto


Float Property InnKeeperRuleTimer Auto Conditional
Scene Property InnScene Auto
Float Property FastTravelTimer Auto Conditional
Scene Property MerchantScene Auto
Float Property MerchantRuleTimer Auto Conditional
; These  regulate the appearance of player dialogs relating to the requests
Float Property SexDealTimer Auto Conditional
Float Property SkoomaDealTimer Auto Conditional
Float Property LactacidDealTimer Auto Conditional
Float Property MilkDealTimer Auto Conditional
Float Property KeySearchTimer Auto Conditional

Actor Property PlayerRef Auto
Armor Property _DflowPonyTailDealInventory Auto
Armor Property _DflowPonyTailDealRend Auto
ReferenceAlias Property You  Auto  
ReferenceAlias Property Player  Auto  
ReferenceAlias Property Follower  Auto  
ReferenceAlias Property Actor1  Auto  
String[] Property OIDText Auto
String[] Property OIDTextDesc Auto
String[] Property DealNoti Auto
Int[] Property OIDs Auto ; Putting these here was problematic. This is no longer used.

Int[] Property DealType Auto
Int Property DealsBuilt Auto
Int Property MaxModDealsSetting Auto
Int Property MaxModDealsAviliable Auto ; This isn't used any longer.
Bool Property OptimizeRules Auto ; This is now ignored, rules always check for conflicts.
Bool Property ForceKeyCheck Auto

Int[] Property DealMStages Auto ; Save deal stages
Int[] Property DealMCodes Auto ; Save deal codes
Int[] Property RuleSave Auto ; Save rule state
Float Property PausedDailyDealTimerRemaining Auto
Float Property PausedInnKeeperInnKeeperDaysRemaining Auto
Float Property PausedFastTravelTimerDaysRemaining Auto
Float Property PausedMerchantRuleTimerDaysRemaining Auto
Float Property PausedSexDealTimerDaysRemaining Auto
Float Property PausedSkoomaDealTimerDaysRemaining Auto
Float Property LactacidDealTimerDaysRemaining Auto
Float Property MilkDealTimerDaysRemaining Auto


Quest Property DealO  Auto 
Quest Property DealB  Auto 
Quest Property DealH  Auto 
Quest Property DealP  Auto 
Quest Property DealS Auto 

Quest Property DealM1 Auto ; Bear
Quest Property DealM2 Auto ; Wolf
Quest Property DealM3 Auto  ;Dragon
Quest Property DealM4 Auto  ;Skeever
Quest Property DealM5 Auto ; Slaughterfish

ObjectReference Property _DFKeyContainer Auto
ObjectReference Property _DFMilkBarrel Auto

Keyword Property VendorItemFood Auto
Keyword Property MME_Milk Auto

Keyword Property ddRestraintsKey Auto
Keyword Property ddChastityKey Auto
Keyword Property ddPiercingKey Auto


Int[] availableRules
; FOLDEND - Properties

; FOLDSTART - Notes
    ; hood - probably conflicts with other plans
    ; harness - save for pony deal
    ; pony boots - save for pony deal
    ; ring - impairs smithing
    ; amulet - impairs enchanting
    ; circlet - impairs alchemy
    ; name change
    ;
    ; keys
    ; takes gems
    ; takes jewellery
    ; takes magic
    ; takes alchemy
    ; takes smithing
    ; takes enchanting
; FOLDEND - Notes


Function StartMDC()
	If 0 == DealsBuilt
		Update()
	EndIf
EndFunction

Function Update()

	Int NumODeals = 26
	
     ; Use index 1 base ... deal 0 is reserved for 'no deal'.
    OIDText = new String[27] 
    OIDTextDesc = new String[27] 
    DealType = New Int[27] 
    DealNoti = New String[27]
    availableRules = New Int[27]

    OIDText[0] = "$DFMDNoDeal"                ; -
    OIDText[1] = "$DFMDCuffsRule"             ; L1+2
    OIDText[2] = "$DFMDCollarRule"            ; L1+2
    OIDText[3] = "$DFMDGagRule"               ; L1+2
    OIDText[4] = "$DFMDNPRule"                ; L1+2 nipple piercing
    OIDText[5] = "$DFMDVPRule"                ; L1+2 vaginal piercing
    OIDText[6] = "$DFMDNakedRule"             ; L1+2
    OIDText[7] = "$DFMDWhoreRule"             ; L1+2 Whore armor
    OIDText[8] = "$DFMDBlindFoldRule"         ; L1+2
    OIDText[9] = "$DFMDBootsRule"             ; L1+2
    OIDText[10] = "$DFMDGlovesRule"           ; L1+2
    OIDText[11] = "$DFMDPetSuitInTownRule"    ; L3
    OIDText[12] = "$DFMDCrawlInTownRule"      ; L3
    OIDText[13] = "$DFMDInnKeeperRule"        ; L3
    OIDText[14] = "$DFMDBoundInTownRule"      ; L3
    OIDText[15] = "$DFMDMerchantRule"         ; L3
    OIDText[16] = "$DFMDJacketRule"           ; L3
    OIDText[17] = "$DFMDExpensiveRule"        ; L1+2+3
    OIDText[18] = "$DFMKeyRule"               ; L3
    OIDText[19] = "$DFMSkoomaRule"            ; L3
    OIDText[20] = "$DFMMilkingRule"           ; L3
    OIDText[21] = "$DFMSpankRule"             ; L1+2
    OIDText[22] = "$DFSexRule"                ; L1+2
    OIDText[23] = "$DFMLactacidRule"          ; L1+2
    OIDText[24] = "$DFMRingRule"              ; L1+2
    OIDText[25] = "$DFMAmuletRule"            ; L1+2
    OIDText[26] = "$DFMCircletRule"           ; L1+2
    
    OIDTextDesc[0] = "$DFMDNoDealDesc"
    OIDTextDesc[1] = "$DFMDCuffsRuleDesc"
    OIDTextDesc[2] = "$DFMDCollarRuleDesc"
    OIDTextDesc[3] = "$DFMDGagRuleDesc"
    OIDTextDesc[4] = "$DFMDNPRuleDesc"
    OIDTextDesc[5] = "$DFMDVPRuleDesc"
    OIDTextDesc[6] = "$DFMDNakedRuleDesc"
    OIDTextDesc[7] = "$DFMDWhoreRuleDesc"
    OIDTextDesc[8] = "$DFMDBlindFoldRuleDesc"
    OIDTextDesc[9] = "$DFMDBootsRuleDesc"
    OIDTextDesc[10] = "$DFMDGlovesRuleDesc"
    OIDTextDesc[11] = "$DFMDPetSuitInTownRuleDesc"
    OIDTextDesc[12] = "$DFMDCrawlInTownRuleDesc"
    OIDTextDesc[13] = "$DFMDInnKeeperRuleDesc"
    OIDTextDesc[14] = "$DFMDBoundInTownRuleDesc"
    OIDTextDesc[15] = "$DFMDMerchantRuleDesc"
    OIDTextDesc[16] = "$DFMDJacketRuleDesc"
    OIDTextDesc[17] = "$DFMDExpensiveRuleDesc"
    OIDTextDesc[18] = "$DFMKeyRuleDesc" ; L3
    OIDTextDesc[19] = "$DFMSkoomaRuleDesc" ; L3
    OIDTextDesc[20] = "$DFMMilkingRuleDesc" ; L3
    OIDTextDesc[21] = "$DFMSpankRuleDesc" ; L1
    OIDTextDesc[22] = "$DFSexRuleDesc" ; L1
    OIDTextDesc[23] = "$DFMLactacidRuleDesc" ; L1
    OIDTextDesc[24] = "$DFMRingRuleDesc" ; L1
    OIDTextDesc[25] = "$DFMAmuletRuleDesc" ; L1
    OIDTextDesc[26] = "$DFMCircletRuleDesc" ; L1
    
    ; 0 = no deal, 1 = tier 1/2, 2 = tier 3
    DealType[ 0] = 0
    DealType[ 1] = 1
    DealType[ 2] = 1
    DealType[ 3] = 1
    DealType[ 4] = 1
    DealType[ 5] = 1
    DealType[ 6] = 1
    DealType[ 7] = 1
    DealType[ 8] = 1
    DealType[ 9] = 1
    DealType[10] = 1
    
    DealType[11] = 2
    DealType[12] = 2
    DealType[13] = 2
    DealType[14] = 2
    DealType[15] = 2
    DealType[16] = 2
    DealType[18] = 2
    DealType[19] = 2 ; Skooma
    DealType[20] = 2 ; Milking

    DealType[21] = 1 ; Spanking
    DealType[22] = 1
    DealType[23] = 1 ; Lactacid
    DealType[24] = 1
    DealType[25] = 1
    DealType[26] = 1
    
    DealType[17] = 3 ; Special - a deal type that is ALWAYS available, even if you already have it.
    
    
    DealNoti[11] = "$DFDEAL_PET_HUM"
    DealNoti[12] = "$DFDEAL_CRAWL_HUM"
    DealNoti[13] = "$DFDEAL_INN_HUM"
    DealNoti[14] = "$DFDEAL_BOUND_HUM"
    DealNoti[15] = "$DFDEAL_MERC_HUM"
    DealNoti[16] = "$DFDEAL_JACK_HUM"
    DealNoti[17] = "$DFDEAL_EXPENSE_HUM"
    
    CuffsRule = 1
    CollarRule = 1
    GagRule = 1
    NPRule = 1
    VPRule = 1
    NakedRule = 1
    WhoreRule  = 1
    BlindFoldRule = 1
    BootsRule = 1
    GlovesRule = 1
    PetSuitInTownRule = 1
    CrawlInTownRule = 1
    InnKeeperRule = 1
    BoundInTownRule = 1
    MerchantRule = 1
    JacketRule = 1
    ExpensiveRule = 1
    KeyRule = 1
    SkoomaRule = 0 ; Some rules start disabled because they require supporting mods.
    MilkingRule = 0
    SpankingRule = 0
    SexRule = 1
    LactacidRule = 0
    RingRule = 1
    AmuletRule = 1
    CircletRule = 1
    
   If Tool.CheckSpanking()
        SpankingRule = 1
   EndIf

    If IsSkoomaWhorePresent()
        SkoomaRule = 1
    EndIf

    If IsMmePresent()
        MilkingRule = 1
        LactacidRule = 1
    EndIf
    
    KeySearchTimer = Utility.GetCurrentGameTime() + (1.0/24.0)
    
    DealsBuilt = NumODeals

    ; When deals with dependencies have their supporting mod removed, the deal remains, but is gated to do nothing.

EndFunction


; Disables rules for external mods that have gone missing/stopped working/never existed.
Function DisableExternalRules()
    If !IsMmePresent()
        LactacidRule = 0
        MilkingRule = 0
    EndIf
    
    If !IsSkoomaWhorePresent()
        SkoomaRule = 0
    EndIf
EndFunction

; Tier 1 and 2 rules 
Int[] Function GetLowRules(Int skipRule = -2)

    DisableExternalRules()

    Int[] rules = New Int[20]
    Int bb = 0
    Int rr = 1
    While rr <= DealsBuilt
    
        If rr == skipRule
            Debug.TraceConditional("DF - GetLowRules - skipRule " + skipRule, ShowDiagnostics)
        ElseIf 1 != DealType[rr]
            Debug.TraceConditional("DF - GetLowRules - reject " + rr + " type is " + DealType[rr], ShowDiagnostics)
        ElseIf 1 != GetRuleState(rr)
            Debug.TraceConditional("DF - GetLowRules - reject " + rr + " state is " + GetRuleState(rr), ShowDiagnostics)
        ElseIf IsConflictingRule(rr)
            Debug.TraceConditional("DF - GetLowRules - reject " + rr + " conflicting", ShowDiagnostics)
        Else
            Debug.TraceConditional("DF - GetLowRules - add " + rr + " at " + bb, ShowDiagnostics)
            rules[bb] = rr
            bb += 1
        EndIf
    
        ;If rr != skipRule && 1 == DealType[rr] && 1 == GetRuleState(rr) && !IsConflictingRule(rr)
        ;    rules[bb] = rr
        ;    bb += 1
        ;EndIf
        rr += 1
    EndWhile
    
    ; Don't add this rule until we're running short, so it's never the first thing you get.
    ; It has rule type 3, so always skipped by initial adds
    If 0 != ExpensiveRule && bb < 5
        Debug.TraceConditional("DF - GetLowRules - add expensive rule", ShowDiagnostics)
        rules[bb] = 17 ; Expensive rule is always available if enabled
        bb += 1
    EndIf
    
    While bb < 20
        rules[bb] = -1
        bb += 1
    EndWhile
    
    Return rules
    
EndFunction

Int[] Function GetHiRules(Int skipRule = -2)

    DisableExternalRules()


    Int[] rules = New Int[10]
    
    Int bb = 0
    Int rr = 11 ; It's safe to start at 11, there are no type 1 deals below this, and any new deals will have higher indices
    While rr <= DealsBuilt
    
        If rr == skipRule
            Debug.TraceConditional("DF - GetHiRules - skipRule " + skipRule, ShowDiagnostics)
        ElseIf 2 != DealType[rr]
            Debug.TraceConditional("DF - GetHiRules - reject " + rr + " type is " + DealType[rr], ShowDiagnostics)
        ElseIf 1 != GetRuleState(rr)
            Debug.TraceConditional("DF - GetHiRules - reject " + rr + " state is " + GetRuleState(rr), ShowDiagnostics)
        ElseIf IsConflictingRule(rr)
            Debug.TraceConditional("DF - GetHiRules - reject " + rr + " conflicting", ShowDiagnostics)
        Else
            Debug.TraceConditional("DF - GetHiRules - add " + rr + " at " + bb, ShowDiagnostics)
            rules[bb] = rr
            bb += 1
        EndIf

        ;If rr != skipRule && 2 == DealType[rr] && 1 == GetRuleState(rr) && !IsConflictingRule(rr)
        ;    rules[bb] = rr
        ;    bb += 1
        ;EndIf
        rr += 1
    EndWhile

    If 0 != ExpensiveRule && bb < 3
        Debug.TraceConditional("DF - GetHiRules - add expensive rule", ShowDiagnostics)
        ; It has rule type 3, so always skipped by initial adds
        rules[bb] = 17 ; Expensive rule is always available if enabled
        bb += 1
    EndIf
    
    While bb < 10
        rules[bb] = -1
        bb += 1
    EndWhile
    
    Return rules

EndFunction

Int Function CountRules(Int[] rules)

    Int ii = 0
    Int limit = rules.Length
    While ii < limit
        If rules[ii] < 0
             limit = ii
        EndIf
        ii += 1
    EndWhile
    
    Return limit
    
EndFunction

Int Function setT1or2rule(Bool forceAllocate = False)
    ; When adding a new rule - here - it's added either as a level 1 or level 2 deal.
    ; This is called T1 or T2 (Tier 1 or Tier 2) though the jargon tier is used few other places.
    ;
    ; The rule's state will be set to 0 = disabled, 1 = enabled+inactive, or 2 = active.
    ; Test rule is < 2 to be sure it's not set.

    ; Return the selected rule index.
    ; If we cannot find a valid rule, return 0, which is no deal...
    Debug.TraceConditional("DF - ERROR - calling setT1or2rule - deprecated!", ShowDiagnostics)

    ; Build array of available, valid deal indices
    Int bb = 0
    Int rr = 1
    While rr <= DealsBuilt
        If 1 == DealType[rr] && 1 == GetRuleState(rr) && !IsConflictingRule(rr)
            availableRules[bb] = rr
            bb += 1
        EndIf
        rr += 1
    EndWhile

    ; Don't add this rule until we're running short, so it's never the first thing you get.
    ; It has rule type 3, so always skipped by initial adds
    If 0 != ExpensiveRule && bb < 5
        availableRules[bb] = 17 ; Expensive rule is always available if enabled
        bb += 1
    EndIf

    Int maxIndex = bb - 1
    If maxIndex < 0
        ; There is no valid rule!
        ; This should force a rule extension instead...
        ; Won't happen unless rule 17 is disabled by the user.
        Return 0
    EndIf

    Int selected = Utility.RandomInt(0, maxIndex)
    Int ruleIndex = availableRules[selected]

    If ruleIndex > 0
        SetRule(ruleIndex, 2)
        Tool.ReduceResistFloat(2.0)
    Else ; Punish resist harder for failed allocation, to compensate for freebie rule.
        Tool.ReduceResistFloat(7.0)
    EndIf

    Return ruleIndex

EndFunction

Int Function setT3rule(Bool Override=False)

    Debug.TraceConditional("DF - ERROR - calling setT3rule - deprecated!", ShowDiagnostics)

    ; Build array of available, valid deal indices
    Int bb = 0
    Int rr = 11 ; It's safe to start at 11, there are no type 1 deals below this, and any new deals will have higher indices
    While rr <= DealsBuilt
        If 2 == DealType[rr] && 1 == GetRuleState(rr) && !IsConflictingRule(rr)
            availableRules[bb] = rr
            bb += 1
        EndIf
        rr += 1
    EndWhile

    If 0 != ExpensiveRule && bb < 5
        ; It has rule type 3, so always skipped by initial adds
        availableRules[bb] = 17 ; Expensive rule is always available if enabled
        bb += 1
    EndIf

    Int maxIndex = bb - 1
    If maxIndex < 0
        ; There is no valid rule!
        ; This should force a rule extension instead...
         ; Won't happen unless rule 17 is somehow disabled, no logic for that yet.
       Return 0
    EndIf
    
    Int selected = Utility.RandomInt(0, maxIndex)
    Int ruleIndex = availableRules[selected]
    
    If ruleIndex > 0
        SetRule(ruleIndex, 2)
        Tool.ReduceResistFloat(4.0)
    Else ; Punish resist harder for failed allocation, to compensate for freebie rule.
        Tool.ReduceResistFloat(21.0)
    EndIf

    Return ruleIndex
    
EndFunction

; Get rule status by index (0 = disabled, 1 = enabled, 2 = set, 3+ other values of set...)
Int Function GetRuleState(Int ruleIndex)
    Int ruleState = -1
    If ruleIndex == 1
        ruleState = CuffsRule
    ElseIf ruleIndex == 2
        ruleState = CollarRule
    ElseIf ruleIndex == 3
        ruleState = GagRule
    ElseIf ruleIndex == 4
        ruleState = NPRule
    ElseIf ruleIndex == 5
        ruleState = VPRule
    ElseIf ruleIndex == 6
        ruleState = NakedRule
    ElseIf ruleIndex == 7
        ruleState = WhoreRule 
    ElseIf ruleIndex == 8
        ruleState = BlindFoldRule
    ElseIf ruleIndex == 9
        ruleState = BootsRule
    ElseIf ruleIndex == 10
        ruleState = GlovesRule
    ElseIf ruleIndex == 11
        ruleState = PetSuitInTownRule
    ElseIf ruleIndex == 12
        ruleState = CrawlInTownRule
    ElseIf ruleIndex == 13
        ruleState = InnKeeperRule
    ElseIf ruleIndex == 14
        ruleState = BoundInTownRule
    ElseIf ruleIndex == 15
        ruleState = MerchantRule
    ElseIf ruleIndex == 16
        ruleState = JacketRule
    ElseIf ruleIndex == 17
        ruleState = ExpensiveRule
    ElseIf ruleIndex == 18
        ruleState = KeyRule
    ElseIf ruleIndex == 19
        ruleState = SkoomaRule
    ElseIf ruleIndex == 20
        ruleState = MilkingRule
    ElseIf ruleIndex == 21
        ruleState = SpankingRule
    ElseIf ruleIndex == 22
        ruleState = SexRule
    ElseIf ruleIndex == 23
        ruleState = LactacidRule
    ElseIf ruleIndex == 24
        ruleState = RingRule 
    ElseIf ruleIndex == 25
        ruleState = AmuletRule
    ElseIf ruleIndex == 26
        ruleState = CircletRule
    EndIf
    Return ruleState
EndFunction

Bool Function IsSkoomaWhorePresent()
    Return 0.0 != _DFModSkoomaWhorePresent.GetValue()
EndFunction

Bool Function IsMmePresent()
    Return 0.0 != _DFModMmePresent.GetValue()
EndFunction


Function DelayGag()
    if PlayerRef.WornHasKeyword(Tool.LDC.libs.zad_Deviousgag)
        Tool.LDC.RemoveDeviceByKeyword(Tool.LDC.libs.zad_Deviousgag)
    endIf
    DelayGag = GameDaysPassed.GetValue() + 0.04
EndFunction

Function DelayChastity()
    if PlayerRef.WornHasKeyword(Tool.LDC.libs.zad_DeviousBelt)
        Tool.LDC.RemoveDeviceByKeyword(Tool.LDC.libs.zad_DeviousBelt)
    endIf
    DelayChastity = GameDaysPassed.GetValue() + 0.04
EndFunction

; b = 0 disable, b = 1 remove, b = 2 add
; Won't find many SetRule(X, 2) because the old rule setting functions set the Rule to 2 directly.
Function SetRule(Int ruleIndex, Int b)

    If ruleIndex < 1
        Return
    EndIf

    ; Flag to update the timer-driven deals if due for it.
    Bool checkDealTimer = False

    If ruleIndex == 1      ; Cuffs (Arm + Leg)
        If  1 == b && CuffsRule > 1
            Tool.LDC.RemoveDeviceByKeyword(Tool.LDC.libs.zad_DeviousArmcuffs)
            Tool.LDC.RemoveDeviceByKeyword(Tool.LDC.libs.zad_DeviousLegcuffs)
        ElseIf 2 == b
            Tool.LDC.AddDeviceByKeyword(Tool.LDC.libs.zad_DeviousArmcuffs)
            Tool.LDC.AddDeviceByKeyword(Tool.LDC.libs.zad_DeviousLegcuffs)
        EndIf
        CuffsRule = b
    ElseIf ruleIndex == 2  ; Collar
        If 1 == b && CollarRule > 1
            Tool.LDC.RemoveDeviceByKeyword(Tool.LDC.libs.zad_DeviousCollar)
        ElseIf 2 == b
            Tool.LDC.AddDeviceByKeyword(Tool.LDC.libs.zad_DeviousCollar)
        EndIf
        CollarRule = b
    ElseIf ruleIndex == 3  ; Gag
        If 1 == b && GagRule > 1
            Tool.LDC.RemoveDeviceByKeyword(Tool.LDC.libs.zad_Deviousgag)
        ElseIf 2 == b
            Tool.LDC.AddDeviceByKeyword(Tool.LDC.libs.zad_Deviousgag)
        EndIf
        GagRule = b
    ElseIf ruleIndex == 4  ; Nipple Piercings
        If 1 == b && NPRule > 1
            Tool.LDC.RemoveDeviceByKeyword(Tool.LDC.libs.zad_deviouspiercingsnipple)
        ElseIf 2 == b
            Tool.LDC.AddDeviceByKeyword(Tool.LDC.libs.zad_deviouspiercingsnipple)
        EndIf
        NPRule = b
    ElseIf ruleIndex == 5  ; Vaginal Piercings
        If 1 == b && VPRule > 1
            Tool.LDC.RemoveDeviceByKeyword(Tool.LDC.libs.zad_deviouspiercingsvaginal)
        ElseIf 2 == b
            Tool.LDC.AddDeviceByKeyword(Tool.LDC.libs.zad_deviouspiercingsvaginal)
        EndIf
        VPRule = b
    ElseIf ruleIndex == 6  ; Naked
        NakedRule = b
    ElseIf ruleIndex == 7  ; Whore
        If 2 == b
            Tool.GiveWhoreArmor(False)
        EndIf
        WhoreRule = b
    ElseIf ruleIndex == 8  ; Blindfold
        If 1 == b && BlindFoldRule > 1
            Tool.LDC.RemoveDeviceByKeyword(Tool.LDC.libs.zad_deviousblindfold)
        ElseIf 2 == b
            Tool.LDC.AddDeviceByKeyword(Tool.LDC.libs.zad_deviousblindfold)
        EndIf
        BlindFoldRule = b
    ElseIf ruleIndex == 9  ; Boots
        If 1 == b && BootsRule > 1
            Tool.LDC.RemoveDeviceByKeyword(Tool.LDC.libs.zad_deviousboots)
        ElseIf 2 == b
            Tool.LDC.AddDeviceByKeyword(Tool.LDC.libs.zad_deviousboots)
        EndIf
        BootsRule = b
    ElseIf ruleIndex == 10 ; Gloves
        If 1 == b && GlovesRule > 1
            Tool.LDC.RemoveDeviceByKeyword(Tool.LDC.libs.zad_deviousgloves)
        ElseIf 2 == b
            Tool.LDC.AddDeviceByKeyword(Tool.LDC.libs.zad_deviousgloves)
        EndIf
        GlovesRule = b
    ElseIf ruleIndex == 11 ; PetSuit in town
        If 1 == b && PetSuitInTownRule > 1
            Tool.LDC.RemoveDeviceByKeyword(Tool.LDC.libs.zad_deviousPetSuit)
        EndIf
        PetSuitInTownRule = b
    ElseIf ruleIndex == 12 ; Crawl in town
        If 2 == b
            PlayerRef.Additem(_DflowPonyTailDealInventory, 1)
        EndIf
        CrawlInTownRule = b
    ElseIf ruleIndex == 13 ; Inn keeper
        InnKeeperRule = b
    ElseIf ruleIndex == 14 ; Bound in town
        If 1 == b && BoundInTownRule > 1
            Tool.LDC.RemoveDeviceByKeyword(Tool.LDC.libs.zad_deviousHeavyBondage)
        EndIf
        BoundInTownRule = b
    ElseIf ruleIndex == 15 ; Merchant
        MerchantRule = b
    ElseIf ruleIndex == 16 ; Jacket
        JacketRule = b
    ElseIf ruleIndex == 17 ; Expensive
        ExpensiveRule = b
    ElseIf ruleIndex == 18 ; Key
        If 1 == b
            ; Give the player their keys back if the deal is over.
            _DFKeyContainer.RemoveAllItems(PlayerRef)
        ElseIf 2 == b
            KeySearchTimer = Utility.GetCurrentGameTime() + (1.0/24.0)
        EndIf
        StorageUtil.FormListClear(PlayerRef, "DF_KeyRuleInventoryAddList")
        KeyRule = b
    ElseIf ruleIndex == 19 ; Skooma
        If IsSkoomaWhorePresent()
            If 2 == b
                SkoomaDealRequests = 0
                SkoomaDealDefaults = 0
                SkoomaDealTimer = Utility.GetCurrentGameTime()
                checkDealTimer = True
            EndIf
            SkoomaRule = b
        Else
            SkoomaRule = 0
        EndIf
    ElseIf ruleIndex == 20 ; Milking
        If IsMmePresent()
            If 2 == b
                MME_Milk = _DF_mme.GetMilkKeyword()
                MilkDealRequests = 0
                MilkDealDefaults = 0
                MilkDealTimer = Utility.GetCurrentGameTime()
                StorageUtil.SetFormValue(PlayerRef, "MME_MilkBarrel_Override", _DFMilkBarrel)
                DrinkLactacid(3)
                checkDealTimer = True
            Else
                StorageUtil.UnsetFormValue(PlayerRef, "MME_MilkBarrel_Override")
            EndIf
            MilkingRule = b
        Else
            MilkingRule = 0
        EndIf
    ElseIf ruleIndex == 21 ; Spanking
        If 2 == b
            _DFSpankDealRequests.SetValue(0.0)
            SpankDealDefaults = 0
            Tool.AllowSpanking()
            checkDealTimer = True
        EndIf
        SpankingRule = b
    ElseIf ruleIndex == 22 ; Sex
        If 2 == b
            SexDealRequests = 0
            SexDealDefaults = 0
            SexDealTimer = Utility.GetCurrentGameTime()
            checkDealTimer = True
        EndIf
        SexRule = b
    ElseIf ruleIndex == 23 ; Lactacid
        If IsMmePresent()
            If 2 == b
                LactacidDealRequests = 0
                LactacidDealDefaults = 0
                LactacidDealTimer = Utility.GetCurrentGameTime()
                checkDealTimer = True
            EndIf
            LactacidRule = b
        Else
            LactacidRule = 0
        EndIf
    ElseIf ruleIndex == 24 ; Ring
        If 2 == b
            Tool.AddDealItem("ring")
        EndIf
        RingRule = b
    ElseIf ruleIndex == 25 ; Amulet
        If 2 == b
            Tool.AddDealItem("amulet")
        EndIf
        AmuletRule = b
    ElseIf ruleIndex == 26 ; Circlet
        If 2 == b
            Tool.AddDealItem("circlet")
        EndIf
        CircletRule = b
    EndIf

    If checkDealTimer
        CheckAndClearDealRequests()
    EndIf

    If 2 == b
        Debug.Notification(OIDTextDesc[ruleIndex])
    EndIf

EndFunction


Bool Function IsConflictingRule(Int ruleIndex)
    ; Return true if the rule conflicts with existing rules

    If ruleIndex == 1 ; Cuffs
        Return DealO.GetStage() >= 1
    ElseIf ruleIndex == 2 ; Collar
        Return DealO.GetStage() >= 2
    ElseIf ruleIndex == 3 ; Gag
        Return DealB.GetStage() >= 3
    ElseIf ruleIndex == 4 ; NP
        Return DealP.GetStage() >= 1
    ElseIf ruleIndex == 5 ; VP
        Return DealP.GetStage() >= 2
    ElseIf ruleIndex == 6 ; Naked
        Return DealH.GetStage() >= 2 || DealP.GetStage() >= 3
    ElseIf ruleIndex == 7 ; Whore armor, incompatible with H2+ S2+
        Return DealS.GetStage() >= 2 || DealH.GetStage() >= 2 || JacketRule > 1 || PetSuitInTownRule > 1
    ElseIf ruleIndex == 9 ; Boots
        Return DealB.GetStage() >= 2
    ElseIf ruleIndex == 10 ; Gloves
        Return DealB.GetStage() >= 2
    ElseIf ruleIndex == 11 ; PetSuit in town
        Return DealH.GetStage() >= 3 || BoundInTownRule > 1 || CrawlInTownRule > 1 || JacketRule > 1
    ElseIf ruleIndex == 12 ; Crawl in town
        Return DealH.GetStage() >= 3 || PetSuitInTownRule > 1 || BoundInTownRule > 1 || JacketRule > 1
    ElseIf ruleIndex == 13 ; Innkeeper in town 13 has no conflicts
        Return False
    ElseIf ruleIndex == 14 ; Bound in town
        Return DealH.GetStage() >= 3 || PetSuitInTownRule > 1 || CrawlInTownRule > 1 || JacketRule > 1
    ElseIf ruleIndex == 15 ; Merchant discount 15 has no conflicts
        Return False
    ElseIf ruleIndex == 16 ; Jacket in town
        Return DealH.GetStage() >= 3 || PetSuitInTownRule > 1 || BoundInTownRule > 1 || CrawlInTownRule > 1
    ElseIf ruleIndex == 19 ; Skooma
        Return 2 == GagRule || DealB.GetStage() >= 3
    ElseIf ruleIndex == 21 ; Spanking
        ; not sure about whether should disallow everything that would make the animations bad?
        Return DealH.GetStage() >= 3 || PetSuitInTownRule > 1 || BoundInTownRule > 1 || JacketRule > 1
    ElseIf ruleIndex == 22 ; Sex
        Return DealO.GetStage() >= 3 
    ElseIf ruleIndex == 23 ; Lactacid
        Return 2 == GagRule || DealB.GetStage() >= 3
    EndIf
    ; 17 expensive, is always non-conflicting
    ; 18 keys, is non-conflicting.
    ; 20 milking, mostly non-conflicting.
    ; 21 spanking, non-conflicting - though looks bad with most restraints.
    ; 24, 25, 26 ring, amulet, circlet are non-conflicting.

    Return False
EndFunction


; Returns True if the named (classic) deal and stage are open.
Bool Function IsClassicDealNoConflict(String dealName, Int stage)

    Debug.TraceConditional("DF - ICDNC " + dealName + " at " + stage, ShowDiagnostics)
    If "ownership" == dealName
        If 1 == stage && 2 == CuffsRule ; arm+leg cuffs
            Return False
        ElseIf 2 == stage && 2 == CollarRule ; collar
            Return False
        ElseIf stage >= 3 && DealS.GetStage() >= 3 && (2 == GagRule || DealB.GetStage() >= 3); chastity - conflicts with whore deal if gagged
            Return False
        EndIf
    ElseIf "bondage" == dealName
        ; 1 == corset
        If 2 == stage && (2 == BootsRule || 2 == GlovesRule) ; boots+gloves
            Return False
        ElseIf stage >= 3 && 2 == GagRule ; gag
            Return False
        EndIf
    ElseIf "piercing" == dealName
        If 1 == stage && 2 == NPRule ; nips
            Return False
        ElseIf 2 == stage && 2 == VPRule ; vaginal
            Return False
        ElseIf stage >= 3 && 2 == NakedRule ; naked to show piercings
            Return False
        EndIf
    ElseIf "slut" == dealName ; H ... this is special in that the level 4 variant does NOT bind hands.
        ; 1 == dialogs ... reluctantly allow gag rule and classic bondage rule, even though it's also a gag, as you can still speak, it's just hard.
        If 2 == stage && 2 == NakedRule ; naked in town
            Return False
        ElseIf stage == 3 && (2 == BoundInTownRule || 2 == JacketRule || 2 == PetSuitInTownRule || 2 == CrawlInTownRule) ; bound in town
            Return False
        ;ElseIf stage == 4
            ; nothing to do
        EndIf
    ElseIf "whore" == dealName ; S
        If 1 == stage && DealO.GetStage() >= 3 ; anal plug ... this is bad for classic ownership, but that's always been allowed. In fact, this entire rule is full of classic clashes :(
        ElseIf 2 == stage && (2 == WhoreRule) ; whore armor - doesn't REALLY clash with all the "in town" rules, because it still does things OUT of town.
            Return False
        ElseIf 3 >= stage && (2 == GagRule || DealB.GetStage() >= 3) && DealO.GetStage() >= 3 ; sign/whoring
            Return False
        EndIf
    EndIf
    
    Debug.TraceConditional("DF - ICDNC " + dealName + " at " + stage + " VALID", ShowDiagnostics)
    Return True
    
EndFunction


; End of adding deal functions

Int Function GetT1or2RulesAvailable()

    Int available = 0
    Int rr = 1
    While rr <= DealsBuilt
        If 1 == DealType[rr] && 0 != GetRuleState(rr)
            available += 1
        EndIf
        rr += 1
    EndWhile
    Return available
    
EndFunction

Int Function GetT3RulesAvailable()

    Int available = 0
    Int rr = 11 ; It's safe to start at 11, there are no type 1 deals below this, and any new deals will have higher indices
    While rr <= DealsBuilt
        If 2 == DealType[rr] && 0 != GetRuleState(rr)
            available += 1
        EndIf
        rr += 1
    EndWhile
    Return available
    
EndFunction

Bool Function HaveModularDeals()
    Return DealM1.GetStage() > 0 || DealM2.GetStage() > 0 || DealM3.GetStage() > 0 || DealM4.GetStage() > 0 || DealM5.GetStage() > 0
EndFunction

Bool Function IsDealTaken(Int index)
    Return GetRuleState(index) >= 2
EndFunction

Bool Function CheckDealEnabled(Int dealIndex) ; Indexed from 1 to 5
    If 1 == dealIndex
        Return 0 != (DealM1 as _MDDeal).Enabled
    ElseIf 2 == dealIndex
        Return 0 != (DealM2 as _MDDeal).Enabled
    ElseIf 3 == dealIndex
        Return 0 != (DealM3 as _MDDeal).Enabled
    ElseIf 4 == dealIndex
        Return 0 != (DealM4 as _MDDeal).Enabled
    ElseIf 5 == dealIndex
        Return 0 != (DealM5 as _MDDeal).Enabled
    EndIf
    Return False
EndFunction

Int Function GetMaxDealInUse()
    Int count = 0
    If (DealM1 as _MDDeal).GetStage() > 0
        count = 1
    EndIf
    If (DealM2 as _MDDeal).GetStage() > 0
        count = 2
    EndIf
    If (DealM3 as _MDDeal).GetStage() > 0
        count = 3
    EndIf
    If (DealM4 as _MDDeal).GetStage() > 0
        count = 4
    EndIf
    If (DealM5 as _MDDeal).GetStage() > 0
        count = 5
    EndIf
    Return count
EndFunction

Bool Function TryChangeModularDealEnables(Int newDealCount)
    ; Don't let the player reduce the number of modular DEALS (not rules) if it would disable an active deal.
    ; Return False if the attempted change is not allowed.
    ; Current enable count is in MaxModDealsSetting...
    
    If newDealCount >= MaxModDealsSetting
        MaxModDealsSetting = newDealCount
        EnableDeals()
        Return True
    EndIf
    
    ; Consider deal removal
    Int maxInUse = GetMaxDealInUse()
    If maxInUse > newDealCount
        ; Cannot change
        EnableDeals()
        Return False
    EndIf
        
    ; Can reduce deals
    MaxModDealsSetting = newDealCount
    EnableDeals()
    
    Return True
	
EndFunction

Function EnableDeals()

    (DealM1 as _MDDeal).Enabled = 0
    (DealM2 as _MDDeal).Enabled = 0
    (DealM3 as _MDDeal).Enabled = 0
    (DealM4 as _MDDeal).Enabled = 0
    (DealM5 as _MDDeal).Enabled = 0

    If MaxModDealsSetting >= 1
        (DealM1 as _MDDeal).Enabled = 1
    EndIf
    If MaxModDealsSetting >= 2
        (DealM2 as _MDDeal).Enabled = 1
    EndIf
    If MaxModDealsSetting >= 3
        (DealM3 as _MDDeal).Enabled = 1
    EndIf
    If MaxModDealsSetting >= 4
        (DealM4 as _MDDeal).Enabled = 1
    EndIf
    If MaxModDealsSetting >= 5
        (DealM5 as _MDDeal).Enabled = 1
    EndIf
EndFunction

Bool Function DisableRule(Int ruleIndex)
    ; Only called from MCM
    ; Returns False on error, True otherwise

    If GetRuleState(ruleIndex) < 2
        SetRule(ruleIndex, 0) ; Fix - only disable the rule if the Check PASSES!!!
        Return True
    else
        Return False
    EndIf
    
EndFunction

Bool Function EnableRule(Int ruleIndex)
    If 19 == ruleIndex ; Skooma Whore
        If IsSkoomaWhorePresent()
            SetRule(ruleIndex, 1)
            Return True
        Else
            Debug.Trace("DF - Skooma Whore missing")
        EndIf
        Return False
    ElseIf 20 == ruleIndex || 23 == ruleIndex; MME
        If IsMmePresent()
            SetRule(ruleIndex, 1)
            Return True
        Else
            Debug.Trace("DF - MME missing")
        EndIf
        Return False
    ElseIf 21 == ruleIndex
        If Tool.CheckSpanking()
            SetRule(ruleIndex, 1)
            Return True
        EndIf
        Return False
    EndIf

    SetRule(ruleIndex, 1)
    Return True
EndFunction


Function RemoveRule(Int ruleIndex)
    SetRule(ruleIndex, 1)
EndFunction


Function PauseAndSave()

    ; SAVE TIMERS !!!
    SaveTimers()

    ; Deals don't need to preserve much state because we won't reset or mess with them.
    ; They -do- save the days remaining in the deal.
    (DealM1 As _MDDeal).Save()
    (DealM2 As _MDDeal).Save()
    (DealM3 As _MDDeal).Save()
    (DealM4 As _MDDeal).Save()
    (DealM5 As _MDDeal).Save()

    ; Can't leave the deal flags set...
    RuleSave = New Int[27]
    RuleSave[1]  = CuffsRule
    RuleSave[2]  = CollarRule
    RuleSave[3]  = GagRule
    RuleSave[4]  = NPRule
    RuleSave[5]  = VPRule
    RuleSave[6]  = NakedRule
    RuleSave[7]  = WhoreRule 
    RuleSave[8]  = BlindFoldRule
    RuleSave[9]  = BootsRule
    RuleSave[10] = GlovesRule
    RuleSave[11] = PetSuitInTownRule
    RuleSave[12] = CrawlInTownRule
    RuleSave[13] = InnKeeperRule
    RuleSave[14] = BoundInTownRule
    RuleSave[15] = MerchantRule
    RuleSave[16] = JacketRule
    RuleSave[17] = ExpensiveRule
    RuleSave[18] = KeyRule
    RuleSave[19] = SkoomaRule
    RuleSave[20] = MilkingRule
    RuleSave[21] = SpankingRule
    RuleSave[22] = SexRule
    RuleSave[23] = LactacidRule
    RuleSave[24] = RingRule 
    RuleSave[25] = AmuletRule
    RuleSave[26] = CircletRule

    ; Need to save the extra rule timers.
    CuffsRule = 0
    CollarRule = 0
    GagRule = 0
    NPRule = 0
    VPRule = 0
    NakedRule = 0
    WhoreRule = 0
    BlindFoldRule = 0
    BootsRule = 0
    GlovesRule = 0
    PetSuitInTownRule = 0
    CrawlInTownRule = 0
    InnKeeperRule = 0
    BoundInTownRule = 0
    MerchantRule = 0
    JacketRule = 0
    ExpensiveRule = 0
    KeyRule = 0
    SkoomaRule = 0
    MilkingRule = 0
    SpankingRule = 0
    SexRule = 0
    LactacidRule = 0
    RingRule = 0
    AmuletRule = 0
    CircletRule = 0

    IsPaused = True

EndFunction

Function Resume()

    ; Correct the deal timers
    (DealM1 As _MDDeal).Restore()
    (DealM2 As _MDDeal).Restore()
    (DealM3 As _MDDeal).Restore()
    (DealM4 As _MDDeal).Restore()
    (DealM5 As _MDDeal).Restore()

    If RuleSave && RuleSave.Length >= 27
        CuffsRule  = RuleSave[1] 
        CollarRule = RuleSave[2] 
        GagRule    = RuleSave[3] 
        NPRule     = RuleSave[4] 
        VPRule     = RuleSave[5] 
        NakedRule  = RuleSave[6] 
        WhoreRule  = RuleSave[7] 
        BlindFoldRule     = RuleSave[8] 
        BootsRule         = RuleSave[9] 
        GlovesRule        = RuleSave[10]
        PetSuitInTownRule = RuleSave[11]
        CrawlInTownRule   = RuleSave[12]
        InnKeeperRule     = RuleSave[13]
        BoundInTownRule   = RuleSave[14]
        MerchantRule  = RuleSave[15]
        JacketRule    = RuleSave[16]
        ExpensiveRule = RuleSave[17]
        KeyRule       = RuleSave[18]
        SkoomaRule    = RuleSave[19]
        MilkingRule   = RuleSave[20]
        SpankingRule  = RuleSave[21]
        SexRule       = RuleSave[22]
        LactacidRule  = RuleSave[23]
        RingRule      = RuleSave[24]
        AmuletRule    = RuleSave[25]
        CircletRule   = RuleSave[26]
    EndIf

    RestoreTimers()
    KeySearchTimer = Utility.GetCurrentGameTime() + (1.0/24.0) ; An hour in the future - it's fine, this is just to stop it going off constantly

    IsPaused = False

EndFunction


Function SaveTimers()
    Float now = Utility.GetCurrentGameTime()
    PausedDailyDealTimerRemaining = _DFDailyDealTimer.GetValue() - now
    PausedInnKeeperInnKeeperDaysRemaining = InnKeeperRuleTimer - now
    PausedFastTravelTimerDaysRemaining = FastTravelTimer - now
    PausedMerchantRuleTimerDaysRemaining = MerchantRuleTimer - now
    PausedSexDealTimerDaysRemaining = SexDealTimer - now
    PausedSkoomaDealTimerDaysRemaining = SkoomaDealTimer - now
    LactacidDealTimerDaysRemaining = LactacidDealTimer - now
    MilkDealTimerDaysRemaining = MilkDealTimer - now
EndFunction

Function RestoreTimers()
    Float now = Utility.GetCurrentGameTime()
    _DFDailyDealTimer.SetValue( PausedDailyDealTimerRemaining + now )
    InnKeeperRuleTimer = PausedInnKeeperInnKeeperDaysRemaining + now
    FastTravelTimer = PausedFastTravelTimerDaysRemaining + now
    MerchantRuleTimer = PausedMerchantRuleTimerDaysRemaining + now
    SexDealTimer = PausedSexDealTimerDaysRemaining + now
    SkoomaDealTimer = PausedSkoomaDealTimerDaysRemaining + now
    LactacidDealTimer = LactacidDealTimerDaysRemaining + now
    MilkDealTimer = MilkDealTimerDaysRemaining + now
EndFunction


Function End()
    If DealM1.GetStage() > 0 
        (DealM1 as _MDDeal).End()
    EndIf
    DealM1.Reset()
    If DealM2.GetStage() > 0 
        (DealM2 as _MDDeal).End()
    EndIf
    DealM2.Reset()
    If DealM3.GetStage() > 0 
        (DealM3 as _MDDeal).End()
    EndIf
    DealM3.Reset()
    If DealM4.GetStage() > 0 
        (DealM4 as _MDDeal).End()
    EndIf
    DealM4.Reset()
    If DealM5.GetStage() > 0 
        (DealM5 as _MDDeal).End()
    EndIf
    DealM5.Reset()
EndFunction


; Disable rules for mods that don't exist
Function CheckExternalDeals()
    
    Bool haveMme = IsMmePresent()
    Bool haveSkoomaWhore = IsSkoomaWhorePresent()

    If 2 != LactacidRule && 0.0 == haveMme
        LactacidRule = 0
    EndIf
    
    If 2 != MilkingRule && 0.0 == haveMme
        MilkingRule = 0
    EndIf
    
    If 2 != SkoomaRule && 0.0 == haveSkoomaWhore
        SkoomaRule = 0
    EndIf
    
EndFunction


;
;Functions below related to content and testing.
;

; This is called periodically to review whether the player is keeping up with their requests.
; Called from QF__Gift_09000D62.DebtInc() and from SetStage()
; Can also be triggered from time check dialogs.
Function CheckAndClearDealRequests()

    Float dealTime = _DFDailyDealTimer.GetValue()
    Float now = Utility.GetCurrentGameTime()
    
    ; Actual update period is regulated by _DFDailyDealTimer ... once per day at most
    If now - dealTime < 1.0 ; If at least one day hasn't passed yet, don't update.
        Return
    EndIf

    ; Update timer so we won't run for another day.
    _DFDailyDealTimer.SetValue(now)

    Int defaultDays = (now - dealTime) As Int
    If defaultDays < 1
        defaultDays = 1
    ElseIf defaultDays > 2
        defaultDays = 2
    EndIf
    

    Bool haveMme = (0.0 != _DFModMmePresent.GetValue())
    Bool haveSkoomaWhore = (0.0 != _DFModSkoomaWhorePresent.GetValue())

    Int spankDealRequests = _DFSpankDealRequests.GetValue() As Int
    
    ; Must provide at least one spanking in the period.
    If 2 == SpankingRule && spankDealRequests <= 0
        SpankDealDefaults += defaultDays
    EndIf
    _DFSpankDealRequests.SetValue(0.0)

    If 2 == SexRule && SexDealRequests <= 0
        SexDealDefaults += defaultDays
    EndIf
    SexDealRequests = 0

    ; Must drink at least 3 skooma in the period.
    Int skoomaPerDay = 3
    Int expectedSkooma = defaultDays * skoomaPerDay
    If haveSkoomaWhore && 2 == SkoomaRule && SkoomaDealRequests < expectedSkooma
        SkoomaDealDefaults += (expectedSkooma - SkoomaDealRequests + skoomaPerDay - 1) / skoomaPerDay
    EndIf
    SkoomaDealRequests = 0
    
    ; Must drinks at least one lactacid in the period.
    If haveMme && 2 == LactacidRule && LactacidDealRequests < defaultDays
        LactacidDealDefaults += (defaultDays - LactacidDealRequests)
    EndIf
    LactacidDealRequests = 0

    ; Must provide at least one milking in the period.
    If haveMme && 2 == MilkingRule && MilkDealRequests < defaultDays
        MilkDealDefaults += (defaultDays - MilkDealRequests)
    EndIf
    MilkDealRequests = 0

EndFunction

; Called from dialogs to update on demand.
; 0 = no timed deals, 1 = lots of time, 2 = some time, 3 = almost out of time, 4 = failed previous, have defaulted deals
Function UpdateTimerStatusCondition()

    CheckAndClearDealRequests()

    If 2 == SpankingRule && SpankDealDefaults > 0 \
        || 2 == SexRule && SexDealDefaults > 0 \
        || 2 == SkoomaRule && SkoomaDealDefaults > 0 \
        || 2 == LactacidRule && LactacidDealDefaults > 0 \
        || 2 == MilkingRule && MilkDealDefaults > 0
        TimerStatus = 4
        Return
    EndIf
    
    If 2 != SpankingRule && 2 != SexRule && 2 != SkoomaRule && 2 != LactacidRule && 2 != MilkingRule
        TimerStatus = 0
        Return
    EndIf

    Float dealTime = _DFDailyDealTimer.GetValue()
    Float now = Utility.GetCurrentGameTime()
    
    Float days = now - dealTime
    
    Float daysLeft = 1.0 - days

    If daysLeft <= 0.02 ; half an hour
        TimerStatus = 0 ; Almost no time left, or should have been handled by CheckAndClearDealRequests() - right on the edge - refuse to discuss this topic.
    ElseIf daysLeft > 0.5
        TimerStatus = 1 ; lots
    ElseIf daysLeft > 0.125
        TimerStatus = 2 ; some
    Else
        TimerStatus = 3 ; almost out
    EndIf

EndFunction    


Function PunishSpankDealDefaults()
    If 2 == SpankingRule && SpankDealDefaults > 0
        Tool.AddPunishmentDebt(SpankDealDefaults)
    EndIf
    SpankDealDefaults = 0
EndFunction

Function PunishSexDealDefaults()
    If 2 == SexRule && SexDealDefaults > 0
        Tool.AddPunishmentDebt(SexDealDefaults)
    EndIf
    SexDealDefaults = 0
EndFunction

Function PunishSkoomaDealDefaults()
    If 2 == SkoomaRule && SkoomaDealDefaults > 0
        Tool.AddPunishmentDebt(SkoomaDealDefaults)
    EndIf
    SkoomaDealDefaults = 0
EndFunction

Function PunishLactacidDealDefaults()
    If 2 == LactacidRule && LactacidDealDefaults > 0
        Tool.AddPunishmentDebt(LactacidDealDefaults)
    EndIf
    LactacidDealDefaults = 0
EndFunction

Function PunishMilkDealDefaults()
    If  2 == MilkingRule && MilkDealDefaults > 0
        Tool.AddPunishmentDebt(MilkDealDefaults)
        DrinkLactacid(2)
    EndIf
    MilkDealDefaults = 0
EndFunction

Function PunishAllDefaults()
    PunishSpankDealDefaults()
    PunishSexDealDefaults()
    PunishSkoomaDealDefaults()
    PunishLactacidDealDefaults()
    PunishMilkDealDefaults()
EndFunction


Function SkipSexWithPlayer(Actor who)
    Tool.ReduceResistFloat(3.0)
    SexDealTimer = Utility.GetCurrentGameTime() + (1.0 / 24.0)
    SexDealRequests += 1
EndFunction

Function SexWithPlayer(Actor who, Bool isRape = False)
    Tool.ReduceResistFloat(2.0)
    SexDealTimer = Utility.GetCurrentGameTime() + (1.0 / 24.0)
    SexDealRequests += 1
    If isRape
        Tool.SingleRape(who)
    Else
        Tool.SingleSex(who)
    EndIf
EndFunction


Function DrinkSkooma()
    DelayGag()

    Tool.ReduceResistFloat(1.0)
    SkoomaDealTimer = Utility.GetCurrentGameTime() + (0.5 / 24.0)
    SkoomaDealRequests += 1

    Bool haveSkoomaWhore = (0.0 != _DFModSkoomaWhorePresent.GetValue())
    If haveSkoomaWhore
        ; Pick a random nasty skooma
        Form[] addictiveSkoomas = _DF_SkoomaWhore.GetAddictiveSkoomas()
        Int selected = Utility.RandomInt(1, addictiveSkoomas.Length) - 1
        Potion skooma = addictiveSkoomas[selected] As Potion
        
        If skooma
            PlayerRef.AddItem(skooma, 1, True)
            PlayerRef.EquipItem(skooma)
        EndIf
    EndIf

EndFunction

Function DrinkSkoomaRejected()
    Tool.ReduceResistFloat(5.0)
    SkoomaDealRequests += 1
EndFunction


Function DrinkLactacid(Int amount = 1)
    DelayGag()

    LactacidDealTimer = Utility.GetCurrentGameTime() + (4.0 / 24.0)
    LactacidDealRequests += 1
    
    ; Weak willed PCs make good cows
    If _DWill.GetValue() <= 3.0 && Utility.RandomInt(0, 1) == 1
        amount += 1
    EndIf
    
    ; Get that cow producing!
    If MilkingRule == 2.0 && Utility.RandomInt(0, 1) == 1
        amount += 1
    EndIf
    
    Tool.ReduceResistFloat(amount As Float)

    Bool haveMme = (0.0 != _DFModMmePresent.GetValue())
    If haveMme
        Potion lactacid = GetLactacid()
        If lactacid
            While amount > 0
                amount -= 1
                PlayerRef.AddItem(lactacid, 1, True)
                PlayerRef.EquipItem(lactacid)
                If amount > 0
                    Utility.Wait(1.0)
                EndIf
            EndWhile
                
        EndIf
    Else
        Debug.Notification("Lactacid ERROR - MME not present?")
    EndIf

EndFunction

Function DrinkLactacidRejected()
    Tool.ReduceResistFloat(5.0)
    LactacidDealRequests += 1
EndFunction


Function HandOverKeys(Actor who)
    Tool.ReduceResistFloat(1.0)
EndFunction

Function SearchForKeys(Actor who)
    ; Only works for the player right now...
    CheckAndRemoveDealKeys()
EndFunction
    
    
Function MilkingDone(Int bottlesProduced)

    If 2 == MilkingRule
        Debug.Notification("$DF_MILKING_NOTICE")
        Tool.ReduceResistFloat(1.0)
        If bottlesProduced < 1
            Debug.Notification("$DF_MILKING_NO_MILKS")
        ElseIf 1 == bottlesProduced
            Debug.Notification("$DF_MILKING_ONE_MILK")
        Else
            Debug.Notification("You produced " + bottlesProduced + " milk bottles like a good cow.")
        EndIf
        
        If bottlesProduced > 0 && MoveMilkBottles()
            Debug.Notification("$DF_MILKING_FOLLOWER_DRINKS")
            MilkDealTimer = Utility.GetCurrentGameTime() + 1.0 ; This isn't actually used for anything at the moment...
            MilkDealRequests += 1
        EndIf
    EndIf

EndFunction


Bool Function MoveMilkBottles()

    Actor who = PlayerRef
    
    If _DFMilkBarrel != (StorageUtil.GetFormValue(who, "MME_MilkBarrel_Override") As ObjectReference)
        Debug.Notification("Milking ERROR - MilkBarrel was stolen!")
        ; We know the player met other requirements, so skipping this is't a complete freebie.
        Return True
    EndIf
    
    Int iFormIndex = _DFMilkBarrel.GetNumItems()
    
    Bool found = False
    
    While iFormIndex > 0
        iFormIndex -= 1
        Form kForm = _DFMilkBarrel.GetNthForm(iFormIndex)
        If kForm
            Int count = _DFMilkBarrel.GetItemCount(kForm)
            
            If !found && kForm.HasKeyWord(MME_Milk) && kForm.HasKeyWord(VendorItemFood)
                
                _DFMilkBarrel.RemoveItem(kForm, 1, True) ; Destroy one item
                Debug.Notification("$DF_MILKING_BOTTLE_TAKEN")
                found = True
                
                If count > 1
                    _DFMilkBarrel.Removeitem(kForm, count - 1, True, who) ; Move remaining milk to the player
                EndIf
                
            Else
                ; Move everything else to player.
                _DFMilkBarrel.Removeitem(kForm, count, True, who)
            EndIf
        EndIf
    EndWhile
    
    Return found

EndFunction


; Support without updates to MME - fails if gagged and can steal the wrong kind of milk.
Bool Function RemoveMilkBottle()

    MME_Milk = _DF_mme.GetMilkKeyword()
    
    Actor who = PlayerRef
    Int iFormIndex = who.GetNumItems()
    While iFormIndex > 0
        iFormIndex -= 1
        Form kForm = who.GetNthForm(iFormIndex)
        
        If kForm.HasKeyWord(MME_Milk) && kForm.HasKeyWord(VendorItemFood)
            ;Int count = who.GetItemCount(kForm)
            who.Removeitem(kForm, 1, True)
            Debug.Notification("$DF_MILKING_BOTTLE_TAKEN")
            Return True
        EndIf

    EndWhile
    
    Return False
    
EndFunction


Function SetAliasForScene(Actor Akactor1 = none, Actor Akactor2 = none)
    SexDealTimer = Utility.GetCurrentGameTime() + (1.0 / 24.0)
    Tool.PlacePCNearPlayer()
    You.ForceRefTo(Tool.PC)
    Follower.ForceRefTo(Tool.Follower.GetActorReference())
    If Akactor1
        Actor1.ForceRefTo(Akactor1)
    EndIf
EndFunction


Function StartInnScene()
    game.setplayeraidriven(true)
    Tool.PauseAll()
    Tool.PlacePCNearPlayer()
    Tool.SceneErrorCatchandPlay(InnScene, 30)
    Tool.ResumeAll()
    game.setplayeraidriven(False)
    Tool.PC.Disable()
EndFunction

Function StartMerchantScene()
    Tool.PauseAll()
    game.setplayeraidriven(true)
    Tool.PlacePCNearPlayer()
    Tool.SceneErrorCatchandPlay(MerchantScene, 30)
    game.setplayeraidriven(false)
    Tool.ResumeAll()
    Tool.PC.Disable()
EndFunction



Function InnOutcome()

	Tool.PauseAll()
	If InnKeeperRule == 3 ; Oral
		Tool.SexOral(Actor1.GetActorReference())
	ElseIf InnKeeperRule == 4 ; Sex
		Tool.Sex(Actor1.GetActorReference())
	ElseIf InnKeeperRule == 5 ; Group sex
		Tool.Rapetime()
	ElseIf InnKeeperRule == 6 ; Dog sex
		Tool.Dog.Enable()
		Tool.Dog.MoveTo(PlayerRef)
		Tool.Sex(Tool.Dog)
		Utility.wait(10)
		While Tool.libs.IsAnimating(Tool.playerref)
			Utility.wait(4)
		EndWhile
		Tool.Dog.Disable()
	EndIf
	InnKeeperRule = 2
	InnKeeperRuleTimer = Utility.GetCurrentGameTime() + TimerSetting
	Tool.ResumeAll()
    
EndFunction

Function MerchantOutcome()

	Tool.PauseAll()
	If MerchantRule == 3 ; Oral 
		Tool.SexOral(Actor1.GetActorReference())
	ElseIf MerchantRule == 4 ; Sex
		Tool.Sex(Actor1.GetActorReference())
	ElseIf MerchantRule == 5 ; Dog sex
		Tool.Dog.Enable()
		Tool.Dog.MoveTo(PlayerRef)
		Tool.Sex(Tool.Dog)
		Utility.wait(10)
		While Tool.libs.IsAnimating(Tool.playerref)
			Utility.wait(4)
		EndWhile
		Tool.Dog.Disable()
	EndIf
	MerchantRule = 2
	MerchantRuleTimer = Utility.GetCurrentGameTime() + TimerSetting
	Tool.ResumeAll()
    
EndFunction

Function FastTravelTimerStart()
	FastTravelTimer = Utility.GetCurrentGameTime() + 0.04 ; slightly less than an hour
EndFunction

Function CheckTrigger(Int RuleCode)

    If (DealM1 as _MDDeal).GetRule3() == RuleCode
        (DealM1 as _MDDeal).Triggered = True 
    EndIf
    If (DealM2 as _MDDeal).GetRule3() == RuleCode
        (DealM2 as _MDDeal).Triggered = True 
    EndIf
    If (DealM3 as _MDDeal).GetRule3() == RuleCode
        (DealM3 as _MDDeal).Triggered = True 
    EndIf
    If (DealM4 as _MDDeal).GetRule3() == RuleCode
        (DealM4 as _MDDeal).Triggered = True 
    EndIf
    If (DealM5 as _MDDeal).GetRule3() == RuleCode
        (DealM5 as _MDDeal).Triggered = True 
    EndIf

EndFunction

Function Test()
	setT1or2rule()
	setT1or2rule()
	setT1or2rule()
	Int Output = setT3rule()
	Debug.Notification(Output)
EndFunction

Potion Function GetLeafSkooma()
    If 255 != Game.GetModByName("SexLabSkoomaWhore.esp")
        Potion shouldBeSkooma = _DF_SkoomaWhore.GetLeafSkooma() As Potion
        If shouldBeSkooma
            Return shouldBeSkooma As Potion
        EndIf
    EndIf
    ; Return vanilla skooma instead
    Return Game.GetForm(0x00057A7A) As Potion
EndFunction
    
Potion Function GetLactacid()
    If 255 != Game.GetModByName("MilkModNEW.esp")
        Potion shouldBeLactacid = _DF_mme.GetLactacid() As Potion
        If shouldBeLactacid
            Return shouldBeLactacid As Potion
        EndIf
    EndIf
    ; Could return a built-in replacement here.
    Return None
EndFunction



; PC actively offers the keys.
Function GiveKeys()

    Actor followerActor = follower.GetActorReference()
    If Tool.CheckAndRemoveKeys(followerActor, _DFKeyContainer)
        Debug.Notification("$DF_KEYS_ALL_TAKEN")
        Tool.ReduceResistFloat(1.0)
        KeySearchTimer = Utility.GetCurrentGameTime() + (1.0/24.0)
    EndIf
    
    ForceKeyCheck = False
    AllowPretendKeyCheck = 0.0
    _DFEnableKeySearchGreeter.SetValue(0.0)
    ; Discard anything added while we were handling this, it's too confusing for the player otherwise.
    StorageUtil.FormListClear(PlayerRef, "DF_KeyRuleInventoryAddList")

EndFunction


; Called from the forcegreet dialog to remove keys.
Function CheckAndRemoveDealKeys()

    KeySearchTimer = Utility.GetCurrentGameTime() + (1.0/24.0)
    
    ForceKeyCheck = False
    AllowPretendKeyCheck = 0.0
    _DFEnableKeySearchGreeter.SetValue(0.0) ; Disable the package
    ; Discard anything added while we were handling this, it's too confusing for the player otherwise.
    StorageUtil.FormListClear(PlayerRef, "DF_KeyRuleInventoryAddList")
    
    Actor followerActor = follower.GetActorReference()

    If Tool.CheckAndRemoveKeys(followerActor, _DFKeyContainer)
        ; Naughty player must be punished ...
        Tool.AddPunishmentDebt()
        
    EndIf
    
    If followerActor
        followerActor.EvaluatePackage()
    EndIf

    AllowPretendKeyCheck = 0.0 ; to be sure, to be sure
    
EndFunction

; Called by the 'fake' key check... There's probably no point keeping the actual check in here.
Function FakeKeyCheck()
    AllowPretendKeyCheck = 0.0
EndFunction


; Called periodically from _Dtick, always.
Function CheckKeyDealTrigger()

    Actor followerActor = SetFollowerAlias()
    
    If 2 != KeyRule
        ForceKeyCheck = False
        AllowPretendKeyCheck = 0.0
        _DFEnableKeySearchGreeter.SetValue(0.0)
        ; Discard anything added in here unless the KeyRule is in force.
        StorageUtil.FormListClear(PlayerRef, "DF_KeyRuleInventoryAddList")
        Return
    EndIf
    
    Float now = Utility.GetCurrentGameTime()
    
    ; Check for key flags in the list and clear it. If a key is found, force an eventual key check...
    If ScanListForKeys()
    
        KeySearchTimer = now + (0.1/24.0) ; Give the player a short time to hand over the keys before check enabled.
        ForceKeyCheck = True
        
    ElseIf KeySearchTimer < now ; Timer has elapsed...
    
        Actor playerActor = PlayerRef
        
        If playerActor.IsInCombat() || playerActor.IsArrested() || !followerActor.Is3DLoaded() || !playerActor.HasLOS(followerActor) || playerActor.GetDistance(followerActor) > 500.0 \
            || followerActor.IsInDialogueWithPlayer() || followerActor.IsDoingFavor() || _DFlowAnimation.IsInvalidAnimationActor(playerActor) 
            ; Do nothing this time around
            ; will check again next time...
        ElseIf ForceKeyCheck
            ; We could enter this several times if the package is not starting... The flag is only cleared if the package runs and searches.
            
            ; Trigger a force-greet search
            _DFEnableKeySearchGreeter.SetValue(1.0) ; this enables the package
            followerActor.EvaluatePackage()
        Else
            ; If timer elapsed without key detection there's no need to check ...
            ; Flag the follower to spam the player with a harmless HELLO message and 
            ; set next search to some significant time in the future, varying based on location.
            AllowPretendKeyCheck = 1.0
            
            Float checkIntervalHours = 12.0
            Location loc = PlayerRef.GetCurrentLocation()
            
            If loc.HasKeyword(Tool.LocTypeInn)
                checkIntervalHours = 1.0
            ElseIf loc.HasKeyword(Tool.LocTypeDwelling)
                checkIntervalHours = 2.0
            ElseIf loc.HasKeyword(Tool.LocTypeCity)
                checkIntervalHours = 3.0
            ElseIf loc.HasKeyword(Tool.LocTypeHold)
                checkIntervalHours = 4.0
            ElseIf loc.HasKeyword(Tool.LocTypeBanditCamp)
                checkIntervalHours = 6.0
            ElseIf loc.HasKeyword(Tool.LocTypeDungeon)
                checkIntervalHours = 8.0
            EndIf

            KeySearchTimer = now + (checkIntervalHours/ 24.0)
            Int realMins = (checkIntervalHours * 3) As Int
        EndIf
        
    EndIf

EndFunction

Bool Function ScanListForKeys()

    ; This relies on support for arrays over 128 elements ... here's hoping that works reliably ...
    ; There are other ways, but more complex, and potentially getting into territory where a StorageUtil bug might manifest.
    ; (And they do exist).
    ; Alas there is no way to "get and clear" a list as an atomic operation, so we can always miss items ... kind of super rare though ... probably.
    ; For keys checks, this is OK. For other scenarios you'd have to pluck one by one to be sure you got everything.
    Form[] itemList = StorageUtil.FormListToArray(PlayerRef, "DF_KeyRuleInventoryAddList")
    StorageUtil.FormListClear(PlayerRef, "DF_KeyRuleInventoryAddList")

    Int ii = itemList.Length
    
    ; If there are a lot of items, instead of wasting time scanning this list, force the follower to do a search of the actual inventory.
    ; They must have seen the player pick up so much stuff that a search is perfectly reasonable.
    If ii > 126
        Return True
    EndIf
    
    While ii
        ii -= 1
        Form addedItem = itemList[ii]
        If addedItem.HasKeyword(ddRestraintsKey) || addedItem.HasKeyword(ddChastityKey) || addedItem.HasKeyword(ddPiercingKey)
            Return True
        EndIf
    EndWhile

    Return False

EndFunction

Actor Function SetFollowerAlias()

    Actor who = Tool.Follower.GetActorReference()
    If Follower.GetActorReference() != who
        Follower.ForceRefTo(who)
    EndIf
    Return who

EndFunction
