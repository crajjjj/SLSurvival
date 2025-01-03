;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_WindhelmSlavery15 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(7000)
GetOwningQuest().SetStage(7500)

Game.GetPlayer().moveto(WayMarker)
akSpeaker.moveto(WayMarker)

ActorUtil.ClearPackageOverride(akSpeaker)
akSpeaker.evaluatePackage()

myScripts.SLV_DeviousUnEquip(true,false,false,true,true,false,false,true,true,true,false,false,false,false,false)

myScripts.SLV_IvanaMoodChange(true,1) 
myScripts.SLV_BrutusMoodChange(true,1)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
ObjectReference Property WayMarker Auto
SLV_Utilities Property myScripts auto
