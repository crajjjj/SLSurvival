;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 61
Scriptname SLV_PreQuest2 Extends Quest Hidden

;BEGIN ALIAS PROPERTY SLV_Player
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Player Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_Igor
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Igor Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_PikeLetter
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_PikeLetter Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_11
Function Fragment_11()
;BEGIN CODE
setObjectiveCompleted(500)
setObjectiveDisplayed(1000)

reviveNPC.resurrectNPC_Mainquest()
SLV_Pre2.Start()
SLV_Pre2.setstage(1000)
SLV_Pre2.SetActive(true)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_53
Function Fragment_53()
;BEGIN CODE
(WICourier as WICourierScript).addAliasToContainer(Alias_SLV_PikeLetter)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_9
Function Fragment_9()
;BEGIN CODE
setObjectiveDisplayed(500)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Quest Property SLV_Pre2 Auto 
SLV_ReviveNPC Property reviveNPC auto
Quest Property WICourier  Auto  
Book Property SLV_PikeLetter  Auto  
