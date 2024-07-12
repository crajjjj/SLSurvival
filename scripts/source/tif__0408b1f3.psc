;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname TIF__0408B1F3 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
If _SLS_SteepFallQuest.IsRunning() && JsonUtil.GetFloatValue("SL Survival/SteepFall.json", "objectcollisionfallchance", Missing = 100.0) > Utility.RandomFloat(0.0, 100.0)
	SteepFall.Trip(true)
	(Game.GetFormFromFile(0x000D64, "SL Survival.esp") as SLS_Utility).SendDoSpecificNpcSpankEvent(Timeout = 12.0, AllowNpcInFurniture = true, akActor = akSpeaker, DialogWait = false)

Else ; Shorter timer for spanks
	(Game.GetFormFromFile(0x000D64, "SL Survival.esp") as SLS_Utility).SendDoSpecificNpcSpankEvent(Timeout = 8.0, AllowNpcInFurniture = true, akActor = akSpeaker, DialogWait = false)
EndIf
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

_SLS_SteepFall Property SteepFall Auto

Quest Property _SLS_SteepFallQuest Auto
