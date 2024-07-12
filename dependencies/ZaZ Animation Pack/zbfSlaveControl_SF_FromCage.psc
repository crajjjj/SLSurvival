;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 3
Scriptname zbfSlaveControl_SF_FromCage Extends Scene Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN CODE
zbfSA.SetCageDoorOpen(False)
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

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
zbfSA.SetCageDoorOpen(True)

zbfLeash.SetAllDefaults()
zbfLeash.SetDestination(zbfSA.GetMasterMarker())
zbfLeash.SetArrival(afDistance = 150.0, afTime = 3.0)
zbfLeash.StartLeash("Custom", aiDoneValue = 5)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

zbfSlaveActions Property zbfSA  Auto  

zbfSlaveLeash Property zbfLeash  Auto  
