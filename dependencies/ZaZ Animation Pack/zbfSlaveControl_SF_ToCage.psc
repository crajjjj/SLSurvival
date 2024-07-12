;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 10
Scriptname zbfSlaveControl_SF_ToCage Extends Scene Hidden

;BEGIN FRAGMENT Fragment_5
Function Fragment_5()
;BEGIN CODE
zbfSA.SetCageDoorOpen(True)

zbfLeash.SetAllDefaults()
zbfLeash.SetDestination(zbfSA.GetPlayerMarker())
zbfLeash.SetArrival(afDistance = 30.0, afTime = 1.0)
zbfLeash.StartLeash("Custom", aiDoneValue = 4)
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

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
zbfSA.PlaceCageDoorMarkers()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_8
Function Fragment_8()
;BEGIN CODE
zbfSA.SetCageDoorOpen(False)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

zbfSlaveActions Property zbfSA  Auto  

zbfSlaveLeash Property zbfSL  Auto  

zbfSlaveLeash Property zbfLeash  Auto  
