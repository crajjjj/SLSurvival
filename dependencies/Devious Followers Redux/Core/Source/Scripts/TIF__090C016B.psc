;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 3
Scriptname TIF__090C016B Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_2
Function Fragment_2(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
libs.removeDevice(libs.PlayerRef,Xlibs2.zadx_PetSuit_Black_Inventory ,xlibs2.zadx_PetSuit_Black_Rendered, libs.zad_DeviousPetSuit,skipevents = false, skipmutex = true)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

QF__Gift_09000D62 Property q  Auto  

zadxlibs2 Property xlibs2  Auto  

zadlibs Property libs  Auto  
