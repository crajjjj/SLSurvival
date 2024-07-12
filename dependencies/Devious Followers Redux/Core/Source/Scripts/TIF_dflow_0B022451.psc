;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 12
Scriptname TIF_dflow_0B022451 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_10
Function Fragment_10(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
libs.ManipulateGenericDeviceByKeyword(libs.Playerref, libs.zad_Deviousgloves,False)
 libs.ManipulateGenericDeviceByKeyword(libs.Playerref, libs.zad_Deviousboots,False)
 libs.ManipulateGenericDeviceByKeyword(libs.Playerref, libs.zad_Deviouscorset,False)
PlayerRef.RemoveItem(Gold001, 1000)
DealQ.setstage(4)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

zadlibs Property libs  Auto  

Actor Property PlayerRef  Auto  

Armor Property I  Auto  

Armor Property R  Auto  
QF__Gift_09000D62 Property q  Auto  

MiscObject Property Gold001  Auto  

Quest Property Dealq  Auto  
