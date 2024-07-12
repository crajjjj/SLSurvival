;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname TIF__05024817 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
; There's going to be fewer 4p animations so give a 50 50 chance of 3p or 4p
If Utility.RandomFloat(1.0, 100.0) > 50.0
Main.StartSex3p(akSpeaker, SexCat = 2, DecWillIncFame = true, Victim = none, TeleportType = 2)
Else
Main.StartSex4p(akSpeaker, SexCat = 2, DecWillIncFame = true, Victim = none, TeleportType = 2)
EndIf
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

SLS_Main Property Main Auto
