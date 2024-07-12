Scriptname _DFRuleSkooma extends _DFRuleTemplate

Function Start(Actor Player, _LDC DeviceController)
    _DFlowModDealController MDC = GetOwningQuest() as _DFlowModDealController
    
    MDC.SkoomaDealRequests = 0
    MDC.SkoomaDealDefaults = 0
    MDC.SkoomaDealTimer = Utility.GetCurrentGameTime()
    MDC.SkoomaRule = 2
    MDC.CheckAndClearDealRequests()
EndFunction

Function Stop(Actor Player, _LDC DeviceController) 
    (GetOwningQuest() as _DFlowModDealController).SkoomaRule = 1 
EndFunction