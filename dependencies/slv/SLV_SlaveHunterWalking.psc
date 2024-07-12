;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 21
Scriptname SLV_SlaveHunterWalking Extends Scene Hidden

;BEGIN FRAGMENT Fragment_9
Function Fragment_9()
;BEGIN CODE
SLV_You.getActorRef().moveto(Game.getPlayer())

ActorUtil.ClearPackageOverride(SLV_BountyHunter1.getActorRef())
SLV_BountyHunter1.getActorRef().evaluatePackage()

ActorUtil.ClearPackageOverride(SLV_BountyHunter2.getActorRef())
SLV_BountyHunter2.getActorRef().evaluatePackage()

GetOwningQuest().SetObjectiveCompleted(2500)
GetOwningQuest().SetStage(3000)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_3
Function Fragment_3()
;BEGIN CODE
if !game.getplayer().IsInFaction(SLV_FactionEscortSlave)
	game.getplayer().addtoFaction(SLV_FactionEscortSlave)

	if SLV_StoryMode.getvalue() != 0
		myScripts.SLV_PlayerMoveTo(waypoint3)

		SLV_BountyHunter1.getActorRef().moveto(waypoint3)
		SLV_BountyHunter2.getActorRef().moveto(waypoint3)
	else
		myScripts.SLV_PlayerMoveTo(waypoint_Whiterun)

		SLV_BountyHunter1.getActorRef().moveto(waypoint_Whiterun)
		SLV_BountyHunter2.getActorRef().moveto(waypoint_Whiterun)
	endif
endif
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
debug.SendAnimationEvent(Game.getplayer(), "IdleForceDefaultState")
Game.EnablePlayerControls()
game.SetPlayerAIDriven(false)
SendModEvent("dhlp-Resume")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_13
Function Fragment_13()
;BEGIN CODE
slv_sexisrunning.setvalue(1)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
ObjectReference Property waypoint3 auto

GlobalVariable Property SLV_StoryMode Auto 
ObjectReference Property waypoint_Whiterun auto

SLV_Utilities Property myScripts auto

Faction Property SLV_FactionEscortSlave auto
ReferenceAlias Property SLV_BountyHunter1 Auto
ReferenceAlias Property SLV_BountyHunter2 Auto
ReferenceAlias Property SLV_You Auto

GlobalVariable Property SLV_SexIsRunning Auto 


