;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 5
Scriptname _Dx_TIF__092EF72B Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_4
Function Fragment_4(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Tool.Sex(akspeaker)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_3
Function Fragment_3(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
(GetOwningQuest() As _DDeal).DelayHrs(3.0)
tool.IncrementSlutCount()
tool.ReduceResistFloat(1.0)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

_DFtools Property tool  Auto  
