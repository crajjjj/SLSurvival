;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 61
Scriptname SLV_PreQuest1 Extends Quest Hidden

;BEGIN ALIAS PROPERTY SLV_BanditLeader
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_BanditLeader Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_Belethor
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Belethor Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_Lucan
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Lucan Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_PikeLetter
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_PikeLetter Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_Hideout
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Hideout Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_PikeLetter2
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_PikeLetter2 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_Chest
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Chest Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_Bandit
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Bandit Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_Orgnar
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Orgnar Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_BookPrequest
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_BookPrequest Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_Igor
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Igor Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_Carriage
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Carriage Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_Player
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Player Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_Slave
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Slave Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_Murphy
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Murphy Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_You
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_You Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_49
Function Fragment_49()
;BEGIN CODE
setObjectiveCompleted(5200)
SetObjectiveDisplayed(5500)
alias_SLV_Bandit.getActorRef().enable()

alias_SLV_Bandit.GetActorRef().SetAV("Aggression", 0)
;alias_SLV_Bandit.GetActorRef().SetAV("Confidence", 3)

ActorUtil.AddPackageOverride(alias_SLV_Bandit.GetActorRef(), SLV_FollowPlayer ,100)
alias_SLV_Bandit.GetActorRef().evaluatePackage()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_11
Function Fragment_11()
;BEGIN CODE
setObjectiveDisplayed(1000)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_58
Function Fragment_58()
;BEGIN CODE
SetObjectiveDisplayed(3500)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_55
Function Fragment_55()
;BEGIN CODE
SetObjectiveDisplayed(1500)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_13
Function Fragment_13()
;BEGIN CODE
SetObjectiveDisplayed(3000)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_26
Function Fragment_26()
;BEGIN CODE
setObjectiveCompleted(6500)
SetObjectiveDisplayed(7000)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_28
Function Fragment_28()
;BEGIN CODE
SetObjectiveDisplayed(7500)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_57
Function Fragment_57()
;BEGIN CODE
SetObjectiveDisplayed(2500)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_20
Function Fragment_20()
;BEGIN CODE
SetObjectiveCompleted(4500)
SetObjectiveDisplayed(5000)
alias_SLV_Murphy.getActorRef().disable()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_56
Function Fragment_56()
;BEGIN CODE
SetObjectiveDisplayed(2000)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_16
Function Fragment_16()
;BEGIN CODE
SetObjectiveDisplayed(4000)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_33
Function Fragment_33()
;BEGIN CODE
SetObjectiveDisplayed(10000)
stop()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_41
Function Fragment_41()
;BEGIN CODE
setObjectiveDisplayed(8000)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_21
Function Fragment_21()
;BEGIN CODE
setObjectiveCompleted(5500)
SetObjectiveDisplayed(6000)

autodoor.enable()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_60
Function Fragment_60()
;BEGIN CODE
setObjectiveCompleted(5000)
SetObjectiveDisplayed(5200)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_48
Function Fragment_48()
;BEGIN CODE
SetObjectiveDisplayed(9500)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_59
Function Fragment_59()
;BEGIN CODE
SetObjectiveDisplayed(4500)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_50
Function Fragment_50()
;BEGIN CODE
setObjectiveCompleted(6000)
SetObjectiveDisplayed(6500)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Package Property SLV_FollowPlayer Auto
Quest Property WICourier  Auto  
Book Property SLV_PikeLetter  Auto  
ObjectReference Property autodoor Auto

