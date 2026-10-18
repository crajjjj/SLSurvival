;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname TIF__040974C4 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Util.SendDoSpecificNpcSpankEvent(Timeout = 3.0, AllowNpcInFurniture = true, akActor = akspeaker, DialogWait = false)
; This INFO never had the quest property filled (the other three spank greetings do)
Quest Cooloff = Game.GetFormFromFile(0x0974C9, "SL Survival.esp") as Quest ; _SLS_HelloSpankCooloffQuest
Cooloff.Stop()
Cooloff.Start()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

SLS_Utility Property Util Auto

Quest Property _SLS_HelloSpankCooloffQuest Auto
