;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 3
Scriptname QF__081DFD34 Extends Quest Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN AUTOCAST TYPE _MDDeal
Quest __temp = self as Quest
_MDDeal kmyQuest = __temp as _MDDeal
;END AUTOCAST
;BEGIN CODE
Float temp = kmyQuest.GameDaysPassed.GetValue() + kmyQuest._DflowDealBaseDays.GetValue()
kmyQuest.DealPriceTimer.SetValue(temp)
kmyQuest.stage1();
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN AUTOCAST TYPE _MDDeal
Quest __temp = self as Quest
_MDDeal kmyQuest = __temp as _MDDeal
;END AUTOCAST
;BEGIN CODE
Float temp = 0
if (kmyQuest.DealPriceTimer.getValue() <=   kmyQuest.GameDaysPassed.GetValue())
temp =  kmyQuest.GameDaysPassed.GetValue() +  kmyQuest._DflowDealBaseDays.GetValue()
kmyQuest.DealPriceTimer.SetValue(temp)
Else
temp = kmyQuest.DealPriceTimer.GetValue() +  kmyQuest._DflowDealBaseDays.GetValue()
kmyQuest.DealPriceTimer.SetValue(temp)
endif

kmyQuest.stage2();
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN AUTOCAST TYPE _MDDeal
Quest __temp = self as Quest
_MDDeal kmyQuest = __temp as _MDDeal
;END AUTOCAST
;BEGIN CODE
float temp = 0.0
if (kmyQuest.DealPriceTimer.getValue() <=   kmyQuest.GameDaysPassed.GetValue())
temp =  kmyQuest.GameDaysPassed.GetValue() +  kmyQuest._DflowDealBaseDays.GetValue()
kmyQuest.DealPriceTimer.SetValue(temp)
Else
temp = kmyQuest.DealPriceTimer.GetValue() +  kmyQuest._DflowDealBaseDays.GetValue()
kmyQuest.DealPriceTimer.SetValue(temp)
endif
kmyQuest.stage3();
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
