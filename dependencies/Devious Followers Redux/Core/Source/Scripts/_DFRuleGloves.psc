Scriptname _DFRuleGloves extends _DFRuleTemplate  

Keyword GloveKwd

Event OnInit()
    GloveKwd = Keyword.GetKeyword("zad_DeviousGloves")
EndEvent

Function Start(Actor Player, _LDC DeviceController)
    DeviceController.AddDeviceByKeyword(GloveKwd)
EndFunction

Function Stop(Actor Player, _LDC DeviceController)
    DeviceController.RemoveDeviceByKeyword(GloveKwd)
EndFunction