;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 12
Scriptname TIF_Dflow_0B00A4E3 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_10
Function Fragment_10(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
;libs.RemoveDevice(libs.PlayerRef, I , R,libs.zad_DeviousHeavyBondage)
Bool a =q.tool.LDC.RemoveAndDestroyDeviceByKeyWord( libs.zad_DeviousBlindfold)
if !a 
a =q.tool.LDC.RemoveAndDestroyDeviceByKeyWord( libs.zad_DeviousHood)
endif
if a
Q.DeviceRemovalDebt()
Lives.setvalue(Lives.getvalue() as int - 1)
else
Debug.Notification("$DFNOTREMOVED")
endif
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
