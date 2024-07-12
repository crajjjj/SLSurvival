;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_SolitudeFashion19 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(2000)
GetOwningQuest().SetStage(2500)

ActorUtil.AddPackageOverride(Falk.getActorRef(), SLV_BluePalace ,100)
Falk.getActorRef().evaluatePackage()

myScripts.SLV_SexlabStripNPC(Game.GetPlayer())
myScripts.SLV_SexlabStripNPC(akSpeaker)
myScripts.SLV_SexlabStripNPC(Taarie.getActorRef())
myScripts.SLV_SexlabStripNPC(Falk.getActorRef())

myScripts.SLV_DeviousUnEquipActor(akSpeaker,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true)
Utility.wait(2.0)
myScripts.SLV_DeviousUnEquipActor(Taarie.getActorRef(),true,true,true,true,true,true,true,true,true,true,true,true,true,true,true)
Utility.wait(2.0)

myScripts.SLV_DeviousEquipActorColor(akSpeaker,",white","",false,false,false,false,false,true,true,false,false,false,false,false,true,false,true)
Utility.wait(2.0)
myScripts.SLV_DeviousEquipActorColor(Taarie.getActorRef(),",red","",false,false,false,false,false,true,true,false,false,false,false,false,true,false,true)

Utility.wait(2.0)

Form ArmorOrClothes = akSpeaker.GetWornForm(Armor.GetMaskForSlot(32)) 
if ArmorOrClothes 
	akSpeaker.UnEquipItem(ArmorOrClothes , True, True)
endif
Form ArmorOrClothesTaarie = Taarie.getActorRef().GetWornForm(Armor.GetMaskForSlot(32)) 
if ArmorOrClothesTaarie
	Taarie.getActorRef().UnEquipItem(ArmorOrClothesTaarie , True, True)
endif
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Package Property SLV_BluePalace Auto
ReferenceAlias Property Taarie Auto 
ReferenceAlias Property Falk Auto 
SLV_Utilities Property myScripts auto
