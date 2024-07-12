;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_SexSlaveTraining2_3 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(1000)
GetOwningQuest().SetStage(1500)

if ThisMenu.SkipScenes
	return
endif

SLV_Animal.ForceRefTo(Animal)
;Debug.notification("New Animal= " + SLV_Animal.getActorRef().getActorBase().getName())

SLV_Slaver.ForceRefTo(akSpeaker)
;Debug.notification("New Slaver= " + SLV_Slaver.getActorRef().getActorBase().getName())

SLV_SlaveFollower.ForceRefTo(SLV_Ivana.getActorRef())
;Debug.notification("New Slaver2= " + SLV_Slaver2.getActorRef().getActorBase().getName())

SLV_You.getActorRef().moveto(Game.GetPlayer())

SendModEvent("dhlp-Suspend")
game.DisablePlayerControls(1, 1, 1, 0, 0, 1, 1)
game.SetPlayerAIDriven(true)
PunishScene.ForceStart()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
ReferenceAlias Property SLV_You Auto
SLV_MCMMenu Property ThisMenu auto
Scene Property PunishScene  Auto
ReferenceAlias Property SLV_Slaver Auto
ReferenceAlias Property SLV_SlaveFollower Auto
SLV_Utilities Property myScripts auto

ReferenceAlias Property SLV_Ivana Auto 
ReferenceAlias Property SLV_Animal Auto  
Actor Property Animal Auto  

