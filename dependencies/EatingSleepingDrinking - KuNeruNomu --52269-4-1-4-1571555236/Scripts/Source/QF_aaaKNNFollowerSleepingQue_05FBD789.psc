;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 4
Scriptname QF_aaaKNNFollowerSleepingQue_05FBD789 Extends Quest Hidden

;BEGIN ALIAS PROPERTY Follower00
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Follower00 Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN AUTOCAST TYPE _KNNFollowerGoToBedQuest
Quest __temp = self as Quest
_KNNFollowerGoToBedQuest kmyQuest = __temp as _KNNFollowerGoToBedQuest
;END AUTOCAST
;BEGIN CODE
kmyQuest.GetUp()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN AUTOCAST TYPE _KNNFollowerGoToBedQuest
Quest __temp = self as Quest
_KNNFollowerGoToBedQuest kmyQuest = __temp as _KNNFollowerGoToBedQuest
;END AUTOCAST
;BEGIN CODE
kmyQuest.GoToBed()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
