;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_SolitudeFashion22 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(3000)
GetOwningQuest().SetStage(3500)

myScripts.SLV_SexlabStripNPC(Game.GetPlayer())
myScripts.SLV_SexlabStripNPC(akSpeaker)
myScripts.SLV_SexlabStripNPC(Taarie.getActorRef())
myScripts.SLV_SexlabStripNPC(Falk.getActorRef())

myScripts.SLV_DeviousUnEquipActor(akSpeaker,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true)
Utility.wait(2.0)
myScripts.SLV_DeviousUnEquipActor(Taarie.getActorRef(),true,true,true,true,true,true,true,true,true,true,true,true,true,true,true)
Utility.wait(5.0)

myScripts.SLV_DeviousEquipActorColor(akSpeaker,",white","",false,false,true,false,false,false,true,false,false,false,false,false,true,true,false)
Utility.wait(2.0)
myScripts.SLV_DeviousEquipActorColor(Taarie.getActorRef(),",red","",false,false,true,false,false,false,true,false,false,false,false,false,true,true,false)
Utility.wait(5.0)

Form ArmorOrClothes = akSpeaker.GetWornForm(Armor.GetMaskForSlot(32)) 
if ArmorOrClothes 
	akSpeaker.UnEquipItem(ArmorOrClothes , True, True)
endif
Form ArmorOrClothesTaarie = Taarie.getActorRef().GetWornForm(Armor.GetMaskForSlot(32)) 
if ArmorOrClothesTaarie
	Taarie.getActorRef().UnEquipItem(ArmorOrClothesTaarie , True, True)
endif
if ThisMenu.SkipScenes
	return
endif
SLV_UseFollowerSex.setValue(1)

SendModEvent("dhlp-Suspend")

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
ReferenceAlias Property Taarie Auto 
ReferenceAlias Property Falk Auto 
GlobalVariable Property SLV_UseFollowerSex Auto 