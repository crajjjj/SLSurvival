;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 3
Scriptname PF__SLS_LicInspFgPack_0405F3DB Extends Package Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(Actor akActor)
;BEGIN CODE
;Debug.Messagebox(akActor + "Begin FG")
akActor.AddToFaction(_SLS_LicInspInChaseFact)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2(Actor akActor)
;BEGIN CODE
akActor.AddToFaction(_SLS_LicInspLostSightFact)
_SLS_LicInspLostSightSpell.Cast(akActor, akActor)
akActor.EvaluatePackage()
;Debug.Messagebox("FG ENd")
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Faction Property _SLS_LicInspLostSightFact Auto

Spell Property _SLS_LicInspLostSightSpell Auto

Faction Property _SLS_LicInspInChaseFact  Auto  
