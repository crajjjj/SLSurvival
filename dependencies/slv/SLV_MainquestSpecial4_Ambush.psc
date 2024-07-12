;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 10
Scriptname SLV_MainquestSpecial4_Ambush Extends Scene Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
if ! game.getPlayer().isinfaction(zbfSlaverfaction)
	debug.SendAnimationEvent(game.getplayer(), "ZazAPC011")
	NextScene.Start()
else
	Debug.notification("The Stormcloak soldiers invites you to follow him to a camp.")
	Game.EnablePlayerControls()
	game.SetPlayerAIDriven(false)
	ActorUtil.ClearPackageOverride(soldier.getActorRef())
	soldier.getActorRef().evaluatePackage()
	ActorUtil.ClearPackageOverride(campleader.getActorRef())
	campleader.getActorRef().evaluatePackage()
endif
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Faction Property zbfSlaverFaction Auto
Scene Property NextScene  Auto  

ReferenceAlias Property Soldier Auto 
ReferenceAlias Property Campleader Auto 

