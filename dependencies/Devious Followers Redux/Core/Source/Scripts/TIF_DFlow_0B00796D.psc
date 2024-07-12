;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname TIF_DFlow_0B00796D Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
bool ok = q.tool.LDC.RemoveAndDestroyDeviceByKeyWord( libs.zad_DeviousCollar)

If ok
    q.DeviceRemovalGold()
    _DFlowLives.setvalue(_DFlowLives.getvalue() as int - 1)
EndIf
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
libs.ManipulateGenericDeviceByKeyword(PlayerRef,libs.zad_DeviousCollar,false)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

QF__Gift_09000D62 Property q  Auto  

Actor Property PlayerRef  Auto  

zadlibs Property libs  Auto  

GlobalVariable Property _DFlowLives Auto
