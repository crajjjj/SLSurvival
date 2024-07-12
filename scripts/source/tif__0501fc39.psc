;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname TIF__0501FC39 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
StorageUtil.UnSetIntValue(akSpeaker, "SLS_Begging_NpcWants")
_SLS_BeggingSelfDegradation.CompleteAllObjectives()
_SLS_BeggingSelfDegradation.SetStage(30)
_SLS_BeggingSelfDegradation.Stop()
Main.BegSuccess(Init.PlayerWants, Menu.BegQuantity)
Dnpc.Clear()
QuestGiver.Clear()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Quest Property _SLS_BeggingSelfDegradation Auto
SLS_Main Property Main Auto
SLS_Mcm Property Menu Auto
SLS_Init Property Init Auto
ReferenceAlias Property Dnpc Auto
ReferenceAlias Property QuestGiver Auto
ReferenceAlias Property Client  Auto