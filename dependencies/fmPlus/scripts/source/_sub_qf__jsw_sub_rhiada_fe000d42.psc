;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname _SUB_QF__JSW_SUB_Rhiada_FE000D42 Extends Quest Hidden

;BEGIN ALIAS PROPERTY RhiadaREF
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_RhiadaREF Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
; stage 10
Alias_RhiadaREF.ForceRefTo(RhiadaREF)
Start()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN CODE
; stage 20
Reset()
Stop()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Actor Property RhiadaREF  Auto  
