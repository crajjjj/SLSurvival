;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_WhiterunEnslaved Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
if locationCheck.PlayerIsInEnforcedLocation()
	enslavequest.isLocationEnslaved = true
else
	enslavequest.isLocationEnslaved = false
endif
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

SLV_EnforcerLocationCheck Property locationCheck auto
SLV_LocationEnslaveCheck Property enslavequest auto

