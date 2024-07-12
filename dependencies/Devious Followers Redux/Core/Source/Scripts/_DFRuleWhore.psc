Scriptname _DFRuleWhore extends _DFRuleTemplate  

_DF_WhoreDeal Property WhoreQuest Auto
Keyword Property PlugKwd Auto
Armor Property WhoreSign Auto

Function Start(Actor Player, _LDC DeviceController)
    WhoreQuest.DelayHr()
    DeviceController.RemoveDeviceByKeyword(PlugKwd)
    Player.AddItem(WhoreSign)
EndFunction

Function Stop(Actor Player, _LDC DeviceController)
    DeviceController.libs.UnlockDevice(Player, WhoreSign)
EndFunction