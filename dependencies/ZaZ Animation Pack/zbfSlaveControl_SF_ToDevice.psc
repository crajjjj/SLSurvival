;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 4
Scriptname zbfSlaveControl_SF_ToDevice Extends Scene Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
zbfSA.PlaceToDeviceMarkers()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_3
Function Fragment_3()
;BEGIN CODE
zbfSA.StartBindInDevice()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN CODE
zbfLeash.SetAllDefaults()
zbfLeash.SetMaster(zbfSA.GetMaster())
zbfLeash.SetDestination(zbfSA.GetMasterMarker())
zbfLeash.StartLeash("Custom", aiDoneValue = 3)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

zbfSlaveActions Property zbfSA  Auto  

zbfSlaveLeash Property zbfLeash  Auto  
