Scriptname _DFRuleNipplePiercing extends _DFRuleTemplate  

Keyword Property NPKwd Auto

Function Start(Actor Player, _LDC DeviceController)
    DeviceController.AddDeviceByKeyword(NPKwd)
EndFunction

Function Stop(Actor Player, _LDC DeviceController)
    DeviceController.RemoveDeviceByKeyword(NPKwd)
EndFunction