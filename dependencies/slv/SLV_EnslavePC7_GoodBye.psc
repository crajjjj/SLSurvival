;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 6
Scriptname SLV_EnslavePC7_GoodBye Extends Scene Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
debug.SendAnimationEvent(Game.getplayer(), "IdleForceDefaultState")
if SLV_Follower
	debug.SendAnimationEvent(SLV_Follower.getactorref(), "IdleForceDefaultState")
endif

ActorUtil.AddPackageOverride(SLV_Diamond.getActorRef(), SLV_Kneeling ,100)
SLV_Diamond.getActorRef().evaluatePackage()

GetOwningQuest().SetObjectiveCompleted(0)
GetOwningQuest().SetStage(500)

Game.EnablePlayerControls()
game.SetPlayerAIDriven(false)
SendModEvent("dhlp-Resume")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_3
Function Fragment_3()
;BEGIN CODE
debug.SendAnimationEvent(Game.getplayer(), "IdleForceDefaultState")
if SLV_Follower
	debug.SendAnimationEvent(SLV_Follower.getactorref(), "IdleForceDefaultState")
endif
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
ReferenceAlias Property SLV_Follower  Auto
ReferenceAlias Property SLV_Diamond Auto
Package Property SLV_Kneeling Auto

