;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 12
Scriptname TIF_Dflow_0A029AFE Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_10
Function Fragment_10(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
;libs.RemoveDevice(libs.PlayerRef, I , R,libs.zad_DeviousHeavyBondage)
Bool a = libs.ManipulateGenericDeviceByKeyword(libs.Playerref, libs.zad_DeviousGloves,False)
if a
q.DeviceRemovalGold()

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

MiscObject Property Gold001  Auto  
GlobalVariable Property Lives  Auto  
