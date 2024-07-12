;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_MarkarthSlavery15 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(8000)
GetOwningQuest().SetStage(8500)

myScripts.SLV_DeviousEquip(true,true,false,false,false,true,true,true,false,true,true,true,true,true,false)

if ThisMenu.SkipScenes
	return
endif
 
SendModEvent("dhlp-Suspend")
akSpeaker.addItem(Whip)
game.DisablePlayerControls(1, 1, 1, 0, 0, 1, 1)
game.SetPlayerAIDriven(true)
PunishScene.Start()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SlV_MCMMenu Property ThisMenu auto
Scene Property PunishScene  Auto 
Weapon Property Whip Auto
SLV_Utilities Property myScripts auto