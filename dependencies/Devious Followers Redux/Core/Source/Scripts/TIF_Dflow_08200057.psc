;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 3
Scriptname TIF_Dflow_08200057 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_2
Function Fragment_2(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Utility.Wait(5.0)
QF__Gift_09000D62 owning = (GetOwningQuest() as QF__Gift_09000D62)
owning.EnslavedDueToDebt()
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

MiscObject Property Gold001  Auto  

GlobalVariable Property _Dtats  Auto  

GlobalVariable Property SSO  Auto  

GlobalVariable Property _DflowEndlessMode Auto  
Armor Property I  Auto
Armor Property R  Auto
