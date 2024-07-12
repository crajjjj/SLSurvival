;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_MainquestSpecial6_13 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(1500)
getowningquest().setstage(2000)

Dog1.getActorRef().enable()
Dog2.getActorRef().enable()

ActorUtil.AddPackageOverride(Dog1.getActorRef(), npcIdle ,100)
Dog1.getActorRef().evaluatePackage()
ActorUtil.AddPackageOverride(Dog2.getActorRef(), npcIdle ,100)
Dog2.getActorRef().evaluatePackage()
ActorUtil.AddPackageOverride(akSpeaker , npcIdle ,100)
akSpeaker.evaluatePackage()

Horse1.getActorRef().disable()
Horse2.getActorRef().disable()

if ThisMenu.SkipScenes
	return
endif

SendModEvent("dhlp-Suspend")
game.DisablePlayerControls(1, 1, 1, 0, 0, 1, 1)
game.SetPlayerAIDriven(true)

PunishScene.Start()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
ReferenceAlias Property Dog1 Auto 
ReferenceAlias Property Dog2 Auto 
ReferenceAlias Property Horse1 Auto 
ReferenceAlias Property Horse2 Auto 

SLV_MCMMenu Property ThisMenu auto
Scene Property PunishScene  Auto 
Package Property npcIdle Auto
