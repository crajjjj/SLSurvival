;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_RiverwoodLucan11 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(1500)
GetOwningQuest().SetStage(2000)

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

myScripts.SLV_DeviousEquip(equipGag,equipPlugs,equipHarness,equipBelt,equipBra,equipCollar,equipCuffs,equipArmbinder,equipYoke,equipBlindfold,equipNPiercings,equipVPiercings,equipBoots,equipGloves,equipCorset)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto


