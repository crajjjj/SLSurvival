;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname TIF__04051ABC Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
LicUtil.EquipMandatoryRestaints()
;Debug.Messagebox("Infraction: " + (Game.GetFormFromFile(0x0420BB, "SL Survival.esp") as _SLS_LicenceUtil).LicInfractionType)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

_SLS_LicenceUtil Property LicUtil Auto
