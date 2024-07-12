;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_WalkOfShame2_7 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
myScripts.SLV_DeviousUnEquip(true,true,true,true,true,true,true,true,true,true,true,true,true,true,true)
Utility.wait(2.0)

bool equipGag = false
bool equipPlugs = true
bool equipHarness = false
bool equipBelt = false
bool equipBra = false
bool equipCollar = true
bool equipCuffs = true
bool equipArmbinder = true
bool equipYoke = false
bool equipBlindfold = false
bool equipNPiercings = true
bool equipVPiercings = true
bool equipBoots = true
bool equipGloves = true
bool equipCorset = true

myScripts.SLV_DeviousEquip(equipGag,equipPlugs,equipHarness,equipBelt,equipBra,equipCollar,equipCuffs,equipArmbinder,equipYoke,equipBlindfold,equipNPiercings,equipVPiercings,equipBoots,equipGloves,equipCorset)

GetOwningQuest().SetObjectiveCompleted(3000)
GetOwningQuest().SetStage(3500)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
