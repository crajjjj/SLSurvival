;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 5
Scriptname SLV_ArenaFightRezzGladiator Extends Scene Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
arena.clearFighter( SLV_Bones.getActorRef())

ActorUtil.RemoveAllPackageOverride(SLV_DoNothing2)

debug.SendAnimationEvent(Game.getplayer(), "IdleForceDefaultState")
Game.EnablePlayerControls()
game.SetPlayerAIDriven(false)
SendModEvent("dhlp-Resume")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_4
Function Fragment_4()
;BEGIN CODE
if SLV_Fighter1 != none
	arena.clearFighter(SLV_Fighter1.getActorRef())
endif
if SLV_Fighter2 != none
	arena.clearFighter(SLV_Fighter2.getActorRef())
endif
if SLV_Fighter3 != none
	arena.clearFighter(SLV_Fighter3.getActorRef())
endif
if SLV_Fighter4 != none
	arena.clearFighter(SLV_Fighter4.getActorRef())
endif
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
ReferenceAlias Property SLV_Fighter1 Auto
ReferenceAlias Property SLV_Fighter2 Auto
ReferenceAlias Property SLV_Fighter3 Auto
ReferenceAlias Property SLV_Fighter4 Auto
ReferenceAlias Property SLV_Bones Auto

SLV_Utilities Property myScripts auto
SLV_ArenaUtilities Property arena Auto
Package Property SLV_DoNothing2 auto
GlobalVariable Property SLV_ColosseumFightMode Auto
