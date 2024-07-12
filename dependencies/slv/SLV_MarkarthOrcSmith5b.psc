;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_MarkarthOrcSmith5b Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(2000)
GetOwningQuest().SetStage(2500)

if ThisMenu.SkipScenes
	return
endif
 
SLV_SlaveFollower.ForceRefTo(ThisMenu.slavefollower)
;Debug.notification("New SlaveFollower= " + SLV_Slaver.getActorRef().getActorBase().getName())

SendModEvent("dhlp-Suspend")
Game.GetPlayer().addItem(Whip)
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
ReferenceAlias Property SLV_SlaveFollower Auto
