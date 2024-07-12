;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 13
Scriptname SLV_ArenaFightPresentFighter Extends Scene Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
debug.SendAnimationEvent(Game.getplayer(), "IdleForceDefaultState")
Game.EnablePlayerControls()
game.SetPlayerAIDriven(false)
SendModEvent("dhlp-Resume")

Utility.wait(2.0)
GetOwningQuest().SetObjectiveCompleted(1000)
GetOwningQuest().SetStage(1500)

if MCMMenu.dontDieInArena || SLV_ColosseumFightMode.getValue() == 2  || SLV_ColosseumFightMode.getValue() == 3
	Game.getPlayer().GetActorBase().SetEssential(true)
endif

if SLV_Fighter1 != none
	startfighting(SLV_Fighter1.getActorRef())
endif
if SLV_Fighter2 != none
	startfighting(SLV_Fighter2.getActorRef())
endif
if SLV_Fighter3 != none
	startfighting(SLV_Fighter3.getActorRef())
endif
if SLV_Fighter4 != none
	startfighting(SLV_Fighter4.getActorRef())
endif

arenaTimer.StartArenaTimer()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
ReferenceAlias Property SLV_Fighter1 Auto
ReferenceAlias Property SLV_Fighter2 Auto
ReferenceAlias Property SLV_Fighter3 Auto
ReferenceAlias Property SLV_Fighter4 Auto
SLV_MCMMenu Property MCMMenu Auto
GlobalVariable Property SLV_ColosseumFightMode Auto

Actor Property PlayerRef Auto
SLV_ArenaFightTimer Property arenaTimer Auto

function startfighting(Actor Fighter)

;ActorUtil.ClearPackageOverride(Fighter)
;Fighter.evaluatePackage()

if Fighter == none
	return
endif

if SLV_ColosseumFightMode.getValue() == 2  || SLV_ColosseumFightMode.getValue() == 3
	Fighter.GetActorBase().SetEssential(true)
endif

Fighter.startcombat(PlayerRef)
endfunction
