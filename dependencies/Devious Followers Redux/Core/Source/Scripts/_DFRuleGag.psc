Scriptname _DFRuleGag extends _DFRuleTemplate  

_DF_BondageDeal Property BondageDeal Auto
Keyword Property GagKwd Auto

Function Start(Actor Player, _LDC DeviceController)
    BondageDeal.DelayHr()
    DeviceController.AddDeviceByKeyword(GagKwd)
EndFunction

Function Stop(Actor Player, _LDC DeviceController)
    DeviceController.RemoveDeviceByKeyword(GagKwd)
EndFunction