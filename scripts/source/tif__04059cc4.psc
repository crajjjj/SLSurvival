;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname TIF__04059CC4 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
StorageUtil.UnSetIntValue(akSpeaker, "SLS_Begging_NpcWants")
Init.ClientOrgasmState = 0
Client.Clear()
Main.BegSuccess(Init.PlayerWants, Menu.BegNumItems)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

SLS_Init Property Init Auto
SLS_Main Property Main Auto
SLS_Mcm Property Menu Auto
ReferenceAlias Property Client Auto
