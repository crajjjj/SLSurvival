Scriptname _DFRuleVaginalPiercing extends _DFRuleTemplate  

Function Start(Actor Player, _LDC DeviceController)
    DeviceController.AddDeviceByKeyword(DeviceController.libs.zad_DeviousPiercingsVaginal)
EndFunction

Function Stop(Actor Player, _LDC DeviceController)
    DeviceController.RemoveDeviceByKeyword(DeviceController.libs.zad_DeviousPiercingsVaginal)
EndFunction