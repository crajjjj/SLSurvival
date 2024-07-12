;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname TIF__0501595A Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
(_SLS_CreatureForceGreet.GetNthAlias(0) as ReferenceAlias).Clear()
_SLS_CreatureForceGreet.Stop()
(akSpeaker).EvaluatePackage()
Debug.SendAnimationEvent(Game.GetPlayer(), "IdleStop")
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Quest Property _SLS_CreatureForceGreet Auto
