;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 28
Scriptname sr_SHBStartScene Extends Scene Hidden

;BEGIN FRAGMENT Fragment_6
Function Fragment_6()
;BEGIN CODE
game.disablePlayerControls()
GetOwningQuest().SetObjectiveCompleted(5)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_8
Function Fragment_8()
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(0, true)
GetOwningQuest().SetObjectiveDisplayed(5)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
(GetOwningQuest() as sr_SolitudeHorseDelivery).ftu.AnimateAndFillPlayer()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_18
Function Fragment_18()
;BEGIN CODE
Game.GetPlayer().AddToFaction(sr_QSTWorkerFaction)
Game.GetPlayer().SetFactionRank(sr_QSTWorkerFaction, 10)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_4
Function Fragment_4()
;BEGIN CODE
(GetOwningQuest() as sr_SolitudeHorseDelivery).ftu.InflationDone()
Game.EnablePlayerControls()
GetOwningQuest().SetStage(9)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Faction Property sr_QSTWorkerFaction Auto
