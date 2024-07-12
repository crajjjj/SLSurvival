;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_FalkreathLod1 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
myScripts.SLV_SexlabStripNPC(Game.GetPlayer())
myScripts.SLV_SexlabStripNPC(akSpeaker)

myScripts.SLV_DeviousUnEquipActor3(Game.GetPlayer(),true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true)

GetOwningQuest().SetObjectiveCompleted(0)
GetOwningQuest().SetStage(500)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto