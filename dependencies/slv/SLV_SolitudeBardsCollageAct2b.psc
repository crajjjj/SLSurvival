;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 13
Scriptname SLV_SolitudeBardsCollageAct2b Extends Scene Hidden

;BEGIN FRAGMENT Fragment_7
Function Fragment_7()
;BEGIN CODE
myScripts.SLV_DeviousEquipActorColor(SLV_Slave.getActorRef(),",white","",false,false,false,false,false,false,true,false,false,true,true,true,true,true,false)
Utility.wait(2.0)
myScripts.SLV_DeviousEquipActorColor(Ildi.getActorRef(),",red","",false,false,false,false,false,false,true,false,false,true,true,true,true,true,false)
Utility.wait(2.0)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN CODE
ActorUtil.ClearPackageOverride(Ildi.getactorref())
ActorUtil.AddPackageOverride(Ildi.getActorRef(), bardstage ,100)
Ildi.getActorRef().evaluatePackage()

ActorUtil.ClearPackageOverride(SLV_Slave.getactorref())
ActorUtil.AddPackageOverride(SLV_Slave.getActorRef(), bardstage ,100)
SLV_Slave.getActorRef().evaluatePackage()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
SendModEvent("dhlp-Resume")
Game.EnablePlayerControls()
game.SetPlayerAIDriven(false)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_4
Function Fragment_4()
;BEGIN CODE
ActorUtil.ClearPackageOverride(Ildi.getactorref())
ActorUtil.AddPackageOverride(Ildi.getActorRef(), SLV_XCrossBardsCollegeIldi ,100)
Ildi.getactorref().evaluatePackage()

ActorUtil.ClearPackageOverride(SLV_Slave.getactorref())
ActorUtil.AddPackageOverride(SLV_Slave.getActorRef(), SLV_XCrossBardsCollegePC ,100)
SLV_Slave.getactorref().evaluatePackage()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_10
Function Fragment_10()
;BEGIN CODE
debug.SendAnimationEvent(Ildi.getactorref(), "IdleForceDefaultState")
debug.SendAnimationEvent(SLV_Slave.getactorref(), "IdleForceDefaultState")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_3
Function Fragment_3()
;BEGIN CODE
sendModEvent("SlaverunReloaded_WhippingScream")
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
ReferenceAlias Property Ildi Auto 
Package Property bardstage Auto
Package Property SLV_XCrossBardsCollegeIldi Auto
Package Property SLV_XCrossBardsCollegePC Auto
ReferenceAlias Property SLV_Slave Auto 
