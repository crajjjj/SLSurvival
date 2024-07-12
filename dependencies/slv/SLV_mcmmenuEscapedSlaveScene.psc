;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 12
Scriptname SLV_mcmmenuEscapedSlaveScene Extends Scene Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
ActorUtil.ClearPackageOverride(Zaid.getActorRef())
Zaid.getActorRef().evaluatePackage()
ActorUtil.ClearPackageOverride(Mundus.getActorRef() )
Mundus.getActorRef().evaluatePackage()
ActorUtil.ClearPackageOverride(Eric.getActorRef())
Eric.getActorRef().evaluatePackage()

;ActorUtil.RemoveAllPackageOverride(SLV_Followplayer)
SendModEvent("dhlp-Resume")
Game.EnablePlayerControls()
game.SetPlayerAIDriven(false)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_7
Function Fragment_7()
;BEGIN CODE
sendModEvent("SlaverunReloaded_WhippingScream")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_9
Function Fragment_9()
;BEGIN CODE
sendModEvent("SlaverunReloaded_WhippingScream")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_10
Function Fragment_10()
;BEGIN CODE
sendModEvent("SlaverunReloaded_WhippingScream")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_4
Function Fragment_4()
;BEGIN CODE
ActorUtil.AddPackageOverride(Zaid.getActorRef() , SLV_FollowPlayer,100)
Zaid.getActorRef().evaluatePackage()
ActorUtil.AddPackageOverride(Mundus.getActorRef() , SLV_FollowPlayer,100)
Mundus.getActorRef().evaluatePackage()
ActorUtil.AddPackageOverride(Eric.getActorRef() , SLV_FollowPlayer,100)
Eric.getActorRef().evaluatePackage()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
ReferenceAlias Property Zaid Auto 
ReferenceAlias Property Eric Auto 
ReferenceAlias Property Mundus Auto 
Package Property SLV_FollowPlayer Auto
