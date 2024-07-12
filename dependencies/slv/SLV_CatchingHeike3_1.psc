;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_CatchingHeike3_1 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(0)
getowningquest().setstage(500)

ActorUtil.ClearPackageOverride(SLV_Ivana.getactorref())
SLV_Ivana.GetActorRef().evaluatePackage()
ActorUtil.AddPackageOverride(SLV_Ivana.GetActorRef(), SLV_DoNothing ,100)
SLV_Ivana.GetActorRef().evaluatePackage()
SLV_Ivana.GetActorRef().moveto(markarthMarker)
;SLV_Ivana.GetActorRef().disable()
SLV_Ivana.GetActorRef().SetOutfit(NotSlaveOutfit)

ActorUtil.ClearPackageOverride(SLV_Valentina.getactorref())
SLV_Valentina.GetActorRef().evaluatePackage()
ActorUtil.AddPackageOverride(SLV_Valentina.GetActorRef(), SLV_DoNothing ,100)
SLV_Valentina.GetActorRef().evaluatePackage()
SLV_Valentina.GetActorRef().moveto(markarthMarker)
;SLV_Valentina.GetActorRef().disable()
SLV_Ivana.GetActorRef().SetOutfit(NotSlaveOutfit)

if ThisMenu.SkipScenes
	return
endif

SLV_You.getActorRef().moveto(Game.GetPlayer())

ActorUtil.ClearPackageOverride(SLV_Farengar.getactorref())
SLV_Farengar.GetActorRef().evaluatePackage()
ActorUtil.AddPackageOverride(SLV_Farengar.GetActorRef(), SLV_WalktoDragonsReachCenter,100)
SLV_Farengar.GetActorRef().evaluatePackage()

ActorUtil.ClearPackageOverride(SLV_Zaid.getactorref())
SLV_Zaid.GetActorRef().evaluatePackage()
ActorUtil.AddPackageOverride(SLV_Zaid.GetActorRef(), SLV_WalktoDragonsReachCenter,100)
SLV_Zaid.GetActorRef().evaluatePackage()

SLV_AmputeePlayer.setValue(3)

SendModEvent("dhlp-Suspend")
game.DisablePlayerControls(1, 1, 1, 0, 0, 1, 1)
game.SetPlayerAIDriven(true)
PunishScene.ForceStart()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
GlobalVariable Property SLV_AmputeePlayer Auto
ReferenceAlias Property SLV_Ivana Auto 
ReferenceAlias Property SLV_Valentina Auto 
Package Property SLV_DoNothing Auto
ObjectReference Property markarthMarker auto
ReferenceAlias Property SLV_You Auto
SLV_MCMMenu Property ThisMenu auto
Scene Property PunishScene Auto 

ReferenceAlias Property SLV_Farengar Auto 
ReferenceAlias Property SLV_Zaid Auto
Package Property SLV_WalktoDragonsReachCenter Auto

Outfit Property NotSlaveOutfit auto

