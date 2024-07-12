Scriptname _DFRuleCrawlInTown extends _DFRuleTemplate 

Armor Property CrawlPlug Auto
GlobalVariable Property RuleGlobal Auto

Function Start(Actor Player, _LDC DeviceController)
    Player.AddItem(CrawlPlug)
    (GetOwningQuest() as _DFlowModDealController).CrawlInTownRule = 2
EndFunction

Function Stop(Actor Player, _LDC DeviceController)
    (GetOwningQuest() as _DFlowModDealController).CrawlInTownRule = 1
    DeviceController.libs.UnlockDevice(Player, CrawlPlug)
    Player.RemoveItem(CrawlPlug)
EndFunction

Event OnObjectUnequipped(Form akBaseObject, ObjectReference akReference)
    if akBaseObject.HasKeyWord(Keyword.GetKeyword("")) && RuleGlobal.GetValue() == 3
        (GetOwningQuest() as _DFlowModDealController).CrawlInTownRule = 2
    endIf
EndEvent