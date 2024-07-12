;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 52
Scriptname SLV_Aboltionism Extends Quest Hidden

;BEGIN ALIAS PROPERTY SLV_JarlWhiterun1
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_JarlWhiterun1 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_Player
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Player Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_Ivana
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Ivana Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_Diamond
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Diamond Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_Murphy
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Murphy Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_Pike
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Pike Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_Bellamy
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Bellamy Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_JarlWhiterun2
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_JarlWhiterun2 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_JarlMorthal1
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_JarlMorthal1 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_Draemora
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Draemora Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_Thalmor
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Thalmor Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_38
Function Fragment_38()
;BEGIN CODE
SetObjectiveDisplayed(3500)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_43
Function Fragment_43()
;BEGIN CODE
SetObjectiveDisplayed(4000)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_36
Function Fragment_36()
;BEGIN CODE
SetObjectiveDisplayed(2500)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
SetObjectiveDisplayed(0)
jarlswap.updateJarlOfWhiterun()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_10
Function Fragment_10()
;BEGIN CODE
setObjectiveDisplayed(500)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_50
Function Fragment_50()
;BEGIN CODE
SetObjectiveDisplayed(300)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_44
Function Fragment_44()
;BEGIN CODE
SetObjectiveDisplayed(6500)
myScripts.SLV_disableBrutus()
myScripts.SLV_disableMundus()
myScripts.SLV_disableZaid()
myScripts.SLV_disableExecution()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_46
Function Fragment_46()
;BEGIN CODE
SetObjectiveDisplayed(11000)
stop()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_42
Function Fragment_42()
;BEGIN CODE
SetObjectiveDisplayed(5500)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_33
Function Fragment_33()
;BEGIN CODE
SetObjectiveDisplayed(1500)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_35
Function Fragment_35()
;BEGIN CODE
SetObjectiveDisplayed(3000)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_48
Function Fragment_48()
;BEGIN CODE
setObjectiveDisplayed(100)
jarlswap.updateJarlOfWhiterun()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_51
Function Fragment_51()
;BEGIN CODE
SetObjectiveDisplayed(5200)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_40
Function Fragment_40()
;BEGIN CODE
SetObjectiveDisplayed(4500)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_29
Function Fragment_29()
;BEGIN CODE
SetObjectiveDisplayed(9500)
stop()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_39
Function Fragment_39()
;BEGIN CODE
SetObjectiveDisplayed(5000)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_34
Function Fragment_34()
;BEGIN CODE
SetObjectiveDisplayed(2000)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_41
Function Fragment_41()
;BEGIN CODE
SetObjectiveDisplayed(6000)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_19
Function Fragment_19()
;BEGIN CODE
setObjectiveDisplayed(1000)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_45
Function Fragment_45()
;BEGIN CODE
SetObjectiveDisplayed(10000)
stop()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_47
Function Fragment_47()
;BEGIN CODE
SetObjectiveDisplayed(50)
jarlswap.updateJarlOfWhiterun()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_49
Function Fragment_49()
;BEGIN CODE
setObjectiveDisplayed(200)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_37
Function Fragment_37()
;BEGIN CODE
SetObjectiveDisplayed(9000)
stop()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
SLV_SwapWhiterunJarl Property jarlswap Auto

