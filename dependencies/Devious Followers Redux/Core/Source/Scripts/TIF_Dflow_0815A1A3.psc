;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname TIF_Dflow_0815A1A3 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
(Q as QF__Gift_09000D62).AddFollower(akSpeaker)
(Q as QF__Gift_09000D62).RestartAgreement(akSpeaker, 3)
DebugV.SetValue(0)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

globalvariable Property DebugV  Auto  

GlobalVariable Property HirelingRecognizeStenvar  Auto  

Faction Property fac  Auto  
Quest property q auto

ReferenceAlias Property ra  Auto  


