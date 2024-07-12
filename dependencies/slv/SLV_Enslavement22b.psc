;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_Enslavement22b Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Actor player = Game.getplayer()
myScripts.SLV_PlayerMoveTo(DragonsreachMarker)
SLV_Brutus.getActorRef().moveto(player)
SLV_Sven.getActorRef().moveto(player)

if ThisMenu.SkipScenes
	GetOwningQuest().SetObjectiveCompleted(4500)
	GetOwningQuest().SetStage(5000)
	return
endif

SendModEvent("dhlp-Suspend")
game.DisablePlayerControls(1, 1, 1, 0, 0, 1, 1)
game.SetPlayerAIDriven(true)
PunishScene.Start()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_MCMMenu Property ThisMenu auto
Scene Property PunishScene Auto 
ObjectReference Property DragonsreachMarker Auto 
ReferenceAlias Property SLV_Brutus Auto 
ReferenceAlias Property SLV_Sven Auto
SLV_Utilities Property myScripts auto

