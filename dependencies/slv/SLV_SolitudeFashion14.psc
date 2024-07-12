;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_SolitudeFashion14 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(2500)
GetOwningQuest().SetStage(3000)

myScripts.SLV_DeviousEquipActor(SLV_Taarie.getActorRef(),false,false,false,false,false,false,false,false,false,false,true,true,false,false,false)
myScripts.SLV_SexlabStripNPC(SLV_Falk.getActorRef())

Utility.wait(2.0)

Form ArmorOrClothesTaarie = SLV_Taarie.getActorRef().GetWornForm(Armor.GetMaskForSlot(32)) 
if ArmorOrClothesTaarie
	SLV_Taarie.getActorRef().UnEquipItem(ArmorOrClothesTaarie , True, True)
endif

if ThisMenu.SkipScenes
	return
endif

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
ReferenceAlias Property SLV_Taarie Auto
ReferenceAlias Property SLV_Falk Auto
