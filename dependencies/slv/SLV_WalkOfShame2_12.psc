;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_WalkOfShame2_12 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE

Game.getPlayer().moveto(xMarkerDragonsreach)
SLV_Bellamy.getActorRef().moveto(xMarkerDragonsreach)
SLV_Murphy.getActorRef().moveto(xMarkerDragonsreach)

if ThisMenu.SkipScenes
	GetOwningQuest().SetObjectiveCompleted(5000)
	GetOwningQuest().SetStage(5500)
	return
endif

myScripts.SLV_PlayScene(PunishScene)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_MCMMenu Property ThisMenu auto
SLV_Utilities Property myScripts auto
Scene Property PunishScene  Auto 

ObjectReference Property xMarkerDragonsreach Auto
ReferenceAlias Property SLV_Bellamy Auto
ReferenceAlias Property SLV_Murphy Auto
