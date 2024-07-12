;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_RiverwoodLucan14 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(2000)
GetOwningQuest().SetStage(2500)

myScripts.SLV_SexlabStripNPC(Game.GetPlayer())
myScripts.SLV_IvanaMoodChange(true,1)

bool equipGag = true
bool equipPlugs = false
bool equipHarness = false
bool equipBelt = false
bool equipBra = false
bool equipCollar = false
bool equipCuffs = false
bool equipArmbinder = false
bool equipYoke = true
bool equipBlindfold = true
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
myScripts.SLV_DeviousEquipActor2(Game.getPlayer(),equipGag,equipPlugs,equipHarness,equipBelt,equipBra,equipCollar,equipCuffs,equipArmbinder,equipYoke,equipBlindfold,equipNPiercings,equipVPiercings,equipBoots,equipGloves,equipCorset,equipMittens,equipHood,equipClamps,equipSuit,equipShackles,equipHobblesSkirt, equipHobblesSkirtRelaxed)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto


