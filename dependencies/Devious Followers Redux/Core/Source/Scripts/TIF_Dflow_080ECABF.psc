;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 12
Scriptname TIF_Dflow_080ECABF Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_10
Function Fragment_10(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
(DealQ As _DDeal).BuyOut(_DFlowDealPP)

libs.RemoveDevice(libs.PlayerRef,I ,R, libs.zad_DeviousPlugAnal, skipevents = false, skipmutex = true)
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

GlobalVariable Property _DflowDealPP  Auto  

Key Property PTool  Auto  