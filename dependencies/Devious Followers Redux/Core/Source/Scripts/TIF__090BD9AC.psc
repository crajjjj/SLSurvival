;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 9
Scriptname TIF__090BD9AC Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_7
Function Fragment_7(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetowningQuest().setstage(200)
GameQ.setstage(400)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

zadlibs Property libs  Auto  

Actor Property PlayerRef  Auto  

Armor Property D  Auto  

Armor Property DE  Auto  


Quest Property GameQ  Auto  