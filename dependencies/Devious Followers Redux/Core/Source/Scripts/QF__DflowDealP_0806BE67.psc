;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 5
Scriptname QF__DflowDealP_0806BE67 Extends Quest Hidden

;BEGIN ALIAS PROPERTY _DMaster
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias__DMaster Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_3
Function Fragment_3()
;BEGIN CODE
KmyQuest.DelayHrs(5.0)
Float Temp = 0.0
if (_DflowDealPPTimer.getValue() <=  GameDaysPassed.GetValue())
temp = GameDaysPassed.GetValue() + _DflowDealBaseDays.GetValue()
_DflowDealPPTimer.SetValue(temp)
Else
temp =_DflowDealPPTimer.GetValue() + _DflowDealBaseDays.GetValue()
_DflowDealPPTimer.SetValue(temp)
endif

KmyQuest.Triggered = False
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN AUTOCAST TYPE _DDeal
Quest __temp = self as Quest
_DDeal kmyQuest = __temp as _DDeal
;END AUTOCAST
;BEGIN CODE
KmyQuest.addvag()
Float Temp = 0.0
if (_DflowDealPPTimer.getValue() <=  GameDaysPassed.GetValue())
temp = GameDaysPassed.GetValue() + _DflowDealBaseDays.GetValue()
_DflowDealPPTimer.SetValue(temp)
Else
temp =_DflowDealPPTimer.GetValue() + _DflowDealBaseDays.GetValue()
_DflowDealPPTimer.SetValue(temp)
endif
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_4
Function Fragment_4()
;BEGIN CODE
kmyQuest.Stage0()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN AUTOCAST TYPE _DDeal
Quest __temp = self as Quest
_DDeal kmyQuest = __temp as _DDeal
;END AUTOCAST
;BEGIN CODE
KmyQuest.addnips()
Float temp = GameDaysPassed.GetValue() + _DflowDealBaseDays.GetValue()
_DflowDealPPTimer.SetValue(temp)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
Reset()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

GlobalVariable Property GameDaysPassed auto
GlobalVariable Property _DflowDealPPTimer auto
GlobalVariable Property _DflowDealBaseDays auto
