;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 4
Scriptname QF__KNNWaterBarrelQuest_05F49057 Extends Quest Hidden

;BEGIN ALIAS PROPERTY waterBarrel09
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_waterBarrel09 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY waterBarrel07
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_waterBarrel07 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY waterBarrel02
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_waterBarrel02 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY waterBarrel06
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_waterBarrel06 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY waterBarrel08
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_waterBarrel08 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY waterBarrel01
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_waterBarrel01 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY waterBarrel00
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_waterBarrel00 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Player
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Player Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY waterBarrel05
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_waterBarrel05 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY waterBarrel03
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_waterBarrel03 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY waterBarrel04
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_waterBarrel04 Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN AUTOCAST TYPE _KNNWaterBarrelQuest
Quest __temp = self as Quest
_KNNWaterBarrelQuest kmyQuest = __temp as _KNNWaterBarrelQuest
;END AUTOCAST
;BEGIN CODE
kmyQuest.ShutDown()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN AUTOCAST TYPE _KNNWaterBarrelQuest
Quest __temp = self as Quest
_KNNWaterBarrelQuest kmyQuest = __temp as _KNNWaterBarrelQuest
;END AUTOCAST
;BEGIN CODE
kmyQuest.StartUp()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
