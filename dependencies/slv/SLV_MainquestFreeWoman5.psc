;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_MainquestFreeWoman5 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
myScripts.SLV_enslavement(true)

Actor player = Game.GetPlayer()
player.RemoveFromFaction(SlaverunSlaverFaction) 
player.RemoveFromFaction(SlaverunSlaveMasterFaction ) 

SLV_You.getActorRef().moveto(Game.GetPlayer())

myScripts.SLV_StripBothHands(player)
Armor ankleiron = Game.GetFormFromFile(0x004009, "ZaZAnimationPack.esm") as Armor
player.equipItem(ankleiron)
Armor wristiron = Game.GetFormFromFile(0x001008, "ZaZAnimationPack.esm") as Armor
player.equipItem(wristiron)

if SLV_Main.getStage() < 2000
	myScripts.SLV_enableMundus()
endif


if ThisMenu.SkipScenes
	myScripts.SLV_EnslavePlayer(true,true)
	return
endif

SendModEvent("dhlp-Suspend")
game.DisablePlayerControls(1, 1, 1, 0, 0, 1, 1)
game.SetPlayerAIDriven(true)

PunishScene.ForceStart()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
ReferenceAlias Property SLV_You Auto
SLV_MCMMenu Property ThisMenu auto
Scene Property PunishScene  Auto
Faction Property SlaverunSlaverFaction auto
Faction Property SlaverunSlaveMasterFaction auto
SLV_Utilities Property myScripts auto
Quest Property SLV_Main Auto 
