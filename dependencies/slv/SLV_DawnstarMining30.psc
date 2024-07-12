;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_DawnstarMining30 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
if MCMMenu.SkipScenes
	return
endif
akSpeaker.addItem(Whip)
Game.getplayer().addItem(Whip)
SendModEvent("dhlp-Suspend")

pPisser.ForceRefTo(akSpeaker)
;Debug.notification("New pPisser= " + (pPisser.GetRef() as Actor).getActorBase().getName())
Slave.ForceRefTo(MCMMenu.slavefollower)

game.DisablePlayerControls(1, 1, 1, 0, 0, 1, 1)
game.SetPlayerAIDriven(true)
PunishScene.Start()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_MCMMenu Property MCMMenu auto
ReferenceAlias Property pPisser  Auto  
ReferenceAlias Property Slave  Auto  
Scene Property PunishScene  Auto  
Weapon Property Whip Auto

