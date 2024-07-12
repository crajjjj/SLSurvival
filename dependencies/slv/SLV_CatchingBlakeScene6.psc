;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 5
Scriptname SLV_CatchingBlakeScene6 Extends Scene Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
ActorUtil.ClearPackageOverride(SLV_Zaid.getactorref())
SLV_Zaid.GetActorRef().evaluatePackage()
ActorUtil.AddPackageOverride(SLV_Zaid.GetActorRef(), SLV_Idle ,100)
SLV_Zaid.GetActorRef().evaluatePackage()

ActorUtil.ClearPackageOverride(SLV_Blake.getactorref())
SLV_Blake.GetActorRef().evaluatePackage()
ActorUtil.AddPackageOverride(SLV_Blake.GetActorRef(), SLV_Idle ,100)
SLV_Blake.GetActorRef().evaluatePackage()

Game.EnablePlayerControls()
game.SetPlayerAIDriven(false)
SendModEvent("dhlp-Resume")
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
ReferenceAlias Property SLV_Zaid Auto
ReferenceAlias Property SLV_Blake Auto 
Package Property SLV_Idle Auto

