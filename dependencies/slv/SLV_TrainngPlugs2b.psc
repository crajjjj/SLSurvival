;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname SLV_TrainngPlugs2b Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
myScripts.SLV_IvanaMoodChange(true,1)

myScripts.SLV_DeviousUnEquipActor2(Game.GetPlayer(),false,false,false,false,false,false,false,true,true,false,false,false,false,false,false,false, false, false, true,false, true, true)

GetOwningQuest().SetObjectiveCompleted(1750)
GetOwningQuest().SetStage(2000)

myScripts.SLV_Play2Sex(Game.GetPlayer(),akSpeaker,"Blowjob", true)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto


