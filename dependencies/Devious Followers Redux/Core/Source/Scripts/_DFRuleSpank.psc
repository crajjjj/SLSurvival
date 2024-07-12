Scriptname _DFRuleSpank extends _DFRuleTemplate  

_DFTools Property Tool Auto

Bool Function IsValid(Actor Player)
    bool spanking = Tool.CheckSpanking()
    Debug.Trace("DF - Check Spank - " + spanking)
    Return spanking
EndFunction

Function Start(Actor Player, _LDC DeviceController)
    _DFlowModDealController MDC = GetOwningQuest() as _DFlowModDealController
    
    MDC._DFSpankDealRequests.SetValue(0.0)
    MDC.SpankDealDefaults = 0
    Tool.AllowSpanking()

    MDC.SpankingRule = 2

    MDC.CheckAndClearDealRequests()
EndFunction

Function Stop(Actor Player, _LDC DeviceController) 
    (GetOwningQuest() as _DFlowModDealController).SpankingRule = 1 
EndFunction