;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 4
Scriptname TIF_DFlow_0B0094AA Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_3
Function Fragment_3(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Q.PayOffFollower(akSpeaker)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

zadlibs Property libs  Auto  

MiscObject Property Gold001  Auto  

Actor Property PlayerRef  Auto  
QF__Gift_09000D62 Property q  Auto  

Faction Property Fac  Auto  

GlobalVariable Property _DflowDebt  Auto  
