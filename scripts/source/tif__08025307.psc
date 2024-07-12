;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname TIF__08025307 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
BegTarget.Clear()
_SLS_BeggingGagged.Stop()
Devious.DoMoan()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

_SLS_InterfaceDevious Property Devious Auto
ReferenceAlias Property BegTarget Auto
Quest Property _SLS_BeggingGagged Auto
