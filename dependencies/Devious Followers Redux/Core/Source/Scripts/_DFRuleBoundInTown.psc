Scriptname _DFRuleBoundInTown extends _DFRuleTemplate  

Keyword Property ArmbinderKwd Auto

_LDC DC

Function Start(Actor Player, _LDC DeviceController)
    DC = DeviceController
    (GetOwningQuest() as _DFlowModDealController).BoundInTownRule = 2
EndFunction

Function Stop(Actor Player, _LDC DeviceController)
    (GetOwningQuest() as _DFlowModDealController).BoundInTownRule = 1
    UnbindHands()
EndFunction

Function BindHands()
    DC.EquipDeviceByKeyword(ArmbinderKwd)
EndFunction

Function UnbindHands()
    DC.RemoveDeviceByKeyword(DC.libs.zad_DeviousHeavyBondage)
EndFunction