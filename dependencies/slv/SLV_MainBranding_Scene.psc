;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 69
Scriptname SLV_MainBranding_Scene Extends Scene Hidden

;BEGIN FRAGMENT Fragment_10
Function Fragment_10()
;BEGIN CODE
myBranding.brandingLeaveStocks(Game.getPlayer(),BrandingStocksRef,DungeonFloorRef)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_47
Function Fragment_47()
;BEGIN CODE
SLV_Slaver.getActorRef().moveto(DungeonFloorRef)
SLV_Slaver2.getActorRef().moveto(DungeonFloorRef)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_50
Function Fragment_50()
;BEGIN CODE
BrandingStocksRef = brandingScript.SLV_createBrandingDevice()
Utility.wait(2.0)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_65
Function Fragment_65()
;BEGIN CODE
slv_sexisrunning.setvalue(1)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_34
Function Fragment_34()
;BEGIN CODE
myScripts.SLV_CleanUpPackages()
SLV_Slaver.getActorRef().moveto(DungeonFloorRef)
SLV_Slaver2.getActorRef().moveto(DungeonFloorRef)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_58
Function Fragment_58()
;BEGIN CODE
myBranding.brandingdoBranding(true)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
myScripts.SLV_CleanUpPackages()

if SLV_SexTraining.getstage() == 5500
	myScripts.SLV_IvanaReset()

	ActorUtil.AddPackageOverride(SLV_Brutus.getActorRef(), SLV_FollowPlayer ,100)
	SLV_Brutus.GetActorRef().evaluatePackage()
	ActorUtil.AddPackageOverride(SLV_Sven.getActorRef(), SLV_FollowPlayer ,100)
	SLV_Sven.GetActorRef().evaluatePackage()
endif

Game.EnablePlayerControls()
game.SetPlayerAIDriven(false)
SendModEvent("dhlp-Resume")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_67
Function Fragment_67()
;BEGIN CODE
slv_sexisrunning.setvalue(1)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_44
Function Fragment_44()
;BEGIN CODE
SLV_You.getActorRef().moveto(Game.getPlayer())
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_62
Function Fragment_62()
;BEGIN CODE
myScripts.SLV_PrepareForTattoo(Game.getplayer())
debug.SendAnimationEvent(Game.getplayer(), "IdleForceDefaultState")
myBranding.brandingMoveToStocks(Game.getPlayer(),BrandingStocksRef)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_BrandingDeviceMain Property myBranding auto
GlobalVariable Property SLV_SexIsRunning Auto 
ReferenceAlias Property SLV_You Auto

ObjectReference BrandingStocksRef
ObjectReference Property DungeonFloorRef Auto
SLV_Utilities Property myScripts auto
SLV_BrandingDeviceMove Property brandingMove auto
Quest Property SLV_SexTraining Auto
ReferenceAlias Property SLV_Brutus Auto 
ReferenceAlias Property SLV_Sven Auto 
Package Property SLV_FollowPlayer Auto
ReferenceAlias Property SLV_Slaver Auto 
ReferenceAlias Property SLV_Slaver2 Auto 

SLV_BrandingDeviceMove Property brandingScript auto



