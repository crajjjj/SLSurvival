;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 3
Scriptname TIF_Dflow_081930EE Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Client.ForceRefto(AkSpeakerRef)
PC.ForceRefto(Tool.PC)
Tool.PlacePCNearPlayer()
(GetOwningQuest() as _DFPotionQuest).RunScene()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

_DFTools Property tool Auto
ReferenceAlias Property Client Auto
ReferenceAlias Property PC Auto
