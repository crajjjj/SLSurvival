;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname TIF_Dflow_090C28E7 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
(GetOwningQuest() as QF__DflowGames_0A0110DC).Alias_JarlPetGame.ForceRefTo(akSpeakerRef)

_DFPlayer.MoveTo(Game.Getplayer(),1000,1000)
(GetOwningQuest() as QF__DflowGames_0A0110DC).Alias_SceneYou.ForceRefTo(_DFPlayer)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
WOOf.Start()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
QF__Gift_09000D62 Property q Auto 

Scene Property Woof  Auto  
ObjectReference property _DFPlayer Auto
