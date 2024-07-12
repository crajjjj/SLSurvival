;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 12
Scriptname TIF_Dflow_081D8630 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_11
Function Fragment_11(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
libs.UnlockDevice(libs.playerRef, (GetOwningQuest() as _DFlowModDealController)._DflowPonyTailDealInventory,(GetOwningQuest() as _DFlowModDealController)._DflowPonyTailDealRend,libs.zad_DeviousPlugAnal)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_10
Function Fragment_10(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
tool.LDC.ForceEquipDeviceByKeyword(tool.LDC.libs.zad_DeviousPlugAnal)
(GetOwningQuest() as _DFlowModDealController).CrawlInTownRule = 3
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

zadlibs Property libs  Auto  
_Dftools property tool Auto
Actor Property PlayerRef  Auto  
QF__Gift_09000D62 property q Auto

MiscObject Property Gold001  Auto  
