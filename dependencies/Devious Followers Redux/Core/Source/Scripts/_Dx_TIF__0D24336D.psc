;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 19
Scriptname _Dx_TIF__0D24336D Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_15
Function Fragment_15(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
; nothing here
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_18
Function Fragment_18(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
_DFlowProps OQ = GetOwningQuest() As _DFlowProps
OQ.ItemToRemove = 3
; -- DC.PickRandomDeal()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

zadlibs Property libs  Auto  

Actor Property PlayerRef  Auto  

Armor Property I  Auto  

Armor Property R  Auto  
QF__Gift_09000D62 Property q  Auto  
GlobalVariable Property Lives  Auto  

QF__DflowDealController_0A01C86D Property DC Auto
