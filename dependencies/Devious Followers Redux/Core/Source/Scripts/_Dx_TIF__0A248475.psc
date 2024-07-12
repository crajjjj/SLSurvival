;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 11
Scriptname _Dx_TIF__0A248475 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_9
Function Fragment_9(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
; put player back on their knees
(q As QF__Gift_09000D62).PunCrawl()
; includes adding debt
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

zadlibs Property libs  Auto  
_Dftools property tool Auto
Actor Property PlayerRef  Auto  

MiscObject Property Gold001  Auto  

Quest Property q  Auto 
