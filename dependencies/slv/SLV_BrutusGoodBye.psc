;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 9
Scriptname SLV_BrutusGoodBye Extends Scene Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
debug.SendAnimationEvent(Game.getplayer(), "IdleForceDefaultState")
debug.SendAnimationEvent(SLV_Valentina.getactorref(), "IdleForceDefaultState")
if SLV_Follower
	debug.SendAnimationEvent(SLV_Follower.getactorref(), "IdleForceDefaultState")
endif

GetOwningQuest().SetObjectiveCompleted(0)
GetOwningQuest().SetStage(50)

Game.EnablePlayerControls()
game.SetPlayerAIDriven(false)
SendModEvent("dhlp-Resume")
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
ReferenceAlias Property SLV_Valentina Auto 
ReferenceAlias Property SLV_Follower  Auto
