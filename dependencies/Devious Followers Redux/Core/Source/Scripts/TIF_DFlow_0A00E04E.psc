;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname TIF_DFlow_0A00E04E Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
(q as _DflowFollowerController).AddFollowerLend(akSpeaker)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

globalvariable Property HasHirelingGV  Auto  

GlobalVariable Property HirelingRecognizeMarcurio  Auto  
Faction Property fac  Auto  
Quest property q auto

ReferenceAlias Property ra  Auto  
