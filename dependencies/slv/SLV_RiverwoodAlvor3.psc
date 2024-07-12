;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_RiverwoodAlvor3 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(1000)
getowningquest().setstage(2500)

if ThisMenu.SkipScenes
	return
endif

akSpeaker.additem(Whip)

Int newItems = newItemEnabling.Length
While newItems 
	newItems -= 1
	newItemEnabling[newItems].Enable()
EndWhile

ActorUtil.AddPackageOverride(akSpeaker, SLV_Followplayer ,100)
akSpeaker.evaluatePackage()

SLV_You.getActorRef().moveto(Game.GetPlayer())
SendModEvent("dhlp-Suspend")
game.DisablePlayerControls(1, 1, 1, 0, 0, 1, 1)
game.SetPlayerAIDriven(true)
PunishScene.Start()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
ObjectReference[] Property newItemEnabling Auto
Scene Property PunishScene  Auto  
Weapon Property Whip Auto
Package Property SLV_Followplayer Auto
SlV_MCMMenu Property ThisMenu auto
ReferenceAlias Property SLV_You Auto 


