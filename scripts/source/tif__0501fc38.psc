;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname TIF__0501FC38 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
StorageUtil.UnSetIntValue(akSpeaker, "SLS_Begging_NpcWants")
_SLS_BeggingSelfDegradation.FailAllObjectives()
_SLS_BeggingSelfDegradation.SetStage(30)
_SLS_BeggingSelfDegradation.Stop()
(Game.GetFormFromFile(0x000D64, "SL Survival.esp") as SLS_Utility).BegSelfDegradationResistLoss()
Dnpc.Clear()
QuestGiver.Clear()
Client.Clear()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Quest Property _SLS_BeggingSelfDegradation Auto
SLS_Init Property Init Auto
ReferenceAlias Property Dnpc Auto
ReferenceAlias Property QuestGiver Auto
ReferenceAlias Property Client Auto
