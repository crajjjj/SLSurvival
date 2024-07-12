;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 3
Scriptname SLV_TrainingPlugs Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_2
Function Fragment_2(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(1500)
GetOwningQuest().SetStage(1600)

curObject.enable()
curObject2.enable()

curObject.setActorOwner(Game.GetPlayer().GetActorBase())
curObject2.setActorOwner(Game.GetPlayer().GetActorBase())

; unequip the gloves
;myScripts.SLV_DeviousUnEquipActor2(Actor NPCActor,bool equipGag,bool equipPlugs,bool equipHarness,bool equipBelt,bool equipBra,bool equipCollar,bool equipCuffs,bool equipArmbinder,bool equipYoke,
;bool equipBlindfold,bool equipNPiercings,bool equipVPiercings,bool equipBoots,bool equipGloves,bool equipCorset,bool equipMittens=true, bool equipHood=true, bool equipClamps=true, bool equipSuit=true, bool equipShackles=true, bool equipHobblesSkirt=true, bool equipHobblesSkirtRelaxed=true)
myScripts.SLV_DeviousUnEquipActor2(Game.GetPlayer(),false,false,true,true,true,false,false,true,true,false,false,false,true,true,false,false, false, false, true, false, true,true)

myScripts.SLV_DeviousEquipActor2(Game.GetPlayer(),false,false,false,false,false,false,false,true,false,false,false,false,true,false,false,false, false, false, false, false, true, false)
;myScripts.SLV_DeviousEquip(false,false,false,false,false,false,false,true,false,false,false,false,true,false,false)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
;DEVIOUS DEVICES PROPERTIES
ObjectReference Property curObject Auto
ObjectReference Property curObject2 Auto
SLV_Utilities Property myScripts auto
