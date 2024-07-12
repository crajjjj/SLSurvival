;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 9
Scriptname SLV_ArenaFightWinning Extends Scene Hidden

;BEGIN FRAGMENT Fragment_8
Function Fragment_8()
;BEGIN CODE
int fightmode = SLV_ColosseumFightMode.getValue() as int

if SLV_ColosseumFightMode.getValue() == 2  || SLV_ColosseumFightMode.getValue() == 3
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
	arena.clearFighter( SLV_Bones.getActorRef())

	ActorUtil.RemoveAllPackageOverride(SLV_DoNothing2)

	debug.SendAnimationEvent(Game.getplayer(), "IdleForceDefaultState")
	Game.EnablePlayerControls()
	game.SetPlayerAIDriven(false)
	SendModEvent("dhlp-Resume")
endif
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
if SLV_ColosseumFightMode.getValue() == 0  || SLV_ColosseumFightMode.getValue() == 1
	NextScene1.Start()
else
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
	arena.clearFighter( SLV_Bones.getActorRef())

	ActorUtil.RemoveAllPackageOverride(SLV_DoNothing2)

	debug.SendAnimationEvent(Game.getplayer(), "IdleForceDefaultState")
	Game.EnablePlayerControls()
	game.SetPlayerAIDriven(false)
	SendModEvent("dhlp-Resume")
endif
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Scene Property NextScene1  Auto  
ReferenceAlias Property SLV_Fighter1 Auto
ReferenceAlias Property SLV_Fighter2 Auto
ReferenceAlias Property SLV_Fighter3 Auto
ReferenceAlias Property SLV_Fighter4 Auto
ReferenceAlias Property SLV_Bones Auto

SLV_Utilities Property myScripts auto
SLV_ArenaUtilities Property arena Auto
Package Property SLV_DoNothing2 auto
GlobalVariable Property SLV_ColosseumFightMode Auto
