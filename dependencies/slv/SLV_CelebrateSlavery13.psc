;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_CelebrateSlavery13 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
if SLV_Abolitionismquest.isrunning()
	SLV_Abolitionismquest.FailAllObjectives()
	SLV_Abolitionismquest.SetStage(10000)
endif
if SLV_DeadslaveWalkingquest.isrunning()
	SLV_DeadslaveWalkingquest.FailAllObjectives()
	SLV_DeadslaveWalkingquest.SetStage(10000)
endif

myScripts.SLV_SexlabStripNPC(Game.GetPlayer())
myScripts.SLV_DeviousUnEquip(true,true,true,true,true,true,true,true,true,true,true,true,true,true,true)

Form ArmorOrClothes = Game.GetPlayer().GetWornForm(Armor.GetMaskForSlot(32)) 
if ArmorOrClothes 
	Game.GetPlayer().UnEquipItem(ArmorOrClothes , True, True)
endif

if ThisMenu.SkipScenes
	GetOwningQuest().SetObjectiveCompleted(7000)
	GetOwningQuest().SetStage(10000)
	if ThisMenu.DieOnBadEnd
		Game.GetPlayer().kill()
	endif
	return
endif
SendModEvent("dhlp-Suspend")

game.DisablePlayerControls(true, true, false, true, true, true, true, true)
game.SetPlayerAIDriven(true)
PunishScene.Start()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_MCMMenu Property ThisMenu auto
Scene Property PunishScene  Auto
SLV_Utilities Property myScripts auto

Quest Property SLV_Abolitionismquest Auto
Quest Property SLV_DeadslaveWalkingquest Auto
Quest Property SLV_SlaveryMainquest Auto

