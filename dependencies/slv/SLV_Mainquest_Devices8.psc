;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_Mainquest_Devices8 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
myScripts.SLV_DeviousUnEquip(false,false,false,false,false,false,false,false,false,true,false,false,false,false,false)

;Function SLV_DeviousEquip(bool equipGag,bool equipPlugs,bool equipHarness,bool equipBelt,bool equipBra,bool equipCollar,bool equipCuffs,bool equipArmbinder,bool equipYoke,
;bool equipBlindfold,bool equipNPiercings,bool equipVPiercings,bool equipBoots,bool equipGloves,bool equipCorset)

myScripts.SLV_DeviousEquip(false,false,false,false,false,false,false,false,false,true,false,false,false,false,false)

myScripts.SLV_Play2Sex(Game.GetPlayer(),akSpeaker, "Sex", true)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
