;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname PRKF__SLS_GagBegPerk_08024D8C Extends Perk Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
_SLS_BeggingGagged.Stop()
_SLS_BeggingGagged.Start()
BegTarget.ForceRefTo(akTargetRef)
Main.UpdateBeggingDialogFactors(akTargetRef as Actor)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Package Property _SLS_GagBegForceGreet Auto
ReferenceAlias Property BegTarget Auto
Quest Property _SLS_BeggingGagged Auto

SLS_Main Property Main Auto
