;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_WindhelmSlavery27 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(4500)
GetOwningQuest().SetStage(4750)

if ThisMenu.SkipScenes
	return
endif
SendModEvent("dhlp-Suspend")
akSpeaker.addItem(Whip)

Dremora1.getActorRef().enable()
Thalmor1.getActorRef().enable()

ActorUtil.AddPackageOverride(akSpeaker, gotoDungeon,100)
akSpeaker.evaluatePackage()
ActorUtil.AddPackageOverride(Dremora1.getActorRef(), gotoDungeon,100)
Dremora1.getActorRef().evaluatePackage()
ActorUtil.AddPackageOverride(Thalmor1.getActorRef(), gotoDungeon,100)
Thalmor1.getActorRef().evaluatePackage()

Dremora1.getActorRef().additem(Whip)
Thalmor1.getActorRef().additem(Whip)

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

ReferenceAlias Property Dremora1 Auto 
ReferenceAlias Property Thalmor1 Auto 
Package Property gotoDungeon Auto
