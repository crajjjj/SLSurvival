;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 3
Scriptname TIF_Dflow_Whore Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
int a = tool.rapetime(180.0, 1024.0)
int b = temp.getvalue() as int
Utility.wait(5)
temp.setvalue(b-a)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Int Tem = temp.getValue() as Int
MCM.Noti("Piggy",Tem)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

_DFtools Property tool  Auto  

GlobalVariable Property NewProperty  Auto  

GlobalVariable Property TEMP  Auto  
_DflowMCM Property MCM auto
