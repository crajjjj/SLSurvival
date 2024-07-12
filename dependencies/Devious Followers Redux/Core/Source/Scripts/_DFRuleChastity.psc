Scriptname _DFRuleChastity extends _DFRuleTemplate  

_DF_OwnershipDeal Property OwnershipQuest Auto
Keyword Property ChastityKwd Auto
Armor Property Belt Auto

Function Start(Actor Player, _LDC DeviceController)
    OwnershipQuest.DelayHr()
    Player.AddItem(Belt)
EndFunction

Function Stop(Actor Player, _LDC DeviceController)
    DeviceController.RemoveDeviceByKeyword(ChastityKwd)
EndFunction