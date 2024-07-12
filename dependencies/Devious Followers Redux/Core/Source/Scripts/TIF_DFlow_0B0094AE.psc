;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 12
Scriptname TIF_DFlow_0B0094AE Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_11
Function Fragment_11(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Q.PunDebt()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_10
Function Fragment_10(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
;libs.RemoveDevice(libs.PlayerRef, I , R,libs.zad_DeviousHeavyBondage)
libs.ManipulateGenericDeviceByKeyword(libs.Playerref, libs.zad_DeviousHeavyBondage,False)
libs.ManipulateGenericDeviceByKeyword(libs.Playerref, libs.zad_DeviousYoke,False)
libs.ManipulateGenericDeviceByKeyword(libs.Playerref, libs.zad_DeviousArmbinder,False)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

zadlibs Property libs  Auto  

Actor Property PlayerRef  Auto  

Armor Property I  Auto  

Armor Property R  Auto  
QF__Gift_09000D62 Property q  Auto  
