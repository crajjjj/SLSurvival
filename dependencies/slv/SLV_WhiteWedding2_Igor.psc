;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 12
Scriptname SLV_WhiteWedding2_Igor Extends Scene Hidden

;BEGIN FRAGMENT Fragment_7
Function Fragment_7()
;BEGIN CODE
myBranding.brandingdoBranding(true)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN CODE
slv_sexisrunning.setvalue(1)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
debug.SendAnimationEvent(Game.getplayer(), "IdleForceDefaultState")
Game.EnablePlayerControls()
game.SetPlayerAIDriven(false)
SendModEvent("dhlp-Resume")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_8
Function Fragment_8()
;BEGIN CODE
myBranding.brandingLeaveStocks(Game.getPlayer(),BrandingStocksRef,DungeonFloorRef)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_3
Function Fragment_3()
;BEGIN CODE
BrandingStocksRef = brandingScript.SLV_createBrandingDevice()
Utility.wait(2.0)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_10
Function Fragment_10()
;BEGIN CODE
slv_sexisrunning.setvalue(1)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_6
Function Fragment_6()
;BEGIN CODE
bool equipGag = true
bool equipPlugs = true
bool equipHarness = true
bool equipBelt = true
bool equipBra = true
bool equipCollar = false
bool equipCuffs = false
bool equipArmbinder = true
bool equipYoke = true
bool equipBlindfold = true
bool equipNPiercings = false
bool equipVPiercings = false
bool equipBoots = false
bool equipGloves = true
bool equipCorset = true
bool equipMittens = true
bool equipHood = true
bool equipClamps = true
bool equipSuit = true
bool equipShackles = true
bool equipHobblesSkirt = true
bool equipHobblesSkirtRelaxed = true

myScripts.SLV_DeviousUnEquipActor2(Game.GetPlayer(),equipGag,equipPlugs,equipHarness,equipBelt,equipBra,equipCollar,equipCuffs,equipArmbinder,equipYoke,equipBlindfold,equipNPiercings,equipVPiercings,equipBoots,equipGloves,equipCorset,equipMittens, equipHood, equipClamps, equipSuit, equipShackles, equipHobblesSkirt, equipHobblesSkirtRelaxed)

myScripts.SLV_PrepareForTattoo(Game.getplayer())
debug.SendAnimationEvent(Game.getplayer(), "IdleForceDefaultState")
myBranding.brandingMoveToStocks(Game.getPlayer(),BrandingStocksRef)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_BrandingDeviceMain Property myBranding auto
GlobalVariable Property SLV_SexIsRunning Auto 

SLV_Utilities Property myScripts auto
SLV_BrandingDeviceMove Property brandingScript auto
ObjectReference BrandingStocksRef
ObjectReference Property DungeonFloorRef Auto





;SLV_BrandingDeviceMove Property brandingMove auto



