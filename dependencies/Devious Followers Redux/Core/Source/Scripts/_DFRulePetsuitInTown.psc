Scriptname _DFRulePetsuitInTown extends _DFRuleTemplate

Function Start(Actor Player, _LDC DeviceController)
    (GetOwningQuest() as _DFlowModDealController).PetSuitInTownRule = 2
EndFunction

Function Stop(Actor Player, _LDC DeviceController)
    DeviceController.RemoveDeviceByKeyword(DeviceController.libs.Zad_DeviousPetSuit)
    (GetOwningQuest() as _DFlowModDealController).PetSuitInTownRule = 1
EndFunction
