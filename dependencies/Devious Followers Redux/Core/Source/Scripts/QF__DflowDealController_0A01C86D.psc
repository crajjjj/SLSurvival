;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname QF__DflowDealController_0A01C86D Extends Quest Conditional

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
SetStage(1)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

; _DflowDealMulti
; Premature deal removal cost multiplier as a percentage. Scales up cost of deal removal before it's standard duration has elapsed.
; Set to 0 to disable.
; CostIncrease = This x DaysAheadOfSchedule x DebtCost / 100
; Ranges from 0 to 2000 => 0.0 to +20.0, 0.0 does nothing

String buyoutDeal
MiscObject Property Gold Auto
Bool Property Cancelled Auto Hidden Conditional

GlobalVariable Property _DFBuyout Auto

GlobalVariable Property StatusDisabled Auto
GlobalVariable Property StatusEnabled Auto
GlobalVariable Property StatusSelected Auto
GlobalVariable Property StatusActive Auto

Function ShowBuyoutMenu()
    buyoutDeal = DealManager.ShowBuyoutMenu()
    Debug.Trace("DF - Menu Opened - Selected " + buyoutDeal)
    _DFBuyout.SetValue(DealManager.GetDealCost(buyoutDeal))
    Cancelled = buyoutDeal == ""
EndFunction

Function HandleBuyout()
    Debug.Trace("DF - Buyout STARTED - " + buyoutDeal)
    string[] rules = DealManager.GetDealRules(buyoutDeal)
    Debug.Trace("DF - Buyout Rules - " + rules)
    int i = 0
    while i < rules.length
        Debug.Trace("DF - Stopping rule - " + rules[i])
        _DFRuleTemplate rule = DealManager.GetRuleScript(rules[i]) as _DFRuleTemplate
        rule.InternalStop()
        i += 1
    endWhile

    Deals -= rules.Length
    if rules.length == 3
        DealsMax -= 1
    endIf

    DealManager.RemoveDeal(buyoutDeal)
    PlayerRef.RemoveItem(Gold, _DFBuyout.GetValue() as int)

    Debug.Trace("DF - Buyout ENDED - " + buyoutDeal)
EndFunction

; Called by all deals, including modular deals, when a deal is added OR removed.
; The parameter is always 1 for Add
; The parameter is always -1 for Remove
Function DealAdd(Int a)
    
    Deals += a
    
    Debug.Trace("DF - DealAdd - " + Deals)

    ; Reduce boredom and reset the debt penalty accumulator when deals added.
    If a > 0
        Tool.ReduceBoredom()
    EndIf
    
    ; Reduce fatigue when deals are removed
    If a < 0
        Float fatigueValue = _DFFatigue.GetValue()
        Float fatigueDelta = _DFFatigueRate.GetValue()
        Float dealDays = _DflowDealBaseDays.GetValue()
        ; Add fatigue when deal gained.
        fatigueValue += fatigueDelta * (dealDays + 1.0) * (a As Float)
        
        If fatigueValue < 0.0
            fatigueValue = 0.0
        EndIf
        
        _DFFatigue.SetValue(fatigueValue)
    EndIf
        
EndFunction

; Called to add or remove 'maxed out' deals.
Function DealMaxAdd(Int a)
    DealsMax += a
EndFunction

Function Res()
    DealsMax = 0
    Deals = 0 
EndFunction

Function AddRndDay()
    string dealQ = DealManager.GetRandomDeal()
    if dealQ
        DealManager.ExtendDeal(dealQ, 1.0)
        Debug.Notification("$DFDEALDAYINC")
    endIf
EndFunction

Function ResetAllDeals()
    DealManager.ResetAllDeals()
    
    Deals = 0
    DealsMax = 0 ; Not the max deals but the number of maxed-out deals.
EndFunction

Function AddRandomDeal()

	string added = (UberController As _DFDealUberController).AddDeal()

	If added < 1 && Deals > 0
        AddRndDay()
        AddRndDay()
        AddRndDay()
    EndIf

EndFunction

Function RemoveDeviceByIndex(Int index)

    _DUtil.Notify("Remove Device Index " + index)

    Actor who = libs.playerref
    Keyword kw
    
    If 1 == index
        Debug.Notification("$DF_REMOVE_MSG_BLINDFOLD")
        kw = libs.zad_DeviousBlindfold
    ElseIf 2 == index
        Debug.Notification("$DF_REMOVE_MSG_BOOTS")
        kw = libs.zad_DeviousBoots
    ElseIf 3 == index
        Debug.Notification("$DF_REMOVE_MSG_GAG")
        kw = libs.zad_DeviousGag
    ElseIf 4 == index
        Debug.Notification("$DF_REMOVE_MSG_HEAVY")
        kw = libs.zad_DeviousHeavyBondage
    ElseIf 5 == index
        Debug.Notification("$DF_REMOVE_MSG_MITTENS")
        kw = libs.zad_DeviousBondageMittens
    ElseIf 6 == index
        Debug.Notification("$DF_REMOVE_MSG_COLLAR")
        kw = libs.zad_DeviousCollar
    ElseIf 7 == index
        Debug.Notification("$DF_REMOVE_MSG_GLOVES")
        kw = libs.zad_DeviousGloves
    EndIf
        
    If kw
        Armor deviceI = StorageUtil.GetFormValue(who, "zad_Equipped" + libs.LookupDeviceType(kw) + "_Inventory") As Armor
        
        If deviceI && !deviceI.HasKeyword(Libs.zad_QuestItem)
            Armor deviceR = libs.GetRenderedDevice(deviceI)
            libs.RemoveDevice(who, deviceI, deviceR, kw)
            who.Removeitem(deviceI, 1, True)
        EndIf
    EndIf
    
EndFunction

Function PickRandomDeal()
    Debug.Trace("DF - PickRandomDeal - start")

    NewDeal = (UberController As _DFDealUberController).GetPotentialDeal()

    Debug.Trace("DF - PickRandomDeal - NewDeal - " + NewDeal)
EndFunction

Function PickAnyRandomDeal()
    Debug.Trace("DF - PickAnyRandomDeal")
    (UberController As _DFDealUberController).RejectedDeal = ""
    PickRandomDeal()
EndFunction

Function AcceptPendingDeal()

    Debug.Trace("DF - AcceptPendingDeal - NewDeal " + NewDeal + ", DealOffering " + DealOffering)

    (UberController As _DFDealUberController).AddDealById(NewDeal)
    
    ; Select the next deal ... well in advance.
    PickRandomDeal()

    Debug.Trace("DF - AcceptPendingDeal - end")

EndFunction

Function RejectPendingDeal()

    Debug.Trace("DF - RejectPendingDeal - NewDeal " + NewDeal + ", DealOffering " + DealOffering)
    (UberController As _DFDealUberController).RejectDeal(NewDeal)
    
    ; Select the next deal ... well in advance.
    PickRandomDeal()
    
    Debug.Trace("DF - RejectPendingDeal - end")

EndFunction


_LDC property LDC auto
GlobalVariable Property _DflowDealBasePrice Auto ; The buyout cost
GlobalVariable Property _DflowDealBaseDebt Auto ; The relief amount
GlobalVariable Property _DflowDealMulti Auto
GlobalVariable Property _DflowDealBaseDays Auto
GlobalVariable Property _DflowDealOP Auto
GlobalVariable Property _DflowDealHP Auto
GlobalVariable Property _DflowDealBP Auto
GlobalVariable Property _DflowDealPP Auto
GlobalVariable Property _DflowDealSP Auto
GlobalVariable Property _DflowDealM1P Auto
GlobalVariable Property _DflowDealM2P Auto
GlobalVariable Property _DflowDealM3P Auto
GlobalVariable Property _DflowDealM4P Auto
GlobalVariable Property _DflowDealM5P Auto
GlobalVariable Property _DflowDealSPTimer Auto
GlobalVariable Property _DflowDealPPTimer Auto
GlobalVariable Property _DflowDealOPTimer Auto
GlobalVariable Property _DflowDealHPTimer Auto
GlobalVariable Property _DflowDealBPTimer Auto 
GlobalVariable Property _DflowDealM1PTimer Auto
GlobalVariable Property _DflowDealM2PTimer Auto
GlobalVariable Property _DflowDealM3PTimer Auto
GlobalVariable Property _DflowDealM4PTimer Auto
GlobalVariable Property _DflowDealM5PTimer Auto
GlobalVariable Property GameDaysPassed Auto
GlobalVariable Property _DFCostScale Auto
GlobalVariable Property _DFFatigue Auto
GlobalVariable Property _DFFatigueRate Auto
GlobalVariable Property _DflowDebtPerDay Auto
GlobalVariable Property _DflowExpensiveDebts Auto
GlobalVariable Property _DFDeepDebtDifficulty Auto

Quest Property UberController Auto
Quest Property DealO  Auto 
Quest Property DealB  Auto 
Quest Property DealH  Auto 
Quest Property DealP  Auto 
Quest Property DealSQ  Auto 
Quest Property DealM1 Auto 
Quest Property DealM2 Auto 
Quest Property DealM3 Auto 
Quest Property DealM4 Auto 
Quest Property DealM5 Auto 
Message Property msg  Auto  
_DFTools Property Tool Auto

Int Property Deals = 0 Auto  Conditional
Int Property DealsMax = 0 Auto  Conditional ; Number of maxed out deals.

Int Property DealOMax  Auto
Bool Property DealO1 Auto
Bool Property DealO2 Auto

Int Property DealBMax  Auto
Bool Property DealB1 Auto
Bool Property DealB2 Auto

Int Property DealHMax  Auto
Bool Property DealH1 Auto
Bool Property DealH2 Auto

Int Property DealPMax  Auto
Int Property DealSQMax  Auto 

; The full ID of the new deal (e.g. each modular deal+rule combination is unique)
String Property NewDeal Auto Hidden
; The de-duplicated ID of the new deal (e.g. modular deals have 1XX values matching the shared rule)
Int Property DealOffering Auto Conditional

Actor Property PlayerRef Auto
Armor Property Item1 Auto
Armor Property Item1r Auto
ZadLibs Property libs Auto

Float Property DealBias = 50.0 Auto
Float Property DealDebtRelief Auto
Float Property DealBuyoutPrice Auto
Float Property DealEarlyOutPrice Auto

Float Property ExpensiveDebtCount Auto


Float SPTimer = 0.0
Float PPTimer = 0.0
Float OPTimer = 0.0
Float HPTimer = 0.0
Float BPTimer = 0.0
Float M1Timer = 0.0
Float M2Timer = 0.0
Float M3Timer = 0.0
Float M4Timer = 0.0
Float M5Timer = 0.0

