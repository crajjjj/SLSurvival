;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname TIF__04088C1B Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
getowningquest().setstage(200)
LicUtil.SetMandatoryGag(akSpeaker)
LicUtil.EquipMandatoryGag()
(Game.GetFormFromFile(0x000D64, "SL Survival.esp") as SLS_Utility).GuardWarnPlayer(akSpeaker)
Self.GetowningQuest().Stop()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

_SLS_LicenceUtil Property LicUtil Auto
