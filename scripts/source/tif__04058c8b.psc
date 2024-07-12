;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname TIF__04058C8B Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
_SLS_LicTownViolation.SetValueInt(0)
LicUtil.DoGateObjectInspection()
TollUtil.TollHasEnoughFollowers(false)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

_SLS_LicenceUtil Property LicUtil Auto
_SLS_TollUtil Property TollUtil Auto

GlobalVariable Property _SLS_LicTownViolation Auto
