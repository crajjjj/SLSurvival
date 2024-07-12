;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname TIF_Dflow_0814DB73 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
q.Tool.PrepareForScene()
(GetOwningquest() as QF__DflowGames_0A0110DC).Alias_SceneYOU.Forcerefto(q.Tool.PC)
(GetOwningquest() as QF__DflowGames_0A0110DC).Alias_Jarl.Forcerefto(Akspeaker)
GetOwningquest().Setstage(402)
; NOTE actually DogScene2
; which triggers jarl scene2
_DflowGamesDogScene.Start()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

QF__Gift_09000D62 Property q  Auto  

Scene Property _DflowGamesDogScene  Auto  
