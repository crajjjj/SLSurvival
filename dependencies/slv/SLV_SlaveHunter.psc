;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 11
Scriptname SLV_SlaveHunter Extends Quest Hidden

;BEGIN ALIAS PROPERTY SLV_BountyHunter2
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_BountyHunter2 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_Watcher1
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Watcher1 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_BountyHunterDog
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_BountyHunterDog Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_Player
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Player Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_You
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_You Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_BountyHunter1
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_BountyHunter1 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_Murphy
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Murphy Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_Bellamy
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Bellamy Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_Follower
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Follower Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_Watcher2
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Watcher2 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_Horse
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Horse Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_Dog
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Dog Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_10
Function Fragment_10()
;BEGIN CODE
SetObjectiveDisplayed(3500)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
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

startingtimer.StartSlaveHunterTimer()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_3
Function Fragment_3()
;BEGIN CODE
SetObjectiveDisplayed(1500)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
setObjectiveDisplayed(500)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_4
Function Fragment_4()
;BEGIN CODE
setObjectiveDisplayed(1000)

Alias_SLV_BountyHunter1.getActorRef().moveto(huntingstart)
Alias_SLV_BountyHunter2.getActorRef().moveto(huntingstart)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_8
Function Fragment_8()
;BEGIN CODE
SetObjectiveDisplayed(3000)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_6
Function Fragment_6()
;BEGIN CODE
SetObjectiveDisplayed(2000)
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

;BEGIN FRAGMENT Fragment_9
Function Fragment_9()
;BEGIN CODE
SetObjectiveDisplayed(9000)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_5
Function Fragment_5()
;BEGIN CODE
SetObjectiveDisplayed(10000)
stop()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_SlaveHunter_Timer Property startingtimer auto
ObjectReference Property huntingStart auto
Package Property SLV_Slaver_GetToPlayer auto
