;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_RiverwoodTaskLucanGag Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
;myScripts.SLV_DeviousUnEquip(false,false,false,false,false,false,false,true,true,false,false,false,false,false,false)

bool equipGag = false
bool equipPlugs = false
bool equipHarness = false
bool equipBelt = false
bool equipBra = false
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
bool equipMittens=false
bool equipHood=false
bool equipClamps=false
bool equipSuit=true
bool equipShackles=false
bool equipHobblesSkirt=false
bool equipHobblesSkirtRelaxed=false
myScripts.SLV_DeviousUnEquipActor2(Game.getPlayer(),equipGag,equipPlugs,equipHarness,equipBelt,equipBra,equipCollar,equipCuffs,equipArmbinder,equipYoke,equipBlindfold,equipNPiercings,equipVPiercings,equipBoots,equipGloves,equipCorset,equipMittens,equipHood,equipClamps,equipSuit,equipShackles,equipHobblesSkirt, equipHobblesSkirtRelaxed)

myScripts.SLV_DeviousEquip(true,false,false,false,false,false,false,false,false,false,false,false,false,false,false)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto


