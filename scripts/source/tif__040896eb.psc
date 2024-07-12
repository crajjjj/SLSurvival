;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname TIF__040896EB Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Dflow.DecResistWithSeverity(Amount = 3.0, DoNotify = true, Severity = "1")
LicUtil.SetMandatoryGag(akSpeaker)
LicUtil.EquipMandatoryGag()
Util.StopAllGuardWarnApproachQuests(akSpeaker, DoCooldown = true)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

_SLS_InterfaceDeviousFollowers Property Dflow Auto
_SLS_LicenceUtil Property LicUtil Auto
SLS_Utility Property Util Auto
