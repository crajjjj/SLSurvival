Scriptname _DFRuleCuffs extends _DFRuleTemplate  

Keyword Property ArmCuffsKwd Auto
Keyword Property LegCuffsKwd Auto

Function Start(Actor Player, _LDC DeviceController)
    DeviceController.AddDeviceByKeyword(ArmCuffsKwd)
    Utility.Wait(1.0)
    DeviceController.AddDeviceByKeyword(LegCuffsKwd)
EndFunction

Function Stop(Actor Player, _LDC DeviceController)
    DeviceController.RemoveDeviceByKeyword(ArmCuffsKwd)
    Utility.Wait(1.0)
    DeviceController.RemoveDeviceByKeyword(LegCuffsKwd)
EndFunction