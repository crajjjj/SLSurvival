Scriptname _DFRuleWhoreArmor extends _DFRuleTemplate  

_DFlowMCM Property Config Auto

Bool Function IsValid(Actor Player)
    bool valid = Config.Tool.GetArmorOfType("light")[0] || Config.Tool.GetArmorOfType("heavy")[0] || Config.Tool.GetArmorOfType("mage")[0]
    if !valid
        Debug.Notification("No valid whore armors found")
    endIf
    return valid
EndFunction 

Function Start(Actor Player, _LDC DeviceController)
    Config.Tool.GiveWhoreArmor(false)
EndFunction

Function Stop(Actor Player, _LDC DeviceController)
    Keyword[] kwds = new Keyword[1]
    kwds[0] = Keyword.GetKeyword("_DFWArmor")

    Form[] whoreArmors = DealManager.GetInventoryObjectsWithKeywords(Player, kwds, true)

    int i = 0
    while i < whoreArmors.length
        Player.RemoveItem(whoreArmors[i])
        i += 1
    endWhile

EndFunction