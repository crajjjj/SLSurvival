;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname QF__SLS_HasPlayerClothes_05021CBC Extends Quest Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN AUTOCAST TYPE SLS_HasPlayerClothes
Quest __temp = self as Quest
SLS_HasPlayerClothes kmyQuest = __temp as SLS_HasPlayerClothes
;END AUTOCAST
;BEGIN CODE
Debug.Messagebox("Player only has one set of clothes/armor")
kmyQuest.PlayerHasOnlyOneClothes = true
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

