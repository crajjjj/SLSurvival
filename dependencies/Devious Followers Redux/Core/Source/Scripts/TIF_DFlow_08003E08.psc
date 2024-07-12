;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 9
Scriptname TIF_DFlow_08003E08 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_7
Function Fragment_7(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
; Start the jacket game
PlayerRef.additem(D, 1, true)
libs.equipDevice(PlayerRef, D , DE, libs.zad_DeviousStraitJacket, skipevents = false, skipmutex = true)
GetowningQuest().setstage(200)
GameQ.setstage(100)
libs.ManipulateGenericDeviceByKeyword(playerref, Libs.Zad_DeviousBlindFold, False)
libs.ManipulateGenericDeviceByKeyword(playerref, Libs.Zad_DeviousHood, False)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

zadlibs Property libs  Auto  

Actor Property PlayerRef  Auto  

Armor Property D  Auto  

Armor Property DE  Auto  


Quest Property GameQ  Auto  
