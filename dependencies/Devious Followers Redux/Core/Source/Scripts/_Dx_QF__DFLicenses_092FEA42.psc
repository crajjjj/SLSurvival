;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 7
Scriptname _Dx_QF__DFLicenses_092FEA42 Extends Quest Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN AUTOCAST TYPE _DFLicensing
Quest __temp = self as Quest
_DFLicensing kmyQuest = __temp as _DFLicensing
;END AUTOCAST
;BEGIN CODE
kmyQuest.StartLicensing()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_5
Function Fragment_5()
;BEGIN AUTOCAST TYPE _DFLicensing
Quest __temp = self as Quest
_DFLicensing kmyQuest = __temp as _DFLicensing
;END AUTOCAST
;BEGIN CODE
kmyQuest.EndLicensing()
kmyQuest.Stop()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_4
Function Fragment_4()
;BEGIN AUTOCAST TYPE _DFLicensing
Quest __temp = self as Quest
_DFLicensing kmyQuest = __temp as _DFLicensing
;END AUTOCAST
;BEGIN CODE
kmyQuest.StopSupply()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_6
Function Fragment_6()
;BEGIN AUTOCAST TYPE _DFLicensing
Quest __temp = self as Quest
_DFLicensing kmyQuest = __temp as _DFLicensing
;END AUTOCAST
;BEGIN CODE
kmyQuest.BeginFromGoldControl()
kmyQuest.SetStage(10)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN AUTOCAST TYPE _DFLicensing
Quest __temp = self as Quest
_DFLicensing kmyQuest = __temp as _DFLicensing
;END AUTOCAST
;BEGIN CODE
kmyQuest.BeginSupply()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
