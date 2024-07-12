;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname TIF__090C014D Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
(GetOwningquest() as QF__DflowGames_0A0110DC).Alias_SceneYOU.Forcerefto(q.Tool.PC)
(GetOwningquest() as QF__DflowGames_0A0110DC).Alias_Jarl.Forcerefto(Akspeaker)
_DflowGamesDogScene.Start()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

QF__Gift_09000D62 Property q  Auto  

Scene Property _DflowGamesDogScene  Auto  
