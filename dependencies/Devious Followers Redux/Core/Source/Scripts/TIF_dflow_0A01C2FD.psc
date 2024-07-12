;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 12
Scriptname TIF_dflow_0A01C2FD Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_10
Function Fragment_10(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Bool removed = q.tool.LDC.RemoveAndDestroyDeviceByKeyWord( libs.zad_DeviousBoots)
If removed
    Q.DeviceRemovalDebt()
    Lives.SetValue((Lives.GetValue() As Int) - 1)
Else
    Debug.Notification("$DFNOTREMOVED")
EndIf
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
