;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname TIF__0408CCF4 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
(Game.GetFormFromFile(0x000D64, "SL Survival.esp") as SLS_Utility).StopAllGuardWarnApproachQuests(akSpeaker, DoCooldown = true)
Main.StartSexOralMale(akSpeaker, SexCat = 0, DecWillIncFame = true, Victim = none, TeleportType = 0)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

SLS_Main Property Main Auto
