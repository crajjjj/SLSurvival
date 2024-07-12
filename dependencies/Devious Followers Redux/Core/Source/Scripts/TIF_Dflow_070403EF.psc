;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 3
Scriptname TIF_Dflow_070403EF Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_2
Function Fragment_2(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Utility.Wait(4.0)
libs.RemoveDevice(libs.PlayerRef, I , R, libs.zad_DeviousStraitJacket, skipevents = false, skipmutex = true);
Libs.Playerref.RemoveItem(I)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

zadlibs Property libs  Auto  
Armor Property I  Auto
Armor Property R  Auto
