;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 12
Scriptname TIF_Dflow_0A0187A6 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_10
Function Fragment_10(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
float a = Debt.getvalue()
GetowningQuest().reset()
GetowningQuest().setstage(0)
GameQ.reset()
GameQ.setstage(100)
q.Etimerreset()
libs.ManipulateGenericDeviceByKeyword(libs.playerref,libs.zad_DeviousGag , False)
Utility.wait(2)
Debt.setvalue(a)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

zadlibs Property libs  Auto  
QF__Gift_09000D62 Property q  Auto  


Actor Property PlayerRef  Auto  

Armor Property D  Auto  

Armor Property DE  Auto  

Armor Property D2  Auto  

Armor Property DE2  Auto  


Quest Property GameQ  Auto  
_Dftools property tool auto

GlobalVariable Property TEMP  Auto  
GlobalVariable Property debt  Auto  
