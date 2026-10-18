;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 3
Scriptname TIF__050201A0 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_2
Function Fragment_2(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Utility.Wait(3.0)
Debug.SendAnimationEvent(akSpeaker, "IdleTake")
Actor Player = Game.GetPlayer() ; The PlayerRef property is not filled on this INFO, so sounds and the mark went to None
_SLS_AssSlapMarker.Play(Player)
Utility.Wait(0.1)
_SLS_AssSlapGruntMarker.Play(Player)
(Game.GetFormFromFile(0x0F37A1, "SL Survival.esp") as _SLS_Trauma).AddSpankTrauma(Player) ; leave a fading spank mark
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Sound Property _SLS_AssSlapMarker Auto
Sound Property _SLS_AssSlapGruntMarker Auto
Actor Property PlayerRef Auto
