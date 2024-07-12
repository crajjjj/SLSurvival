Scriptname _DFRulePack extends Quest  

String Property PackName Auto

_DFRuleTemplate[] Rules
Int RuleIndex

Event OnInit()
    Rules = new _DFRuleTemplate[128]
    RuleIndex = 0
EndEvent

Function RegisterRule(_DFRuleTemplate Rule)
    String ruleKey = "_DF_RuleIndex_" + Rule.RuleName

    Debug.Trace("DF - Registering Rule - " + GetName() + " - " + Rule.RuleName)

    if (StorageUtil.GetIntValue(self, ruleKey, -1) < 0) 
        if RuleIndex > 128
            Debug.Trace("DF - Too many rules - " + GetName())
            return
        endIf

        Rules[RuleIndex] = Rule
        StorageUtil.SetIntValue(self, ruleKey, RuleIndex)
        
        RuleIndex += 1
    else
        Debug.Trace("DF - Already Registered Rule - " + GetName() + " - " + Rule.RuleName)
    endIf
EndFunction

_DFRuleTemplate Function GetRule(String name)
    String ruleKey = "_DF_RuleIndex_" + name
    int index = StorageUtil.GetIntValue(self, ruleKey, -1)
    if index >= 0
        return Rules[index]
    else
        Debug.Trace("DF - GetRule - " + index)
        return none
    endIf
EndFunction