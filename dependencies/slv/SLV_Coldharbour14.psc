;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_Coldharbour14 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(6500)
getowningquest().setstage(7000)

SLV_FuckSlave1.getActorRef().resurrect()
SLV_FuckSlave2.getActorRef().resurrect()
SLV_FuckSlave3.getActorRef().resurrect()
SLV_FuckSlave4.getActorRef().resurrect()

Game.GetPlayer().RemoveSpell(DLC1VampireChange)
Game.GetPlayer().AddSpell(DLC1VampireChange)
Game.GetPlayer().RemovePerk(DLC1VampireTurnPerk)			
Game.GetPlayer().AddPerk(DLC1VampireTurnPerk)

if ThisMenu.SkipScenes
	return
endif

Utility.wait(5.0)
SLV_You.getActorRef().moveto(Game.GetPlayer())

SendModEvent("dhlp-Suspend")
game.DisablePlayerControls(1, 1, 1, 0, 0, 1, 1)
game.SetPlayerAIDriven(true)
PunishScene.ForceStart()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Perk Property DLC1VampireTurnPerk Auto
Spell Property DLC1VampireChange Auto 
ReferenceAlias Property SLV_You Auto
SLV_MCMMenu Property ThisMenu auto
Scene Property PunishScene Auto

ReferenceAlias Property SLV_FuckSlave1 Auto
ReferenceAlias Property SLV_FuckSlave2 Auto
ReferenceAlias Property SLV_FuckSlave3 Auto
ReferenceAlias Property SLV_FuckSlave4 Auto
