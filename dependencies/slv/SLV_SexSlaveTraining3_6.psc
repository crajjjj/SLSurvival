;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_SexSlaveTraining3_6 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(2500)
GetOwningQuest().SetStage(3000)

myScripts.SLV_DeviousEquip(false,false,false,false,false,false,true,false,false,false,false,false,true,false,false)
Utility.wait(2.0)

actor[] sexActors = new actor[2]
sexActors[0] = Game.GetPlayer()
sexActors[1] = akSpeaker

myScripts.SLV_PlaySexAnimation(sexActors,"FunnyBizness Stockade Rape", "Anal", true)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
