Scriptname _DFRuleCollar extends _DFRuleTemplate  

Keyword Property CollarKwd Auto

Function Start(Actor Player, _LDC DeviceController)
    DeviceController.AddDeviceByKeyword(CollarKwd)
EndFunction

Function Stop(Actor Player, _LDC DeviceController)
    DeviceController.RemoveDeviceByKeyword(CollarKwd)
EndFunction