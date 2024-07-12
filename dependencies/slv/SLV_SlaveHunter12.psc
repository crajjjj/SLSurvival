;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_SlaveHunter12 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(3500)
GetOwningQuest().SetStage(9000)

myScripts.SLV_DeviousUnEquipActor2(PlayerRef ,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true)

myScripts.SLV_enslavementChains(PlayerRef)
myScripts.SLV_DeviousEquipActor2(PlayerRef ,false,true,false,false,false,true,true,false,false,false,true,true,true,true,true,false,false,false,false,false,false,false)
myScripts.SLV_GetMoreSubmissive(false,1)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Actor Property PlayerRef auto
SLV_Utilities Property myScripts auto
