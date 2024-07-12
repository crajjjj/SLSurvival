;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_SolitudeFashion17 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(4000)
GetOwningQuest().SetStage(6000)

myScripts.SLV_SexlabStripNPC(Taarie.getActorRef())

myScripts.SLV_DeviousUnEquipActor(Taarie.getActorRef(),true,true,true,true,true,true,true,true,true,true,true,true,true,true,true)
Utility.wait(2.0)

myScripts.SLV_DeviousEquipActorColor(Taarie.getActorRef(),",red", "",true,true,false,true,true,true,true,false,true,true,true,true,true,true,true)

Utility.wait(2.0)

Form ArmorOrClothesTaarie = Taarie.getActorRef().GetWornForm(Armor.GetMaskForSlot(32)) 
if ArmorOrClothesTaarie
	Taarie.getActorRef().UnEquipItem(ArmorOrClothesTaarie , True, True)
endif

if ThisMenu.SkipScenes
	return
endif

SendModEvent("dhlp-Suspend")
Utility.wait(10.0)

Game.getplayer().addItem(Whip)
Falk.getactorref().addItem(Whip)

game.DisablePlayerControls(1, 1, 1, 0, 0, 1, 1)
game.SetPlayerAIDriven(true)

Punishment.Start()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Scene Property Punishment  Auto 
SLV_Utilities Property myScripts auto
SLV_MCMMenu Property ThisMenu auto
ReferenceAlias Property Taarie Auto 
ReferenceAlias Property Falk Auto 
Weapon Property Whip Auto
