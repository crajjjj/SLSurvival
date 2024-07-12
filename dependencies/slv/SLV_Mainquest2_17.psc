;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_Mainquest2_17 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Game.getplayer().moveto(BackinSkyrim)
SLV_LadyMaraPriestess.getActorRef().enable()

GetOwningQuest().SetObjectiveCompleted(100)
GetOwningQuest().SetStage(150)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
ObjectReference Property BackinSkyrim Auto
ReferenceAlias Property SLV_LadyMaraPriestess Auto
