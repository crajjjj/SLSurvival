;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_WhiterunTaskDremora3 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(1000)
GetOwningQuest().SetStage(1500)

myScripts.SLV_SexlabStripNPC(Game.GetPlayer())

myScripts.SLV_DeviousEquip(false,false,false,false,false,true,true,false,false,false,true,true,true,true,true)

Utility.wait(2.0)

myScripts.SLV_Play3Sex(Game.GetPlayer(),akSpeaker, Dremora1.getActorRef() ,"Anal", true)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
ReferenceAlias Property Dremora1 Auto 
