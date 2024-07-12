;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 13
Scriptname TIF_Dflow_070439E2 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_12
Function Fragment_12(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
float a = Debt.getvalue()
GameQ.reset()
GameQ.setstage(10)
GetOwningQuest().setstage(301)
GetOwningQuest().setstage(302)
GetOwningQuest().setstage(303)
q.Etimerreset()

Utility.wait(2)
a = a+1500
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
