;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 6
Scriptname QF__KNNPlayAnimationQuest_05E65312 Extends Quest Hidden

;BEGIN ALIAS PROPERTY Player
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Player Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN AUTOCAST TYPE _KNNPlayAnimationQuest
Quest __temp = self as Quest
_KNNPlayAnimationQuest kmyQuest = __temp as _KNNPlayAnimationQuest
;END AUTOCAST
;BEGIN CODE
kmyQuest.StartupQuest()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_4
Function Fragment_4()
;BEGIN AUTOCAST TYPE _KNNPlayAnimationQuest
Quest __temp = self as Quest
_KNNPlayAnimationQuest kmyQuest = __temp as _KNNPlayAnimationQuest
;END AUTOCAST
;BEGIN CODE
kmyQuest.ForcedQuestStop(Game.GetPlayer(), false)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN AUTOCAST TYPE _KNNPlayAnimationQuest
Quest __temp = self as Quest
_KNNPlayAnimationQuest kmyQuest = __temp as _KNNPlayAnimationQuest
;END AUTOCAST
;BEGIN CODE
kmyQuest.CleanupQuest()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
