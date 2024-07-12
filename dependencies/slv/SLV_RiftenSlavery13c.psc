;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_RiftenSlavery13c Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(6000)
GetOwningQuest().SetStage(7500)

if ThisMenu.slavefollower
	Slave.ForceRefTo(ThisMenu.slavefollower)
endif

if ThisMenu.SkipScenes
	return
endif

SendModEvent("dhlp-Suspend")

game.DisablePlayerControls(1, 1, 1, 0, 0, 1, 1)
game.ForceThirdPerson()
game.SetPlayerAIDriven(true)
PunishScene.Start()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_MCMMenu Property ThisMenu auto
Scene Property PunishScene Auto  
ReferenceAlias Property Slave  Auto
