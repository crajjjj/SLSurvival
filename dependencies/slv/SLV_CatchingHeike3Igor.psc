;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 4
Scriptname SLV_CatchingHeike3Igor Extends Scene Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
Game.EnablePlayerControls()
game.SetPlayerAIDriven(false)
SendModEvent("dhlp-Resume")

ActorUtil.ClearPackageOverride(SLV_Zaid.getactorref())
SLV_Zaid.GetActorRef().evaluatePackage()

ActorUtil.ClearPackageOverride(SLV_Igor.getactorref())
SLV_Igor.GetActorRef().evaluatePackage()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
ReferenceAlias Property SLV_Igor Auto
ReferenceAlias Property SLV_Zaid Auto
