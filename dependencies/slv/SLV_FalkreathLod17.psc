;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_FalkreathLod17 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(2600)
GetOwningQuest().SetStage(3100)

Form ArmorOrClothes = Nenya.getActorRef().GetWornForm(Armor.GetMaskForSlot(32)) 
if ArmorOrClothes 
	Nenya.getActorRef().UnEquipItem(ArmorOrClothes , True, True)
endif

myScripts.SLV_DeviousEquipActor(Nenya.getActorRef(),true,false,false,false,false,false,false,false,false,true,false,false,false,false,false)
myScripts.SLV_Play2Sex(Nenya.getActorRef(),akSpeaker, "", true)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
ReferenceAlias Property Nenya Auto 

