;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 3
Scriptname QF__DFlowItems_080559F0 Extends Quest Hidden

;BEGIN ALIAS PROPERTY PawnMerchant
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_PawnMerchant Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN CODE
SetObjectiveDisplayed(1, False)
SetObjectiveCompleted(1, False)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
UpdateCurrentInstanceGlobal(_DFlowEDhalf)
SetObjectiveCompleted(1, False)
SetObjectiveDisplayed(1, True)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
SetObjectiveCompleted(1, True)
SetObjectiveDisplayed(1, False)
Reset()
Start()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

GlobalVariable Property _DflowEDHalf  Auto  
