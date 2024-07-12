;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname TIF__040A16FE Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Util.GuardWarnMilkingEnd(akSpeaker, TakeMilk = false)
Util.BeginGuardWarnCooldown()
Game.GetPlayer().RemoveItem(Game.GetFormFromFile(0xf, "Skyrim.esm"), 250)
Self.GetOwningQuest().Stop()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

SLS_Utility Property Util Auto
