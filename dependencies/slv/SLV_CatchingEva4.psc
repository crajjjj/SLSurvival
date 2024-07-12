;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_CatchingEva4 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(1500)
getowningquest().setstage(2000)

if ThisMenu.SkipScenes
	return
endif

myScripts.SLV_EnslavementNPC(SLV_SLave.getActorRef())
Utility.wait(2.0)
SLV_Slave.GetActorRef().addItem(Whip)

SLV_You.getActorRef().moveto(Game.GetPlayer())
SLV_Slave.getActorRef().moveto(Game.GetPlayer())
ActorUtil.AddPackageOverride(SLV_Slave.GetActorRef(), SLV_FollowPlayer ,100)
SLV_Slave.GetActorRef().evaluatePackage()

SendModEvent("dhlp-Suspend")
game.DisablePlayerControls(1, 1, 1, 0, 0, 1, 1)
game.SetPlayerAIDriven(true)
PunishScene.ForceStart()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
Weapon Property Whip Auto
ReferenceAlias Property SLV_Slave Auto
Package Property SLV_FollowPlayer Auto
ReferenceAlias Property SLV_You Auto
SLV_MCMMenu Property ThisMenu auto
Scene Property PunishScene  Auto