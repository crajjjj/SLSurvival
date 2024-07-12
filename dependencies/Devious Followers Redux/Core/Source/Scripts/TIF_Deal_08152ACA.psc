;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 12
Scriptname TIF_Deal_08152ACA Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_10
Function Fragment_10(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
;libs.RemoveDevice(libs.PlayerRef, I , R,libs.zad_DeviousHeavyBondage)
(GetOwningQuest() as QF__DflowDealController_0A01C86D).LDC.RemoveAndDestroyDeviceByKeyword( libs.zad_Deviousarmcuffs)
(GetOwningQuest() as QF__DflowDealController_0A01C86D).LDC.RemoveAndDestroyDeviceByKeyword( libs.zad_Deviouscollar)
(GetOwningQuest() as QF__DflowDealController_0A01C86D).LDC.RemoveAndDestroyDeviceByKeyword( libs.zad_Deviouslegcuffs)
libs.RemoveDevice(libs.PlayerRef, item1 , item1R, libs.zad_DeviousBelt, skipevents = false, skipmutex = true)
(DealQ As _DDeal).BuyOut(_DFlowDealOP)
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

Armor Property Item1  Auto  

Armor Property Item1R  Auto  
