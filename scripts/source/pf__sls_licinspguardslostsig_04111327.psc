;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname PF__SLS_LicInspGuardsLostSig_04111327 Extends Package Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(Actor akActor)
;BEGIN CODE
akActor.RemoveFromFaction(_SLS_LicInspInChaseFact)
akActor.EvaluatePackage()
;Debug.Messagebox("Remove from chase faction")
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Faction Property _SLS_LicInspInChaseFact  Auto  
