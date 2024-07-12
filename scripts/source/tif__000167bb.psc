;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname TIF__000167BB Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
;getowningquest().setstage(200)
Self.GetOwningQuest().Stop()
(Game.GetFormFromFile(0x07EF9A, "SL Survival.esp") as _SLS_InterfaceDeviousFollowers).DecResistWithSeverity(Amount = 1.0, DoNotify = true, Severity = "0")
(Game.GetFormFromFile(0x000D64, "SL Survival.esp") as SLS_Utility).GuardWarnPlayer(akSpeaker)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
;WARNING: Unable to load fragment source from function Fragment_0 in script TIF__000167BB
;Source NOT loaded
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
