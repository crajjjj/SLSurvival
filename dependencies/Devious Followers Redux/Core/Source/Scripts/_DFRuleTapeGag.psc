Scriptname _DFRuleTapeGag extends _DFRuleTemplate  

_DF_BondageDeal Property BondageDeal Auto
Armor Property TapeGag Auto

Function Start(Actor Player, _LDC DeviceController)
    BondageDeal.DelayForever()
    DeviceController.libs.LockDevice(Player, TapeGag)
EndFunction

Function Stop(Actor Player, _LDC DeviceController)
    DeviceController.libs.UnlockDevice(Player, TapeGag)
EndFunction