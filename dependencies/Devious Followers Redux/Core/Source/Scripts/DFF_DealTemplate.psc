Scriptname DFF_DealTemplate extends Quest Conditional

Int Property SelectedStage = -1 Auto Conditional Hidden

MiscObject Gold001
Actor PlayerRef

Event OnInit()
    Gold001 = Game.GetFormFromFile(0xF, "Skyrim.esm") as MiscObject
    PlayerRef = Game.GetPlayer()
EndEvent

Function BuyOut()
    GlobalVariable price = DealManager.GetDealCostGlobal(self)

    QF__DflowDealController_0A01C86D DC = Quest.GetQuest("_DflowDealController") As QF__DflowDealController_0A01C86D

    Debug.TraceConditional("DF - _DDeal - Buyout", True)
    Int removeGold = price.GetValue() As Int
    PlayerRef.RemoveItem(Gold001, removeGold)
    Debug.TraceConditional("DF - _DDeal - remove " + removeGold + " debt", True)
    
    Int s = DealManager.GetStageIndex(self)
    
    if s >= 3
      DC.DealMaxAdd(-1)
    Endif

    DC.DealAdd(-s)
    
    DealManager.RemoveDeal(self)
    
    DC.PickRandomDeal()

    BuyOutCallback()
EndFunction

Function BuyOutCallback()
    {clean up your deal - unequip devices, remove items, etc.}
EndFunction