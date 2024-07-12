;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 6
Scriptname TIF_Dflow_081E9BA9 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_4
Function Fragment_4(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
q.DealDebt()
int a = Dealq.getstage() as int
a += 1
Dealq.setstage(a)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_5
Function Fragment_5(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
(GetOwningQuest() as  QF__DflowDealController_0A01C86D).DealAdd(1)
if Dealq.GetStage() == 3
(GetOwningQuest() as  QF__DflowDealController_0A01C86D).DealMaxAdd(1)
Endif
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

QF__Gift_09000D62 Property q Auto
Quest Property Dealq  Auto  
