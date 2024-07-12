;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 47
Scriptname SLV_CelebrateSlavery Extends Quest Hidden

;BEGIN ALIAS PROPERTY SLV_Elisif
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Elisif Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY JarlMorthal1
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_JarlMorthal1 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY JarlMarkarth2
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_JarlMarkarth2 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY JarlFalkreath2
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_JarlFalkreath2 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_Pike
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Pike Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_Player
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Player Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY JarlFalkreath1
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_JarlFalkreath1 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY JarlMarkarth1
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_JarlMarkarth1 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY JarlWhiterun2
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_JarlWhiterun2 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_Maven
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Maven Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY JarlWindhelm1
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_JarlWindhelm1 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_SexSlaveVol43
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_SexSlaveVol43 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY JarlWhiterun1
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_JarlWhiterun1 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY JarlMorthal2
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_JarlMorthal2 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY JarlWindhelm2
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_JarlWindhelm2 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_Bellamy
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Bellamy Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_You
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_You Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_44
Function Fragment_44()
;BEGIN CODE
SetObjectiveDisplayed(6500)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
SetObjectiveDisplayed(0)
jarlSwap.updateAllJarls()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_43
Function Fragment_43()
;BEGIN CODE
SetObjectiveDisplayed(9500)
myScripts.SLV_CleanUpPackages()
stop()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_39
Function Fragment_39()
;BEGIN CODE
SetObjectiveDisplayed(4500)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_46
Function Fragment_46()
;BEGIN CODE
SetObjectiveDisplayed(6000)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_42
Function Fragment_42()
;BEGIN CODE
SetObjectiveDisplayed(5000)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_29
Function Fragment_29()
;BEGIN CODE
SetObjectiveDisplayed(9000)
myScripts.SLV_CleanUpPackages()
stop()
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

;BEGIN FRAGMENT Fragment_33
Function Fragment_33()
;BEGIN CODE
setObjectiveDisplayed(1500)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_37
Function Fragment_37()
;BEGIN CODE
SetObjectiveDisplayed(10000)
myScripts.SLV_CleanUpPackages()
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

;BEGIN FRAGMENT Fragment_36
Function Fragment_36()
;BEGIN CODE
SetObjectiveDisplayed(2500)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_40
Function Fragment_40()
;BEGIN CODE
SetObjectiveDisplayed(4000)
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

;BEGIN FRAGMENT Fragment_45
Function Fragment_45()
;BEGIN CODE
SetObjectiveDisplayed(7000)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_38
Function Fragment_38()
;BEGIN CODE
SetObjectiveDisplayed(3500)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_41
Function Fragment_41()
;BEGIN CODE
SetObjectiveDisplayed(5500)
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

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
SLV_SwapAllJarl Property jarlSwap auto

