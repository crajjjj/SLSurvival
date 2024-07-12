;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 7
Scriptname SLV_ArenaFightGangbang Extends Scene Hidden

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
slv_sexisrunning.setvalue(1)
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

;BEGIN FRAGMENT Fragment_4
Function Fragment_4()
;BEGIN CODE
debug.SendAnimationEvent(Game.getplayer(), "ZazAPCAO052")
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
ReferenceAlias Property SLV_Fighter1 Auto
ReferenceAlias Property SLV_Fighter2 Auto
ReferenceAlias Property SLV_Fighter3 Auto
ReferenceAlias Property SLV_Fighter4 Auto
GlobalVariable Property SLV_SexIsRunning Auto 


Actor Property PlayerRef Auto
SLV_ArenaFightTimer Property arenaTimer Auto

function startfighting(Actor Fighter)
if Fighter.isDead()
	return
endif

Fighter.startcombat(PlayerRef)
endfunction
