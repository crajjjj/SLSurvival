Scriptname _DFRuleRing extends _DFRuleTemplate  

Armor Property Ring Auto

Function Start(Actor Player, _LDC DeviceController)
    Player.AddItem(Ring)
EndFunction

Function Stop(Actor Player, _LDC DeviceController)
    Player.RemoveItem(Ring)
EndFunction