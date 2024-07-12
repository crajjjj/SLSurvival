;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 3
Scriptname PF__SLS_CreatureFleeWaitPack_04119A1A Extends Package Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(Actor akActor)
;BEGIN CODE
;Debug.Messagebox("Doing the thing")
akActor.AddToFaction(_SLS_TameableCreatureFact)
akActor.SetLookAt(PlayerRef, abPathingLookAt = true)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(Actor akActor)
;BEGIN CODE
;Debug.Messagebox("End")
akActor.ClearLookAt()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2(Actor akActor)
;BEGIN CODE
;Debug.Messagebox("Change")
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Actor Property PlayerRef Auto

Faction Property _SLS_TameableCreatureFact Auto

