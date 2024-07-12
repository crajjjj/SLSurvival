;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname TIF__0703E57A Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Debug.Notification(akSpeaker.GetBaseObject().GetName() + " slaps your ass hard as you walk by")
Debug.SendAnimationEvent(akSpeaker, "IdleTake")
Utility.Wait(0.1)
_SLS_AssSlapMarker.Play(PlayerRef)
Utility.Wait(0.1)
_SLS_AssSlapGruntMarker.Play(PlayerRef)
(Game.GetFormFromFile(0x07EF9A, "SL Survival.esp") as _SLS_InterfaceDeviousFollowers).DecResistWithSeverity(Amount = 1.0, DoNotify = true, Severity = "0")
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Sound Property _SLS_AssSlapMarker Auto
Actor Property PlayerRef Auto
Sound Property _SLS_AssSlapGruntMarker Auto
SLS_Init Property Init Auto
