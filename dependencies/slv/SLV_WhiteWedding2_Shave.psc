;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 7
Scriptname SLV_WhiteWedding2_Shave Extends Scene Hidden

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
bool equipBlindfold = false
bool equipNPiercings = false
bool equipVPiercings = false
bool equipBoots = false
bool equipGloves = false
bool equipCorset = false
bool equipMittens = false
bool equipHood = true
bool equipClamps = false
bool equipSuit = false
bool equipShackles = false
bool equipHobblesSkirt = false
bool equipHobblesSkirtRelaxed = false

myScripts.SLV_DeviousUnEquipActor2(Game.GetPlayer(),equipGag,equipPlugs,equipHarness,equipBelt,equipBra,equipCollar,equipCuffs,equipArmbinder,equipYoke,equipBlindfold,equipNPiercings,equipVPiercings,equipBoots,equipGloves,equipCorset,equipMittens, equipHood, equipClamps, equipSuit, equipShackles, equipHobblesSkirt, equipHobblesSkirtRelaxed)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
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
bool equipBlindfold = false
bool equipNPiercings = false
bool equipVPiercings = false
bool equipBoots = false
bool equipGloves = false
bool equipCorset = false
bool equipMittens = true
bool equipHood = true
bool equipClamps = true
bool equipSuit = true
bool equipShackles = true
bool equipHobblesSkirt = true
bool equipHobblesSkirtRelaxed = true

myScripts.SLV_DeviousUnEquipActor2(Game.GetPlayer(),equipGag,equipPlugs,equipHarness,equipBelt,equipBra,equipCollar,equipCuffs,equipArmbinder,equipYoke,equipBlindfold,equipNPiercings,equipVPiercings,equipBoots,equipGloves,equipCorset,equipMittens, equipHood, equipClamps, equipSuit, equipShackles, equipHobblesSkirt, equipHobblesSkirtRelaxed)
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

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
GlobalVariable Property SLV_SexIsRunning Auto 
SLV_Utilities Property myScripts auto

