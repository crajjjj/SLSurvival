;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname PF__SLS_DancePlayerCrowdHate_04100456 Extends Package Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(Actor akActor)
;BEGIN CODE
Dance.ThrowJunk(akActor, Game.GetPlayer())
Utility.Wait(3.0)
Dance.FinishAction(akActor, 0)
akActor.EvaluatePackage()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

_SLS_Dance Property Dance Auto
