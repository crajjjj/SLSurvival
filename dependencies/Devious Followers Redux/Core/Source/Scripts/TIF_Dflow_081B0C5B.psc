;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 3
Scriptname TIF_Dflow_081B0C5B Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_2
Function Fragment_2(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
(q as _DflowFollowerController).AddFollowerDflow(akSpeaker)
FSFollower.ForceRefTo(akSpeaker)
TheScene.Start()
Tool.SceneErrorCatch(TheScene, 30)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

globalvariable Property HasHirelingGV  Auto  

referencealias Property Follower  Auto  

quest Property FollowQuest  Auto  

referencealias Property Hireling  Auto  

faction Property CurrentHireling  Auto  

GlobalVariable Property HirelingRecognizeVorstag  Auto  
Faction Property fac  Auto  
Quest property q auto

ReferenceAlias Property ra  Auto  

Scene Property TheScene Auto  
_DFTools Property tool Auto
ReferenceAlias Property FSFollower auto
