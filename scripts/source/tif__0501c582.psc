;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname TIF__0501C582 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
(Game.GetFormFromFile(0x07EF9A, "SL Survival.esp") as _SLS_InterfaceDeviousFollowers).DecResistWithSeverity(Amount = 5.0, DoNotify = true, Severity = "2")
Main.BegSuccess(Init.PlayerWants, Menu.BegQuantity)
Main.BegRandomReward(1)
Main.BegClothesDeal(akSpeaker as ObjectReference)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

SLS_Main Property Main Auto
SLS_Init Property Init Auto
SLS_Mcm Property Menu Auto
