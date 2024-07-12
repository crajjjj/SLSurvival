;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_MainquestSpecial7_15 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(6500)
GetOwningQuest().SetStage(7500)

myScripts.SLV_DeviousUnEquipActor(Camilla.getActorRef(),true,false,false,true,true,false,false,true,true,true,false,false,false,false,false)
myScripts.SLV_DeviousUnEquip(true,false,true,true,true,false,false,true,true,true,false,false,false,false,false)

ActorUtil.ClearPackageOverride(Camilla.getActorref())
Camilla.getActorref().evaluatePackage()

if ThisMenu.SkipScenes
	return
endif
akSpeaker.addItem(Whip)

SendModEvent("dhlp-Suspend")
game.DisablePlayerControls(1, 1, 1, 0, 0, 1, 1)
game.SetPlayerAIDriven(true)
PunishScene.Start()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_MCMMenu Property ThisMenu auto
Scene Property PunishScene  Auto  
Weapon Property Whip Auto
ReferenceAlias Property Camilla Auto 
SLV_Utilities Property myScripts auto