;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_SolitudeFashion16 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(3500)
GetOwningQuest().SetStage(4000)

myScripts.SLV_SexlabStripNPC(SLV_Taarie.getActorRef())
myScripts.SLV_SexlabStripNPC(Falk.getActorRef())

;myScripts.SLV_DeviousUnEquip(true,true,true,true,true,true,true,true,true,true,true,true,true,true,true)
;Utility.wait(2.0)

myScripts.SLV_DeviousEquipActorColor(SLV_Taarie.getActorRef(),",red","",false,false,false,false,false,true,true,true,false,false,true,true,true,true,true)

Utility.wait(2.0)

Form ArmorOrClothesTaarie = SLV_Taarie.getActorRef().GetWornForm(Armor.GetMaskForSlot(32)) 
if ArmorOrClothesTaarie
	SLV_Taarie.getActorRef().UnEquipItem(ArmorOrClothesTaarie , True, True)
endif

if ThisMenu.SkipScenes
	return
endif

SendModEvent("dhlp-Suspend")
Game.getplayer().addItem(Whip)
Falk.getactorref().addItem(Whip)
Utility.wait(5.0)

game.DisablePlayerControls(1, 1, 1, 0, 0, 1, 1)
game.SetPlayerAIDriven(true)

Punishment.Start()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Scene Property Punishment  Auto 
SLV_Utilities Property myScripts auto
SlV_MCMMenu Property ThisMenu auto
ReferenceAlias Property SLV_Taarie Auto 
ReferenceAlias Property Falk Auto 
Weapon Property Whip Auto

