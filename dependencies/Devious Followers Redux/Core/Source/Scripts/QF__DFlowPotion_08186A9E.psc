;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 5
Scriptname QF__DFlowPotion_08186A9E Extends Quest Hidden

;BEGIN ALIAS PROPERTY _DFAddictedTo
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias__DFAddictedTo Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY PlayerRef
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_PlayerRef Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Player
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Player Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Follower
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Follower Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_3
Function Fragment_3()
;BEGIN AUTOCAST TYPE _DFPotionQuest
Quest __temp = self as Quest
_DFPotionQuest kmyQuest = __temp as _DFPotionQuest
;END AUTOCAST
;BEGIN CODE
SetObjectiveCompleted(20,False)
SetObjectiveDisplayed(50)
SetObjectiveCompleted(100,False)
kmyQuest.Delay()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
SetObjectiveCompleted(10,False)
SetObjectiveDisplayed(20)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
;
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN AUTOCAST TYPE _DFPotionQuest
Quest __temp = self as Quest
_DFPotionQuest kmyQuest = __temp as _DFPotionQuest
;END AUTOCAST
;BEGIN CODE
SetObjectiveDisplayed(10)
kmyQuest.FirstDelay()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_4
Function Fragment_4()
;BEGIN CODE
SetObjectiveDisplayed(100)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
