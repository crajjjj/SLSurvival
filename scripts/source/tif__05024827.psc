;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname TIF__05024827 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Main.BegGagDeal()
; Wait to be ungagged
Int Timer = 10
While Devious.IsPlayerGagged() && Timer > 0
	Timer -= 1
	Utility.Wait(0.5)
EndWhile

If Init.NpcWants == 0
	Main.StartSexOralMale(akSpeaker, SexCat = 2, DecWillIncFame = true, Victim = none, TeleportType = 0)
ElseIf Init.NpcWants == 4
	If Init.BeggingDogsFound > 0 && Init.BeggingWolvesFound > 0
		If Utility.RandomFloat(1.0, 100.0) > 50.0
			Main.StartDogSexOral(akSpeaker, SexCat = 2, DecWillIncFame = true, Victim = none, TeleportType = 0)
		Else
			Main.StartWolfSexOral(akSpeaker, SexCat = 2, DecWillIncFame = true, Victim = none, TeleportType = 0)
		EndIf
	ElseIf Init.BeggingDogsFound > 0
		Main.StartDogSexOral(akSpeaker, SexCat = 2, DecWillIncFame = true, Victim = none, TeleportType = 0)
	Else
		Main.StartWolfSexOral(akSpeaker, SexCat = 2, DecWillIncFame = true, Victim = none, TeleportType = 0)
	EndIf
ElseIf Init.NpcWants == 8
	Main.StartHorseSexOral(akSpeaker, SexCat = 2, DecWillIncFame = true, Victim = none, TeleportType = 0)
EndIf
Devious.DoMoan()
BegTarget.Clear()
_SLS_BeggingGagged.Stop()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

SLS_Main Property Main Auto
SLS_Init Property Init Auto
_SLS_InterfaceDevious Property Devious Auto
ReferenceAlias Property BegTarget Auto
Quest Property _SLS_BeggingGagged Auto
