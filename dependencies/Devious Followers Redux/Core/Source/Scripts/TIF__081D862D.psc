;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 10
Scriptname TIF__081D862D Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_8
Function Fragment_8(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
tool.LDC.RemoveDeviceByKeyword(libs.Zad_DeviousPetSuit)
(GetOwningQuest() as _DFlowModDealController).PetSuitInTownRule = 2
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

zadlibs Property libs  Auto  

_DFtools Property tool  Auto  

Actor Property PlayerRef  Auto  

Keyword Property kw  Auto  

MiscObject Property Gold001  Auto  

Armor Property R  Auto  

Armor Property I  Auto  