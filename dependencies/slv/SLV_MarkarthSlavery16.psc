;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_MarkarthSlavery16 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(8500)
GetOwningQuest().SetStage(9000)
Game.GetPlayer().AddItem(ChestKey, 1)

myScripts.SLV_PlayerMoveTo(WayMarker)
akSpeaker.moveto(WayMarker)

ActorUtil.ClearPackageOverride(akSpeaker)
akSpeaker.evaluatePackage()

myScripts.SLV_DeviousUnEquip(true,true,true,true,true,false,false,true,true,true,false,false,false,false,false)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
ObjectReference Property WayMarker Auto
SLV_Utilities Property myScripts auto
Key Property ChestKey Auto

