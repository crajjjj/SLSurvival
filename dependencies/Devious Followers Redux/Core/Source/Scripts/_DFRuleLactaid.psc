Scriptname _DFRuleLactaid extends _DFRuleTemplate  

Function Start(Actor Player, _LDC DeviceController)
    _DFlowModDealController MDC = GetOwningQuest() as _DFlowModDealController
    MDC.LactacidDealRequests = 0
    MDC.LactacidDealDefaults = 0
    MDC.LactacidDealTimer = Utility.GetCurrentGameTime()
    MDC.LactacidRule = 2
    MDC.CheckAndClearDealRequests()
EndFunction

Function Stop(Actor Player, _LDC DeviceController) 
    (GetOwningQuest() as _DFlowModDealController).LactacidRule = 1 
EndFunction