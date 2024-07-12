;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 6
Scriptname SLV_WhiterunCalmDraugr Extends Quest Hidden

;BEGIN ALIAS PROPERTY draugr03
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_draugr03 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_Player
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Player Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY draugr04
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_draugr04 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY draugr02
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_draugr02 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_Titus
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Titus Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY draugr01
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_draugr01 Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_4
Function Fragment_4()
;BEGIN CODE
setObjectiveDisplayed(1000)
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

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
SetObjectiveDisplayed(2500)
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

;BEGIN FRAGMENT Fragment_5
Function Fragment_5()
;BEGIN CODE
SetObjectiveDisplayed(1500)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto