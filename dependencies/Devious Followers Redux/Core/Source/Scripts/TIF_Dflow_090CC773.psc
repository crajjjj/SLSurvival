;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname TIF_Dflow_090CC773 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
libs.RemoveDevice(libs.PlayerRef, D , DE, libs.zad_DeviousStraitJacket, skipevents = false, skipmutex = true)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
QF__Gift_09000D62 Property q Auto 

Scene Property Woof  Auto  
ObjectReference property _DFPlayer Auto
Armor Property D  Auto  

Armor Property DE  Auto  
zadlibs Property libs  Auto  
