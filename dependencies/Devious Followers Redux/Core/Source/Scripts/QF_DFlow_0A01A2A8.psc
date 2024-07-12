;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname QF_DFlow_0A01A2A8 Extends Quest Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN AUTOCAST TYPE _DflowSleepQuestScript
Quest __temp = self as Quest
_DflowSleepQuestScript kmyQuest = __temp as _DflowSleepQuestScript
;END AUTOCAST
;BEGIN CODE
;Check when the player sleeps
; debug.trace(self + "Register for sleep to give player Well-Rested perks")
kmyquest.RegisterForSleep()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
