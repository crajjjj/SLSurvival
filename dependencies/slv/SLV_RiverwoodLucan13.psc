;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_RiverwoodLucan13 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(1000)
GetOwningQuest().SetStage(1500)

myScripts.SLV_SexlabStripNPC(Game.GetPlayer())
myScripts.SLV_IvanaMoodChange(false,1)

bool equipGag = false
bool equipPlugs = true
bool equipHarness = false
bool equipBelt = false
bool equipBra = false
bool equipCollar = false
bool equipCuffs = false
bool equipArmbinder = false
bool equipYoke = false
bool equipBlindfold = false
bool equipNPiercings = true
bool equipVPiercings = true
bool equipBoots = false
bool equipGloves = false
bool equipCorset = false
myScripts.SLV_DeviousEquip(equipGag,equipPlugs,equipHarness,equipBelt,equipBra,equipCollar,equipCuffs,equipArmbinder,equipYoke,equipBlindfold,equipNPiercings,equipVPiercings,equipBoots,equipGloves,equipCorset)

myScripts.SLV_PlayScene(PunishScene)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Scene Property PunishScene  Auto
SLV_Utilities Property myScripts auto

