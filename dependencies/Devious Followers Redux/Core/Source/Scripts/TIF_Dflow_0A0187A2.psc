;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname TIF_Dflow_0A0187A2 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetStage(101)
Temp.SetValue(10)
libs.ManipulateGenericDeviceByKeyword(libs.playerref, libs.zad_DeviousBelt , False)
libs.ManipulateGenericDeviceByKeyword(libs.playerref, libs.zad_DeviousHobbleSkirt, False)
libs.ManipulateGenericDeviceByKeyword(libs.playerref, libs.zad_DeviousHobbleSkirtRelaxed, False)
libs.ManipulateGenericDeviceByKeyword(libs.playerref, libs.zad_DeviousAnkleShackles, False)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

GlobalVariable Property TEMP  Auto  
zadlibs Property libs  Auto  
