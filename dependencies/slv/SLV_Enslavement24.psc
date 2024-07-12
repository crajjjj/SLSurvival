;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_Enslavement24 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
SLV_SlavetrainingQuest.SetObjectiveCompleted(3000)
SLV_SlavetrainingQuest.SetStage(3500)

;myScripts.SLV_miniLevelUp()
SLV_EnforcerIgnorePC.setvalue(0)

GetOwningQuest().SetObjectiveCompleted(7000)
GetOwningQuest().SetStage(9500)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
Quest Property SLV_SlavetrainingQuest Auto
GlobalVariable Property SLV_EnforcerIgnorePC  Auto
ReferenceAlias Property SLV_SexSlaveVol02 Auto

