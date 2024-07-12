;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname TIF__0501E617 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Init.DegradationDialogPlayerChoice[2] = 2
(Game.GetFormFromFile(0x000D64, "SL Survival.esp") as SLS_Utility).BegSelfDegradationResistLoss()
(Game.GetFormFromFile(0x0840A1, "SL Survival.esp") as _SLS_InterfaceSlsf).IncreaseSexFame("Beast", 5)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

SLS_Init Property Init Auto
