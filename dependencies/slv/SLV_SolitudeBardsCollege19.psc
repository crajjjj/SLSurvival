;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_SolitudeBardsCollege19 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(4500)
GetOwningQuest().SetStage(5000)

myScripts.SLV_SexlabStripNPC(ThisMenu.slavefollower)
myScripts.SLV_SexlabStripNPC(Ildi.getActorRef())

myScripts.SLV_DeviousUnEquipActor(ThisMenu.slavefollower,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true)
myScripts.SLV_DeviousUnEquipActor(Ildi.getActorRef(),true,true,true,true,true,true,true,true,true,true,true,true,true,true,true)
Utility.wait(2.0)

myScripts.SLV_DeviousEquipActorColor(ThisMenu.slavefollower,",white","",false,false,false,false,false,true,true,false,false,false,false,false,true,false,true)
Utility.wait(2.0)
myScripts.SLV_DeviousEquipActorColor(Ildi.getActorRef(),",red","",false,false,false,false,false,true,true,false,false,false,false,false,true,false,true)
Utility.wait(2.0)

if ThisMenu.SkipScenes
	return
endif

myScripts.SLV_StripBothHands(ThisMenu.slavefollower)
Form ArmorOrClothes =ThisMenu.slavefollower.GetWornForm(Armor.GetMaskForSlot(32)) 
if ArmorOrClothes 
	ThisMenu.slavefollower.RemoveItem(ArmorOrClothes , 1)
endif
ArmorOrClothes = Ildi.getActorRef().GetWornForm(Armor.GetMaskForSlot(32)) 
if ArmorOrClothes 
	Ildi.getActorRef().RemoveItem(ArmorOrClothes , 1)
endif

Giraurd.getActorRef().addItem(Whip)
Viarmo.getActorRef().addItem(Whip)

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
SLV_MCMMenu Property ThisMenu auto
ReferenceAlias Property Ildi Auto 
ReferenceAlias Property Giraurd Auto 
ReferenceAlias Property Viarmo Auto 
Weapon Property Whip Auto

