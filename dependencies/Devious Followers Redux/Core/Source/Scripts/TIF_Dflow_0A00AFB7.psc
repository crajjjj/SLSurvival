;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 11
Scriptname TIF_Dflow_0A00AFB7 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_9
Function Fragment_9(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Tool.PunDebt()
Tool.AddPunishmentScore(15)
libs.EquipDevice(libs.PlayerRef, I, R, libs.zad_DeviousCollar)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_10
Function Fragment_10(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
libs.ManipulateGenericDeviceByKeyword(PlayerRef, libs.zad_Deviousarmcuffs, False)
libs.ManipulateGenericDeviceByKeyword(PlayerRef, libs.zad_Deviouslegcuffs, False)
libs.ManipulateGenericDeviceByKeyword(libs.Playerref, libs.zad_DeviousYoke, False)
libs.ManipulateGenericDeviceByKeyword(libs.Playerref, libs.zad_DeviousArmbinder, False)
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
