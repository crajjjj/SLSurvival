;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_ColosseumMain_32 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(9000)
GetOwningQuest().SetStage(9500)

colosseumEnabling.SLV_enableAll()

myScripts.SLV_PlayScene(PunishScene)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
Scene Property PunishScene  Auto

SLV_EnableColosseum Property colosseumEnabling auto