;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 28
Scriptname SLV_ArenaFightDeadRezzing Extends Scene Hidden

;BEGIN FRAGMENT Fragment_26
Function Fragment_26()
;BEGIN CODE
int doEnslavement = Utility.RandomInt(1,100)		
myScripts.SLV_DisplayInformation("doEnslavement: " + doEnslavement + " +mcmenslavement" +  MCMMenu.arenaEnslavementProbabilty )
myScripts.SLV_DisplayInformation("slave: " + Game.getPlayer().IsInFaction(zbfFactionSlave) )
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_23
Function Fragment_23()
;BEGIN CODE
SLV_ArenaFightQuest.SetObjectiveCompleted(2500)
SLV_ArenaFightQuest.SetStage(3000)

if SLV_Fighter1 !=none
	prepareFighter(SLV_Fighter1.getActorRef())
endif
if SLV_Fighter2 !=none
	prepareFighter(SLV_Fighter2.getActorRef())
endif
if SLV_Fighter3 !=none
	prepareFighter(SLV_Fighter3.getActorRef())
endif
if SLV_Fighter4 !=none
	prepareFighter(SLV_Fighter4.getActorRef())
endif
prepareFighter( SLV_Bones.getActorRef())

ActorUtil.RemoveAllPackageOverride(SLV_DoNothing2)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
deadPlayer.ReviveDeadPlayer()
shaving.RestoreSavedHairCut(Game.getPlayer())

Game.DisablePlayerControls()
game.SetPlayerAIDriven(true)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
int doEnslavement = Utility.RandomInt(1,100)		
myScripts.SLV_DisplayInformation("doEnslavement: " + doEnslavement + " +mcmenslavement" +  MCMMenu.arenaEnslavementProbabilty )
myScripts.SLV_DisplayInformation("slave: " + Game.getPlayer().IsInFaction(zbfFactionSlave) )

if (doEnslavement <= MCMMenu.arenaEnslavementProbabilty) && (!Game.getPlayer().IsInFaction(zbfFactionSlave))

	Game.DisablePlayerControls()
	game.SetPlayerAIDriven(true)

	SLV_ArenaFightEnslavementScene.Start()
else
	debug.SendAnimationEvent(Game.getplayer(), "IdleForceDefaultState")
	Game.EnablePlayerControls()
	game.SetPlayerAIDriven(false)
	SendModEvent("dhlp-Resume")
endif
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
GlobalVariable Property SLV_SexIsRunning Auto 
SLV_PrepareDeadPlayer Property deadPlayer Auto

ReferenceAlias Property SLV_Fighter1 Auto
ReferenceAlias Property SLV_Fighter2 Auto
ReferenceAlias Property SLV_Fighter3 Auto
ReferenceAlias Property SLV_Fighter4 Auto
ReferenceAlias Property SLV_Bones Auto
Quest Property SLV_ArenaFightQuest Auto

SLV_Utilities Property myScripts auto
SLV_MCMMenu Property MCMMenu Auto
SLV_HeadShaving Property shaving Auto
Faction Property zbfFactionSlave auto
Scene Property SLV_ArenaFightEnslavementScene auto
Package Property SLV_DoNothing2 auto

function prepareFighter(Actor fighterActor)
if fighterActor == none
	return
endif

if fighterActor.isDead()
	fighterActor.resurrect()
endif

ActorUtil.ClearPackageOverride(fighterActor)
fighterActor.evaluatePackage()

debug.SendAnimationEvent(fighterActor, "IdleForceDefaultState")
fighterActor.getActorBase().SetEssential(false)
endfunction
