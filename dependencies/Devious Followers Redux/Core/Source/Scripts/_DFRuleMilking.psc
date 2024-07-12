Scriptname _DFRuleMilking extends _DFRuleTemplate  

Function Start(Actor Player, _LDC DeviceController)
    _DFlowModDealController MDC = GetOwningQuest() as _DFlowModDealController
    
    MDC.MME_Milk = Game.GetFormFromFile(0x0006D61F,  "MilkModNEW.esp") As Keyword
    MDC.MilkDealRequests = 0
    MDC.MilkDealDefaults = 0
    MDC. MilkDealTimer = Utility.GetCurrentGameTime()
    StorageUtil.SetFormValue(Player, "MME_MilkBarrel_Override", MDC._DFMilkBarrel)
    MDC.DrinkLactacid(3)
    MDC.MilkingRule = 2
    MDC.CheckAndClearDealRequests()
EndFunction

Function Stop(Actor Player, _LDC DeviceController)
    (GetOwningQuest() as _DFlowModDealController).MilkingRule = 1
    StorageUtil.UnsetFormValue(Player, "MME_MilkBarrel_Override")
EndFunction