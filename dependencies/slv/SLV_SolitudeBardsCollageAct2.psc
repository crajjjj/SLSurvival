;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 20
Scriptname SLV_SolitudeBardsCollageAct2 Extends Scene Hidden

;BEGIN FRAGMENT Fragment_14
Function Fragment_14()
;BEGIN CODE
ActorUtil.ClearPackageOverride(Ildi.getactorref())
ActorUtil.AddPackageOverride(Ildi.getActorRef(), bardstage ,100)
Ildi.getActorRef().evaluatePackage()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_17
Function Fragment_17()
;BEGIN CODE
Game.ForceThirdPerson()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_10
Function Fragment_10()
;BEGIN CODE
ActorUtil.ClearPackageOverride(Ildi.getactorref())
ActorUtil.AddPackageOverride(Ildi.getActorRef(), SLV_XCrossBardsCollegeIldi ,100)
Ildi.getactorref().evaluatePackage()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
myScripts.SLV_DeviousEquipActorColor(Game.GetPlayer(),",white","",false,false,false,false,false,false,true,false,false,true,true,true,true,true,false)
;Utility.wait(2.0)
myScripts.SLV_DeviousEquipActorColor(Ildi.getActorRef(),",red","",false,false,false,false,false,false,true,false,false,true,true,true,true,true,false)
;Utility.wait(2.0)
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

;BEGIN FRAGMENT Fragment_3
Function Fragment_3()
;BEGIN CODE
sendModEvent("SlaverunReloaded_WhippingScream")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_6
Function Fragment_6()
;BEGIN CODE
debug.SendAnimationEvent(Game.getplayer(), "IdleForceDefaultState")
debug.SendAnimationEvent(Ildi.getactorref(), "IdleForceDefaultState")
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
ReferenceAlias Property Ildi Auto 
Package Property bardstage Auto
Package Property SLV_XCrossBardsCollegeIldi Auto
