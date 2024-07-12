;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 15
Scriptname SLV_ArenaFight Extends Quest Hidden

;BEGIN ALIAS PROPERTY SLV_Player
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Player Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_You
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_You Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_ChoppingBlock
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_ChoppingBlock Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_Bones
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Bones Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_Cassius
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Cassius Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_Watcher1
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Watcher1 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_Watcher3
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Watcher3 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_ArenaDoor
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_ArenaDoor Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_Caesar
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Caesar Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_Fighter1
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Fighter1 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_DeadPlayer
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_DeadPlayer Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_ArenaLever
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_ArenaLever Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_ArenaDoorExit
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_ArenaDoorExit Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_Watcher2
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Watcher2 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_Gladiator
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Gladiator Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_Fighter4
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Fighter4 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_Fighter2
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Fighter2 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_Fighter3
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Fighter3 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_ChoppingBlock2
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_ChoppingBlock2 Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_5
Function Fragment_5()
;BEGIN CODE
SetObjectiveCompleted(1000)
SetObjectiveDisplayed(1500)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_14
Function Fragment_14()
;BEGIN CODE
SetObjectiveDisplayed(3500)

Alias_SLV_ArenaDoorExit.getReference().enable()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_12
Function Fragment_12()
;BEGIN CODE
Alias_SLV_ArenaDoorExit.getReference().disable()

arenadoor.lock(true)

SetObjectiveDisplayed(9000)
stop()
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
Alias_SLV_ArenaDoorExit.getReference().disable()

arenadoor.lock(true)

SetObjectiveDisplayed(10000)
stop()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_11
Function Fragment_11()
;BEGIN CODE
arenadoor.lock(true)

SetObjectiveDisplayed(5000)
stop()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_7
Function Fragment_7()
;BEGIN CODE
SetObjectiveDisplayed(2500)
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

;BEGIN FRAGMENT Fragment_13
Function Fragment_13()
;BEGIN CODE
SetObjectiveDisplayed(3000)

Alias_SLV_ArenaDoorExit.getReference().enable()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_6
Function Fragment_6()
;BEGIN CODE
SetObjectiveDisplayed(2000)

Alias_SLV_ArenaDoorExit.getReference().enable()
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

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

ObjectReference Property arenadoor auto

