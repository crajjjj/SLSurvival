;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 4
Scriptname QF_aaaKNNIdleAnimQuest_05254A7D Extends Quest Hidden

;BEGIN ALIAS PROPERTY Player
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Player Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY animMarker
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_animMarker Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN AUTOCAST TYPE aaaKNNIdleAnimQuest
Quest __temp = self as Quest
aaaKNNIdleAnimQuest kmyQuest = __temp as aaaKNNIdleAnimQuest
;END AUTOCAST
;BEGIN CODE
kmyQuest.ShutDownIdleHotkeyAnim()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN AUTOCAST TYPE aaaKNNIdleAnimQuest
Quest __temp = self as Quest
aaaKNNIdleAnimQuest kmyQuest = __temp as aaaKNNIdleAnimQuest
;END AUTOCAST
;BEGIN CODE
kmyQuest.StandUp()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN AUTOCAST TYPE aaaKNNIdleAnimQuest
Quest __temp = self as Quest
aaaKNNIdleAnimQuest kmyQuest = __temp as aaaKNNIdleAnimQuest
;END AUTOCAST
;BEGIN CODE
kmyQuest.StartUpIdleHotkeyAnim()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
