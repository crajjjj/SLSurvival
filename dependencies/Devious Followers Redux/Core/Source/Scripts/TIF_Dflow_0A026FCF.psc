;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 10
Scriptname TIF_Dflow_0A026FCF Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_9
Function Fragment_9(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
libs.equipDevice(PlayerRef, D , DE, libs.zad_DeviousStraitJacket, skipevents = false, skipmutex = true)
GetowningQuest().setstage(200)
GameQ.setstage(200)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_7
Function Fragment_7(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
msg.show()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

zadlibs Property libs  Auto  

Actor Property PlayerRef  Auto  

Armor Property D  Auto  

Armor Property DE  Auto  


Quest Property GameQ  Auto  

Message Property msg  Auto  
