;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 3
Scriptname TIF_DFlow_0B0094AC Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
libs.ManipulateGenericDeviceByKeyword(PlayerRef,libs.zad_DeviousGloves,false)
libs.ManipulateGenericDeviceByKeyword(PlayerRef,libs.zad_DeviousBoots,false)
libs.ManipulateGenericDeviceByKeyword(PlayerRef,libs.zad_DeviousCollar,false)
Q.BuyoutOfSlavery()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

zadlibs Property libs  Auto  

MiscObject Property Gold001  Auto  

Actor Property PlayerRef  Auto  
QF__Gift_09000D62 Property q  Auto  

Faction Property Fac  Auto  

GlobalVariable Property _DflowDebt  Auto  
