Scriptname _DFRuleAnalPlug extends _DFRuleTemplate  

Keyword Property APlugKwd Auto

Function Start(Actor Player, _LDC DeviceController)
    DeviceController.AddDeviceByKeyword(APlugKwd)
EndFunction

Function Stop(Actor Player, _LDC DeviceController)
    DeviceController.RemoveDeviceByKeyword(APlugKwd)
EndFunction