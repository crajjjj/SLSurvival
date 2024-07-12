;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_DeadSlaveWalking6 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
myScripts.SLV_SexlabStripNPC(Game.GetPlayer())

myScripts.SLV_DeviousEquip(false,false,false,false,false,true,true,true,false,true,true,true,true,true,true)

Utility.wait(5.0)
myScripts.SLV_PlayerMoveTo(cageMarker)
Utility.wait(5.0)

SLV_SlaveGladiatorQuest.Stop()
SLV_SlaveGladiatorQuest.Reset() 
SLV_SlaveGladiatorQuest.Start() 
SLV_SlaveGladiatorQuest.SetStage(0)
SLV_SlaveGladiatorQuest.SetActive(true)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
Quest Property SLV_SlaveGladiatorQuest Auto
ObjectReference Property cageMarker Auto
