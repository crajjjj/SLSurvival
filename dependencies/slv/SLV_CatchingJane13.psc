;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_CatchingJane13 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(5000)
getowningquest().setstage(5500)

SLV_Slave.ForceRefTo(akSpeaker)
;Debug.notification("New Slave= " + SLV_Slave.getActorRef().getActorBase().getName())

SLV_Slaver.ForceRefTo(SLV_Igor.getActorRef())
;Debug.notification("New Slaver= " + SLV_Slaver.getActorRef().getActorBase().getName())

SLV_You.getActorRef().moveto(Game.GetPlayer())
Game.getplayer().addItem(Whip)

SendModEvent("dhlp-Suspend")
game.DisablePlayerControls(1, 1, 1, 0, 0, 1, 1)
game.SetPlayerAIDriven(true)
PunishScene.ForceStart()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Weapon Property Whip Auto
ReferenceAlias Property SLV_You Auto
SLV_MCMMenu Property ThisMenu auto
Scene Property PunishScene  Auto
ReferenceAlias Property SLV_Slaver Auto
ReferenceAlias Property SLV_Slave Auto
ReferenceAlias Property SLV_Igor Auto 