;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 4
Scriptname TIF_Dflow_081A4645 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_2
Function Fragment_2(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
(GetOwningQuest() As QF__Gift_09000D62).RobPlayerItems()
Tool.ResumeAll()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_3
Function Fragment_3(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
; Do nothing much
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

QF__Gift_09000D62 Property q  Auto  

zadlibs Property libs  Auto  
Actor Property PlayerRef  Auto  
Armor Property Collar  Auto  
Armor Property Mitts  Auto  
Armor Property boots  Auto
Message Property msg  Auto  
GlobalVariable Property FreedomCost Auto
GlobalVariable Property EnslaveDebt Auto
GlobalVariable Property Will Auto

MiscObject Property Gold001  Auto  

GlobalVariable Property _Dtats  Auto  

GlobalVariable Property SSO  Auto  

Keyword Property SSNS  Auto  
Keyword Property VNS  Auto 

_DFtools Property tool  Auto  

ObjectReference Property Shop  Auto  

GlobalVariable Property _DFlowItemsPerRemoved  Auto  

Quest property _DflowItems auto
