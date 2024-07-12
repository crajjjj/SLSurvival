Scriptname _DFRuleCirclet extends _DFRuleTemplate  

Armor Property Circlet Auto

Function Start(Actor Player, _LDC DeviceController)
    Player.AddItem(Circlet)
EndFunction

Function Stop(Actor Player, _LDC DeviceController)
    Player.RemoveItem(Circlet)
EndFunction