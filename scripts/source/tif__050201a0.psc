;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 3
Scriptname TIF__050201A0 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_2
Function Fragment_2(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Utility.Wait(3.0)
Debug.SendAnimationEvent(akSpeaker, "IdleTake")
_SLS_AssSlapMarker.Play(PlayerRef)
Utility.Wait(0.1)
_SLS_AssSlapGruntMarker.Play(PlayerRef)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Sound Property _SLS_AssSlapMarker Auto
Sound Property _SLS_AssSlapGruntMarker Auto
Actor Property PlayerRef Auto
