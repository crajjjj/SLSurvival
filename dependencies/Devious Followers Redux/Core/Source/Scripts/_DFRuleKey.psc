Scriptname _DFRuleKey extends _DFRuleTemplate  

Function Start(Actor Player, _LDC DeviceController)
    (GetOwningQuest() as _DFlowModDealController).KeySearchTimer = Utility.GetCurrentGameTime() + (1.0/24.0)
EndFunction

Function Stop(Actor Player, _LDC DeviceController)
    (GetOwningQuest() as _DFlowModDealController)._DFKeyContainer.RemoveAllItems(Player)
EndFunction