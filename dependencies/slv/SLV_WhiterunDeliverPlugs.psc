;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 11
Scriptname SLV_WhiterunDeliverPlugs Extends Quest Hidden

;BEGIN ALIAS PROPERTY SLV_Solaf
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Solaf Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_Belethor
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Belethor Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_Mundus
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Mundus Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_LucanValerius
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_LucanValerius Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_Player
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Player Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
SetObjectiveDisplayed(9500)
myScripts.SLV_ProgressMainQuest()
stop()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_6
Function Fragment_6()
;BEGIN CODE
SetObjectiveDisplayed(1500)
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

;BEGIN FRAGMENT Fragment_5
Function Fragment_5()
;BEGIN CODE
SetObjectiveDisplayed(2000)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_4
Function Fragment_4()
;BEGIN CODE
setObjectiveDisplayed(1000)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_9
Function Fragment_9()
;BEGIN CODE
SetObjectiveDisplayed(3000)
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

;BEGIN FRAGMENT Fragment_3
Function Fragment_3()
;BEGIN CODE
setObjectiveDisplayed(500)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto