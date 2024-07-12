;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 22
Scriptname SLV_ColloseumUnderground Extends Quest Hidden

;BEGIN ALIAS PROPERTY SLV_Miner2
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Miner2 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_Bellamy
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Bellamy Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_Miner1
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Miner1 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_You
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_You Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_MiningSlave2
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_MiningSlave2 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_SexSlaveVol48
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_SexSlaveVol48 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_Michelangela
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Michelangela Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_Pike
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Pike Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_Leonardo
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Leonardo Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_Player
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Player Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_MiningSlave1
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_MiningSlave1 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_BandidBoss
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_BandidBoss Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_Mundus
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Mundus Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
SetObjectiveDisplayed(0)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_16
Function Fragment_16()
;BEGIN CODE
SetObjectiveDisplayed(7000)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_4
Function Fragment_4()
;BEGIN CODE
setObjectiveDisplayed(500)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_17
Function Fragment_17()
;BEGIN CODE
setObjectiveCompleted(6000)
SetObjectiveDisplayed(6500)
myDoor.enable()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_21
Function Fragment_21()
;BEGIN CODE
SetObjectiveDisplayed(7500)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_11
Function Fragment_11()
;BEGIN CODE
SetObjectiveDisplayed(2000)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_20
Function Fragment_20()
;BEGIN CODE
setObjectiveDisplayed(8000)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_15
Function Fragment_15()
;BEGIN CODE
SetObjectiveDisplayed(6000)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_18
Function Fragment_18()
;BEGIN CODE
SetObjectiveDisplayed(5700)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_7
Function Fragment_7()
;BEGIN CODE
SetObjectiveDisplayed(3500)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_10
Function Fragment_10()
;BEGIN CODE
setObjectiveDisplayed(1000)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_14
Function Fragment_14()
;BEGIN CODE
SetObjectiveDisplayed(5000)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_9
Function Fragment_9()
;BEGIN CODE
SetObjectiveDisplayed(5500)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_6
Function Fragment_6()
;BEGIN CODE
SetObjectiveDisplayed(2500)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
SetObjectiveDisplayed(10000)
stop()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_13
Function Fragment_13()
;BEGIN CODE
SetObjectiveDisplayed(4000)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_3
Function Fragment_3()
;BEGIN CODE
SetObjectiveDisplayed(9500)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_8
Function Fragment_8()
;BEGIN CODE
SetObjectiveDisplayed(4500)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_12
Function Fragment_12()
;BEGIN CODE
SetObjectiveDisplayed(3000)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_5
Function Fragment_5()
;BEGIN CODE
setObjectiveDisplayed(1500)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_19
Function Fragment_19()
;BEGIN CODE
SetObjectiveDisplayed(5600)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
ObjectReference Property mydoor auto
