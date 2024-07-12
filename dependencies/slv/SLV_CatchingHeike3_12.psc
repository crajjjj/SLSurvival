;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_CatchingHeike3_12 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(5500)
getowningquest().setstage(6000)

ActorUtil.AddPackageOverride(SLV_Ivana.GetActorRef(), SLV_FollowPlayer ,100)
SLV_Ivana.GetActorRef().evaluatePackage()
SLV_Ivana.getActorRef().moveto(Game.GetPlayer())

ActorUtil.AddPackageOverride(SLV_Valentina.GetActorRef(), SLV_FollowPlayer ,100)
SLV_Valentina.GetActorRef().evaluatePackage()
SLV_Valentina.getActorRef().moveto(Game.GetPlayer())

ActorUtil.ClearPackageOverride(SLV_Zaid.getactorref())
SLV_Zaid.GetActorRef().evaluatePackage()

ActorUtil.ClearPackageOverride(SLV_Eric.getactorref())
SLV_Eric.GetActorRef().evaluatePackage()

if ThisMenu.SkipScenes
	SLV_Ava.GetActorRef().disable()
	
	myScripts.SLV_enslavementNPC(SLV_Ivana.getActorRef())
	myScripts.SLV_enslavementChains(SLV_Ivana.getActorRef())

	myScripts.SLV_enslavementNPC(SLV_Valentina.getActorRef())
	myScripts.SLV_enslavementChains(SLV_Valentina.getActorRef())
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
SLV_Utilities Property myScripts auto
ReferenceAlias Property SLV_Ava Auto 
ReferenceAlias Property SLV_Ivana Auto 
ReferenceAlias Property SLV_Valentina Auto 
ReferenceAlias Property SLV_Zaid Auto 
ReferenceAlias Property SLV_Eric Auto 
Package Property SLV_FollowPlayer Auto

ReferenceAlias Property SLV_You Auto
SLV_MCMMenu Property ThisMenu auto
Scene Property PunishScene Auto