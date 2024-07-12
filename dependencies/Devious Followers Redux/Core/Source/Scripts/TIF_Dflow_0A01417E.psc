;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 10
Scriptname TIF_Dflow_0A01417E Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_9
Function Fragment_9(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
float a = Temp.getValue()
a -= 1
Temp.setValue(a)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

zadlibs Property libs  Auto  

Actor Property PlayerRef  Auto  

Armor Property D  Auto  

Armor Property DE  Auto  


Quest Property GameQ  Auto  
_Dftools property tool auto

GlobalVariable Property TEMP  Auto  
