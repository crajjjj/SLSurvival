Scriptname _DFDealUberController extends Quest  

; Binds classic and modular deals together into a single system.
; Now we can ask for a random deal and it will be identified by a unique ID that can be used to apply it.

; FOLDSTART - IDs
; If the ID is >= 100, then it's a deal specific modular rule, bound to a specific modular deal M1 = 100, M2 = 200, etc.
; If the ID is < 100, then it's a classic deal.
; _DflowDealB => Bondage Deal  -  01 corset,            02 boots+gloves,     03 gag,                  04 tape-gag, (103+ forcegreets occur), (104 tape-gag forcegreets occur)
; _DflowDealH => Slut Deal     -  11 speech,            12 naked in town,    13 bound-hands in town,  14 cum layers (Hellos in _DflowDealH)
; _DflowDealO => Ownership     -  21 arm+leg cuffs,     22 collar,           23 chastity belt,        24 chastity belt with once-per-day
; _DflowDealP => Piercings     -  31 nipple-piercings,  32 pussy-piercings,  33 must be naked while talking (forcegreets occur)
; _DflowDealS => Sign?         -  41 anal-plug,         42 whore-armor,      43 sign

; Add the base for the modular deal (100 bear, 200 wolf, 300 dragon, 400 skeever, 500 slaughterfish) to this ID to get the ID for a modular deal.
;  0 NoDeal                -
;  1 CuffsRule             L1+2
;  2 CollarRule            L1+2
;  3 GagRule               L1+2
;  4 NPRule                L1+2 nipple piercing
;  5 VPRule                L1+2 vaginal piercing
;  6 NakedRule             L1+2
;  7 WhoreRule             L1+2 whore armor
;  8 BlindFoldRule         L1+2
;  9 BootsRule             L1+2
; 10 GlovesRule            L1+2
; 11 PetSuitInTownRule     L3
; 12 CrawlInTownRule       L3
; 13 InnKeeperRule         L3
; 14 BoundInTownRule       L3
; 15 MerchantRule          L3
; 16 JacketRule            L3
; 17 ExpensiveRule         L1+2+3
; 18 KeyRule               L3
; 19 SkoomaRule            L3
; 20 MilkingRule           L3
; 21 SpankRule             L1+2
; 22 SexRule               L1+2
; 23 LactacidRule          L1+2
; 24 RingRule              L1+2
; 25 AmuletRule            L1+2
; 26 CircletRule           L1+2
; FOLDEND - IDs

; FOLDSTART - Properties
_DDeal Property BondageDeal Auto
_DDeal Property SlutDeal Auto ; H
_DDeal Property OwnershipDeal Auto
_DDeal Property PiercingDeal Auto
_DDeal Property WhoreDeal Auto ; SQ

_MDDeal Property M1 Auto ; 100
_MDDeal Property M2 Auto ; 200
_MDDeal Property M3 Auto ; 300
_MDDeal Property M4 Auto ; 400
_MDDeal Property M5 Auto ; 500

String Property RejectedDeal Auto 
Bool Property ShowDiagnostics Auto

_DFlowModDealController Property MDC Auto

_DFtools Property Tool Auto
QF__Gift_09000D62 Property DFlowQ Auto

_DFlowProps Property DFlowProps Auto

GlobalVariable Property _DFZero Auto
; FOLDEND - Properties

Int[] existingDeals

Quest PrevQuest

Function StartDeals()
	MDC.StartMDC()
EndFunction

; Simple deal adding function. Picks a candidate deal, then confirms the deal.
String Function AddDeal()

    String targetDeal = GetPotentialDeal()
    _Dutil.Info("DF - adding random deal " + targetDeal)

    MakeDeal(targetDeal)

    Return targetDeal
EndFunction

Int Function AddDealById(String targetDeal, Bool reduceDebt = True)

    _Dutil.Info("DF - adding deal by ID " + targetDeal)

   
    MakeDeal(targetDeal, reduceDebt)


    Return -1

EndFunction

Function RejectDeal(String targetDeal)
    Debug.TraceConditional("DF - RejectDeal " + targetDeal + " START", ShowDiagnostics)

    _Dutil.Info("DF - RejectDeal " + targetDeal)
    If targetDeal != ""
        RejectedDeal = targetDeal
    EndIf
    DFlowQ.DealRejectDebt()
    _Dutil.Info("DF - RejectDeal - END")

EndFunction

String Function GetPotentialDeal()
    _DUtil.Info("DF - GetPotentialDeal - START")
    MDC.StartMDC() ; does nothing if started already

    string id = DealManager.SelectDeal(RejectedDeal)

    _DUtil.Info("DF - GetPotentialDeal - END " + id)
    return id
EndFunction

Function MakeDeal(String id, Bool reduceDebt = True)
	_Dutil.Info("DF - MakeDeal - " + id + " START")
    
    Debug.Trace("DF - Fetching Rule Alias")
    _DFRuleTemplate rule = DealManager.GetRuleScript(id)
    Debug.Trace("DF - Fetched Rule Alias - " + rule)
    rule.InternalStart()

    If reduceDebt
        _Dutil.Info("DF - MakeDeal - reduce debt")
        DFlowQ.DealDebt()
    EndIf
    
    Int stage = DealManager.ActivateRule(id)
        
    If stage > 0
        Tool.ReduceResist(stage)
        Debug.TraceConditional("DF - MakeDeal - stage > 0 - update deal count globals", ShowDiagnostics)
        QF__DflowDealController_0A01C86D DC = (self As Quest) As QF__DflowDealController_0A01C86D
        DC.DealAdd(1)
        If 3 >= stage
            Debug.TraceConditional("DF - MakeDeal - add a max deal", ShowDiagnostics)
            DC.DealMaxAdd(1)
        EndIf
    Else
        Debug.Trace("DF - MakeDeal - Failed to activate deal")
    EndIf

    Tool.DeferPunishments()
    RejectedDeal = 0
    _Dutil.Info("DF - MakeDeal - END")
EndFunction

Bool Function CheckDealOpen(Int id)
    
    Return True

EndFunction


; True is the player has any deals that make them naked in town, or more broadly.
; Naked deals are: slut-deal lvl 2+, whore deal level 2+, piercing deal lvl 3+, modular naked rule (6), modular whore rule (7), modular pet-suit rule (11), modular jacket rule sort of (16)
Bool Function HaveNakedDeals()
    Return SlutDeal.GetStage() >= 2 \
        || WhoreDeal.GetStage() >= 2 \
        || PiercingDeal.GetStage() >= 3 \
        || MDC.NakedRule >= 2 \
        || MDC.WhoreRule >= 2 \
        || MDC.PetSuitInTownRule >= 2 \
        || MDC.JacketRule >= 2
EndFunction

; For device removal in return for deals.
Function DeviceRemovalDeal()

    ; DFlowProps = Quest.GetQuest("_DFlow") As _DFlowProps
    
    QF__DflowDealController_0A01C86D DC = (self As Quest) As QF__DflowDealController_0A01C86D

    Int dealIndex = DC.DealOffering
    Int addResult = AddDealById(dealIndex, False)
    
    Int deviceIndex = DFlowProps.ItemToRemove
    _Dutil.Info("DF - DeviceRemovalDeal - dealIndex " + dealIndex + ", addResult " + addResult + ", deviceIndex " + deviceIndex)
    
    If addResult >= 0
        ; Remove the device specified in _DFlow
        DC.RemoveDeviceByIndex(deviceIndex)
    EndIf

EndFunction

; Returns true if there was a deal to remove
Bool Function RemoveRandomDeal()
   
    Debug.TraceConditional("DF - RemoveRandomDeal - start", ShowDiagnostics)

    string dealQ = DealManager.GetRandomDeal()
    
    Debug.TraceConditional("DF - RemoveRandomDeal - remove - " + dealQ, ShowDiagnostics)
    
    DealManager.RemoveDeal(dealQ)
    
    Debug.TraceConditional("DF - RemoveRandomDeal - end", ShowDiagnostics)
    
    return true

EndFunction