;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname TIF__04057C32 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Devious.EquipRandomDds(PlayerRef, Menu.Init.PpFailDevices)
PpFail.EndPickpocketFailFg(akSpeaker)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

_SLS_InterfaceDevious Property Devious Auto
_SLS_PickPocketFailDetect Property PpFail Auto
SLS_Mcm Property Menu Auto
Actor Property PlayerRef Auto
