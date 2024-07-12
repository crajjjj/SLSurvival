;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname TIF__0502222C Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
;Debug.Messagebox("What player wants: " + Init.PlayerWants)
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
