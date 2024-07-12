;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_SexSlaveTraining4_6 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(2500)
GetOwningQuest().SetStage(3000)

myScripts.SLV_SchlongSize(akSpeaker ,20)

ActorUtil.AddPackageOverride(SLV_Ivana.GetActorRef(), SLV_DungeonCenter,100)
SLV_Ivana.GetActorRef().evaluatePackage()
ActorUtil.RemoveAllPackageOverride(SLV_FollowPlayer)

if ThisMenu.SkipScenes
	return
endif

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
SLV_Utilities Property myScripts auto
ReferenceAlias Property SLV_Ivana Auto 
Package Property SLV_FollowPlayer Auto
Package Property SLV_DungeonCenter Auto