;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_MainquestSpecial3End Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
SLV_quest.SetObjectiveCompleted(6250)
SLV_quest.SetStage(6300)

myScripts.SLV_miniLevelUp()
if ThisMenu.SkipScenes
	GetOwningQuest().SetObjectiveCompleted(6000)
	GetOwningQuest().SetStage(6500)
	return
endif


;SLV_You.getActorRef().moveto(Game.GetPlayer())

;SLV_AmputeePlayer.setValue(9)

;SendModEvent("dhlp-Suspend")
;game.DisablePlayerControls(1, 1, 1, 0, 0, 1, 1)
;game.SetPlayerAIDriven(true)
;PunishScene.ForceStart()

GetOwningQuest().SetObjectiveCompleted(6000)
GetOwningQuest().SetStage(6500)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
ReferenceAlias Property SLV_You Auto
Scene Property PunishScene Auto 
GlobalVariable Property SLV_AmputeePlayer Auto
SLV_Utilities Property myScripts auto
SLV_MCMMenu Property ThisMenu Auto
Quest Property SLV_quest Auto
