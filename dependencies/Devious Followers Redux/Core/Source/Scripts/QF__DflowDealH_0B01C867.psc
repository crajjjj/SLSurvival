;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 6
Scriptname QF__DflowDealH_0B01C867 Extends Quest Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN CODE
Float temp = GameDaysPassed.GetValue() + _DflowDealBaseDays.GetValue()
_DflowDealHPTimer.SetValue(temp)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN AUTOCAST TYPE _DDeal
Quest __temp = self as Quest
_DDeal kmyQuest = __temp as _DDeal
;END AUTOCAST
;BEGIN CODE
Float temp = 0
if (_DflowDealHPTimer.getValue() <=  GameDaysPassed.GetValue())
temp = GameDaysPassed.GetValue() + _DflowDealBaseDays.GetValue()
_DflowDealHPTimer.SetValue(temp)
Else
temp =_DflowDealHPTimer.GetValue() + _DflowDealBaseDays.GetValue()
_DflowDealHPTimer.SetValue(temp)
endif
kmyQuest.DelayHrs(4.0)

KmyQuest.Triggered = False
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_3
Function Fragment_3()
;BEGIN AUTOCAST TYPE _DDeal
Quest __temp = self as Quest
_DDeal kmyQuest = __temp as _DDeal
;END AUTOCAST
;BEGIN CODE
Float temp = 0
If (_DflowDealHPTimer.getValue() <=  GameDaysPassed.GetValue())
    temp = GameDaysPassed.GetValue() + _DflowDealBaseDays.GetValue()
    _DflowDealHPTimer.SetValue(temp)
Else
    temp =_DflowDealHPTimer.GetValue() + _DflowDealBaseDays.GetValue()
    _DflowDealHPTimer.SetValue(temp)
EndIf

KmyQuest.Triggered = False
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_4
Function Fragment_4()
;BEGIN AUTOCAST TYPE _DDeal
Quest __temp = self as Quest
_DDeal kmyQuest = __temp as _DDeal
;END AUTOCAST
;BEGIN CODE
kmyQuest.Stage0()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
Float temp = 0
If (_DflowDealHPTimer.getValue() <=  GameDaysPassed.GetValue())
    temp = GameDaysPassed.GetValue() + _DflowDealBaseDays.GetValue()
    _DflowDealHPTimer.SetValue(temp)
Else
    temp =_DflowDealHPTimer.GetValue() + _DflowDealBaseDays.GetValue()
    _DflowDealHPTimer.SetValue(temp)
EndIf
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

GlobalVariable Property GameDaysPassed auto
GlobalVariable Property _DflowDealHPTimer auto
GlobalVariable Property _DflowDealBaseDays auto

Bool Property TriggeredDealH Auto Conditional
