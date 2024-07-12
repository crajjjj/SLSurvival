;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 15
Scriptname SLV_ArenaShow Extends Quest Hidden

;BEGIN ALIAS PROPERTY SLV_Watcher3
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Watcher3 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_Animal8
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Animal8 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_You
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_You Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_Player
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Player Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_ArenaDoor
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_ArenaDoor Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_Caesar
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Caesar Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_Animal2
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Animal2 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_Animal3
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Animal3 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_Animal9
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Animal9 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_Animal1
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Animal1 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_Watcher2
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Watcher2 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_Animal5
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Animal5 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_Animal4
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Animal4 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_Animal6
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Animal6 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_Animal7
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Animal7 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_ArenaDoorExit
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_ArenaDoorExit Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_ArenaLever
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_ArenaLever Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_Bones
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Bones Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_Watcher1
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Watcher1 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_Cassius
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Cassius Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
Alias_SLV_ArenaDoorExit.getReference().disable()

SetObjectiveDisplayed(10000)
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
SetObjectiveCompleted(1000)
SetObjectiveDisplayed(1500)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_4
Function Fragment_4()
;BEGIN CODE
SetObjectiveCompleted(500)
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

;BEGIN FRAGMENT Fragment_14
Function Fragment_14()
;BEGIN CODE
SetObjectiveDisplayed(9000)

Alias_SLV_ArenaDoorExit.getReference().enable()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_13
Function Fragment_13()
;BEGIN CODE
SetObjectiveDisplayed(9500)

Alias_SLV_ArenaDoorExit.getReference().enable()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
