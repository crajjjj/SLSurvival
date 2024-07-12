;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 10
Scriptname TIF_Dflow_0A018799 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_9
Function Fragment_9(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Tool.PunDebt()
Tool.AddPunishmentScore(15)
libs.ForceEquipDevice(libs.PlayerRef, I, R, libs.zad_DeviousCollar)
libs.ManipulateGenericDeviceByKeyword(libs.PlayerRef,  libs.zad_DeviousBoots, True)
libs.ManipulateGenericDeviceByKeyword(libs.PlayerRef,  libs.zad_DeviousBondageMittens, True)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_8
Function Fragment_8(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
libs.ManipulateGenericDeviceByKeyword(PlayerRef, libs.zad_DeviousCollar, False)
libs.ManipulateGenericDeviceByKeyword(PlayerRef, libs.zad_Deviousarmcuffs, False)
libs.ManipulateGenericDeviceByKeyword(PlayerRef, libs.zad_Deviouslegcuffs, False)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

zadlibs Property libs  Auto  

Actor Property PlayerRef  Auto  

Armor Property I  Auto  

Armor Property R  Auto  

MiscObject Property Gold001  Auto  

_DFTools Property Tool Auto
