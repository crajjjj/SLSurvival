;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname PRKF__SLS_ChaseDoorActivateP_04111E0A Extends Perk Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
_SLS_PlayerActivatedDoor.SetValueInt(1)
Utility.Wait(3.0)
_SLS_PlayerActivatedDoor.SetValueInt(0)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

GlobalVariable Property _SLS_PlayerActivatedDoor  Auto  
