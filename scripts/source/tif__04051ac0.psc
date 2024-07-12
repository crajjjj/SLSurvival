;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname TIF__04051AC0 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Util.SendDoSpecificNpcSpankEvent(Timeout = 4.0, AllowNpcInFurniture = false, akActor = akSpeaker, DialogWait = true)
(Game.GetFormFromFile(0x0850D2, "SL Survival.esp") as _SLS_Api).SendAuthorativeConvoEndEvent(akSpeaker)
Self.GetOwningQuest().Stop()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

SLS_Utility Property Util Auto
