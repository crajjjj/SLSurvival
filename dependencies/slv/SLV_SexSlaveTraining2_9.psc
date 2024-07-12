;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_SexSlaveTraining2_9 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(4000)
GetOwningQuest().SetStage(4500)

waittimer.StartSexSlaveTraining2Timer()

if ThisMenu.SkipScenes
	return
endif

SLV_Slaver.ForceRefTo(akSpeaker)
;Debug.notification("New Slaver= " + SLV_Slaver.getActorRef().getActorBase().getName())

SLV_Animal.ForceRefTo(Animal)
;Debug.notification("New Animal= " + SLV_Animal.getActorRef().getActorBase().getName())

SendModEvent("dhlp-Suspend")
game.DisablePlayerControls(1, 1, 1, 0, 0, 1, 1)
game.SetPlayerAIDriven(true)
PunishScene.Start()

Utility.wait(15.0)

myScripts.SLV_Play2Sex(Game.GetPlayer(),Animal ,"", true)

ActorUtil.ClearPackageOverride(SLV_Ivana.GetActorRef())
SLV_Ivana.GetActorRef().evaluatePackage()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_SexSlaveTraining2Timer Property waittimer auto
SLV_MCMMenu Property ThisMenu auto
Scene Property PunishScene  Auto
ReferenceAlias Property SLV_Slaver Auto  
SLV_Utilities Property myScripts auto

Scene Property PunishScene2  Auto
ReferenceAlias Property SLV_Animal Auto  
Actor Property Animal Auto
ReferenceAlias Property SLV_Ivana Auto 
