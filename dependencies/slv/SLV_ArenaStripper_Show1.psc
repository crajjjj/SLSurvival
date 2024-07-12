;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 7
Scriptname SLV_ArenaStripper_Show1 Extends Scene Hidden

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

;BEGIN FRAGMENT Fragment_6
Function Fragment_6()
;BEGIN CODE
bool equipGag = false
bool equipPlugs = false
bool equipHarness = false
bool equipBelt = false
bool equipBra = false
bool equipCollar = false
bool equipCuffs = false
bool equipArmbinder = false
bool equipYoke = false
bool equipBlindfold = true
bool equipNPiercings = false
bool equipVPiercings = false
bool equipBoots = false
bool equipGloves = true
bool equipCorset = true
bool equipMittens=false
bool equipHood=false
bool equipClamps=false
bool equipSuit=false
bool equipShackles=false
bool equipHobblesSkirt=false
bool equipHobblesSkirtRelaxed=false

myScripts.SLV_DeviousUnEquipActor2(Game.getPlayer(), equipGag,equipPlugs,equipHarness,equipBelt,equipBra,equipCollar,equipCuffs,equipArmbinder,equipYoke,equipBlindfold,equipNPiercings,equipVPiercings,equipBoots,equipGloves,equipCorset, equipMittens, equipHood, equipClamps, equipSuit, equipShackles,equipHobblesSkirt, equipHobblesSkirtRelaxed)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_4
Function Fragment_4()
;BEGIN CODE
bool equipGag = false
bool equipPlugs = false
bool equipHarness = false
bool equipBelt = true
bool equipBra = true
bool equipCollar = false
bool equipCuffs = false
bool equipArmbinder = false
bool equipYoke = false
bool equipBlindfold = false
bool equipNPiercings = false
bool equipVPiercings = false
bool equipBoots = false
bool equipGloves = false
bool equipCorset = false
bool equipMittens=false
bool equipHood=false
bool equipClamps=false
bool equipSuit=true
bool equipShackles=false
bool equipHobblesSkirt=true
bool equipHobblesSkirtRelaxed=false

myScripts.SLV_DeviousUnEquipActor2(Game.getPlayer(), equipGag,equipPlugs,equipHarness,equipBelt,equipBra,equipCollar,equipCuffs,equipArmbinder,equipYoke,equipBlindfold,equipNPiercings,equipVPiercings,equipBoots,equipGloves,equipCorset, equipMittens, equipHood, equipClamps, equipSuit, equipShackles,equipHobblesSkirt, equipHobblesSkirtRelaxed)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto

