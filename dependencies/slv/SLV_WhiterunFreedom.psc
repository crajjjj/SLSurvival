;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 126
Scriptname SLV_WhiterunFreedom Extends Quest Hidden

;BEGIN ALIAS PROPERTY SLV_Mundus
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Mundus Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_Player
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Player Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_LadyMaraPriestess
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_LadyMaraPriestess Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_Titus
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Titus Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_Eric
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Eric Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_LadyMara
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_LadyMara Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_Murphy
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Murphy Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_Bellamy
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Bellamy Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_JarlMorthal2
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_JarlMorthal2 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_DremoraLord
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_DremoraLord Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_JarlWhiterun2
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_JarlWhiterun2 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_JarlWhiterun1
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_JarlWhiterun1 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_You
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_You Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_Fang
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Fang Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_JarlMorthal1
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_JarlMorthal1 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_Ivana
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Ivana Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_Diamond
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Diamond Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_Pike
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Pike Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_MolagBal
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_MolagBal Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_29
Function Fragment_29()
;BEGIN CODE
setObjectiveDisplayed(9000)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_41
Function Fragment_41()
;BEGIN CODE
SetObjectiveDisplayed(7800)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_85
Function Fragment_85()
;BEGIN CODE
SetObjectiveDisplayed(2800)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_8
Function Fragment_8()
;BEGIN CODE
setObjectiveDisplayed(1000)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_122
Function Fragment_122()
;BEGIN CODE
setObjectiveDisplayed(500)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_43
Function Fragment_43()
;BEGIN CODE
setObjectiveDisplayed(5800)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_40
Function Fragment_40()
;BEGIN CODE
SetObjectiveDisplayed(8800)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_34
Function Fragment_34()
;BEGIN CODE
SetObjectiveDisplayed(9500)
stop()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN CODE
SetObjectiveDisplayed(0)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_45
Function Fragment_45()
;BEGIN CODE
SetObjectiveDisplayed(3800)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_44
Function Fragment_44()
;BEGIN CODE
SetObjectiveDisplayed(4800)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_42
Function Fragment_42()
;BEGIN CODE
SetObjectiveDisplayed(6800)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Softzdd  Property  zdd Auto
SLV_SoftHydraSlavegirls  Property  hydraslavegirls Auto
SLV_SwapJarl Property jarlswap Auto
SLV_EventHandler Property events Auto
SLV_Utilities Property myScripts auto
SLV_SlaverOutfit Property slaveroutfit auto

GlobalVariable Property SLV_ForcePeriodicCheck  Auto 
GlobalVariable Property SLV_WhiterunTask  Auto 
GlobalVariable Property SLV_WhiterunCiticen  Auto  
ObjectReference Property MolagBalsRoom Auto

