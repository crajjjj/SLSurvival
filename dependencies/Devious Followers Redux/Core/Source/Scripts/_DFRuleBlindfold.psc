Scriptname _DFRuleBlindfold extends _DFRuleTemplate  

Keyword Property BlindfoldKwd Auto

Function Start(Actor Player, _LDC DeviceController)
    DeviceController.AddDeviceByKeyword(BlindfoldKwd)
EndFunction

Function Stop(Actor Player, _LDC DeviceController)
    DeviceController.RemoveDeviceByKeyword(BlindfoldKwd)
EndFunction