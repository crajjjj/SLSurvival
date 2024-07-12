;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_EnslavePCEnda Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
myScripts.SLV_enableValentina()

myScripts.SLV_IvanaMoodChange(true,1)
;Game.getplayer().additem(SLV_SexSlaveVol01.getReference())

SLV_CatchingIvanaQuest.Reset() 
SLV_CatchingIvanaQuest.Start() 
SLV_CatchingIvanaQuest.SetActive(true) 
SLV_CatchingIvanaQuest.SetStage(0)

GetOwningQuest().SetObjectiveCompleted(4000)
GetOwningQuest().SetStage(9500)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Quest Property SLV_CatchingIvanaQuest Auto
SLV_Utilities Property myScripts auto
ReferenceAlias Property SLV_SexSlaveVol01 Auto

