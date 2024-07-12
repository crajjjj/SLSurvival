;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname TIF__0501F6BC Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Init.IsDegradationSuccess = Main.IsDegradationSuccess()
_SLS_BeggingSelfDegradation.SetStage(20)
_SLS_BeggingSelfDegradation.SetObjectiveDisplayed(10, false)
_SLS_BeggingSelfDegradation.SetObjectiveDisplayed(20)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

SLS_Main Property Main Auto
SLS_Init Property Init Auto
Quest Property _SLS_BeggingSelfDegradation Auto
