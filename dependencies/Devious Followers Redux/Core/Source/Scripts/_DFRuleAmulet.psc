Scriptname _DFRuleAmulet extends _DFRuleTemplate  

Armor Property Amulet Auto

Function Start(Actor Player, _LDC DeviceController)
    Player.AddItem(Amulet)
EndFunction

Function Stop(Actor Player, _LDC DeviceController)
    Player.RemoveItem(Amulet)
EndFunction