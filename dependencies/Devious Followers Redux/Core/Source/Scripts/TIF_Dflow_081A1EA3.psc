;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname TIF_Dflow_081A1EA3 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
DC.AddRandomDeal()
(GetowningQuest() as QF__Gift_09000D62).DealDebt()

DC.AddRandomDeal()
(GetowningQuest() as QF__Gift_09000D62).DealDebt()

DC.AddRandomDeal()
(GetowningQuest() as QF__Gift_09000D62).DealDebt()

(GetowningQuest() as QF__Gift_09000D62).Tool.ReduceResist(18)
Tool.ResumeALL()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

_DFtools Property Tool Auto  
QF__DflowDealController_0A01C86D Property DC Auto
