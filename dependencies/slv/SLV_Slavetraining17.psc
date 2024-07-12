;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_Slavetraining17 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(8000)
GetOwningQuest().SetStage(8250)

myScripts.SLV_IvanaMoodChange(false,1)

if ThisMenu.SkipScenes
	return
endif

SLV_Sven.getActorRef().addItem(Whip)
SLV_Brutus.getActorRef().addItem(Whip)

SendModEvent("dhlp-Suspend")

game.DisablePlayerControls(1, 1, 1, 0, 0, 1, 1)
game.SetPlayerAIDriven(true)

Punishment.Start()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Scene Property Punishment  Auto 
SLV_MCMMenu Property ThisMenu auto
ReferenceAlias Property SLV_Brutus Auto 
ReferenceAlias Property SLV_Sven Auto 
Weapon Property Whip Auto
SLV_Utilities Property myScripts auto
