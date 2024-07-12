;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname TIF_Dflow_080F19F8 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
(GetowningQuest() as _DDeal).DelayHrs(1.0)
Tool.DealDelayhr()
;Tool.PauseAll()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Client.ForceRefto(AkSpeakerRef)

(GetowningQuest() as _DDeal).DelayHrs(6.0)
(GetowningQuest() as QF__DFlowDealS_090E53C8).WhoreOut()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

_DFTools Property tool Auto
ReferenceAlias Property Client Auto
