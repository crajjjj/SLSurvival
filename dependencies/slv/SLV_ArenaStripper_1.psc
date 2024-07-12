;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_ArenaStripper_1 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
myScripts.SLV_SexlabStripNPC(Game.getPlayer())


bool equipGag = false
bool equipPlugs = true
bool equipHarness = false
bool equipBelt = false
bool equipBra = false
bool equipCollar = true
bool equipCuffs = true
bool equipArmbinder = false
bool equipYoke = false
bool equipBlindfold = false
bool equipNPiercings = true
bool equipVPiercings = true
bool equipBoots = false
bool equipGloves = false
bool equipCorset = false
bool equipMittens=false
bool equipHood=false
bool equipClamps=false
bool equipSuit=false
bool equipShackles=false
bool equipHobblesSkirt=false
bool equipHobblesSkirtRelaxed=false

myScripts.SLV_DeviousEquipActor2(Game.getPlayer(), equipGag,equipPlugs,equipHarness,equipBelt,equipBra,equipCollar,equipCuffs,equipArmbinder,equipYoke,equipBlindfold,equipNPiercings,equipVPiercings,equipBoots,equipGloves,equipCorset, equipMittens, equipHood, equipClamps, equipSuit, equipShackles,equipHobblesSkirt, equipHobblesSkirtRelaxed)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
