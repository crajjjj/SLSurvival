;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname TIF__04057C2B Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Main.StartSexAnal(akSpeaker, SexCat = 0, DecWillIncFame = false, Victim = Game.GetPlayer(), TeleportType = 0)
PpFail.EndPickpocketFailFg(akSpeaker)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

SLS_Main Property Main Auto
_SLS_PickPocketFailDetect Property PpFail Auto
