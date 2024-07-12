;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 11
Scriptname TIF_Dflow_090E7B6B Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_10
Function Fragment_10(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
(GetOwningQuest() as _DDeal).DelayReset()
(GetOwningQuest() as _DDeal).DelayHrs(3.0)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

zadlibs Property libs  Auto  
_Dftools property tool Auto
Actor Property PlayerRef  Auto  
QF__Gift_09000D62 property q Auto

MiscObject Property Gold001  Auto  
