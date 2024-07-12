;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname TIF_Dflow_07041986 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
libs.RemoveDevice(libs.PlayerRef, I , R, libs.zad_Devioussuit, false)
_DflowLives.SetValue(1)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

zadlibs Property libs  Auto
Armor Property I  Auto
Armor Property R  Auto
QF__Gift_09000D62 Property q  Auto  
GlobalVariable Property _DflowLives Auto  
