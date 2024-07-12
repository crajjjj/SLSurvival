;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 9
Scriptname QF__DflowGoldMode_08112478 Extends Quest Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN AUTOCAST TYPE _DFGoldConQScript
Quest __temp = self as Quest
_DFGoldConQScript kmyQuest = __temp as _DFGoldConQScript
;END AUTOCAST
;BEGIN CODE
kmyQuest.ResetIt()
Reset()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_5
Function Fragment_5()
;BEGIN AUTOCAST TYPE _DFGoldConQScript
Quest __temp = self as Quest
_DFGoldConQScript kmyQuest = __temp as _DFGoldConQScript
;END AUTOCAST
;BEGIN CODE
kmyQuest.ResetIt()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN AUTOCAST TYPE _DFGoldConQScript
Quest __temp = self as Quest
_DFGoldConQScript kmyQuest = __temp as _DFGoldConQScript
;END AUTOCAST
;BEGIN CODE
kmyQuest.StartIt()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN AUTOCAST TYPE _DFGoldConQScript
Quest __temp = self as Quest
_DFGoldConQScript kmyQuest = __temp as _DFGoldConQScript
;END AUTOCAST
;BEGIN CODE
kmyQuest.ResetAgreedGold()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
