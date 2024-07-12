;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_EnslavePCEnd2 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
myScripts.SLV_enableValentina()

myScripts.SLV_IvanaMoodChange(false,1)
;Game.getplayer().additem(SLV_SexSlaveVol01.getReference())

SLV_CatchingIvanaQuest.Reset() 
SLV_CatchingIvanaQuest.Start() 
SLV_CatchingIvanaQuest.SetActive(true) 
SLV_CatchingIvanaQuest.SetStage(0)

myScripts.SLV_PlayScene(PunishScene)

GetOwningQuest().SetObjectiveCompleted(4000)
GetOwningQuest().SetStage(9500)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Scene Property PunishScene  Auto
SLV_Utilities Property myScripts auto
Quest Property SLV_CatchingIvanaQuest Auto
ReferenceAlias Property SLV_SexSlaveVol01 Auto

