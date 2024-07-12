;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 3
Scriptname TIF__040581A4 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_2
Function Fragment_2(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Self.GetOwningQuest().Stop()
LicUtil.ProcAllFollowers(MustBeLoaded = true)
(Game.GetFormFromFile(0x0850D2, "SL Survival.esp") as _SLS_Api).SendAuthorativeConvoEndEvent(akSpeaker)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

_SLS_LicenceUtil Property LicUtil Auto
