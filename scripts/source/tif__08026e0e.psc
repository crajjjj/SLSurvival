;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname TIF__08026E0E Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
TossOutDoor.GetReference().Lock(false)
TossOutDoor.GetReference().Activate(PlayerRef)
While _SLS_PlayerSleepMarker.GetCurrentLocation().IsSameLocation(PlayerRef.GetCurrentLocation())
	Utility.Wait(0.1)
EndWhile
akSpeaker.Disable()
EvictionSleepTrack.CleanUp()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Actor Property PlayerRef Auto
ReferenceAlias Property TossOutDoor Auto
ObjectReference Property _SLS_PlayerSleepMarker Auto
SLS_EvictionSleepTrack Property EvictionSleepTrack Auto
