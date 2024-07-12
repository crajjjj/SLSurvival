;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 8
Scriptname _Dx_QF__DFSlaveryWatcher_0931D0B2 Extends Quest Hidden

;BEGIN ALIAS PROPERTY PlayerSlave
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_PlayerSlave Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_4
Function Fragment_4()
;BEGIN AUTOCAST TYPE _DFSlaveryWatching
Quest __temp = self as Quest
_DFSlaveryWatching kmyQuest = __temp as _DFSlaveryWatching
;END AUTOCAST
;BEGIN CODE
kmyQuest.EndExternalSlavery()
SetStage(90)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN AUTOCAST TYPE _DFSlaveryWatching
Quest __temp = self as Quest
_DFSlaveryWatching kmyQuest = __temp as _DFSlaveryWatching
;END AUTOCAST
;BEGIN CODE
; waiting for an external event - handler will set stage 80 or 90
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN AUTOCAST TYPE _DFSlaveryWatching
Quest __temp = self as Quest
_DFSlaveryWatching kmyQuest = __temp as _DFSlaveryWatching
;END AUTOCAST
;BEGIN CODE
Debug.TraceConditional("DF - SlaveryWatcher - Stage 10", True)
SetObjectiveDisplayed(10, True)
kmyQuest.StartExternalSlavery()
SetStage(50)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_7
Function Fragment_7()
;BEGIN CODE
SetObjectiveDisplayed(10, False)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_6
Function Fragment_6()
;BEGIN AUTOCAST TYPE _DFSlaveryWatching
Quest __temp = self as Quest
_DFSlaveryWatching kmyQuest = __temp as _DFSlaveryWatching
;END AUTOCAST
;BEGIN CODE
kmyQuest.Unregister()
SetStage(100)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

QF__Gift_09000D62 Property _DFlow Auto
_Dtick Property Tick Auto

GlobalVariable Property _DFlowEnable Auto
