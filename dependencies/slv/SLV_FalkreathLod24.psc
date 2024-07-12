;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_FalkreathLod24 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(500)
GetOwningQuest().SetStage(1000)

ActorUtil.ClearPackageOverride(Nenya.getActorRef())
Nenya.getActorRef().evaluatePackage()
Form ArmorOrClothes = Nenya.getActorRef().GetWornForm(Armor.GetMaskForSlot(32)) 
if ArmorOrClothes 
	Nenya.getActorRef().RemoveItem(ArmorOrClothes , 1)
endif

Nenya.getActorRef().moveto(game.getPlayer())
ActorUtil.AddPackageOverride(Nenya.getActorRef(), SLV_DoNothing,100)
Nenya.getActorRef().evaluatePackage()
myScripts.SLV_SexlabStripNPC(Nenya.getActorRef())

myScripts.SLV_DeviousUnEquipActor(Nenya.getActorRef(),true,true,true,true,true,true,true,true,true,true,true,true,true,true,true)
Utility.wait(2.0)

myScripts.SLV_DeviousEquipActor(Nenya.getActorRef(),false,false,false,false,false,false,false,false,false,false,true,true,false,false,false)

ArmorOrClothes = Nenya.getActorRef().GetWornForm(Armor.GetMaskForSlot(32)) 
if ArmorOrClothes 
	Nenya.getActorRef().UnEquipItem(ArmorOrClothes , True, True)
endif

myScripts.SLV_Play3Sex(Nenya.getActorRef(),akSpeaker, MCMMenu.malefollower,"FMM", true)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_MCMMenu Property MCMMenu Auto
SLV_Utilities Property myScripts auto
ReferenceAlias Property Nenya Auto 
Package Property SLV_DoNothing Auto

