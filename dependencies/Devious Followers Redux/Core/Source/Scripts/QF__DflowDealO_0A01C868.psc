;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 19
Scriptname QF__DflowDealO_0A01C868 Extends Quest Hidden

;BEGIN ALIAS PROPERTY Follower
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Follower Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_15
Function Fragment_15()
;BEGIN AUTOCAST TYPE _DDeal
Quest __temp = self as Quest
_DDeal kmyQuest = __temp as _DDeal
;END AUTOCAST
;BEGIN CODE
KmyQuest.addcollar()
Float temp = 0.0
if (_DflowDealOPTimer.getValue() <=  GameDaysPassed.GetValue())
    temp = GameDaysPassed.GetValue() + _DflowDealBaseDays.GetValue()
    _DflowDealOPTimer.SetValue(temp)
Else
    temp =_DflowDealOPTimer.GetValue() + _DflowDealBaseDays.GetValue()
    _DflowDealOPTimer.SetValue(temp)
endif
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_17
Function Fragment_17()
;BEGIN AUTOCAST TYPE _DDeal
Quest __temp = self as Quest
_DDeal kmyQuest = __temp as _DDeal
;END AUTOCAST
;BEGIN CODE
KmyQuest.equipitem1()
KmyQuest.Delayhr()
Float temp = 0
if (_DflowDealOPTimer.getValue() <=  GameDaysPassed.GetValue())
    temp = GameDaysPassed.GetValue() + _DflowDealBaseDays.GetValue()
    _DflowDealOPTimer.SetValue(temp)
Else
    temp =_DflowDealOPTimer.GetValue() + _DflowDealBaseDays.GetValue()
    _DflowDealOPTimer.SetValue(temp)
endif

KmyQuest.Triggered = False
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_16
Function Fragment_16()
;BEGIN AUTOCAST TYPE _DDeal
Quest __temp = self as Quest
_DDeal kmyQuest = __temp as _DDeal
;END AUTOCAST
;BEGIN CODE
KmyQuest.addbelt()
KmyQuest.Delayhr()
Float temp = 0
if (_DflowDealOPTimer.getValue() <=  GameDaysPassed.GetValue())
    temp = GameDaysPassed.GetValue() + _DflowDealBaseDays.GetValue()
    _DflowDealOPTimer.SetValue(temp)
Else
    temp =_DflowDealOPTimer.GetValue() + _DflowDealBaseDays.GetValue()
    _DflowDealOPTimer.SetValue(temp)
endif

KmyQuest.Triggered = False
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_18
Function Fragment_18()
;BEGIN CODE
kmyQuest.Stage0()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_9
Function Fragment_9()
;BEGIN CODE
KmyQuest.addcuffs()
Float temp = GameDaysPassed.GetValue() + _DflowDealBaseDays.GetValue()
_DflowDealOPTimer.SetValue(temp)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

GlobalVariable Property GameDaysPassed auto
GlobalVariable Property _DflowDealOPTimer auto
GlobalVariable Property _DflowDealBaseDays auto
