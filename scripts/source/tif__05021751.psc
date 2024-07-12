;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname TIF__05021751 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
If Init.NpcWants == 1
Main.StartSexVaginal(akSpeaker, SexCat = 2, DecWillIncFame = true, Victim = none, TeleportType = 0)
ElseIf Init.NpcWants == 2
Main.StartSexAnal(akSpeaker, SexCat = 2, DecWillIncFame = true, Victim = none, TeleportType = 0)
EndIf
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

SLS_Main Property Main Auto
SLS_Init Property Init Auto
