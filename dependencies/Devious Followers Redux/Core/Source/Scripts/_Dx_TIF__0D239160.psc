;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname _Dx_TIF__0D239160 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
OQ.DealAdd(1)
If OQ.GetStage() >= 3
    OQ.DealMaxAdd(1)
EndIf
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
DQ.SetStage(DQ.GetStage() + 1)

Int index = (GetOwningQuest() As _DFlowProps).ItemToRemove
OQ.RemoveDeviceByIndex(index)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
QF__DflowDealController_0A01C86D Property OQ Auto
_DDeal Property DQ Auto
