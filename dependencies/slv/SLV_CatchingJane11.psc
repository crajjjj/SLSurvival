;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_CatchingJane11 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(4000)
getowningquest().setstage(4500)

SLV_Slaver.ForceRefTo(SLV_Constantine.getActorRef())
;Debug.notification("New Slaver= " + SLV_Slaver.getActorRef().getActorBase().getName())
akSpeaker.addItem(Whip)

SLV_You.getActorRef().moveto(Game.GetPlayer())

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
ReferenceAlias Property SLV_Constantine Auto 