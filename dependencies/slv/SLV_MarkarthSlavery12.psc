;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_MarkarthSlavery12 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(6500)
GetOwningQuest().SetStage(7000)

myScripts.SLV_DeviousEquip(false,false,true,false,false,true,true,false,false,true,true,true,true,true,true)
myScripts.SLV_Play2Sex(Game.GetPlayer(),akSpeaker, "Anal", true)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
