Scriptname _DFRuleSex extends _DFRuleTemplate  

Function Start(Actor Player, _LDC DeviceController)
    _DFlowModDealController MDC = GetOwningQuest() as _DFlowModDealController
    
    MDC.SexDealRequests = 0
    MDC.SexDealDefaults = 0
    MDC.SexDealTimer = Utility.GetCurrentGameTime()
    MDC.SexRule = 2
    MDC.CheckAndClearDealRequests()
EndFunction

Function Stop(Actor Player, _LDC DeviceController) 
    (GetOwningQuest() as _DFlowModDealController).SexRule = 1
EndFunction