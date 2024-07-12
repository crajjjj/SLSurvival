;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_MainquestSpecial7_12 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(5000)
GetOwningQuest().SetStage(5500)

ActorUtil.AddPackageOverride(akSpeaker,SLV_Followplayer,100)
akSpeaker.evaluatePackage()

if ThisMenu.SkipScenes
	return
endif
Camilla.Getactorref().addItem(Whip)

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
Package Property SLV_Followplayer Auto
ReferenceAlias Property Camilla Auto 
