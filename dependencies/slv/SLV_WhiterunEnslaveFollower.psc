;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 4
Scriptname SLV_WhiterunEnslaveFollower Extends Quest Hidden

;BEGIN ALIAS PROPERTY SLV_Player
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Player Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_Mundus
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Mundus Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_Pike
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Pike Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN CODE
setObjectiveDisplayed(500)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
setObjectiveDisplayed(1000)
myScripts.SLV_ProgressMainQuest()
stop()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
SetObjectiveDisplayed(0)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_3
Function Fragment_3()
;BEGIN CODE
SetObjectiveDisplayed(1500)
myScripts.SLV_ProgressMainQuest()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto