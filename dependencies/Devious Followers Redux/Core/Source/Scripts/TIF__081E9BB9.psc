;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 12
Scriptname TIF__081E9BB9 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_10
Function Fragment_10(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Int Tea = Dealq.GetStage()
if tea == 3
(GetOwningQuest() as  QF__DflowDealController_0A01C86D).DealMaxAdd(-1)
Endif
Tea = Tea*-1
(GetOwningQuest() as  QF__DflowDealController_0A01C86D).DealAdd(tea)
PlayerRef.RemoveItem(Gold001, DealPrice.getValue() as int)
(DealQ as _MDDeal).BuyOut()
DealQ.Reset()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

zadlibs Property libs  Auto  

Actor Property PlayerRef  Auto  

Armor Property I  Auto  

Armor Property R  Auto  
QF__Gift_09000D62 Property q  Auto  

MiscObject Property Gold001  Auto  

Quest Property Dealq  Auto  

GlobalVariable Property _DflowDealOP  Auto  

GlobalVariable Property DealPrice  Auto  
