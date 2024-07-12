Scriptname _DFRuleCorset extends _DFRuleTemplate  

Keyword Property CorsetKwd Auto

Function Start(Actor Player, _LDC DeviceController)
    DeviceController.AddDeviceByKeyword(CorsetKwd)
EndFunction

Function Stop(Actor Player, _LDC DeviceController)
    DeviceController.RemoveDeviceByKeyword(CorsetKwd)
EndFunction