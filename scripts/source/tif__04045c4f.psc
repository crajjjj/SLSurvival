;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname TIF__04045C4F Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Self.GetOwningQuest().Stop()
LicUtil.DoGateObjectInspection()
LicUtil.GateCheckLicenceExpiredRemove(akSpeaker)
(Game.GetFormFromFile(0x0850D2, "SL Survival.esp") as _SLS_Api).SendAuthorativeConvoEndEvent(akSpeaker)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

_SLS_LicenceUtil Property LicUtil Auto
