scriptName DealManager hidden

string function SelectDeal(string lastRejected) global native

int function ActivateRule(string id) global native

GlobalVariable function GetRuleGlobal(string id) global native

String function GetRuleName(string id) global native

String function GetRuleDesc(string id) global native

String function GetRuleHint(string id) global native

String function GetRuleInfo(string id) global native

String function GetRulePack(string id) global native

Bool Function CanEnableRule(string id) global native

Bool Function CanDisableRule(string id) global native

string[] function GetEnslavementRules() global native

Int function GetDealCost(string id) global native

function RemoveDeal(string deal) global native

string function GetRandomDeal() global native

function ExtendDeal(string deal, float by = 0.0) global native

string[] function GetDeals() global native

string[] function GetDealRules(string deal) global native

String[] function GetPackNames() global native
Quest Function GetPackQuest(string name) global native
String[] Function GetPackRules(string name) global native

Function ShowBuyoutMenuInternal() global native
Bool Function IsBuyoutSelected() global native
String Function GetBuyoutMenuResult() global native

String Function ShowBuyoutMenu() global
    ShowBuyoutMenuInternal()
    float waitInterval = 0.5

    while !IsBuyoutSelected()
        Debug.Trace("Waiting for menu selection")
        Utility.WaitMenuMode(waitInterval)
    endWhile

    return GetBuyoutMenuResult()
EndFunction

function SetRuleValid(string path, bool valid) global native

Function PunDebt() global
    _DFtools Tool = Quest.GetQuest("_DFtools") as _DFtools
    Tool.PunDebt()
EndFunction

_DFRuleTemplate Function GetRuleScript(String id) global
    String packName = GetRulePack(id)
    Debug.Trace("DF - GetRuleScript - packName = " + packName)

    _DFRulePack pack = GetPackQuest(packName) as _DFRulePack
    Debug.Trace("DF - GetRuleScript - pack = " + pack)
    
    String name = GetRuleName(id)
    Debug.Trace("DF - GetRuleScript - name = " + name)
   
    return pack.GetRule(name)
EndFunction

Function ResetAllDeals() global native
Function Pause() global native
Function Resume() global native

; Utilities
Form[] function GetInventoryNamedObjects(ObjectReference a, String[] names) global native
Form[] function GetInventoryObjectsWithKeywords(ObjectReference a, Keyword[] kwds, bool requireAll) global native