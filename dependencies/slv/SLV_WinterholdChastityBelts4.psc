;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_WinterholdChastityBelts4 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
WinterholdSlavery.SetObjectiveCompleted(3500)
WinterholdSlavery.setStage(4000)

myScripts.SLV_SexlabStripNPC(Game.GetPlayer())
myScripts.SLV_DeviousUnEquip(false,false,false,true,false,false,false,false,false,false,false,false,false,false,false)
Utility.wait(2.0)

if ThisMenu.SkipScenes
	GetOwningQuest().SetObjectiveCompleted(1500)
	GetOwningQuest().SetStage(2000)
	return
endif
akSpeaker.addItem(Whip)
SendModEvent("dhlp-Suspend")

game.DisablePlayerControls(1, 1, 1, 0, 0, 1, 1)
game.SetPlayerAIDriven(true)
PunishScene.Start()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SlV_MCMMenu Property ThisMenu auto
Scene Property PunishScene  Auto  
Weapon Property Whip Auto
SLV_Utilities Property myScripts auto
Quest Property WinterholdSlavery Auto