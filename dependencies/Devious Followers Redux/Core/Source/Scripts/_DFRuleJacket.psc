Scriptname _DFRuleJacket extends _DFRuleTemplate  

Function Start(Actor Player, _LDC DeviceController)
    (GetOwningQuest() as _DFlowModDealController).JacketRule = 2
EndFunction

Function Stop(Actor Player, _LDC DeviceController)
    DeviceController.RemoveDeviceByKeyword(DeviceController.libs.zad_DeviousStraitJacket)
    (GetOwningQuest() as _DFlowModDealController).JacketRule = 1
EndFunction
