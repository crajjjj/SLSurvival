;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 12
Scriptname SLV_DawnstarFreedom Extends Quest Hidden

;BEGIN ALIAS PROPERTY SLV_Player
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Player Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_Pike
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Pike Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_JarlDawnstar2
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_JarlDawnstar2 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_JarlDawnstar1
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_JarlDawnstar1 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_JarlMorthal1
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_JarlMorthal1 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_Bellamy
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Bellamy Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_Ivana
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Ivana Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_JarlDawnsHCarl1
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_JarlDawnsHCarl1 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_JarlDawnsHCarl2
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_JarlDawnsHCarl2 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_JarlMorthal2
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_JarlMorthal2 Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
setObjectiveDisplayed(500)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_10
Function Fragment_10()
;BEGIN CODE
SetObjectiveDisplayed(2500)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_8
Function Fragment_8()
;BEGIN CODE
SetObjectiveDisplayed(9000)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_4
Function Fragment_4()
;BEGIN CODE
SetObjectiveDisplayed(1500)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_6
Function Fragment_6()
;BEGIN CODE
SetObjectiveDisplayed(9500)
stop()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
SetObjectiveDisplayed(0)
jarlswap.updateJarlOfDawnstar()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_5
Function Fragment_5()
;BEGIN CODE
SetObjectiveDisplayed(2000)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_3
Function Fragment_3()
;BEGIN CODE
setObjectiveDisplayed(1000)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_SwapDawnstarJarl Property jarlswap Auto

