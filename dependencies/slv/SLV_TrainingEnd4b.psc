;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_TrainingEnd4b Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(9500)
GetOwningQuest().SetStage(10000)

myScripts.SLV_IvanaReset()
Game.getplayer().additem(SLV_SlaveCertificate.getReference())
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
;DEVIOUS DEVICES PROPERTIES
ReferenceAlias Property SLV_SlaveCertificate Auto
SLV_Utilities Property myScripts auto
