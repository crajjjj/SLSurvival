;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 14
Scriptname TIF_Dflow_0A00AA4A Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_10
Function Fragment_10(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Bool removed = q.tool.LDC.RemoveAndDestroyDeviceByKeyWord( libs.zad_DeviousGag)
if !removed
   removed = q.tool.LDC.RemoveAndDestroyDeviceByKeyWord( libs.zad_DeviousHood)
endif
if removed
    q.DeviceRemovalDebt()
    Lives.setvalue(Lives.getvalue() as int - 1)
else
    Debug.Notification("$DFNOTREMOVED")
endif
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_13
Function Fragment_13(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
; nothing
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
