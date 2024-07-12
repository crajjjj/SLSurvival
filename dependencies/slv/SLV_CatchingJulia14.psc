;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_CatchingJulia14 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(5000)
getowningquest().setstage(5500)

ActorUtil.AddPackageOverride(SLV_Igor.GetActorRef(), SLV_FollowPlayer ,100)
SLV_Igor.GetActorRef().evaluatePackage()

if ThisMenu.SkipScenes
	return
endif

SLV_You.getActorRef().moveto(Game.GetPlayer())

SendModEvent("dhlp-Suspend")
game.DisablePlayerControls(1, 1, 1, 0, 0, 1, 1)
game.SetPlayerAIDriven(true)
BeatScene.start()

;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
ReferenceAlias Property SLV_Igor Auto 
Package Property SLV_FollowPlayer Auto
ReferenceAlias Property SLV_You Auto
Scene Property BeatScene  Auto  
SLV_MCMMenu Property ThisMenu auto
