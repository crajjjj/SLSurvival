;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_SolitudeFashion12 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(500)
GetOwningQuest().SetStage(1000)

ActorUtil.AddPackageOverride(akSpeaker, followPlayer ,100)
akSpeaker.evaluatePackage()

myScripts.SLV_SexlabStripNPC(akSpeaker)
myScripts.SLV_DeviousEquipActor(akSpeaker,false,false,false,false,false,true,false,false,false,false,false,false,true,false,false)
Utility.wait(2.0)

Form ArmorOrClothes = akSpeaker.GetWornForm(Armor.GetMaskForSlot(32)) 
if ArmorOrClothes 
	akSpeaker.UnEquipItem(ArmorOrClothes , True, True)
endif
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
Package Property followPlayer Auto
