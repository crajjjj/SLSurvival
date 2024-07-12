;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_CatchingJane7 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(1500)
getowningquest().setstage(2000)

waittimer.StartCatchingJaneTimer()

if ThisMenu.SkipScenes
	ActorUtil.ClearPackageOverride(SLV_Jane.getactorref())
	SLV_Jane.GetActorRef().evaluatePackage()

	ActorUtil.ClearPackageOverride(SLV_Constantine.getactorref())
	SLV_Constantine.GetActorRef().evaluatePackage()

	Utility.wait(10.0)

	SLV_Jane.getactorref().disable()
	SLV_Constantine.getactorref().disable()
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
ReferenceAlias Property SLV_Jane Auto 
ReferenceAlias Property SLV_Constantine Auto 
SLV_CatchingJane_Timer Property waittimer auto
ReferenceAlias Property SLV_You Auto
SLV_MCMMenu Property ThisMenu auto
Scene Property PunishScene  Auto
