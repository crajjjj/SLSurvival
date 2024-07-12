;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_CatchingIvana10 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(5000)
GetOwningQuest().SetStage(5500)

SLV_AmputeeIvana.setValue(6)

if ThisMenu.SkipScenes || (!ThisMenu.StoryMode)
	Amputee.SLV_AmputeeActor(SLV_Ivana.getActorRef(),SLV_AmputeeIvana.getValue() as int)

	int bodypart = SLV_AmputeeIvana.getValue() as int

	Amputee.SLV_ApplyProstetics(SLV_Ivana.getactorref(), bodypart)
	myScripts.SLV_IvanaReset()
	return
endif

SLV_You.getActorRef().moveto(Game.GetPlayer())

SendModEvent("dhlp-Suspend")
game.DisablePlayerControls(1, 1, 1, 0, 0, 1, 1)
game.SetPlayerAIDriven(true)
PunishScene.ForceStart()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
ReferenceAlias Property SLV_You Auto
SLV_MCMMenu Property ThisMenu auto
Scene Property PunishScene Auto 
GlobalVariable Property SLV_AmputeeIvana Auto

SLV_Utilities Property myScripts auto
SLV_Amputee Property Amputee Auto
ReferenceAlias Property SLV_Ivana Auto

