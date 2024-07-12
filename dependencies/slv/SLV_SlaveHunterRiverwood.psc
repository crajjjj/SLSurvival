;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 22
Scriptname SLV_SlaveHunterRiverwood Extends Scene Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
SLV_SlaveHunterHumiliation.Forcestart()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
SLV_You.getActorRef().moveto(Game.getPlayer())
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_8
Function Fragment_8()
;BEGIN CODE
;SLV_FindSpectators.stop()
;SLV_FindSpectators.reset()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_18
Function Fragment_18()
;BEGIN CODE
SLV_You.getActorRef().moveto(Game.getPlayer())
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_20
Function Fragment_20()
;BEGIN CODE
debug.SendAnimationEvent(Game.getplayer(), "ZazAPOA001")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_16
Function Fragment_16()
;BEGIN CODE
SLV_You.getActorRef().moveto(Game.getPlayer())
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_14
Function Fragment_14()
;BEGIN CODE
SLV_You.getActorRef().moveto(Game.getPlayer())

if !game.getplayer().IsInFaction(SLV_FactionEscortSlave)
	game.getplayer().addtoFaction(SLV_FactionEscortSlave)

	myScripts.SLV_PlayerMoveTo(waypoint)

	SLV_BountyHunter1.getActorRef().moveto(waypoint)
	SLV_BountyHunter2.getActorRef().moveto(waypoint)
	SLV_BountyHunterDog.getActorRef().moveto(waypoint)
endif
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_5
Function Fragment_5()
;BEGIN CODE
SLV_FindSpectators.start()
SLV_You.getActorRef().moveto(Game.getplayer())

slaveHunterHelper.SLV_FillWatcherRefs()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
ObjectReference Property waypoint auto
Quest Property SLV_FindSpectators Auto 
SLV_Utilities Property myScripts auto
Faction Property SLV_FactionEscortSlave auto

ReferenceAlias Property SLV_BountyHunter1 Auto
ReferenceAlias Property SLV_BountyHunter2 Auto
ReferenceAlias Property SLV_BountyHunterDog Auto
ReferenceAlias Property SLV_You Auto

GlobalVariable Property SLV_SexIsRunning Auto 
SLV_FindSpecators Property spectators auto
SLV_SlaveHunter Property slaveHunter auto
SLV_SlaveHunterHelper Property slaveHunterHelper auto

Scene Property SLV_SlaveHunterHumiliation auto


