;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_MainquestSpecial10_15 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(4500)
getowningquest().setstage(5000)

if ThisMenu.SkipScenes
	return
endif

ActorUtil.AddPackageOverride(akSpeaker, SLV_FollowPlayer ,100)
akSpeaker.evaluatePackage()
akSpeaker.additem(SLV_Cane)

ActorUtil.ClearPackageOverride(SLV_Maul.GetActorRef())
SLV_Maul.GetActorRef().evaluatePackage()
SLV_Maul.GetActorRef().moveto(Game.getPlayer())
ActorUtil.AddPackageOverride(SLV_Maul.GetActorRef(), SLV_FollowPlayer ,100)
SLV_Maul.GetActorRef().evaluatePackage()
SLV_Maul.GetActorRef().additem(SLV_Cane)

ActorUtil.ClearPackageOverride(SLV_Saul.GetActorRef())
SLV_Saul.GetActorRef().evaluatePackage()
SLV_Saul.GetActorRef().moveto(Game.getPlayer())
ActorUtil.AddPackageOverride(SLV_Saul.GetActorRef(), SLV_FollowPlayer ,100)
SLV_Saul.GetActorRef().evaluatePackage()
SLV_Saul.GetActorRef().additem(SLV_Cane)

ActorUtil.ClearPackageOverride(SLV_Brynjolf.GetActorRef())
SLV_Brynjolf.GetActorRef().evaluatePackage()
SLV_Brynjolf.GetActorRef().moveto(Game.getPlayer())
ActorUtil.AddPackageOverride(SLV_Brynjolf.GetActorRef(), SLV_FollowPlayer ,100)
SLV_Brynjolf.GetActorRef().evaluatePackage()
SLV_Brynjolf.GetActorRef().additem(SLV_Cane)

ActorUtil.ClearPackageOverride(SLV_Hemming.GetActorRef())
SLV_Hemming.GetActorRef().evaluatePackage()
SLV_Hemming.GetActorRef().moveto(Game.getPlayer())
ActorUtil.AddPackageOverride(SLV_Hemming.GetActorRef(), SLV_FollowPlayer ,100)
SLV_Hemming.GetActorRef().evaluatePackage()
SLV_Hemming.GetActorRef().additem(SLV_Cane)

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
Scene Property PunishScene  Auto
Weapon Property SLV_Cane Auto

ReferenceAlias Property SLV_Maul Auto 
ReferenceAlias Property SLV_Saul Auto 
ReferenceAlias Property SLV_Brynjolf Auto 
ReferenceAlias Property SLV_Hemming Auto 

Package Property SLV_FollowPlayer Auto
