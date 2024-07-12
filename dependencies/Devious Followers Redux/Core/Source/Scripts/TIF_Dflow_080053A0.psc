;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 4
Scriptname TIF_Dflow_080053A0 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_2
Function Fragment_2(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Q.StartNewAgreement(akSpeaker, 10)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_3
Function Fragment_3(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
; Fix the case where the force start didn't work right and the PC simply recruited a new follower themselves
If 10 == FS.GetStage()
  FSFollower.ForceRefTo(akSpeaker)
  GuardScene.Start()
  (Tool As _DFTools).SceneErrorCatch(GuardScene, 30)
EndIf
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

QF__Gift_09000D62 Property q  Auto  

Faction Property Fac  Auto  

ReferenceAlias Property _DMaster  Auto 

Quest Property FS Auto 
Quest Property Tool Auto
ReferenceAlias Property FSFollower Auto
Scene Property GuardScene Auto
