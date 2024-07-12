Scriptname _DFRuleChastityGame extends _DFRuleTemplate  

_DF_OwnershipDeal Property OwnershipQuest Auto
Armor Property SpecialBelt Auto

Function Start(Actor Player, _LDC DeviceController)
    OwnershipQuest.DelayHr()
    Player.AddItem(SpecialBelt)
EndFunction

Function Stop(Actor Player, _LDC DeviceController)
    DeviceController.libs.UnlockDevice(Player, SpecialBelt, destroyDevice = true)
EndFunction