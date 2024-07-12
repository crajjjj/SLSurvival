;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_RiverwoodLucan1b Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(500)
getowningquest().setstage(1000)

myScripts.SLV_SexlabStripNPC(Game.GetPlayer())
myScripts.SLV_IvanaMoodChange(false,1)

bool equipGag = true
bool equipPlugs = true
bool equipHarness = true
bool equipBelt = true
bool equipBra = true
bool equipCollar = true
bool equipCuffs = true
bool equipArmbinder = true
bool equipYoke = true
bool equipBlindfold = true
bool equipNPiercings = true
bool equipVPiercings = true
bool equipBoots = true
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

equipGag = false
equipPlugs = false
equipHarness = false
equipBelt = false
equipBra = false
equipCollar = true
equipCuffs = true
equipArmbinder = false
equipYoke = false
equipBlindfold = false
equipNPiercings = false
equipVPiercings = false
equipBoots = true
equipGloves = true
equipCorset = true
myScripts.SLV_DeviousEquip(equipGag,equipPlugs,equipHarness,equipBelt,equipBra,equipCollar,equipCuffs,equipArmbinder,equipYoke,equipBlindfold,equipNPiercings,equipVPiercings,equipBoots,equipGloves,equipCorset)

myScripts.SLV_PlayScene(PunishScene)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Scene Property PunishScene  Auto
SLV_Utilities Property myScripts auto

