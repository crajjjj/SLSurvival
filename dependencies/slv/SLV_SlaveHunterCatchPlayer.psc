;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 24
Scriptname SLV_SlaveHunterCatchPlayer Extends Scene Hidden

;BEGIN FRAGMENT Fragment_9
Function Fragment_9()
;BEGIN CODE
myScripts.SLV_equipDDChainsPlugs(game.getPlayer())

debug.SendAnimationEvent(Game.getplayer(), "IdleForceDefaultState")

myScripts.SLV_DeviousUnEquip(true,false,false,false,false,false,false,false,false,false,false,false,false,false,false)


debug.SendAnimationEvent(Game.getplayer(), "IdleForceDefaultState")
Game.EnablePlayerControls()
game.SetPlayerAIDriven(false)
SendModEvent("dhlp-Resume")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
myScripts.SLV_SexlabStripNPC(PlayerRef )
myScripts.SLV_StripBothHands(PlayerRef )
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_4
Function Fragment_4()
;BEGIN CODE
myScripts.SLV_DeviousUnEquipActor2(PlayerRef ,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true)

myScripts.SLV_equipDDChainsNoPlugs(PlayerRef )
myScripts.SLV_StripBothHands(PlayerRef )
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(1500)
getowningquest().setstage(2000)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_20
Function Fragment_20()
;BEGIN CODE
myScripts.SLV_DeviousUnEquipActor2(PlayerRef ,false,false,false,false,false,false,false,false,false,false,false,false,false,false,true,true,true,true,true,true,true,true)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN CODE
debug.SendAnimationEvent(PlayerRef , "ZazAPCAO052")

myScripts.SLV_DeviousUnEquipActor2(PlayerRef ,false,false,false,false,false,false,false,false,true,true,true,true,true,true,false,false,false,false,false,false,false,false)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
Actor Property PlayerRef auto
