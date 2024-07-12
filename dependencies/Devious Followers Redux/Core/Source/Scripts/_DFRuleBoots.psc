Scriptname _DFRuleBoots extends _DFRuleTemplate  

Keyword Property BootsKwd Auto

Function Start(Actor Player, _LDC DeviceController)
    DeviceController.AddDeviceByKeyword(BootsKwd)
EndFunction

Function Stop(Actor Player, _LDC DeviceController)
    DeviceController.RemoveDeviceByKeyword(BootsKwd)
EndFunction